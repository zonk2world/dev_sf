public class LensValidationRules {

    public string Design { get; set; }
    public string Material { get; set; }

    public double rx{get; set;}
    public double rcyl{get; set;}
    public double raxis{get; set;}
    public double correct{get; set;}
    public double flatk{get; set;}
    public double steepk{get; set;}
    public double kaxis{get; set;}

    public Integer nBlend { get; set; }
    //public string ChinaOptions { get; set; }  //not needed for lens calculation
    //public string cClass { get; set; }     //not needed for lens calculation

    public Double Adjustment { get; set; }
    public Double Hvid { get; set; }
    public Double e { get; set; }
    private Double P; //{ get; set; }       //doesn't look like this is passed back
    public Double Rsag { get; set; }      // value at input, not totally clear what it does
    public Double LSag { get; set; }      // sag on the lens, returned by calculation
    public Double Tangent { get; set; }
    public Double Par { get; set; }
    public Double Bvp { get; set; }
    public Double Ct { get; set; }
    public Double Oad { get; set; }
    public Double Poz { get; set; }
    public Double Npc { get; set; }
    public Double Ir1 { get; set; }
    public Double Ir2 { get; set; }
    public Double Ir3 { get; set; }
    public Double Ir4 { get; set; }
    public Double Ir5 { get; set; }
    public Double Ir6 { get; set; }
    public Double Ir7 { get; set; }
    public Double Irw1 { get; set; }
    public Double Irw2 { get; set; }
    public Double Irw3 { get; set; }
    public Double Irw4 { get; set; }
    public Double Irw5 { get; set; }
    public Double Irw6 { get; set; }
    public Double Irw7 { get; set; }
    public Double T_Par { get; set; }
    public Double T_Bvp { get; set; }
    public Double T_Oad { get; set; }
    public Double T_Poz { get; set; }
    public Double T_Ir1 { get; set; }
    public Double T_Ir2 { get; set; }
    public Double T_Ir3 { get; set; }
    public Double T_Ir4 { get; set; }
    public Double T_Ir5 { get; set; }
    public Double T_Ir6 { get; set; }
    public Double T_Ir7 { get; set; }
    public Double T_Irw1 { get; set; }
    public Double T_Irw2 { get; set; }
    public Double T_Irw3 { get; set; }
    public Double T_Irw4 { get; set; }
    public Double T_Irw5 { get; set; }
    public Double T_Irw6 { get; set; }
    public Double T_Irw7 { get; set; }
    public Double toricity { get; set; }  // for toric lenses
    public Double Bfs { get; set; }
    public Double Bshape { get; set; }
    public Double Fshape { get; set; }
    public integer laser { get; set; }    // 1 for yes, 0 for no
    public string cType { get; set; }
    public double AOZ { get; set; }
    public double minCT { get; set; }
    public double minJT { get; set; }
    public double minET { get; set; }
    
    public double FCR { get; set;}            // found in calc_lent
    public double CCR { get; set;}
    
    public integer ACDeltaType { get; set; }
    public double CtDelta { get; set; }
    
    private double ACDelta; //changed to private, set this with ACDeltaType
    
    private double BSag1, BSag2, BSag3, BSag4, BSag5, BSag6, BSag7, BSag8;              // added by Jeremy for lens_crunch internal calculations
    private double BSagT, CSagT;
    
    private double iSag1 = 0, iSag2 = 0,  iSag3 = 0, iSag4 = 0,  iSag5 = 0, iSag6 = 0,  iSag7 = 0;  //defined in calc_sag
    
    private double pc_width, pc_sag, edgeAng, edgeX, edgeZ, edgeSag1, edgeSag2, PC_x, PC_z, edgeTh;  // for shape_edge function
    private double edgeR;    // edge radius
    private double cnAng;    //edge turn angle in degrees

    //Material properties
    //private double materialName;  // material the pretty name; not needed for calculation
    private string materialID;    // database ID value for button material
    private double Index;      // index of refrection of the material
    private double t_group, th_button, OAD_button;
    
    private string designID;    // database ID value for lens design
    private double push_type, push_factor; // specific to each lens design
    private double jessen;  // Jessen factor 
    
    private double OAZ, FEED;
    
    private double FCZ, BCZ; // set in calc_junction, used in calc_lent
    private double FCD, BCD; // set in orthocalc1


    public String lensDesign { get;set; }
    public String validationType { get;set; }
    public String company { get;set; }
    public String account { get;set; }

    public String hardLowerLimit { get;set; }
    public String softLowerLimit { get;set; }

    public class Limit {
        public double upper;
        public double lower;
    }

    public class FieldLimits {
        public Limit rx;
        public Limit rcyl
        public Limit raxis;
        public Limit correct;
        public Limit flatk;
        public Limit steepk;
        public Limit kaxis;

        public Limit Adjustment;
        public Limit Hvid;
        public Limit e;
    }

    public LensValidationRules(){ //initial settings on creation
        nBlend = 2; // theoretically this should be set by the user, but we don't really use it often
        adjustment = 0;
        HVID = 12.5;
        ct = 0; CtDelta = 0;
        IR1 = 0;  IR2 = 0;  IR3 = 0;  IR4 = 0;  IR5 = 0;  IR6 = 0;  IR7 = 0;
        IRW1 = 0; IRW2 = 0; IRW3 = 0; IRW4 = 0; IRW5 = 0; IRW6 = 0; IRW7 = 0;
        T_IR1 = 0;  T_IR2 = 0;  T_IR3 = 0;  T_IR4 = 0;  T_IR5 = 0;  T_IR6 = 0;  T_IR7 = 0;
        T_IRW1 = 0; T_IRW2 = 0; T_IRW3 = 0; T_IRW4 = 0; T_IRW5 = 0; T_IRW6 = 0; T_IRW7 = 0;
        BSag1 = 0; BSag2 = 0; BSag3 = 0;
        BSag7 = 0; BSag8 = 0; BSagT = 0;
        
        PAR = 0; BVP = 0; OAD = 0;
        BCZ = 0; POZ = 0;
        T_PAR = 0; T_BVP = 0; T_OAD = 0;
        T_POZ = 0;
        
        Bshape = 0; Fshape = 0;
        Ctype = 'Emerald';

        AOZ = 0; CCR = 0; FEED = 0;


        ctDelta = .00;
        ACDelta = 1.5;
        ACDeltaType = 1;
        
        Rsag = 0;
        
        jessen = .75; // goes to 1 for > 7 correction, defaults to .75
        
        //BestFit = 0; Push_End = 0; Push_Full = 0;
    }

    public double hardValidationLimit(String lenstype){
        FieldLimits redLimits = new FieldLimits();

        if ( validationType == 'Company' ) {

        } else if ( validationType == 'Account' ) {

        } else {
            switch on lenstype {
                when 'Emerald' {
                    redLimits.flatk.upper = 48;
                    redLimits.flatk.lower = 38;
                }
            }
        }

        return redLimits;
    }


    private boolean setMaterial(){    // returns true if material exists, false on failure
        if(material == 'Equalens II'){
          MaterialId = '11';
          Index = 423; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'Boston XO2'){
          MaterialId = '34';
          Index = 428; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'Boston XO'){
          MaterialId = '08'; 
          Index = 415; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
        }else if(material == 'Boston EO'){
          MaterialId = '05';
          Index = 428; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'Boston ES'){
          MaterialId = '06';
          Index = 423; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'Equalens'){
          MaterialId = '10';
          Index = 423; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'Boston EM'){
          MaterialId = '32';
          Index = 423; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'HDS_100'){
          MaterialId = '29';
          Index = 442; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'HDS'){
          MaterialId = '28';
          Index = 442; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'Paraperm O2'){
          MaterialId = '99';
          Index = 442; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'Paraperm EW'){
          MaterialId = '99';
          Index = 442; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'FluoroPerm 30'){
          MaterialId = '99';
          Index = 442; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'FluoroPerm 60'){
          MaterialId = '99';
          Index = 442; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'FluoroPerm 92'){
          MaterialId = '99';
          Index = 442; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'FluoroPerm 151'){
          MaterialId = '99';
          Index = 442; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'PMMA'){
          MaterialId = '25';
          Index = 490; T_Group = 4;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'SGP 1'){
          MaterialId = '17';
          Index = 442; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'SGP 2'){
          MaterialId = '23';
          Index = 442; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'SGP 3'){
          MaterialId = '15';
          Index = 442; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'Fluorex 300'){
          MaterialId = '12';
          Index = 442; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'Fluorex 500'){
          MaterialId = '13';
          Index = 442; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'Fluorex 700'){
          MaterialId = '14';
          Index = 442; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'Optimum Classic'){
          MaterialId = '41';
          Index = 442; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'Optimum Comfort'){
          MaterialId = '42';
          Index = 442; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'Optimum Extra'){
          MaterialId = '43';
          Index = 442; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'Optimum Extreme'){
          MaterialId = '44';
          Index = 442; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'SynergEyes Si150'){
          MaterialId = '37';
          Index = 442; T_Group = 1;
          Th_Button = 4.35; Oad_Button = 12.7;
      }else if(material == 'Menicon Z'){
          MaterialId = '36';
          Index = 442; T_Group = 2;
          Th_Button = 4.35; Oad_Button = 12.7;
        } else {
            system.debug('Problem with material; not on approved list.');
            return false;
        }
    
        EdgeR = 0.05;
        CnAng = 30;

        if (T_Group == 1){
            minCT = 0.12;
            minJT = 0.16;
            minET = 0.16;
        }
        else if (T_Group == 2){ //difference between T_Group 1 and 2 seems to be historical
            minCT = 0.12;
            minJT = 0.16;
            minET = 0.16;
        }/*
        else if (T_Group == 3){  // We no longer create any lenses with T_Group 3 materials
            minCT = 0.12;
            minJT = 0.18;
            minET = 0.16;
        }*/
        else if (T_Group == 4){
            minCT = 0.08;
            minJT = 0.12;
            minET = 0.16;
        }
        else return false;    // we should end up failing out before this, but it doesn't hurt to have extra failsafes
        
        if (ct < minCT){
            ct = minCT;      // set center thickness to minimum
        }
        return true;
    }

    public boolean setDesign(){
        if (design == 'Emerald'){
            designID = '23';
            laser = 1;
            NPC = 4;
            push_type = 1; push_factor=0.0245;
            jessen = 0.75;
            MinCt = 0.22 + CtDelta;
            system.debug('CtDelta is :'+ CtDelta);
        }
        else return false;
        return true;
    }
    
    public boolean calculateNew(){ //runs the calculation, returns true on success
        
        // fail out if initialization failed and user is dividing by zero
        if (flatk == 0 || flatk == null){system.debug('Flat K should not be 0.');return false;}
        
        //set up material default values, fail if it does not exist
        if (!setMaterial()){system.debug('Material does not exist.');return false;}
        
        // set default design parameters
        if (!setDesign()){system.debug('Design does not exist.');return false;}
        
        // Calculate correction
        // correct = rx + adjustment; // disabled since correction limits are handled by UI
        
        //set ACDelta if ACDeltaType has changed
        if (ACDeltaType == 1){ ACDelta = 1.5; }
        else                 { ACDelta = 1.0; }
                
        system.debug('ACDeltaType = '+ACDeltaType);
        system.debug('ACDelta = '+ACDelta);
        
        // Different calc_new will all happen  here
        /*if(design == 'Sapphire') {
            return calculateNew_Sapphire();
        }*/

        if (correct > 7) {
            jessen = 1;
        }
        
        par = (337.5 / (flatk + correct - jessen));
        
        //if (bvp == 0 ){ // set bvp if it hasn't been set yet
        //    bvp = (rx - correct + jessen);
        //}
        bvp = (rx - correct + jessen); // this is for new lenses, so no need to do an already-set check
       
        // calc_[lenstype] is roughly equivalent to ortho_calc_1(A, C, E, G, i, K, M, lens_type, push_type, push_factor, O, Q)
        // key for translating ortho_Calc_1 variable name changes
        // A = flatk;
        // C = RX;
        // G = e;
        // E = correct
        // i = Oad
        // K = par
        // m = BVP
        // O = Rsag
        // Q = tangent

        // expect an ugly if tree here for lens type, unfortunately
        if (design == 'Emerald'){ 
      calc_emerald();
        }
        else return false;
        
        //calculate the reverse curve, which sets IR1, happens fairly uniformly across other ortho-k lenses
    calc_fit();

        // end of lens ortho function
         
        calc_PSag();
        calc_junction(FCD, BCD);
        
        AOZ = FCD; POZ = BCD;
        
        calc_lent();
        
        return true;
    }
    
    public boolean calculateRefresh(){

        Calc_PSag();
        Calc_junction(FCD, BCD); //TODO: pull passed variables back to class level
        Calc_lent();
        
        return true;
    }
    
    // returns the sag between two different radial zone depths
    private double carrier(double zoneIn, double ZoneOut, double SagZ){
        double zoneW = zoneOut - ZoneIn;
        double zoneH = math.sqrt(math.pow(zoneW,2) + math.pow(sagZ,2));
        double zoneU = (zoneH * (zoneIn + (zoneW / 2) ) ) / SagZ ;
        double carrier = math.sqrt( (math.pow(ZoneU,2) + math.pow(zoneH / 2, 2) ) );
        return carrier;
    }
    
    private void calc_emerald(){
        double flatrad = 337.5/flatk;
        
        if (e < 0){p = 1 + math.pow(e,2);}
        else {p = 1 - math.pow(e,2);}
        
        FCD = 7;
        BCD = 6.2;
        
        // set reverse curve width
        if (OAD < 11.1){IRW1 = 0.5;}
        else {IRW1 = 0.6;}
        
        //set periphreal width and radius
        if(OAD < 10.2){
            IRW4 = 0.4;
            IR4 = 11;
        }
        else {
            IRW4 = 0.5;
            IR4 = 11.5;
        }
        
        // set alignment curve widths
        if (oad < 10){
            IRW2 = 0.5;
        }
        else if (OAD <= 10.2){
            IRW2 = 0.6;
        }
        else if (OAD < 10.3){ //slightly different than george's code, since OAD*10 is always an integer in his
            IRW2 = 0.65;
        }
        else if (OAD < 11.1){
            IRW2 = 0.7;
        }
        else if (OAD < 11.3){
            IRW2 = 0.75;
        }
        else if (OAD < 11.6){
            IRW2 = 0.8;
        }
        else if (OAD < 11.8){
            IRW2 = 0.85;
        }
        else if (OAD < 12){
            IRW2 = 0.6;
        }
        else {
            IRW2 = ((OAD / 2) - (BCD / 2) - IRW1 - IRW4) / 2;
        }
       
      IRW3 = (OAD / 2) - (BCD / 2) - IRW1 - IRW2 - IRW4; // this was originially in each line of the CASE statement but appears to be identical, so I pulled it out
        
      // set alignment curve radius
      //acdelta = 1.5;  //DEBUGGING CODE, DO NOT LET THIS GO TO LIVE
      IR2 = 337.5 / flatk;
      IR3 = 337.5 / (flatk - ACDelta);
        
        system.debug('ACDelta: '+ ACDelta);
        
    }
        
    private void calc_fit(){
        double pushFull = 0;           // this appears to be an iterative variable
        double cornRad = 337.5 / flatk;      // convert flatk to radians
        double zone1 = BCD / 2;         // first zone looks like it's half the base curve diameter
        double zone2 = zone1 + irw1;       // second zone is the first zone plus the width of ir1
        double sag1 = Par - math.sqrt( math.pow(Par,2) - math.pow(zone1,2) ) ;  // equal to Par - sqrt(Par^2-zone1^2)
        double sag2 = cornRad - math.sqrt(math.pow(cornRad,2) - math.pow(zone2,2));
        double sagFC = sag2 - sag1;
        double surfCorn = 2 * math.pi * cornRad * sag2;
        double surfPar = 2 * math.pi * par * sag1;
        double surfGoal = surfCorn - surfPar;

        double xFC = carrier(zone1, zone2, sagFC);
        double sag3 = xFC - math.sqrt(math.pow(xFC,2) - math.pow(zone1,2) );
        double sag4 = xFC - math.sqrt(math.pow(xFC,2) - math.pow(zone2,2) );
        double surfFC = (2 * math.pi * xFC * sag4) - (2 * math.pi * xFC * sag3); //TODO: on refactor, literally refactor this
        
        double pushOffset = 0.001;
        if ( rx < -7.00 ){pushOffset = 0.01;}

        while(surfFC > surfGoal){
            system.debug('surfFC > surfGoal: '+surfFC+' < '+surfGoal);
          pushFull += pushOffset;
          sag2 -= pushOffset;
            sagFC = sag2 - sag1;
         xFC = carrier(zone1, zone2, sagFC);
            sag3 = xFC - math.sqrt(math.pow(xFC,2) - math.pow(zone1,2) ) ;
            sag4 = xFC - math.sqrt(math.pow(xFC,2) - math.pow(zone2,2) ) ;
          surfFC = (2 * math.pi * xFC * sag4) - (2 * math.pi * xFC * sag3);
      }
        
        //there is a switch on push type, but emeralds have push type = 1
        double pushEnd = pushFull - push_factor;
        sag2 = sag2 + pushFull - pushEnd; // on refactor, isn't that just sag2 plus push factor?
        sagFc = sag2 - sag1;
        xFC = carrier(zone1, zone2, sagFc);
        
        system.debug('zone1: ' + zone1 + '; zone2: ' + zone2 + '; sagFC: ' + sagFC );
           
      IR1 = xFC;

    }
    
    private void calc_PSag(){
        
        if (PAR == 0){system.debug('PAR is 0, you should probably do something about that.');} //TODO: make this error back properly
        
        double sagBest, diaBest, newBest;
        double BestFit;  // this is the BFS, being calculated in a vairly odd way... basically, check the curvature to each end of a curve and see
                         // which one has the smallest curve, then use that one... but it has no awareness of the number of curves. Definitely needs a refactor
        
        if (-e < 0) {P = 1 + math.pow(e,2); }
        else { P = 1 - math.pow(e,2); }
        
        ISag1 = 0;
        ISag2 = 0;
        ISag3 = 0;
        ISag4 = 0;
        ISag5 = 0;
        ISag6 = 0;
        ISag7 = 0;
        
        OAZ = OAD / 2;

    //TODO: refactor to make this not only about emeralds, I think this part is good now

        BCZ = OAZ - IRW1 - IRW2 - IRW3 - IRW4 - IRW5 - IRW6 - IRW7;   // rather than switch based on NPC, let zero'd curves be included
        
        double BCD = BCZ * 2;

        double IRZ1 = BCZ + IRW1;
        double IRZ2 = BCZ + IRW1 + IRW2;
    double IRZ3 = BCZ + IRW1 + IRW2 + IRW3;
    double IRZ4 = BCZ + IRW1 + IRW2 + IRW3 + IRW4;
    double IRZ5 = BCZ + IRW1 + IRW2 + IRW3 + IRW4 + IRW5;
    double IRZ6 = BCZ + IRW1 + IRW2 + IRW3 + IRW4 + IRW5 + IRW6;
    double IRZ7 = BCZ + IRW1 + IRW2 + IRW3 + IRW4 + IRW5 + IRW6 + IRW7;

        system.debug('IRZ1: '+IRZ1);
        system.debug('IRZ2: '+IRZ2);
        system.debug('IRZ3: '+IRZ3);
        system.debug('IRZ4: '+IRZ4);
        system.debug('IRZ5: '+IRZ5);
        system.debug('IRZ6: '+IRZ6);
        system.debug('IRZ7: '+IRZ7);
        system.debug('POW PAR ::: '+math.pow(PAR,2));
        system.debug('POW BCZ ::: '+math.pow(BCZ,2));
        BSag1 = math.pow(BCZ,2) / (PAR + math.sqrt(math.pow(PAR,2) - P * math.pow(BCZ,2) )      );
        system.debug('BSag1: '+BSag1);
//    BSag1 = (BCZ ^ 2)       / (x_PAR +        (     x_PAR ^ 2  - P *        BCZ ^ 2  ) ^ 0.5)

        system.debug('IR1: '+IR1);
        system.debug('IR2: '+IR2);
        system.debug('IR3: '+IR3);
        system.debug('IR4: '+IR4);
        system.debug('IR5: '+IR5);
        system.debug('IR6: '+IR6);
        system.debug('IR7: '+IR7);

        
        if (NPC >= 1) ISag1 = SagDepth(IR1, IRZ1, P) - SagDepth(IR1,  BCZ, P); //todo: verify NPC matches
        if (NPC >= 2) ISag2 = SagDepth(IR2, IRZ2, P) - SagDepth(IR2, IRZ1, P);
    if (NPC >= 3) ISag3 = SagDepth(IR3, IRZ3, P) - SagDepth(IR3, IRZ2, P);
        if (NPC >= 4) ISag4 = SagDepth(IR4, IRZ4, P) - SagDepth(IR4, IRZ3, P);
        if (NPC >= 5) ISag5 = SagDepth(IR5, IRZ5, P) - SagDepth(IR5, IRZ4, P);
        if (NPC >= 6) ISag6 = SagDepth(IR6, IRZ6, P) - SagDepth(IR6, IRZ5, P);
        if (NPC >= 7) ISag7 = SagDepth(IR7, IRZ7, P) - SagDepth(IR7, IRZ6, P);

        BSagT = BSag1 + ISag1 + ISag2 + ISag3 + ISag4 + ISag5 + ISag6 + ISag7;

        system.debug('BSagT: '+BSagT);
        system.debug('ISag1: '+ISag1);
        system.debug('ISag2: '+ISag2);
        system.debug('ISag3: '+ISag3);
        system.debug('ISag4: '+ISag4);
        system.debug('ISag5: '+ISag5);
        system.debug('ISag6: '+ISag6);
        system.debug('ISag7: '+ISag7);

        BestFit = PAR;

        SagBest = BSag1 + Isag1;
        DiaBest = IRZ1;
        NewBest = (math.pow(DiaBest,2) + math.pow(SagBest,2) ) / (2 * SagBest);
        if (NewBest < BestFit){ BestFit = NewBest;}

        SagBest = BSag1 + Isag1 + Isag2;
        DiaBest = IRZ2;
        NewBest = (math.pow(DiaBest,2) + math.pow(SagBest,2) ) / (2 * SagBest);
        if (NewBest < BestFit){ BestFit = NewBest;}

        SagBest = BSag1 + Isag1 + Isag2 + Isag3;
        DiaBest = IRZ3;
        NewBest = (math.pow(DiaBest,2) + math.pow(SagBest,2) ) / (2 * SagBest);
        if (NewBest < BestFit){ BestFit = NewBest;}

        SagBest = BSag1 + Isag1 + Isag2 + Isag3 + Isag4;
        DiaBest = IRZ4;
        NewBest = (math.pow(DiaBest,2) + math.pow(SagBest,2) ) / (2 * SagBest);
        if (NewBest < BestFit){ BestFit = NewBest;}

        SagBest = BSag1 + Isag1 + Isag2 + Isag3 + Isag4 + Isag5;
        DiaBest = IRZ5;
        NewBest = (math.pow(DiaBest,2) + math.pow(SagBest,2) ) / (2 * SagBest);
        if (NewBest < BestFit){ BestFit = NewBest;}

        SagBest = BSag1 + Isag1 + Isag2 + Isag3 + Isag4 + Isag5 + Isag6;
        DiaBest = IRZ6;
        NewBest = (math.pow(DiaBest,2) + math.pow(SagBest,2) ) / (2 * SagBest);
        if (NewBest < BestFit){ BestFit = NewBest;}

        SagBest = BSag1 + Isag1 + Isag2 + Isag3 + Isag4 + Isag5 + Isag6 + Isag7;
        DiaBest = IRZ7;
        NewBest = (math.pow(DiaBest,2) + math.pow(SagBest,2) ) / (2 * SagBest);
        if (NewBest < BestFit){ BestFit = NewBest;}

        BFS = BestFit;      // set the best fit sphere for the lens
        LSag = BSagT;      // set the other global values
        POZ = BCD;

    }
    
    Private void calc_junction( double cjAoz, double cjPoz ){
        double sagTemp, BTemp;      //temp holding variables
        FCZ = cjAoz / 2;
        BCZ = cjPoz / 2;
        
        if (FCZ < BCZ){
            BSag8 = PAR - math.sqrt(math.pow(PAR,2) - math.pow(FCZ,2));
            sagTemp = 0;            
        }
        else if (FCZ <= BCZ + IRW1 ){
            BTemp = BCZ;
            BSag8 = BSag1;
            SagTemp = (IR1 - math.sqrt(math.pow(IR1,2) - math.pow(FCZ,2)) ) - (IR1 - math.sqrt(math.pow(IR1,2) - math.pow(BTemp,2)) );
            
            system.debug('IR1: '+IR1+'; BSag1: '+BSag1+'; BCZ: '+BCZ+'; SagTemp: '+sagTemp);
        }
        else if (FCZ <= BCZ + IRW1 + IRW2 ){
            BTemp = BCZ + IRW1;
            BSag8 = BSag1 + ISag2;
            SagTemp = (IR2 - math.sqrt(math.pow(IR2,2) - math.pow(FCZ,2)) ) - (IR2 - math.sqrt(math.pow(IR2,2) - math.pow(BTemp,2)) );
        }
        else if (FCZ <= BCZ + IRW1 + IRW2 + IRW3 ){
            BTemp = BCZ + IRW1 + IRW2;
            BSag8 = BSag1 + ISag1 + ISag2;
            SagTemp = (IR3 - math.sqrt(math.pow(IR3,2) - math.pow(FCZ,2)) ) - (IR3 - math.sqrt(math.pow(IR3,2) - math.pow(BTemp,2)) );
        }
        else if (FCZ <= BCZ + IRW1 + IRW2 + IRW3 + IRW4 ){
            BTemp = BCZ + IRW1 + IRW2 + IRW3;
            BSag8 = BSag1 + ISag1 + ISag2 + ISag2;
            SagTemp = (IR4 - math.sqrt(math.pow(IR4,2) - math.pow(FCZ,2)) ) - (IR4 - math.sqrt(math.pow(IR4,2) - math.pow(BTemp,2)) );
        }
        else {
            BSag7 = 1.111;
        }

        BSag7 = (BSag8 + SagTemp);
        //TODO: failure mode? is there already a calculated junction?
    }

    double sagDepth (double rad, double zone, double pValue){
        return math.pow(zone,2) / ( rad + math.sqrt(math.pow(rad,2) - pValue * math.pow(zone,2)));
        //              zone^2  / ( rad + (         rad^2 - pValue * zone*2)) ^1/2
    }
    
    void calc_lent(){
        double et = minET, jt = minJT, sagTest, ETest, TTest;
        double FSAG1;       // this variable is not initialized in George's code; declared locally here
        double carrier_sag;    // this is declared globally in george's version but not used globally; declared locally here
        
        shape_edge();      // sets nEdgeTh and nEdgeAng

        if (ct<minCT) {
            system.debug('CT changed from '+ct+' to '+minCT);
            CT = minCT;
        }

        //FCR = front_curve(X_PAR, x_BVP, CT, Index);
        FCR = front_curve(); //no need to pass the variables as before
        
        do {     //TODO: pull this out into a function
            Fsag1 = sagdepth(FCR, FCZ, 1);
            TTest = JT - 0.005;
            ETest = bsag7 + ct - Fsag1;
            
            system.debug('tTest: '+tTest+'; eTest: '+eTest);
            system.debug('Fsag1: '+fsag1+ '  ct: '+ct+' bsag7: '+bsag7);
            
            if (etest > ttest)break;
            else {
                ct = ct+jt-etest;
                FCR = front_curve();
                system.debug('eTest <= tTest;  ct: '+ct+'; FCR: '+FCR);
            }
            Fsag1 = sagdepth(FCR, FCZ, 1);
            ttest = jt + 0.005;
            etest = bsag7 + ct - Fsag1;

            system.debug('tTest: '+tTest+'; eTest: '+eTest);

            if (etest < ttest)break;
            else{
                ct = ct+jt - etest;
                FCR = front_curve();
                system.debug('eTest >= tTest;  ct: '+ct+'; FCR: '+FCR);
            }
            
        }        while (true);

        Jt = ETest;

        //nJT = JT; nCT = CT; nET = ET;  //not sure what the point of this is, is n "next"?
          // it looks like this doesn't do anything, no reason to have them added to n variables

        Carrier_sag = BSagT - (EdgeR * math.Tan(EdgeAng)) + CT - Fsag1 - ET;
        system.debug('EdgeAng: '+ EdgeAng);
        system.debug('CT: '+ CT);
        system.debug('Fsag1: '+ Fsag1);
        system.debug('ET: '+ ET);
        system.debug('FCZ, OAZ, EdgeR, Carrier Sag:'+FCZ+', '+OAZ+', '+EdgeR+', '+Carrier_Sag);
        CCR = Carrier(FCZ, (OAZ - EdgeR), Carrier_Sag);
        system.debug('FCR, CCR, FCZ:'+FCR+', '+CCR+', '+FCZ);
        FEED = FCR - CCR + (CCR - math.sqrt(math.pow(CCR,2) - math.pow(FCZ,2)) );

        system.debug('  ct: '+ct);
        system.debug('CCR: '+CCR);

    }
    
    private double front_curve(){
        double SPT = bvp + (index / PAR);
        return (index * (1 + ((ct / (index + 1000)) * SPT))) / SPT;
    }

    boolean shape_edge(){

        // calculates the x and z for the edge
        if (NPC ==1){
            PC_Width = IRW1; PC_Sag = ISag1;
        }
        else if (NPC ==2){
            PC_Width = IRW2; PC_Sag = ISag2;
        }
        else if (NPC ==3){
            PC_Width = IRW3; PC_Sag = ISag3;
        }
        else if (NPC ==4){
            PC_Width = IRW4; PC_Sag = ISag4;
        }
        else if (NPC ==5){
            PC_Width = IRW5; PC_Sag = ISag5;
        }
        else if (NPC ==6){
            PC_Width = IRW6; PC_Sag = ISag6;
        } 
        else if (NPC ==7){
            PC_Width = IRW7; PC_Sag = ISag7;
        } 

        //calculations for point 2
        edgeAng = math.atan(pc_sag / pc_width);       //this is in radians
        edgeX = edgeR * math.sin(edgeAng); 
        edgeZ = edgeR * math.sin(cnAng * math.PI / 180);  // changes cnAng to radians, it does look like SF uses radians in the math class

        edgeSag1 = sagDepth(edgeR, edgeX, 1);  //edge radius sag on BC side
        edgeSag2 = sagDepth(edgeR, edgez, 1);  //edge radius sag on FC side

        PC_x = edgeR + edgeX;          // x distance from OAZ to point on lens where edge meets PC
        PC_z = PC_x + math.tan(edgeAng);    // z distance from bSagT to point on lens where edge meets PC 
        edgeTh = PC_z - EdgeSag1 + EdgeR + (EdgeR / math.sin(CnAng * math.PI / 180 )) - (edgeR * math.tan(edgeAng));

        return true;              //TODO: failure catch
    }
    

    
}
