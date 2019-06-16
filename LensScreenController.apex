/*************************************************************************************************************************************************************
@ Class:          LensScreenController1
@ Version:        1.0
@ Author:         
@ Req No:
@ Refer Classes:  
@ Purpose:        Acts as a controller to LensScreenUI page.
--------------------------------------------------------------------------------------------------------------------------------------------------------------
@ Change history: DD.MM.YYYY /  / Created the class "LensScreenController1".
**************************************************************************************************************************************************************/

public without sharing class LensScreenController {

    public Order ord {get;set;} {ord = new Order();}
    public OrderItem odOrdItm {get;set;} {odOrdItm = new OrderItem();}
    public OrderItem osOrdItm {get;set;} {osOrdItm = new OrderItem();}
    public String accName { get;set;}
    public String rmaName {get;set;}
    public String patientName {get;set;}
    
    public String duplicateType {get; set;}
    public String dupOrderId {get;set;}
    public Boolean saveDupCheck {get;set;}
    public Boolean batchToggle {get;set;}

    //Junction variables for OD and OS OrderItems
    public String ordItmDesign {get;set;}
    public String ordItmLens {get;set;}
    public String ordItmRGP {get;set;}
    public String ordItmMaterial {get;set;}
    public String ordItmBlend {get;set;}

    public Boolean isCalculated {get;set;}
    public Boolean isManualInputSaved {get;set;}
    public String errorMessage {get;set;} 
    public String errorPromptMessage {get;set;} 
    public Lens odLens {get;set;} { odLens = new Lens(); }
    public Lens osLens {get;set;} { osLens = new Lens(); }
    public Integer quantity {get;set;}
    public Integer sessionCounter{get;set;}
    public Decimal emeraldLimit {get;set;}

    private OrderItem defualtOrdItm;
    private Map<String, String> lensfieldsMapping;
    private Integer accACDeltaType;
    public String selCompany {get;set;}
    

    private static final String CALCULATE_FAILED = 'Calculate Failed';
    private static final String OD_SIDE = 'OD Side ';
    private static final String OS_SIDE = 'OS Side ';
    private static final String REFRESH = 'Refresh';
    private static final String OU = '1 - OU';
    private static final String OD = '2 - OD';
    private static final String OS = '3 - OS';
    private static final String STRING_BLANK = '';
    private static final String STRING_SPACE = ' ';
    private static final String STRING_COMMA = ',';
    private static final String STRING_STANDARD = 'Standard';
    private static final String STRING_UNDERSCORE = '_';

    //Constructor
    public LensScreenController() {
        isCalculated = false;
        isManualInputSaved = false;
        batchToggle = false;
        //Instantiates an OrderItem with their default values. Used during retaining the values of sticky fields. 
        defualtOrdItm = (OrderItem)OrderItem.sObjectType.newSObject(null, true);
        emeraldLimit = 0;
        odOrdItm.Side__c = OD;
        osOrdItm.Side__c = OS;
        odOrdItm.Eye__c = 'D';
        osOrdItm.Eye__c = 'S';

        selCompany = 'ESC';

        //Get URL parameters like AccountId for creating order from Account and orderId for Re-Orders
        Map<String, String> urlParameterMap = ApexPages.currentPage().getParameters();    
        if(urlParameterMap.containsKey('orderId') && urlParameterMap.get('orderId') != null){
            reOrder(urlParameterMap.get('orderId'), false);            
        }
        if(urlParameterMap.containsKey('AccountId') && urlParameterMap.get('AccountId') != null){
            ord.AccountId = urlParameterMap.get('AccountId');
            accName = [SELECT UNITYSALES__ERP_Customer_ID__c FROM Account WHERE Id = :ord.AccountId LIMIT 1].UNITYSALES__ERP_Customer_ID__c;
            getEmeraldLimit();
        }

        if(!urlParameterMap.containsKey('orderId')){
            odOrdItm.Color__c = 'GREEN';
            osOrdItm.Color__c = 'BLUE';
        }
        
        if(String.isBlank(ordItmRGP)){
            ordItmRGP = 'Boston';
        }        

        if(String.isBlank(String.valueOf(odOrdItm.NPC__c))){
            odOrdItm.NPC__c = 4;
        }                
        
        if(String.isBlank(String.valueOf(osOrdItm.NPC__c))){
            osOrdItm.NPC__c = 4;
        }

                
    }

    /********************************************************************************************************************************************************
      @ Method:           dupOrder
      @ Version:          1.0
      @ Author:           
      @ Param paramName:  NULL
      @ Return:           NULL
      @ Purpose:          Checks whether an order exists or not in salesforce. If exists loads the data based on the type selection.
      ----------------------------------------------------------------------------------------------------------------------------------------------------------
      @ Change history: DD.MM.YYYY /  / Created the method "dupOrder"
    **********************************************************************************************************************************************************/
    public void dupOrder(){
        try{      
            errorPromptMessage = STRING_BLANK;
            if(String.isBlank(dupOrderId)) throw new CustomException('Please enter ERP Order');
            dupOrderId = dupOrderId.trim();      
            List<Order> listOrder = [SELECT Id,Lens_Ord_Itm_Side__c FROM Order WHERE UNITYSALES__ERP_Order_Num__c = :dupOrderId LIMIT 1];           
            if(listOrder.size() > 0){
                if(listOrder[0].Lens_Ord_Itm_Side__c != OU && 
                    listOrder[0].Lens_Ord_Itm_Side__c !=  duplicateType){
                    throw new CustomException('Order Type does not match -- cannot load order');
                } else {
                    Id dupOrdId = listOrder[0].Id;
                    reOrder(dupOrdId, true);
                }                
            } else {
                throw new CustomException('Unable to find the Order');
            }            
        }
        catch(Exception ex){
            system.debug('Cause ::: '+ex.getCause()+' Line Number ::: '+ex.getLineNumber()+' Message ::: '+ex.getMessage()+' Type ::: '+ex.getTypeName()+' Stack ::: '+ex.getStackTraceString());
            errorPromptMessage = ex.getMessage();
        }
    }

    /********************************************************************************************************************************************************
      @ Method:           reOrder
      @ Version:          1.0
      @ Author:           
      @ Param paramName:  orderId
      @ Return:           void
      @ Purpose:          Method will get called from constructor when the url has orderId param. Used to load values from existing record
      ----------------------------------------------------------------------------------------------------------------------------------------------------------
      @ Change history: DD.MM.YYYY /  / Created the method "reOrder"
    **********************************************************************************************************************************************************/
    public void reOrder(String orderId, Boolean isDup){          
        String selectFieldsQryString = generateQueryUsingFieldset('Order','OrderLensController');
        String soqlQry = 'SELECT Id,Account.UNITYSALES__ERP_Customer_ID__c,Patient_ID__r.Name,ERP_RMA__r.Name,'+selectFieldsQryString+ ' FROM Order WHERE Id = :orderId';
        ord = Database.query(soqlQry);         
        ord.Batch_ID__c = STRING_BLANK;
        if(!isDup)
            duplicateType = ord.Lens_Ord_Itm_Side__c;
        getEmeraldLimit();
        if(ord.Lens_Ord_Itm_Side__c.equalsIgnoreCase(OU)){
            ord.Lens_Comments__c = 'Dup OU ('+ ord.UNITYSALES__ERP_Order_Num__c+')';                          
        } else if(ord.Lens_Ord_Itm_Side__c.equalsIgnoreCase(OD)) {
            ord.Lens_Comments__c = 'Dup OD ('+ ord.UNITYSALES__ERP_Order_Num__c+')';            
        } else if(ord.Lens_Ord_Itm_Side__c.equalsIgnoreCase(OS)) {
            ord.Lens_Comments__c = 'Dup OS ('+ ord.UNITYSALES__ERP_Order_Num__c+')';            
        }
        ord.UNITYSALES__ERP_Order_Num__c = STRING_BLANK;
        selectFieldsQryString = generateQueryUsingFieldset('OrderItem','OrderItemLensScreenController');
        
        soqlQry = 'SELECT Product2.Name, '+selectFieldsQryString+' FROM OrderItem WHERE OrderId = :orderId';
        Boolean isReverseEngineered = false;
        for(OrderItem tempOrdItm : Database.query(soqlQry)){
            String colorCode = tempOrdItm.Product2.Name.substring(4,7);
            if(isDup && !duplicateType.equalsIgnoreCase(OU)){
                if(tempOrdItm.Side__c == OD && duplicateType.equalsIgnoreCase(OD)){
                    odOrdItm = (tempOrdItm).clone();                    
                    odOrdItm.Color__c = [SELECT MasterLabel FROM Lens_Lookup__mdt WHERE Lookup_Type__c = 'Color' AND Lookup_value__c = :colorCode].MasterLabel;
                } else if(tempOrdItm.Side__c == OS && duplicateType.equalsIgnoreCase(OS)) {
                    osOrdItm = (tempOrdItm).clone();
                    osOrdItm.Color__c = [SELECT MasterLabel FROM Lens_Lookup__mdt WHERE Lookup_Type__c = 'Color' AND Lookup_value__c = :colorCode].MasterLabel;
                }
            } else {
                if(tempOrdItm.Side__c == OD) {
                    odOrdItm = (tempOrdItm).clone();
                    odOrdItm.Color__c = [SELECT MasterLabel FROM Lens_Lookup__mdt WHERE Lookup_Type__c = 'Color' AND Lookup_value__c = :colorCode].MasterLabel;   
                }                    
                if(tempOrdItm.Side__c == OS) {
                    osOrdItm = (tempOrdItm).clone();
                    osOrdItm.Color__c = [SELECT MasterLabel FROM Lens_Lookup__mdt WHERE Lookup_Type__c = 'Color' AND Lookup_value__c = :colorCode].MasterLabel;
                }                    
            }

            if(!isReverseEngineered) {
                isReverseEngineered = true;
                String lensId = tempOrdItm.Product2.Name.substring(0, 2);
                String materialId = tempOrdItm.Product2.Name.substring(2, 4);
                Lens_Lookup__mdt lensTypeLookUp = [SELECT MasterLabel FROM Lens_Lookup__mdt WHERE Lookup_Type__c = 'Lens' AND Lookup_value__c = :lensId LIMIT 1];
                Lens_Lookup__mdt materialTypeLookUp = [SELECT DeveloperName FROM Lens_Lookup__mdt WHERE Lookup_Type__c = 'Material' AND Lookup_value__c = :materialId LIMIT 1];
                Lens__mdt lens = [SELECT MasterLabel, Design__r.MasterLabel FROM Lens__mdt WHERE DeveloperName = :lensTypeLookUp.MasterLabel LIMIT 1];
                Material__mdt material = [SELECT DeveloperName, RGP__r.DeveloperName FROM Material__mdt WHERE DeveloperName = :materialTypeLookUp.DeveloperName LIMIT 1];
                ordItmLens = lens.MasterLabel;            
                ordItmDesign = lens.Design__r.MasterLabel;
                ordItmMaterial = material.DeveloperName.replace(STRING_UNDERSCORE,STRING_SPACE);
                ordItmRGP = material.RGP__r.DeveloperName.replace(STRING_UNDERSCORE,STRING_SPACE);
            }                        
            ordItmBlend = tempOrdItm.Blend__c;
        }

        accName = ord.Account.UNITYSALES__ERP_Customer_ID__c;
        patientName = ord.Auto_Name__c? ord.Patient_Auto_Name__c : ord.Patient_ID__r.Name;
        rmaName = ord.ERP_RMA__r.Name;
        if(isDup)
            ord.Lens_Ord_Itm_Side__c = duplicateType;
        calculate(false, true);
        //While re-loading Calculate Refresh is also called to get values for historical records.
        Apexpages.currentPage().getParameters().put('calcTypeParam',REFRESH);
        calculate(true, true);
        
        isCalculated = true;                
    }

    /********************************************************************************************************************************************************
      @ Method:           generateQueryUsingFieldset
      @ Version:          1.0
      @ Author:           
      @ Param paramName:  sObjectName - Object API name
                          fieldSetName - Fieldset API name
      @ Return:           string
      @ Purpose:          Generates a SOQL query string using the passed fieldset name and object name.
      ----------------------------------------------------------------------------------------------------------------------------------------------------------
      @ Change history: DD.MM.YYYY /  / Created the method "generateQueryUsingFieldset"
    **********************************************************************************************************************************************************/
    public static String generateQueryUsingFieldset(String sObjectName, String fieldSetName){
        String soqlQry = STRING_BLANK;
        Map<String, Schema.SObjectType> globalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType SObjectTypeObj = globalDescribeMap.get(sObjectName);
        Schema.DescribeSObjectResult describeSObjectResultObj = SObjectTypeObj.getDescribe();
        Schema.FieldSet fieldSetObj = describeSObjectResultObj.FieldSets.getMap().get(fieldSetName);
        for(Schema.FieldSetMember fieldSetMemberObj : fieldSetObj.getFields()){
            soqlQry = soqlQry + fieldSetMemberObj.getFieldPath() + STRING_COMMA;
        }
        soqlQry = soqlQry.removeEnd(STRING_COMMA);        
        return soqlQry; 
    }

    /********************************************************************************************************************************************************
      @ Method:           searchAccountRecords
      @ Version:          1.0
      @ Author:           
      @ Param paramName:  searchCriteria
      @ Return:           List<sObject>
      @ Purpose:          Returns list of sObject records to vf page javascript remoting method
      ----------------------------------------------------------------------------------------------------------------------------------------------------------
      @ Change history: DD.MM.YYYY /  / Created the method "searchAccountRecords"
    **********************************************************************************************************************************************************/
    @RemoteAction
    public static List<sObject> searchAccountRecords(String searchCriteria) {
        String custId = String.escapeSingleQuotes(searchCriteria)+'%';
        return [SELECT Id, Name, UNITYSALES__ERP_Customer_ID__c FROM Account WHERE UNITYSALES__ERP_Customer_ID__c LIKE :custId];
    }

    @RemoteAction
    public static List<sObject> searchPatientRecords(String searchCriteria, String accountId) {
        String patientId = String.escapeSingleQuotes(searchCriteria)+'%';
        String accoiuntId = String.escapeSingleQuotes(accountId);        
        return [SELECT Id, Name, Patient_ID_2__c FROM Patient__c WHERE name LIKE :patientId AND Account__c =:accountId];
    }

    @RemoteAction
    public static List<sObject> searchRMARecords(String searchCriteria) {
        String rmaId = String.escapeSingleQuotes(searchCriteria)+'%';        
        return [SELECT Id, ERP_RMA_Number__c FROM RMA__c WHERE ERP_RMA_Number__c LIKE :rmaId];
    }

    /********************************************************************************************************************************************************
      @ Method:           save
      @ Version:          1.0
      @ Author:           Infoglen
      @ Param paramName:  NULL
      @ Return:           NULL
      @ Purpose:          Creates the Order and Order Item fetching default values of product like price. Calculate API is called if calculate_run is false.
      ----------------------------------------------------------------------------------------------------------------------------------------------------------
      @ Change history: DD.MM.YYYY / Infoglen / Created the method "save"
    **********************************************************************************************************************************************************/
    public PageReference save() {
        sessionCounter = 0;
        errorMessage = STRING_BLANK;
        Savepoint sp = Database.setSavepoint();
        try{
            if(String.isNotBlank(ord.Patient_ID__c)){
                String tempPatientName = [SELECT Name FROM Patient__c WHERE Id = :ord.Patient_ID__c LIMIT 1].Name;
                if(!tempPatientName.equals(patientName)) {
                    ord.Patient_ID__c = null;
                } else {
                    ord.Patient_text__c = tempPatientName;
                }
            }

            // If only patient name is not blank and Auto Name is OFF a new patient record is created
            // If Auto name is true then value assigned to Patient Auto Name
            if(ord.Auto_Name__c){
                ord.Patient_Auto_Name__c = patientName;
                ord.Patient_ID__c = null;
                ord.Patient_text__c =  ord.Patient_Auto_Name__c;
            } else if(String.isBlank(ord.Patient_ID__c)){                
                ord.Patient_ID__c = createPatient(patientName, ord.AccountId);
                ord.Patient_text__c = patientName;
                ord.Patient_Auto_Name__c = STRING_BLANK;                            
            } else {
                ord.Patient_Auto_Name__c = STRING_BLANK; 
            }
            //Adds 30days from the current date.
            ord.UNITYSALES__ERP_Need_By_Date__c = system.today().addDays(30);
            ord.Pricebook2Id = Test.isRunningTest() ? Test.getStandardPricebookId() : [SELECT Id FROM PriceBook2 WHERE Name = 'Standard Price Book'].Id;
            /*Account ordAccount = [SELECT CurrencyIsoCode, Price_Book__c FROM Account WHERE Id = :ord.AccountId LIMIT 1];
            if(Test.isRunningTest()) {
                ord.Pricebook2Id = Test.getStandardPricebookId(); 
            } else if(ordAccount.Price_Book__c != null) {
                ord.Pricebook2Id = ordAccount.Price_Book__c;
            } else {
                ord.Pricebook2Id = [SELECT Id FROM PriceBook2 WHERE Name = 'Standard Price Book'].Id;
            }*/        
            
            ord.EffectiveDate = system.today();
            ord.Status = 'Draft';
            ord.cClass__c = [SELECT Lookup_value__c FROM Lens_Lookup__mdt WHERE MasterLabel = :ord.Order_Type__c AND Lookup_Type__c = 'cClass'].Lookup_value__c; 
            ord.cShip__c = (ord.Shipping__c != STRING_STANDARD) ? ord.Shipping__c : (ord.China_Options__c != STRING_STANDARD) ? ord.China_Options__c : STRING_STANDARD;
            //Calls the setLookUp method for setting the Euclid DB DesignId and MaterialId
            setLookupValue();
            /*if(ord.Lens_Ord_Itm_Side__c.equalsIgnoreCase('1 - OU') || ord.Lens_Ord_Itm_Side__c.equalsIgnoreCase('2 - OD')) {
                String odProdName = odOrdItm.DesignId__c+odOrdItm.MaterialId__c+odOrdItm.ColorId__c;
                List<Product2> odProds = [SELECT Id,IsActive FROM Product2 WHERE Name =: odProdName];
                if(odProds.size() > 0 && odProds[0].IsActive){
                    odOrdItm.Product2Id = odProds[0].Id;
                    if(odOrdItm.PricebookEntryId == null){
                        for(PricebookEntry odPricebookEntryId : [SELECT Id, UnitPrice, CurrencyIsoCode FROM PricebookEntry WHERE Pricebook2Id = :ord.Pricebook2Id AND Product2Id = :odProds[0].Id]) {
                            odOrdItm.PricebookEntryId = odPricebookEntryId.Id;
                            odOrdItm.UnitPrice = odPricebookEntryId.UnitPrice;
                            if(odPricebookEntryId.CurrencyIsoCode.equalsIgnoreCase(ordAccount.CurrencyIsoCode)) {
                                ord.CurrencyIsoCode = odPricebookEntryId.CurrencyIsoCode;
                                break;                                
                            }
                        }
                    }
                } else {
                    throw new CustomException('Invalid Product Id for OD Side');
                }
            }*/

            if(ord.Lens_Ord_Itm_Side__c.equalsIgnoreCase('1 - OU') || ord.Lens_Ord_Itm_Side__c.equalsIgnoreCase('2 - OD')) {
                String odProdName = odOrdItm.DesignId__c+odOrdItm.MaterialId__c+odOrdItm.ColorId__c;                
                List<Product2> odProds = [SELECT Id,IsActive FROM Product2 WHERE Name =: odProdName];
                if(odProds.size() > 0 && odProds[0].IsActive){
                    odOrdItm.Product2Id = odProds[0].Id;
                    //if(odOrdItm.PricebookEntryId == null){
                        PricebookEntry odPricebookEntryId = [SELECT Id, UnitPrice FROM PricebookEntry WHERE Pricebook2Id = :ord.Pricebook2Id AND Product2Id = :odProds[0].Id LIMIT 1];
                        odOrdItm.PricebookEntryId = odPricebookEntryId.Id;
                        odOrdItm.UnitPrice = odPricebookEntryId.UnitPrice;
                    //}
                } else {
                    throw new CustomException('Invalid Product Id for OD Side');
                }
            }
            
            /*if(ord.Lens_Ord_Itm_Side__c.equalsIgnoreCase('1 - OU') || ord.Lens_Ord_Itm_Side__c.equalsIgnoreCase('3 - OS')) {
                String osProdName = osOrdItm.DesignId__c+osOrdItm.MaterialId__c+osOrdItm.ColorId__c;
                List<Product2> osProds = [SELECT Id,IsActive FROM Product2 WHERE Name =: osProdName];
                if(osProds.size() > 0 && osProds[0].IsActive){
                    osOrdItm.Product2Id = osProds[0].Id;
                    if(osOrdItm.PricebookEntryId == null){
                        for(PricebookEntry osPricebookEntryId : [SELECT Id, UnitPrice, CurrencyIsoCode FROM PricebookEntry WHERE Pricebook2Id = :ord.Pricebook2Id AND Product2Id = :osProds[0].Id]){
                            osOrdItm.PricebookEntryId = osPricebookEntryId.Id;
                            osOrdItm.UnitPrice = osPricebookEntryId.UnitPrice;
                            if(osPricebookEntryId.CurrencyIsoCode.equalsIgnoreCase(ordAccount.CurrencyIsoCode)) {
                                ord.CurrencyIsoCode = osPricebookEntryId.CurrencyIsoCode;
                                break;
                            }
                        }
                    }                    

                } else {
                    throw new CustomException('Invalid Product Id for OS Side');
                }
            }*/

            if(ord.Lens_Ord_Itm_Side__c.equalsIgnoreCase('1 - OU') || ord.Lens_Ord_Itm_Side__c.equalsIgnoreCase('3 - OS')) {
                String osProdName = osOrdItm.DesignId__c+osOrdItm.MaterialId__c+osOrdItm.ColorId__c;
                List<Product2> osProds = [SELECT Id,IsActive FROM Product2 WHERE Name =: osProdName];
                if(osProds.size() > 0 && osProds[0].IsActive){
                    osOrdItm.Product2Id = osProds[0].Id;
                    //if(osOrdItm.PricebookEntryId == null){
                        PricebookEntry osPricebookEntryId = [SELECT Id, UnitPrice FROM PricebookEntry WHERE Pricebook2Id = :ord.Pricebook2Id AND Product2Id = :osProds[0].Id LIMIT 1];
                        osOrdItm.PricebookEntryId = osPricebookEntryId.Id;
                        osOrdItm.UnitPrice = osPricebookEntryId.UnitPrice;
                    //}
                } else {
                    throw new CustomException('Invalid Product Id for OS Side');
                }
            }
            
            
            odOrdItm.Quantity = 1;            
            osOrdItm.Quantity = 1;                      

            if(quantity == null || quantity == 0){
                quantity = 1;                
            }
            saveDup(); 
        }

        catch(Exception ex){
            sessionCounter = 0;
            Database.rollback(sp);
            system.debug('Cause ::: '+ex.getCause()+' Line Number ::: '+ex.getLineNumber()+' Message ::: '+ex.getMessage()+' Type ::: '+ex.getTypeName()+' Stack ::: '+ex.getStackTraceString());
            errorMessage = ex.getMessage();
            return null;
        }
        return null;
    }

    /********************************************************************************************************************************************************
      @ Method:           saveDup
      @ Version:          1.0
      @ Author:           Infoglen
      @ Param paramName:  NULL
      @ Return:           NULL
      @ Purpose:          Creates multiple Order and Order Item by cloning the declared Ord and OrdItm
      ----------------------------------------------------------------------------------------------------------------------------------------------------------
      @ Change history: DD.MM.YYYY / Infoglen / Created the method "saveDup"
    **********************************************************************************************************************************************************/
    public PageReference saveDup(){
        Savepoint sp = Database.setSavepoint();
        try{
            errorMessage = STRING_BLANK;            
            if(isCalculated ? true : calculate(true, false)){
                List<Order> cloneOrd = new List<Order>();
                List<OrderItem> cloneOrdItm = new List<OrderItem>();
                for(integer i = 0; i < quantity; i++){                    
                    Order ord = (ord).clone();
                    cloneOrd.add(ord);                    
                }
                insert cloneOrd;
                for(Order tempOrd : cloneOrd){
                    if(ord.Lens_Ord_Itm_Side__c.equalsIgnoreCase(OU)){
                        OrderItem clone_od_ordItm = (odOrdItm).clone();
                        OrderItem clone_os_ordItm = (osOrdItm).clone();
                        clone_od_ordItm.OrderId = tempOrd.Id;
                        clone_os_ordItm.OrderId = tempOrd.Id;
                        cloneOrdItm.add(clone_od_ordItm);
                        cloneOrdItm.add(clone_os_ordItm);
                    } else if(ord.Lens_Ord_Itm_Side__c.equalsIgnoreCase(OD)){ 
                        OrderItem clone_od_ordItm = (odOrdItm).clone();
                        clone_od_ordItm.OrderId = tempOrd.Id;
                        cloneOrdItm.add(clone_od_ordItm);
                    } else {
                        OrderItem clone_os_ordItm = (osOrdItm).clone();                        
                        clone_os_ordItm.OrderId = tempOrd.Id;
                        cloneOrdItm.add(clone_os_ordItm);
                    }                  
                }                
                insert cloneOrdItm;
                sessionCounter = cloneOrd.size();
            }
            /**
             * Sticky Fields Functionality
             * If saveDupCheck is FALSE then will retain the values of sticky fields and resets the remaining fields to their defaults.
             * If saveDupCheck is TRUE then all the fields including the sticky fields are retained.
             */
            if(!saveDupCheck){                
                Set<String> stickyFields = new Set<String>{'Color__c','RGP__c','MaterialLC__c','Product2Id','Design__c','Blend__c','Side__c'};
                Map<String, String> odStickyFieldValues = new Map<String, String>();
                Map<String, String> osStickyFieldValues = new Map<String, String>();
                for(String str : stickyFields){
                    odStickyFieldValues.put(str,(String)odOrdItm.get(str));
                    osStickyFieldValues.put(str,(String)osOrdItm.get(str));
                }                
                odOrdItm = defualtOrdItm.clone();
                osOrdItm = defualtOrdItm.clone();
                for(String field : odStickyFieldValues.keySet()){
                    odOrdItm.put(field, odStickyFieldValues.get(field));
                }
                for(String field : osStickyFieldValues.keySet()){
                    osOrdItm.put(field, osStickyFieldValues.get(field));
                }
                odOrdItm.NPC__c = 4;
                osOrdItm.NPC__c = 4;                
            }

            if(!ord.Auto_Name__c) {
                patientName = STRING_BLANK;
            }
            ord.Patient_ID__c = null;  
            ord.Lens_Comments__c = STRING_BLANK;
            dupOrderId = STRING_BLANK;
            isCalculated = false;
            isManualInputSaved = false;
        }
        catch(Exception ex){
            errorMessage = ex.getMessage();
            system.debug('Cause ::: '+ex.getCause()+' Line Number ::: '+ex.getLineNumber()+' Message ::: '+ex.getMessage()+' Type ::: '+ex.getTypeName()+' Stack ::: '+ex.getStackTraceString());
            sessionCounter = 0;
            Database.rollback(sp);
        }        
        return null;
    }

    /********************************************************************************************************************************************************
      @ Method:           createPatient
      @ Version:          1.0
      @ Author:           
      @ Param paramName:  patientName - Name of the Patient
                          accId - Account Id to which the Patient is related.
      @ Return:           Id
      @ Purpose:          Creates a Patient record
      ----------------------------------------------------------------------------------------------------------------------------------------------------------
      @ Change history: DD.MM.YYYY /  / Created the method "createPatient"
    **********************************************************************************************************************************************************/
    public Id createPatient(String patientName, Id accId){
        Patient__c patient = new Patient__c(Name = patientName, Account__c = accId);
        insert patient;
        ord.Patient_ID__c = patient.Id;
        return patient.Id;
    }

    /********************************************************************************************************************************************************
      @ Method:           calculateAPI
      @ Version:          1.0
      @ Author:           
      @ Param paramName:  calcType - If type is NEW, calculateNew method is called else calculateRefresh.
                          mappings - Defines the mappings its for which side
                          Ln - Lens model
      @ Return:           NULL
      @ Purpose:          Calculates the Lens Data and Manual Input Data based on the Lens Exam Data values.
      ----------------------------------------------------------------------------------------------------------------------------------------------------------
      @ Change history: DD.MM.YYYY /  / Created the method "calculateAPI"
    **********************************************************************************************************************************************************/
    public String calculateAPI(String calcType, Map<String, String > mappings, Lens ln, String ordItmSide, OrderItem ordItm, Boolean isNotReOrder, Boolean isNotManualRefresh){        

        Map<String, Object> lensReq = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(ln));  
        for(String str : mappings.keySet()){

            String paramVal = String.valueOf(ordItm.get(str));
            if(String.isBlank(paramVal)){
                if(String.isBlank(String.valueOf(defualtOrdItm.get(str)))) {
                    paramVal = '0';
                } else {
                    paramVal = String.valueOf(defualtOrdItm.get(str));
                }                 
            }
            lensReq.put(mappings.get(str), paramVal);                                        
        }
        //Lens class ACDeltaType value will be assigned based on the Account ACDeltaType__c field value
        if(String.isNotBlank(String.valueOf(accACDeltaType))) {
            lensReq.put('ACDeltaType', String.valueOf(accACDeltaType));
        }
        Lens calcLens = (lens) JSON.deserialize(JSON.serialize(lensReq), lens.class);
        Boolean isSuccess = (calcType == REFRESH) ? calcLens.calculateRefresh() : calcLens.calculateNew();

        if(isSuccess){
            /*If isNotManualRefresh= TRUE, means that calculateAPI is called by Re-Order functionality and so Calculate(F11) button will still be enabled.  If isNotManualRefresh = FALSE then CalculateAPI is called by Manual Input Save Button by the User*/
            if(calcType == REFRESH && !isNotManualRefresh)
                isManualInputSaved = true;
            else
                isCalculated = true;            

            if(isNotReOrder) {
                Map<String, Object> responseObj = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize( calcLens));
                if(ordItmSide.equalsIgnoreCase(OD)){
                    for(String str : mappings.keySet()){
                        odOrdItm.put(str, responseObj.get(mappings.get(str)));                        
                    }
                } else if(ordItmSide.equalsIgnoreCase(OS)){
                    for(String str : mappings.keySet()){
                        osOrdItm.put(str, responseObj.get(mappings.get(str)));
                    }
                }
            }            
            return JSON.serialize(calcLens);            
        }
        return CALCULATE_FAILED;         
    }

    public void calculateRef() {

        calculate(true, false);
        //return null;    
    }

    /********************************************************************************************************************************************************
      @ Method:           calculate
      @ Version:          1.0
      @ Author:           
      @ Param paramName:  NULL
      @ Return:           Boolean
      @ Purpose:          Mthod the calculate API for each side. If Calculate API return false, then an exception is thrown. 
      ----------------------------------------------------------------------------------------------------------------------------------------------------------
      @ Change history: DD.MM.YYYY /  / Created the method "calculate"
    **********************************************************************************************************************************************************/
    public Boolean calculate(Boolean reOrderCheck, Boolean manualInputCheck){
        Boolean odException = false;
        Boolean osException = false;
        String calcStr = STRING_BLANK;
        String excepStr = 'Lens calculation failed for ';
        String calcType = Apexpages.currentPage().getParameters().get('calcTypeParam');
        errorMessage = STRING_BLANK;
        try{
            List<Account> accList = [SELECT Id, UNITYSALES__ERP_Customer_ID__c FROM Account WHERE UNITYSALES__ERP_Customer_ID__c = :accName AND UNITYSALES__ERP_Customer_ID__c != '' LIMIT 1];
            if(accList.isEmpty()) {
                throw new CustomException('Unable to find the Customer');
            }
            else {
                ord.AccountId = accList[0].Id;
                getEmeraldLimit();
            } 
                

            if(String.isNotBlank(ord.AccountId)) {   
                Account accDeltaType = [SELECT ACDeltaType__c FROM Account WHERE Id =: ord.AccountId LIMIT 1];             
                accACDeltaType = Integer.valueOf(accDeltaType.ACDeltaType__c);
            }
            
            odOrdItm.Design__c = ordItmDesign;
            osOrdItm.Design__c = ordItmDesign;
            odOrdItm.Lens_Product_Name__c = ordItmLens.substringAfter('-').trim();
            osOrdItm.Lens_Product_Name__c = ordItmLens.substringAfter('-').trim();
            odOrdItm.RGP__c = ordItmRGP;
            osOrdItm.RGP__c = ordItmRGP;
            odOrdItm.MaterialLC__c = ordItmMaterial;
            osOrdItm.MaterialLC__c = ordItmMaterial;   
            odOrdItm.Blend__c = ordItmBlend;
            osOrdItm.Blend__c =ordItmBlend;   
            odOrdItm.Order_Priority__c = ord.OrderPriority__c;
            osOrdItm.Order_Priority__c = ord.OrderPriority__c;     

            generateMappings();
            if(ord.Lens_Ord_Itm_Side__c.equalsIgnoreCase(OU)){
                calcStr = calculateAPI(calcType,lensfieldsMapping,odLens,OD,odOrdItm,reOrderCheck,manualInputCheck);

                if(calcStr.containsIgnoreCase(CALCULATE_FAILED)){
                    odException = true;
                    excepStr = excepStr +OD_SIDE;
                } else {
                    odLens = (lens) JSON.deserialize(calcStr, Lens.class);
                }

                calcStr = calculateAPI(calcType,lensfieldsMapping,osLens,OS,osOrdItm,reOrderCheck,manualInputCheck);
                if(calcStr.containsIgnoreCase(CALCULATE_FAILED)){
                    osException = true;
                    if(excepStr.contains(OD_SIDE)){
                        excepStr = excepStr + '& '+OS_SIDE;
                    } else {
                        excepStr = excepStr + OS_SIDE;
                    }
                    
                } else {
                    osLens = (lens) JSON.deserialize(calcStr, Lens.class);
                }

            } else if(ord.Lens_Ord_Itm_Side__c.equalsIgnoreCase(OD)){
                calcStr = calculateAPI(calcType,lensfieldsMapping,odLens,OD,odOrdItm,reOrderCheck,manualInputCheck);
                if(calcStr.containsIgnoreCase(CALCULATE_FAILED)){
                    odException = true;
                    excepStr = excepStr + OD_SIDE;
                } else {
                    odLens = (lens) JSON.deserialize(calcStr, Lens.class);
                }
            } else if(ord.Lens_Ord_Itm_Side__c.equalsIgnoreCase(OS)){
                calcStr = calculateAPI(calcType,lensfieldsMapping,osLens,OS,osOrdItm,reOrderCheck,manualInputCheck);
                if(calcStr.containsIgnoreCase(CALCULATE_FAILED)){
                    osException = true;
                    if(excepStr.contains(OD_SIDE)){
                        excepStr = excepStr + '& '+OS_SIDE;
                    } else {
                        excepStr = excepStr + OS_SIDE;
                    }
                } else {
                    osLens = (lens) JSON.deserialize(calcStr, Lens.class);
                }
            }

            if(odException || osException){
                throw new CustomException(excepStr);
            }
            isCalculated = true;
        }

        catch(Exception ex){
            isCalculated = false;
            errorMessage = ex.getMessage();
            system.debug('Cause ::: '+ex.getCause()+' Line Number ::: '+ex.getLineNumber()+' Message ::: '+ex.getMessage()+' Type ::: '+ex.getTypeName()+' Stack ::: '+ex.getStackTraceString());
        }

        return isCalculated;
    }

    /********************************************************************************************************************************************************
      @ Method:           generateMappings
      @ Version:          1.0
      @ Author:           
      @ Param paramName:  NULL
      @ Return:           NULL
      @ Purpose:          Used to map the fields of Order and Order Item to the values of Lens Model.
                          Mapping configuration is stored in the 'Calaculate_API_Mapping' cutom metadata type.
    ----------------------------------------------------------------------------------------------------------------------------------------------------------
      @ Change history: DD.MM.YYYY /  / Created the method "generateMappings"
    **********************************************************************************************************************************************************/
    public void generateMappings(){
        lensfieldsMapping = new Map<String, String>();

        /*odOrdItm.Lens_Product_Name__c = [SELECT Name FROM Product2 WHERE Id = :ordItmProductId LIMIT 1].Name;
        odOrdItm.Lens_Product_Name__c = odOrdItm.Lens_Product_Name__c.substringAfter('-').trim();
        osOrdItm.Lens_Product_Name__c = odOrdItm.Lens_Product_Name__c;*/    

        for(Lens_Controller_Calculate_API_Mapping__mdt calc : [SELECT Id,Label,Lens_Model_Field_Name__c FROM Lens_Controller_Calculate_API_Mapping__mdt WHERE Object_Type__c = 'Order Item']){
            lensfieldsMapping.put(calc.Label, calc.Lens_Model_Field_Name__c);            
        }
    }  
     
    //Generates picklist values for Design picklist field which retireved from Products.
    public List<SelectOption> getDesignOptions(){
        List<SelectOption> options = new List<SelectOption>();
        for(Design__mdt design : [SELECT MasterLabel FROM Design__mdt]){
             options.add(new SelectOption(design.MasterLabel,design.MasterLabel));
        }
        if(String.isBlank(ordItmDesign)){
           ordItmDesign = '1 - Ortho-K';
        }        

        options.sort();
        return options;       
    }


    //Generates picklist values for Product picklist field based on the design type selelcted.
    public List<SelectOption> getLensOptions(){
        List<SelectOption> options = new List<SelectOption>();
        for(Lens__mdt lens : [SELECT MasterLabel FROM Lens__mdt WHERE Design__r.MasterLabel = :ordItmDesign ORDER BY Order__c ASC]){
             options.add(new SelectOption(lens.MasterLabel,lens.MasterLabel));
        }
        options.sort();
        return options;
    }

    //Generates picklist values for RGP picklist field from Custom Metadata.
    public List<SelectOption> getRGPOptions(){
        List<SelectOption> options = new List<SelectOption>();
        for(RGP__mdt rgp : [SELECT Id, MasterLabel, DeveloperName FROM RGP__mdt ORDER BY MasterLabel ASC]){
             options.add(new SelectOption(rgp.DeveloperName.replace(STRING_UNDERSCORE,STRING_SPACE),rgp.MasterLabel));
        }
        return options;
    }    

    //Generates picklist values for Material picklist field based on the RGP value from Custom Metadata.
    public List<SelectOption> getMaterialOptions(){
        List<SelectOption> options = new List<SelectOption>();
        String ordItmRGP_MDT = ordItmRGP.replace(STRING_SPACE, STRING_UNDERSCORE);
        for(Material__mdt material : [SELECT Id, MasterLabel, DeveloperName, RGP__c, RGP__r.DeveloperName FROM Material__mdt WHERE RGP__r.DeveloperName = :ordItmRGP_MDT ORDER BY MasterLabel ASC]){
             options.add(new SelectOption(material.DeveloperName.replace(STRING_UNDERSCORE,STRING_SPACE),material.MasterLabel));
        }        
        return options;
    }    

    //Generates picklist values for DuplicateType picklist field
    public List<SelectOption> getDuplicateOptions(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('2 - OD','OD'));
        options.add(new SelectOption('3 - OS','OS'));
        options.add(new SelectOption('1 - OU','OU'));
        return options;
    }

    //Generates picklist values for DuplicateType picklist field
    public List<SelectOption> getBlendOptions(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('1 - Heavy','1 - Heavy'));
        options.add(new SelectOption('2 - Medium','2 - Medium'));
        options.add(new SelectOption('3 - Light','3 - Light'));
        return options;
    }

    //Order Priority Picklist Options
    public List<SelectOption> getOrderPriorityOptions(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('NORMAL','Normal'));
        options.add(new SelectOption('IMMED','Immediately'));
        options.add(new SelectOption('VHIGH','Very High'));
        options.add(new SelectOption('HIGH','High'));        
        options.add(new SelectOption('LOW','Low'));
        options.add(new SelectOption('VLOW','Very Low'));

        if(String.isBlank(ord.OrderPriority__c)){
            ord.OrderPriority__c = 'NORMAL';
        }
        return options;
    }

    //Company Picklist Options
    public List<SelectOption> getcompanyOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('ESC','ESC'));
        options.add(new SelectOption('EC','EC'));
        return options;
    }

    //Retrieves the Limit value from the Account selected
    public void getEmeraldLimit(){        
        emeraldLimit = [SELECT Emerald_Target_Limit__c FROM Account WHERE Id = :ord.AccountId LIMIT 1].Emerald_Target_Limit__c;
        if(emeraldLimit == null) {
            emeraldLimit = 0;
        }
    }       

    public void setLookupValue(){
        String lensProdName = ordItmLens.substringAfter('-').trim();        
        for(Lens_Lookup__mdt lookupVal : [SELECT Id, MasterLabel, Lookup_Type__c, Lookup_value__c FROM Lens_Lookup__mdt WHERE MasterLabel = :lensProdName OR MasterLabel =: ordItmMaterial OR MasterLabel =:odOrdItm.Color__c OR MasterLabel = :osOrdItm.Color__c]){
            if(lookupVal.Lookup_Type__c == 'Lens' && lookupVal.MasterLabel == lensProdName){
                odOrdItm.DesignId__c = lookupVal.Lookup_value__c;
                osOrdItm.DesignId__c = lookupVal.Lookup_value__c;
            } else if(lookupVal.Lookup_Type__c == 'Material' && lookupVal.MasterLabel == ordItmMaterial){
                odOrdItm.MaterialId__c = lookupVal.Lookup_value__c;
                osOrdItm.MaterialId__c = lookupVal.Lookup_value__c;
            } else if(lookupVal.Lookup_Type__c == 'Color'){
                if(lookupVal.MasterLabel == odOrdItm.Color__c) {
                    odOrdItm.ColorId__c = lookupVal.Lookup_value__c;
                } 
                if(lookupVal.MasterLabel == osOrdItm.Color__c) {
                    osOrdItm.ColorId__c = lookupVal.Lookup_value__c;
                }
            }
        }
    }
}
