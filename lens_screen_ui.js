$j(document).ready(function() {

    var isCalculated = $j('[id$=isCalculated]').val();

    $j('[id$=odManualInputFields],[id$=osManualInputFields]').find(":text").each(function () {
        var theValue = $j(this).val();
        $j(this).data("value", theValue);
    });

    function addErrorClass(nodeElement, errorString) {
        removeErrorClass(nodeElement);
        $j(nodeElement).parent().addClass("slds-has-error");
        $j(nodeElement).parent().append('<span class="slds-form-element__help">'+errorString+'</span>');
    }

    function removeErrorClass(nodeElement){
        $j(nodeElement).parent().removeClass("slds-has-error");
        $j(nodeElement).parent().find('.slds-form-element__help').remove();
    }

    function k_valueValidation(){
        kError = false;
        var errorString = 'Value is not in range of either mm or diopter';
        for (i = 0; i < arguments.length; i++) {
            var ele = $j('[id$='+arguments[i]+']');
            if(ele.length > 0){
                var diopterVal;
                var mmValue;
                var valInRange = false;
                var enteredVal = $j(ele).val();
                if(enteredVal != ''){
                    if(enteredVal > 2800 && enteredVal < 7000){
                        diopterVal = enteredVal/100;
                        mmValue = (337.5/diopterVal).toFixed(2);
                        valInRange = true;
                    } else if(enteredVal > 28 && enteredVal < 70){
                        diopterVal = enteredVal;
                        mmValue = (337.5/diopterVal).toFixed(2);
                        valInRange = true;
                    } else if(enteredVal > 4.75 & enteredVal < 16){
                        mmValue = enteredVal;
                        diopterVal = (337.5/mmValue).toFixed(2);
                        valInRange = true;
                    } else if(enteredVal > 72 && enteredVal < 99){
                        mmValue = enteredVal/10;
                        diopterVal = (337.5/mmValue).toFixed(2);
                        valInRange = true;
                    } else if(enteredVal > 475 && enteredVal < 1600){
                        mmValue = enteredVal/100;
                        diopterVal = (337.5/mmValue).toFixed(2);
                        valInRange = true;
                    }
                    removeErrorClass(ele);                                                                      
                    
                    if(valInRange){                                         
                        $j(ele).val(mmValue);
                        $j(ele).parent().next().text('('+diopterVal+')');
                    } else {
                        kError = true;                                                                          
                        addErrorClass(ele, errorString);
                    }
                }
            }
        }
        return kError;
    }

    function autoName(){
        var patientAutoName;
        if($j('[id$=side]').val() == '2 - OD'){
            patientAutoName = $j('[id$=autoNamePrefix]').val()+' '+$j('[id$=OD_FlatK]').val()+' / '+$j('[id$=OD_Rx]').val()+' '+$j('[id$=OD_Oad]').val();                           
        } else if($j('[id$=side]').val() == '3 - OS'){
            patientAutoName = $j('[id$=autoNamePrefix]').val()+' '+$j('[id$=OS_FlatK]').val()+' / '+$j('[id$=OS_Rx]').val()+' '+$j('[id$=OS_Oad]').val();                            
        }
        $j('[id$=Patient]').val(patientAutoName);
    }

    function validateInputFields(){
        var tangentArr = ['OS_Tangent','OD_Tangent'];
        var oad_hvid_Arr = ['OD_Oad','OS_Oad','OD_Hvid','OS_Hvid'];
        var axisArr = ['OS_KAxis','OD_KAxis','OS_RAxis','OD_RAxis'];
        var flat_SteepArr = ['OS_FlatK','OS_SteepK','OD_SteepK','OD_FlatK'];
        var rsagArr = ['OD_Rsag','OS_Rsag'];
        var rx_Arr = ['OD_Rx','OS_Rx'];
        var rcyl_Arr = ['OD_RCyl','OS_RCyl'];
        errorString = 'Value is required';
        var divId;
        errorFound = false;
        for (indexVal = 0; indexVal < arguments.length; indexVal++) {
            divId = arguments[indexVal];
            $j('[id$='+divId+']').find(":text").each(function () {  
                if ($j(this).val() == "") {
                    removeErrorClass($j(this));
                    addErrorClass($j(this), errorString);                                   
                    errorFound = true;
                } else {
                    var eleId = $j(this).attr('id').split(':').pop();
                    /*if($j.inArray(eleId, tangentArr) > -1){
                        removeErrorClass($j(this));
                        if($j(this).val() < 31 || $j(this).val() > 39){
                            addErrorClass($j(this), 'Value should be in range of 31 - 39');
                            errorFound = true;
                        }
                    } else*/ if($j.inArray(eleId, axisArr) > -1){
                        removeErrorClass($j(this));
                        if($j(this).val() < 1 || $j(this).val() > 180){
                            addErrorClass($j(this), 'Value should be in range of 1 to 180');
                            errorFound = true;
                        }
                    } else if($j.inArray(eleId, flat_SteepArr) > -1){
                        removeErrorClass($j(this));
                        if($j(this).val() < 28 || $j(this).val() > 70){
                            addErrorClass($j(this), 'Value should be in range of 28 to 70');
                            errorFound = true;
                        }
                    } else if($j.inArray(eleId, oad_hvid_Arr) > -1){

                        removeErrorClass($j(this));
                        while($j(this).val() > 50){
                            $j(this).val(parseInt($j(this).val())/10);
                        }

                        if($j(this).val() <5 || ($j(this).val() > 20 && $j(this).val() < 50)){
                            addErrorClass($j(this), 'Value should be in range of 5 to 20');
                            errorFound = true;
                        }
                    //rSag value validated only if isCalculated is TRUE.
                    } else if($j.inArray(eleId, rsagArr) > -1 && !isCalculated){
                        /*
                        removeErrorClass($j(this));
                        var sagVal = $j(this).val();
                        while(sagVal > 1){
                            sagVal = parseInt(sagVal)/10;
                        }

                        if(sagVal <0.5 || (sagVal > 0.7)){
                            addErrorClass($j(this), 'Value should be in range of 0.5 to 0.7');
                            errorFound = true;
                        } else {
                            $j(this).val(sagVal);
                        }*/                                                                              
                    } else if($j.inArray(eleId, rx_Arr) > -1){
                        removeErrorClass($j(this));
                        var eleVal = $j(this).val();
                        while(eleVal >= 100 || eleVal <= -100){
                            eleVal = parseFloat(eleVal)/10;
                        }
                        if((eleVal < -20 && eleVal > -90) || (eleVal > 20 && eleVal < 99)){
                            addErrorClass($j(this), 'Value should be in range of -20 to 20');
                            errorFound = true;
                        } else {
                            $j(this).val(eleVal);
                        }                                                                              
                    } else if($j.inArray(eleId, rcyl_Arr) > -1){
                        removeErrorClass($j(this));
                        var eleVal = $j(this).val();
                        while(eleVal >= 100 || eleVal <= -100){
                            eleVal = parseFloat(eleVal)/10;
                        }
                        if((eleVal < -40 && eleVal > -90) || (eleVal > 40 && eleVal < 99)){
                            addErrorClass($j(this), 'Value should be in range of -40 to 40');
                            errorFound = true;
                        } else {
                            $j(this).val(eleVal);
                        }
                    }

                    // errorFound = errorFound ? true : validateLensColor();

                    if(!errorFound) removeErrorClass($j(this));
                }
            });
        }
        return errorFound;
    }

    function validateLensColor () {
        $j('[id$=osColor]').parent().parent().removeClass("slds-has-error");
        $j('[id$=osColor]').parent().parent().find('.slds-form-element__help').remove();
        if($j('[id$=odColor]').val() == $j('[id$=osColor]').val()){
            $j('[id$=osColor]').parent().parent().addClass("slds-has-error");
            $j('[id$=osColor]').parent().parent().append('<span class="slds-form-element__help">OD and OS color cannot be same</span>');
            return true;
        }
        return false;
    }

    //Account Lookup Auto Complete
    $j('[id$=LensAccount]').autocomplete({
        source: function(request, response) {
            LensScreenController.searchAccountRecords(request.term, function(result, event){
                if(event.type == 'exception') {
                    alert('An error occurred. Please try again');
                } else {
                    /*if (result.length != 0) {
                        result.push({
                            Name: "No results found"
                        });
                    }*/
                    response(result);
                }
            });
        },

        focus: function(event, ui){
            event.preventDefault();
            $j('[id$=LensAccount]').val(ui.item.label);
            $j('[id$=LensAccountId]').val(ui.item.value);
        },

        select: function( event, ui ) {
            event.preventDefault();
            $j('[id$=LensAccount]').val(ui.item.label);
            $j('[id$=LensAccountId]').val(ui.item.value);
            emeraldLimitValue();
        }
    });

    //ERP RMA Lookup Auto Complete
    $j('[id$=rmaNumber]').autocomplete({
        source: function(request, response) {
            LensScreenController.searchRMARecords(request.term, function(result, event){
                if(event.type == 'exception') {
                    alert('An error occurred. Please try again');
                } else {
                    response(result);
                }
            });
        },



        focus: function(event, ui){ 
            event.preventDefault();
            $j('[id$=rmaNumber]').val(ui.item.label)
        },  

        position : { collision: "flip"},

        select: function( event, ui ) {
            event.preventDefault();
            $j('[id$=rmaNumber]').val(ui.item.label);
            $j('[id$=rmaNumberId]').val(ui.item.value);
        }
    });

    //Patient Lookup Auto Complete
    $j('[id$=Patient]').autocomplete({
        source: function(request, response) {
            var accountId = $j("[id$=LensAccountId").val();
            LensScreenController.searchPatientRecords(request.term, accountId, function(result, event){
                if(event.type == 'exception') {
                    alert('An error occurred. Please try again');
                } else {
                    if (result.length == 0) {
                        result.push({
                            Name: "No results found"
                        });
                    }
                    response(result);
                }
            });
        },

        focus: function(event, ui){
            event.preventDefault();
            $j('[id$=Patient]').val(ui.item.label);
        },

        select: function( event, ui ) {
            event.preventDefault();
            $j('[id$=Patient]').val(ui.item.label);
            $j('[id$=PatientLKId]').val(ui.item.value);
        }

    });

    $j('[id$=Patient], [id$=LensAccount]').change(function(event){
        event.preventDefault();
        if($j(this).val() == 'No results found'){
            $j(this).val('');
        }
    });

    //Used to remove the NONE option from picklist values
    function selectOptionRemove() { 
        $j("select").each(function() {
            $j("select option[value='']").remove();
        }); 
    }

    selectOptionRemove();

    function togglingSides(){
        if($j('[id$=side]').val() == '2 - OD'){
            $j('[id$=odExamDataFields], [id$=odLensDataFields], [id$=odManualInputFields], [id$=osExamDataNoDisplay], [id$=osLensDataNoDisplay], [id$=osManualDataNoDisplay]').removeClass().addClass("slds-show");
            $j('[id$=odExamDataNoDisplay], [id$=osExamDataFields], [id$=osLensDataFields], [id$=osManualInputFields],[id$=odManualDataNoDisplay],[id$=odLensDataNoDisplay]').removeClass().addClass("slds-hide");
            $j('[id$=odExamDataFields], [id$=odLensDataFields], [id$=odManualInputFields]').removeClass("slds-border_right");
            $j('[id$=osExamDataFields], [id$=osLensDataFields], [id$=osManualInputFields]').removeClass("slds-border_left");
            // $j('[id$=osExamDataFields], [id$=osLensDataFields], [id$=osManualInputFields]').find('input:text').val('');                                                     

        } else if($j('[id$=side]').val() == '3 - OS'){
            $j('[id$=osExamDataFields], [id$=osLensDataFields], [id$=osManualInputFields], [id$=odExamDataNoDisplay], [id$=odLensDataNoDisplay], [id$=odManualDataNoDisplay]').removeClass().addClass("slds-show");
            $j('[id$=osExamDataNoDisplay], [id$=odExamDataFields], [id$=odLensDataFields], [id$=odManualInputFields],[id$=osManualDataNoDisplay],[id$=osLensDataNoDisplay]').removeClass().addClass("slds-hide");
            $j('[id$=odExamDataFields], [id$=odLensDataFields], [id$=odManualInputFields]').removeClass("slds-border_right");
            $j('[id$=osExamDataFields], [id$=osLensDataFields], [id$=osManualInputFields]').removeClass("slds-border_left");
            // $j('[id$=odExamDataFields], [id$=odLensDataFields], [id$=odManualInputFields]').find('input:text').val('');  
            //$j('[id$=autoNameOptions]').trigger( "change" );                           

        } else if($j('[id$=side]').val() == '1 - OU'){                            
            $j('[id$=osExamDataFields], [id$=osLensDataFields], [id$=osManualInputFields], [id$=odExamDataFields], [id$=odLensDataFields], [id$=odManualInputFields]').removeClass().addClass("slds-show");
            $j('[id$=odExamDataNoDisplay], [id$=odLensDataNoDisplay], [id$=odManualDataNoDisplay], [id$=osExamDataNoDisplay],[id$=osLensDataNoDisplay],[id$=osManualDataNoDisplay]').removeClass().addClass("slds-hide");                            
            $j('[id$=autoNameOptions]').prop('checked', false);
            $j('[id$=odExamDataFields], [id$=odLensDataFields], [id$=odManualInputFields]').removeClass().addClass("slds-border_right");
            $j('[id$=osExamDataFields], [id$=osLensDataFields], [id$=osManualInputFields]').removeClass().addClass("slds-border_left");
            // $j('[id$=autoNameOptions]').trigger( "change" );
        }

        if($j('[id$=autoNameOptions]').prop('checked')){
            $j('[id$=autoNameOptions]').trigger( "change" );
        } 
    }

    //Toggling the OD and OD sides
    togglingSides();
    

    $j('[id$=side]').change(function(event){
        event.preventDefault();
        togglingSides();
    });

    //Calculate the POZ value
    function calcPoz () {
        if(($j('[id$=side]').val() == '1 - OU') || ($j('[id$=side]').val() == '2 - OD')) {                            

            var odOad = (parseFloat($j('[id$=OD_Oad]').val()));
            var odIrW1 = ($j('[id$=OD_Irw1]').length > 0) ? parseFloat($j('[id$=OD_Irw1]').val()) : 0.000;
            var odIrW2 = ($j('[id$=OD_Irw2]').length > 0) ? parseFloat($j('[id$=OD_Irw2]').val()) : 0.000;
            var odIrW3 = ($j('[id$=OD_Irw3]').length > 0) ? parseFloat($j('[id$=OD_Irw3]').val()) : 0.000;
            var odIrW4 = ($j('[id$=OD_Irw4]').length > 0) ? parseFloat($j('[id$=OD_Irw4]').val()) : 0.000;
            var odIrW5 = ($j('[id$=OD_Irw5]').length > 0) ? parseFloat($j('[id$=OD_Irw5]').val()) : 0.000;
            var odIrW6 = ($j('[id$=OD_Irw6]').length > 0) ? parseFloat($j('[id$=OD_Irw6]').val()) : 0.000;
            var odIrW7 = ($j('[id$=OD_Irw7]').length > 0) ? parseFloat($j('[id$=OD_Irw7]').val()) : 0.000;

            var odPozVal = (odOad - (2*(odIrW1 + odIrW2 + odIrW3 + odIrW4 + odIrW5 + odIrW6 + odIrW7)));
            $j('[id$=OD_Poz]').val(odPozVal.toFixed(3));
        }

        if(($j('[id$=side]').val() == '1 - OU') || ($j('[id$=side]').val() == '3 - OS')) {
            var osOad = (parseFloat($j('[id$=OS_Oad]').val()));
            var osIrW1 = ($j('[id$=OS_Irw1]').length > 0) ? parseFloat($j('[id$=OS_Irw1]').val()) : 0.000;
            var osIrW2 = ($j('[id$=OS_Irw2]').length > 0) ? parseFloat($j('[id$=OS_Irw2]').val()) : 0.000;
            var osIrW3 = ($j('[id$=OS_Irw3]').length > 0) ? parseFloat($j('[id$=OS_Irw3]').val()) : 0.000;
            var osIrW4 = ($j('[id$=OS_Irw4]').length > 0) ? parseFloat($j('[id$=OS_Irw4]').val()) : 0.000;
            var osIrW5 = ($j('[id$=OS_Irw5]').length > 0) ? parseFloat($j('[id$=OS_Irw5]').val()) : 0.000;
            var osIrW6 = ($j('[id$=OS_Irw6]').length > 0) ? parseFloat($j('[id$=OS_Irw6]').val()) : 0.000;
            var osIrW7 = ($j('[id$=OS_Irw7]').length > 0) ? parseFloat($j('[id$=OS_Irw7]').val()) : 0.000;

            var osPozVal = (osOad - (2*(osIrW1 + osIrW2 + osIrW3 + osIrW4 + osIrW5 + osIrW6 + osIrW7)));
            $j('[id$=OS_Poz]').val(osPozVal.toFixed(3));
        }

    }

    //Manual Edit button is enabled once Calculate is run.
    if(!isCalculated){
        $j('[id$=editManualInput]').prop('disabled', true);
        if($j('[id$=side]').val() == '1 - OU'){                            
            $j('[id$=OD_Rx], [id$=OS_Rx]').trigger('change');
        } else if($j('[id$=side]').val() == '2 - OD') {
            $j('[id$=OD_Rx]').trigger('change');
        } else {
            $j('[id$=OS_Rx]').trigger('change');
        }                        
        calcPoz();
        editManualInputFunction();
        $j('[id$=lens],[id$=design]').prop('disabled', true);                        
    } else {
        $j('[id$=editManualInput],[id$=editExamData]').prop('disabled', true);
        $j('#manualInputSection input[type="text"]').prop("disabled", true);
        $j('[id$=lensFieldsData] input[type="text"]').prop("disabled", true);
    }

    

    $j('[id$=OD_Irw1], [id$=OD_Irw2], [id$=OD_Irw3], [id$=OD_Irw4], [id$=OD_Irw5], [id$=OD_Irw6], [id$=OD_Irw7], [id$=OD_Irw1], [id$=OS_Irw2], [id$=OS_Irw3], [id$=OS_Irw4], [id$=OS_Irw5], [id$=OS_Irw6], [id$=OS_Irw7]').change(function(event){
        event.preventDefault();
        calcPoz();
        
    });

    //Calculate button is diabled if Save button(manual input data) is clicked. 
    /*if({!isManualInputSaved}){
        $j('[id$=calculate]').prop('disabled', true);
    } else {
        $j('[id$=calculate]').prop('disabled', false);
    }*/

    function editManualInputFunction () {
        $j('#manualInputSection input[type="text"], [id$=saveManualInput]').prop("disabled", false);
        $j('[id$=lensFieldsData] input[type="text"]').prop("disabled", false);
        $j('[id$=examDatafields] input[type="text"], [id$=editManualInput]').prop("disabled", true);

        $j('[id$=OS_Oad], [id$=OD_Oad], [id$=editExamData]').prop("disabled", false);
        $j('[id$=calculate]').prop("disabled", true);

        if($j('[id$=side]').val() == '3 - OS'){
            $j('[id$=OS_Par]').focus().select();
        } else {
            $j('[id$=OD_Par]').focus().select();                                                    
        }
        $j('[id$=OD_Poz]').prop("disabled", true);
        $j('[id$=OS_Poz]').prop("disabled", true);
    }
    

    // On click of Edit button all manual input fields are enabled along with Save and Cancel button
    $j('[id$=editManualInput]').click(function(event){
        event.preventDefault();                        
        editManualInputFunction();                        
    });

    $j('[id$=editExamData]').click(function(event){
        event.preventDefault();
        $j('#manualInputSection input[type="text"], [id$=saveManualInput]').prop("disabled", true);
        $j('[id$=lensFieldsData] input[type="text"],[id$=editExamData]').prop("disabled", true);
        $j('[id$=examDatafields] input[type="text"], [id$=editManualInput],[id$=calculate]').prop("disabled", false);

        $j('[id$=OD_Correct], [id$=OD_Correct]').prop("disabled", true);

        if($j('[id$=side]').val() == '3 - OS'){
            $j('[id$=OS_FlatK]').focus().select();
        } else {
            $j('[id$=OD_FlatK]').focus().select();                                                    
        }
                              
    });

    // On click of Save or Cancel all the manual input fields are disabled and edit button is enabled
    $j('[id$=saveManualInput]').click(function(event){
        event.preventDefault();  
        if (event.handled !== true) {
            event.handled = true;
            errorFound = false;  
            var str = event.target.id;
            if(str.indexOf('saveManualInput') >= 0){
                if($j('[id$=side]').val() == '1 - OU'){
                    errorFound = validateInputFields('odManualInputFields','osManualInputFields');  
                } else if($j('[id$=side]').val() == '2 - OD'){
                    errorFound = validateInputFields('odManualInputFields');
                } else {
                    errorFound = validateInputFields('osManualInputFields');
                }
            } else {
                $j('[id$=odManualInputFields]').find(":text").each(function () {
                    var previousValue = $j(this).data("value");
                    $j(this).val(previousValue);
                });
            }                    
            
            if(!errorFound){
                if($j('[id$=side]').val() == '2 - OD'){
                    $j('[id$=odManualInputFields]').find(":text").each(function () {
                        removeErrorClass($j(this));
                    });
                    kError = k_valueValidation('OD_Ir1','OD_Ir2','OD_Ir3','OD_Ir4','OD_Ir5','OD_Ir6','OD_Ir7');
                } else if($j('[id$=side]').val() == '3 - OS'){
                    $j('[id$=osManualInputFields]').find(":text").each(function () {
                        removeErrorClass($j(this));
                    });
                    kError = k_valueValidation('OS_Ir1','OS_Ir2','OS_Ir3','OS_Ir4','OS_Ir5','OS_Ir6','OS_Ir7');
                } else {
                    $j('[id$=odManualInputFields]').find(":text").each(function () {
                        removeErrorClass($j(this));
                    });
                    $j('[id$=osManualInputFields]').find(":text").each(function () {
                        removeErrorClass($j(this));
                    });
                    kError = k_valueValidation('OD_Ir1','OD_Ir2','OD_Ir3','OD_Ir4','OD_Ir5','OD_Ir6','OD_Ir7','OS_Ir1','OS_Ir2','OS_Ir3','OS_Ir4','OS_Ir5','OS_Ir6','OS_Ir7');
                }                           

                
                if(!kError){                                   

                    $j('#manualInputSection input[type="text"], [id$=saveManualInput]').prop("disabled", true);
                    $j('[id$=lensFieldsData] input[type="text"]').prop("disabled", true);
                    $j('[id$=examDatafields] input[type="text"],[id$=editManualInput]').prop("disabled", false);
                    $j('[id$=OD_Correct],[id$=OS_Correct]').prop("disabled", true);                                    
                    
                    $j('[id$=lensComments]').focus().select();

                    if(str.indexOf('saveManualInput') >= 0){
                        calc('Refresh');
                    }
                }
            }
        }
                                
    });

    //Event fired when Save Duplicate button is clicked
    $j('[id$=saveDupBtn]').unbind().click(function(event) {
        event.preventDefault();
        var ele = $j('[id$=qty]');
        var errorString = 'Value is required'
        removeErrorClass(ele);
        if($j('[id$=qty]').val() <= 0 || $j('[id$=qty]').val() == ''){
            addErrorClass(ele, errorString);
        } else {
            if(!account_patient_validate()){
                // saveDup($j('[id$=qty]').val());
                saveDup();
            }                           
        } 
    });


    /*TAB and SHIFT TAB Events -- START*/
    $j('[id$=OD_Oad]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                if (!($j('[id$=saveManualInput]').prop('disabled'))) {
                    $j('[id$=OD_Bvp]').focus().select();
                } else {
                    $j('[id$=OD_RAxis]').focus().select();
                }                                
            } else {
                if (($j('[id$=saveManualInput]').prop('disabled'))) {
                    if($j('[id$=side]').val() == '2 - OD'){
                        $j('[id$=calculate]').focus().select();
                    } else {
                        $j('[id$=OS_FlatK]').focus().select();
                    }
                    
                } else {
                    $j('[id$=OD_Ct]').focus().select();
                }                                
            }                           
            event.preventDefault();                           
        }
    });


    $j('[id$=OD_Ct]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                $j('[id$=OD_Oad]').focus().select();                               
            } else {
                $j('[id$=OD_Ir1]').focus().select();
            }
            event.preventDefault();                                                       
        }
    });

    $j('[id$=OS_Ct]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                $j('[id$=OS_Oad]').focus().select();                               
            } else {
                $j('[id$=OS_Ir1]').focus().select();
            }
            event.preventDefault();                                                       
        }
    });

    $j('[id$=OS_Poz]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                $j('[id$=OS_Ct]').focus().select();
            } else {
                $j('[id$=OS_Ir1]').focus().select();                                
            }                           
            event.preventDefault();
        }                                       
    });


    $j('[id$=lensComments]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                if(!$j('[id$=editManualInput]').is(':disabled')){
                    $j('[id$=editManualInput]').focus().select();
                } else if($j('[id$=side]').val() == '2 - OD'){
                    $j('[id$=OD_Bfs]').focus().select();
                } else {
                    $j('[id$=OS_Bfs]').focus().select();
                }                                
            } else {
                $j('[id$=UseOTS]').focus().select();
            }                            
            event.preventDefault();                           
        }
    });

    $j('[id$=UseOTS]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                $j('[id$=lensComments]').focus().select();
                event.preventDefault();
            }                                                      
        }
    });

    $j('[id$=OS_Oad]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                if (!($j('[id$=saveManualInput]').prop('disabled'))) {
                    $j('[id$=OS_Bvp]').focus().select();
                } else {
                    $j('[id$=OS_RAxis]').focus().select();
                }                                
            } else {
                if (($j('[id$=saveManualInput]').prop('disabled'))) {
                    /*if($j('[id$=side]').val() == '1 - OU'){
                        $j('[id$=OD_Adjustment]').focus().select();
                    } else {
                        $j('[id$=OS_Adjustment]').focus().select();
                    }*/                                            
                    $j('[id$=calculate]').focus().select();                            
                } else {
                    $j('[id$=OS_Ct]').focus().select();
                }                                
            }                           
            event.preventDefault();                           
        }
    });

    $j('[id$=OD_Tangent]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                $j('[id$=OD_Rsag]').focus().select();
            } else {
                if($j('[id$=side]').val() == '2 - OD'){
                    $j('[id$=nLaser]').focus().select();
                } else {
                    $j('[id$=OS_Adjustment]').focus().select();
                }                                
            }                           
            event.preventDefault();                            
        }
    });

    $j('[id$=OD_Bvp]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                $j('[id$=OD_Par]').focus().select();
            } else {
                $j('[id$=OD_Oad]').focus().select();
            }                           
            event.preventDefault();                            
        }
    });


    $j('[id$=OS_Bvp]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                $j('[id$=OS_Par]').focus().select();
            } else {
                $j('[id$=OS_Oad]').focus().select();
            }                           
            event.preventDefault();                            
        }
    });


    $j('[id$=OS_Par]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                if($j('[id$=side]').val() == '1 - OU'){
                    $j('[id$=OD_MinET]').focus().select();                                    
                }
                event.preventDefault();                                
            }                                                        
        }
    });


    $j('[id$=osColor]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                $j('[id$=odColor]').focus().select();
            } else {
                $j('[id$=nLaser]').focus().select();    
            }
            event.preventDefault();                            
        }
    }).keyup(function(event) {
        if(event.which > 48 && event.which < 57){                            
            $j('[id$=nLaser]').focus().select();
        }                                                
    });

    $j('[id$=nLaser]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                $j('[id$=osColor]').focus().select();
                event.preventDefault();
            }                            
        }
    });

    $j('[id$=ChinaOptions]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                $j('[id$=cShip]').focus().select();
            } else {
                if($j('[id$=side]').val() == '3 - OS'){
                    $j('[id$=OS_FlatK]').focus().select();
                } else {
                    $j('[id$=OD_FlatK]').focus().select(); 
                }
            }                           
            event.preventDefault();                         
        }                                             
    });
    

    $j('[id$=OD_FlatK]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                $j('[id$=ChinaOptions]').focus().select();
                event.preventDefault();
            }                                                   
        }                                             
    });

    $j('[id$=OD_Adjustment]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                if($j('[id$=side]').val() == '1 - OU'){
                    $j('[id$=OS_Oad]').focus().select();
                    event.preventDefault();
                }                               
            }                                                   
        }                                             
    });

    $j('[id$=OS_Adjustment]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                if($j('[id$=side]').val() == '1 - OU'){
                    $j('[id$=OD_Tangent]').focus().select();
                    event.preventDefault();
                }                               
            }                                                   
        }                                             
    });

    $j('[id$=OS_FlatK]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                if($j('[id$=side]').val() == '3 - OS'){
                    $j('[id$=ChinaOptions]').focus().select();                                  
                } else {
                    $j('[id$=OD_Oad]').focus().select();
                }
                event.preventDefault();                             
            }                                                   
        }                                             
    });


    $j('[id$=OD_Bfs]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                $j('[id$=OD_Poz]').focus().select();
            } else {
                $j('[id$=OD_CCR]').focus().select();                               
            }
            event.preventDefault();                         
        }                                           
    });

    $j('[id$=OS_Bfs]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                $j('[id$=OS_Poz]').focus().select();
            } else {
                $j('[id$=OS_CCR]').focus().select();
            }                           
            event.preventDefault();
        }                                       
    });

    $j('[id$=OS_CCR]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                $j('[id$=OS_Bfs]').focus().select();
            } else {
                if($j('[id$=side]').val() == '3 - OS'){
                    $j('[id$=OS_Ir1]').focus().select();
                } else {
                    $j('[id$=OD_Ir1]').focus().select();
                }
            }                           
            event.preventDefault();
        }                                       
    });


    $j('[id$=OD_Poz]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                $j('[id$=OD_Ct]').focus().select();
            } else {
                $j('[id$=OD_Ir1]').focus().select();                                
            }                           
            event.preventDefault();
        }                                       
    });


    $j('[id$=OD_Ir1]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                $j('[id$=OD_Poz]').focus().select();
                event.preventDefault();
            }                            
        }                                       
    });

    $j('[id$=OS_Ir1]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                $j('[id$=OS_Poz]').focus().select();
                event.preventDefault();
            }                            
        }                                       
    });
          

    $j('[id$=OD_MinET]').keydown(function(event){
        if(event.keyCode == '9'){
            if(event.shiftKey) {
                $j('[id$=OD_MinJT]').focus().select();
            } else {
                if($j('[id$=side]').val() == '2 - OD'){
                    $j('[id$=saveManualInput]').focus().select();
                } else if($j('[id$=editManualInput]').is(':disabled')){
                    $j('[id$=OS_Par]').focus().select();
                }
            }
            
            event.preventDefault(); 
        }                                        
    });


    $j('[id$=OD_Aoz]').keydown(function(event){
        if(event.keyCode == '9'){                            
            if($j('[id$=side]').val() == '2 - OD'){
                $j('[id$=saveManualInput]').focus().select();
            } else {
                $j('[id$=OS_Par]').focus().select();
            }                            
            event.preventDefault(); 
        }                                        
    });

    $j('[id$=OS_Aoz]').keydown(function(event){
        if(event.keyCode == '9'){
            $j('[id$=saveManualInput]').focus().select();                                                        
            event.preventDefault(); 
        }                                        
    });


    $j('[id$=editManualInput]').keydown(function(event){
        if(event.keyCode == '9'){ 
            $j('[id$=lensComments]').focus().select();                            
            event.preventDefault(); 
        }                                        
    });
    
    /*TAB and SHIFT TAB Events -- END*/                                                      

    // Toggling of Save Duplicate feature
    $j('[id$=saveDupOptions]').change(function(event){
        event.preventDefault();
        if($j(this).prop('checked')){
            $j('[id$=qty], [id$=saveDupBtn]').prop('disabled', false);
            $j('#save').prop('disabled', true);
        } else {
            $j('[id$=qty], [id$=saveDupBtn]').prop('disabled', true);
            $j('#save').prop('disabled', false);
            $j('[id$=qty]').val('');
        }
    });

    $j('[id$=saveDupOptions]').trigger('change');

    /* Toggling of Patient Auto Name functionality -- START */
    $j('[id$=autoNameOptions]').change(function(event){
        event.preventDefault();                        
        if($j(this).prop('checked')){
            if($j('[id$=side]').val() == '1 - OU')
                $j('[id$=side]').val('2 - OD').change();                            
              
            $j('[id$=autoNamePrefix]').prop('disabled', false);                           
            if($j('[id$=ordType]').val() == '5 - Trial Lens'){
                $j('[id$=autoNamePrefix]').val('Trial: ');
            } else {
                $j('[id$=autoNamePrefix]').val('Stock: ');
            }
            $j('[id$=autoNamePrefix]').trigger('change');                            
            
        } else {
            $j('[id$=autoNamePrefix]').val('');
            $j('[id$=autoNamePrefix]').prop('disabled', true);                            
            $j('[id$=Patient]').val('');
            $j('[id$=PatientLKId]').val('');                            
        }
    });

    if($j('[id$=autoNameOptions]').prop('checked')){
        $j('[id$=autoNamePrefix]').prop('disabled',false);
    }                    

    $j('[id$=autoNamePrefix]').change(function(event){
        event.preventDefault();
        autoName();                     
    });

    $j('[id$=LensAccount]').keydown(function(event){
        var key = event.keyCode || event.charCode;
        if(key == 8 || key == 46){
            $j('[id$=LensAccountId').val("");                                            
        }
    });

    $j('[id$=Patient]').keydown(function(event){
        var key = event.keyCode || event.charCode;
        if(key == 8 || key == 46){
            $j('[id$=PatientLKId').val(""); 
        }
    });

    function autoNameCheckLoad () {
        if($j('[id$=autoNameOptions]').prop('checked')){
            $j('[id$=autoNamePrefix]').prop('disabled', false);
        }
    }

    $j('[id$=OD_FlatK], [id$=OD_Rx], [id$=OD_Oad], [id$=OS_FlatK], [id$=OS_Rx], [id$=OS_Oad]').change(function(event){
        if($j('[id$=autoNameOptions]').prop('checked')){
            $j('[id$=autoNameOptions]').trigger( "change" );
        }                       
    });

    //Calculation of Correction value.                    

    $j('[id$=OD_Rx],[id$=OD_Adjustment]').change(function(event) {
        var od_rxVal;
        var thisVal = ($j('[id$=OD_Rx]').val());
        if(Number.isInteger(thisVal)){
            var floatVal = thisVal/100;
            console.log('floatVal ::: OD RX '+floatVal);
            od_rxVal = (floatVal).toFixed(2);
        } else {
            od_rxVal = parseFloat($j('[id$=OD_Rx]').val());
        }
        
        var targetLimit = '{!emeraldLimit}';
        var odNum;
        if(od_rxVal >= targetLimit){
            odNum = parseFloat(od_rxVal) + parseFloat($j('[id$=OD_Adjustment]').val());
            $j('[id$=OD_Correct').val(odNum.toFixed(2));
        } else {
            odNum = parseFloat(targetLimit)+parseFloat($j('[id$=OD_Adjustment]').val());
            $j('[id$=OD_Correct').val(odNum.toFixed(2));
        }                       
    });

    $j('[id$=OS_Rx],[id$=OS_Adjustment]').change(function(event) {
        
        var os_rxVal;
        var thisVal = ($j('[id$=OS_Rx]').val());
        if(Number.isInteger(thisVal)){
            var floatVal = thisVal/100;
            os_rxVal = (floatVal).toFixed(2);
        } else {
            os_rxVal = parseFloat($j('[id$=OS_Rx]').val());
        }
        
        var targetLimit = '{!emeraldLimit}';
        var odNum;
        if(os_rxVal >= targetLimit){
            osNum = parseFloat(os_rxVal) + parseFloat($j('[id$=OS_Adjustment]').val());
            $j('[id$=OS_Correct').val(osNum.toFixed(2));
        } else {
            osNum = parseFloat(targetLimit)+parseFloat($j('[id$=OS_Adjustment]').val());
            $j('[id$=OS_Correct').val(osNum.toFixed(2));
        }

    });

    $j('[id$=OD_FlatK], [id$=OS_FlatK], [id$=OD_SteepK], [id$=OS_SteepK]').change(function(event){
        var thisVal = Number($j(this).val());
        if(Number.isInteger(thisVal)){
            if (thisVal > 0 && thisVal < 100) {
                $j(this).val((thisVal).toFixed(2));
            } else if (thisVal > 99 && thisVal < 1000) {
                var floatVal = thisVal/10;
                $j(this).val((floatVal).toFixed(2));
            } else {
                var floatVal = thisVal/100;
                $j(this).val((floatVal).toFixed(2));
            }
        }
    });

    $j('[id$=OD_Rx], [id$=OS_Rx], [id$=OD_RCyl], [id$=OS_RCyl]').change(function(event){
        var thisVal = Number($j(this).val());
        if(Number.isInteger(thisVal)){
            if ((thisVal > 0 && thisVal < 100) || (thisVal < 0 && thisVal > -99)) {
                $j(this).val((thisVal).toFixed(2));
            } else {
                var floatVal = thisVal/100;
                $j(this).val((floatVal).toFixed(2));
            }
        }
    });

    $j('[id$=OD_Oad], [id$=OS_Oad]').change(function(event){
        var thisVal = Number($j(this).val());
        if(Number.isInteger(thisVal)){
            if (thisVal > 0 && thisVal < 100) {
                $j(this).val((thisVal).toFixed(1));
            } else {
                var floatVal = thisVal/10;
                $j(this).val((floatVal).toFixed(1));
            }
        }
    });


    $j('[id$=OD_Irw1], [id$=OD_Irw2], [id$=OD_Irw3], [id$=OD_Irw4], [id$=OD_Irw5], [id$=OD_Irw6], [id$=OD_Irw7], [id$=OS_Irw1], [id$=OS_Irw2], [id$=OS_Irw3], [id$=OS_Irw4], [id$=OS_Irw5], [id$=OS_Irw6], [id$=OS_Irw7]').change(function(event){
        var thisVal = Number($j(this).val());
        if(Number.isInteger(thisVal)){
            if (thisVal == 1) {
                $j(this).val(parseFloat(thisVal).toFixed(2));
            } else if ((thisVal > 1 && thisVal <= 19)) {
                var floatVal = thisVal/10;
                $j(this).val((floatVal).toFixed(2));
            } else {
                var floatVal = thisVal/100;
                $j(this).val((floatVal).toFixed(2));
            }
        }
    });


    /* Toggling of Patient Auto Name functionality -- END */ 

    //Validating Account and Patient 
    function account_patient_validate () {
        acc_patienterrorFound = false;
        if($j('[id$=LensAccountId]').val() == '' || $j('[id$=LensAccount]').val() == ''){
            acc_patienterrorFound = true;
            var ele = $j('[id$=LensAccountId]');
            removeErrorClass(ele);
            addErrorClass(ele, 'Account is required');
        } else {
            var ele = $j('[id$=LensAccountId]'); 
            removeErrorClass(ele);
        }

        if($j('[id$=autoNameOptions]').prop('checked')){
            if($j('[id$=Patient]').val() == ''){
                acc_patienterrorFound = true;  
            }
        }

        if($j('[id$=Patient]').val() == ''){
            acc_patienterrorFound = true;
            var ele = $j('[id$=PatientLKId]'); 
            removeErrorClass(ele);
            addErrorClass(ele, 'Patient is required');
        } else {
            var ele = $j('[id$=PatientLKId]'); 
            removeErrorClass(ele);
        }
        return acc_patienterrorFound;
    }                     

    //Event fired when SAVE button(bottom right corner) is clicked
    $j('[id$=save]').click(function(event){
        event.preventDefault();
        $j('[id$=OD_Rx],[id$=OS_Rx]').trigger('change');
        if (event.handled !== true) {
            event.handled = true;
            errorFound = false;
            if($j('[id$=side]').val() == '1 - OU'){
                if(!isCalculated){
                    errorFound = validateInputFields('odExamDataFields','osExamDataFields','odLensDataFields','osLensDataFields','odManualInputFields','osManualInputFields');
                } else {
                    errorFound = validateInputFields('odExamDataFields','osExamDataFields');
                }

            } else if($j('[id$=side]').val() == '2 - OD'){
                if(!isCalculated){
                    errorFound = validateInputFields('odExamDataFields','odLensDataFields','odManualInputFields');
                } else {
                    errorFound = validateInputFields('odExamDataFields');
                }

            } else {
                if(!isCalculated){
                    errorFound = validateInputFields('osExamDataFields','osLensDataFields','osManualInputFields');
                } else {
                    errorFound = validateInputFields('osExamDataFields');
                }
            }

            if(account_patient_validate()){
                errorFound = true;
            }

            if(!errorFound){
                saveOrder();
            }
        }
    });

    //Calculates the Lens Data and manual input data of respective sides 
    $j('[id$=calculate]').click(function(event){
        $j('[id$=calculate]').prop('disabled', 'true')
        event.preventDefault();
        $j('[id$=OD_Rx],[id$=OS_Rx]').trigger('change');
        errorFound = false;
        if($j('[id$=side]').val() == '1 - OU'){
            errorFound = validateInputFields('odExamDataFields','osExamDataFields');    
        } else if($j('[id$=side]').val() == '2 - OD'){
            errorFound = validateInputFields('odExamDataFields');
        } else {
            errorFound = validateInputFields('osExamDataFields');
        }
        if(!errorFound) calc('New');
    });

    //Resets the entire form along with Session counter
    $j('[id$=reset]').click(function(event){
        //Check for Browser compatability
        event.preventDefault();                     
        resetSessionCounter();
        var url = 'https://'+window.location.hostname+'/apex/LensScreenUI';
        window.location = url; 
    });                                             

    //Validates the manual input values in real-time.
    $j( '[id$=OD_Par],[id$=OS_Par],[id$=OD_Ir1],[id$=OD_Ir2],[id$=OD_Ir3],[id$=OD_Ir4],[id$=OD_Ir5],[id$=OD_Ir6],[id$=OD_Ir7],[id$=OS_Ir1],[id$=OS_Ir2],[id$=OS_Ir3],[id$=OS_Ir4],[id$=OS_Ir5],[id$=OS_Ir6],[id$=OS_Ir7]').change(function() {
        k_valueValidation($j(this).attr('id').split(':').pop());                                                                
    }); 

    $j( '[id$=OD_Par],[id$=OS_Par],[id$=OD_Ir1],[id$=OD_Ir2],[id$=OD_Ir3],[id$=OD_Ir4],[id$=OD_Ir5],[id$=OD_Ir6],[id$=OD_Ir7],[id$=OS_Ir1],[id$=OS_Ir2],[id$=OS_Ir3],[id$=OS_Ir4],[id$=OS_Ir5],[id$=OS_Ir6],[id$=OS_Ir7]').trigger( "change" );

    

    $j("select").change(function() {
        selectOptionRemove();
    });

    $j('[id$=ordType]').change(function () {
        if($j('[id$=autoNameOptions]').prop('checked')) {
            $j('[id$=autoNameOptions]').trigger('change');
        }
    });

    //Tabs to the next element on numeric keypress in Order Information Section
    $j('[id$=ordType],[id$=side],[id$=blend],[id$=design],[id$=lens],[id$=rgp],[id$=material],[id$=odColor]').keyup(function(event) {
        if(event.which > 47 && event.which < 58){                            
            $j(this).closest('div').parent('div').parent('div').next('div').find('select').focus().select();
        }                                                
    });


    /*Autofilling Steep_K with Flat_K value untill Steep_K is changed -- START */
    $j('[id$=OD_FlatK],[id$=OS_FlatK]').on('focusin', function(){
        $j(this).data("value", $j(this).val());
    });

    
    $j('[id$=OD_FlatK]').change(function(event) {
        var odFlatkPrevVal = $j(this).data("value");
        var odFlatkVal = $j(this).val();
        var odSteepkVal = $j('[id$=OD_SteepK]').val();
        if(odFlatkPrevVal == odSteepkVal){
            $j('[id$=OD_SteepK]').val(odFlatkVal);
        }
    });

    $j('[id$=OS_FlatK]').change(function(event) {
        var osFlatkPrevVal = $j(this).data("value");
        var osFlatkVal = $j(this).val();
        var osSteepkVal = $j('[id$=OS_SteepK]').val();
        if(osFlatkPrevVal == osSteepkVal){
            $j('[id$=OS_SteepK]').val(osFlatkVal);
        }
    });



    /*Autofilling Steep_K with Flat_K value untill Steep_K is changed -- END */
    
    /*Toggling of Shipping and China options picklist fields -- START*/

    $j('[id$=shipping]').change(function(event) {
        if($j('[id$=shipping]').val() != 'Standard' && $j('[id$=ChinaOptions]').val() != 'Standard'){
            $j('[id$=ChinaOptions]').val('Standard');
        }
    });

    $j('[id$=ChinaOptions]').change(function(event) {
        if($j('[id$=shipping]').val() !='Standard' && $j('[id$=ChinaOptions]').val() != 'Standard'){
            $j('[id$=shipping]').val('Standard');
        }
    });

    if ( $j('[id$=editManualInput]').prop('disabled') && $j('[id$=saveManualInput]').prop('disabled')) {
        $j('[id$=calculate]').prop('disabled', false);
    } else {
        $j('[id$=calculate]').prop('disabled', true);
    }

    /*Toggling of Shipping and China options picklist fields -- END*/
    /*$j( '[id$=odManualInputFields]' ).find( 'fieldset div div:last input:last-child' ).bind( 'keydown', function( event ) {
        if( event.which === 9 ){
            if($j('[id$=side]').val() == '1 - OU'){
                $j('[id$=OS_Par]').focus().select();
            } else if($j('[id$=side]').val() == '2 - OD'){
                $j('[id$=saveManualInput]').focus().select();
            }
            event.preventDefault();
        }
    });*/

    /*$j( '[id$=osManualInputFields]' ).find( 'fieldset div div:last input:last-child' ).bind( 'keydown', function( event ) {
        if( event.which === 9 ){
            $j('[id$=saveManualInput]').focus().select();
            event.preventDefault();
        }
    });*/
});
