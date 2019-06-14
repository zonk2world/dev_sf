<apex:page showHeader="false" standardStylesheets="false" sidebar="false" applyHtmlTag="false" applyBodyTag="false" docType="html-5.0" controller="LensScreenController">
    <apex:form >
        <html xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" lang="en">
            <head>
                <meta charset="utf-8" />                
                <meta http-equiv="x-ua-compatible" content="ie=edge" />
                <title>Lens Order Entry System</title>
                <meta name="viewport" content="width=device-width, initial-scale=1" />
                <!-- Import the Design System style sheet -->
                <apex:slds />
                <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
                <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
                <script>$j = jQuery.noConflict();</script>

                <apex:stylesheet value="{!$Resource.LensScreenUIStyle}" />
            </head>
            <body>
                <apex:outputPanel layout="block" styleClass="slds-scope" id="pageScope">
                    <apex:actionStatus id="pageStatus">
                        <apex:facet name="start">
                            <div class="pageSpinner">
                                <div role="status" class="slds-spinner slds-spinner_brand slds-spinner_medium" style="z-index: 9050 !important">
                                    <span class="slds-assistive-text">Loading</span>
                                    <div class="slds-spinner__dot-a"></div>
                                    <div class="slds-spinner__dot-b"></div>
                                </div>
                            </div>
                        </apex:facet>
                    </apex:actionStatus>
                    <div role="alertdialog" tabindex="-1" class="slds-modal slds-modal--prompt" id="promptDialog">
                        <div class="slds-modal__container">
                            <div class="slds-modal__header slds-theme--error slds-theme--alert-texture">
                                <!-- <button class="slds-button slds-modal__close slds-button--icon-inverse" title="Close">
                                    <svg aria-hidden="true" class="slds-button__icon slds-button__icon--large">
                                        <use xlink:href="{!URLFOR($Asset.SLDS, 'assets/icons/utility-sprite/svg/symbols.svg#close')}"></use>
                                    </svg>
                                    <span class="slds-assistive-text">Close</span>
                                </button> -->
                                <h2 class="slds-text-heading--medium" id="prompt-heading-id">Error</h2>
                            </div>
                            <div class="slds-modal__content slds-p-around--medium">
                                <div>
                                    <p class="slds-text-align_center" id="promptText"></p>
                                </div>
                            </div>
                            <div class="slds-modal__footer slds-theme--default">
                                <button class="slds-button slds-button--neutral" id="promptClose" onclick="closePrompt(); return false;">Okay</button>
                            </div>
                        </div>
                    </div>
                    <div class="slds-backdrop" id="promptBackdrop"></div>
                    <div class="slds-page-header">
                        <div class="slds-grid slds-wrap">                            
                            <div class="slds-small-size_1-of-1 slds-medium-size_2-of-6 slds-large-size_3-of-12">
                                <!-- HEADING AREA -->
                                <h1 class="slds-page-header__title slds-m-right--small slds-align-middle slds-truncate" title="Title">Lens Entry Online (LEO)</h1>
                                <!-- / HEADING AREA -->     
                            </div>
                            <div class="slds-small-size_1-of-1 slds-medium-size_4-of-6 slds-large-size_9-of-12">

                                <apex:outputPanel layout="block" styleClass="slds-col slds-large-size_1-of-3 slds-medium-size_1-of-1 slds-small-size_1-of-1 slds-float_left slds-text-align_left">
                                    <div class="slds-form-element slds-form--horizontal">
                                        
                                        <button class="slds-button slds-button_neutral" onClick="redirectToSalesConsult();return false;">Sales Consult</button>

                                        <button class="slds-button slds-button_neutral" onClick="redirectToSalesforceHome();return false;">Back to SF</button>

                                        <!-- <apex:commandButton styleClass="slds-button slds-button_neutral" value="Sales Consult Button" action="{!salesConsultPage}"/> -->
                                        
                                    </div> 
                                </apex:outputPanel>                                

                                <apex:outputPanel layout="block" styleClass="slds-col slds-large-size_1-of-3 slds-medium-size_1-of-1 slds-small-size_1-of-1 slds-float_left slds-text-align_left">
                                    <div class="slds-lookup" data-select="single" data-scope="single" data-typeahead="true">
                                        <div class="slds-form-element slds-form--horizontal">
                                            <label class="slds-form-element__label slds-p-top_x-small" for="LensAccount" style="vertical-align:top">Account #</label>
                                            <div class="slds-form-element__control slds-input-has-icon slds-input-has-icon--right">
                                                <div class="slds-pill__container slds-hide"></div>
                                                <apex:inputText id="LensAccount" styleClass="slds-input slds-show" html-aria-autocomplete="list" html-role="combobox" html-aria-expanded="true" html-aria-activedescendant="" html-autofocus="true" value="{!accName}" />
                                                <apex:inputHidden id="LensAccountId" value="{!ord.AccountId}" />
                                            </div>
                                        </div>
                                    </div>
                                </apex:outputPanel>

                                <apex:outputPanel layout="block" styleClass="slds-col slds-large-size_1-of-3 slds-medium-size_1-of-1 slds-small-size_1-of-1 slds-float_left slds-text-align_left">
                                    <div class="slds-lookup" data-select="single" data-scope="single" data-typeahead="true">
                                        <div class="slds-form-element slds-form--horizontal">
                                            <label class="slds-form-element__label" for="Patient" style="vertical-align:top">Patient Name</label>
                                            <div class="slds-form-element__control slds-input-has-icon slds-input-has-icon--right">
                                                <div class="slds-pill__container slds-hide"></div>
                                                <apex:inputText id="Patient" styleClass="slds-input slds-show" html-aria-autocomplete="list" html-role="combobox" html-aria-expanded="true" html-aria-activedescendant="" value="{!patientName}"/>
                                                <apex:inputHidden id="PatientLKId" value="{!ord.Patient_ID__c}" />
                                            </div>
                                        </div>
                                    </div>                                       
                                </apex:outputPanel>
                            </div>
                        </div>
                    </div>
                    <apex:outputPanel id="pageMsgs" layout="block">
                        <apex:outputPanel layout="block" styleClass="slds-size_1-of-1 slds-notify slds-notify_alert slds-theme_alert-texture slds-theme_error" html-role="alert" rendered="{!NOT(len(errorMessage)==0)}">
                            <h2>{!errorMessage}</h2>
                        </apex:outputPanel>
                    </apex:outputPanel>
                    <!-- START : Order Information Section -->
                    <div class="slds-grid">
                        <div class="slds-col">
                            <div class="slds-section-title--divider slds-p-bottom_large">
                                <h3 class="slds-float_left slds-size_1-of-2">Order Information</h3>
                                <h3 id="sessionCounter" class="slds-float_right slds-size_1-of-2 slds-text-align_right">Session Counter:0 </h3>
                            </div>
                            <div class="slds-form slds-text-align_center">                                
                                <apex:outputPanel layout="block" styleClass="slds-col slds-large-size_1-of-12 slds-medium-size_1-of-8 slds-small-size_1-of-4 slds-float_left slds-m-right_xx-small">    
                                    <div class="slds-form-element">
                                        <apex:outputLabel styleClass="slds-form-element__label" for="ordType" value="Order Type"/>
                                        <div class="slds-select_container">
                                            <apex:inputfield html-autocomplete="off" value="{!ord.Order_Type__c}" id="ordType" styleClass="slds-select"/>
                                        </div>
                                    </div>
                                </apex:outputPanel>
                                <apex:outputPanel layout="block" styleClass="slds-col slds-large-size_1-of-12 slds-medium-size_1-of-8 slds-small-size_1-of-4 slds-float_left slds-m-right_xx-small">    
                                    <div class="slds-form-element">
                                        <apex:outputLabel styleClass="slds-form-element__label" for="side" value="Side"/>
                                        <div class="slds-select_container">
                                            <apex:inputfield html-autocomplete="off" value="{!ord.Lens_Ord_Itm_Side__c}" id="side" styleClass="slds-select"/>
                                        </div>
                                    </div>
                                </apex:outputPanel>
                                <apex:outputPanel layout="block" styleClass="slds-col slds-large-size_1-of-12 slds-medium-size_1-of-8 slds-small-size_1-of-4 slds-float_left slds-m-right_xx-small">    
                                    <div class="slds-form-element">
                                        <apex:outputLabel styleClass="slds-form-element__label" for="blend" value="Blend"/>
                                        <div class="slds-select_container"> 
                                            <apex:selectList id="blend" size="1" value="{!ordItmBlend}" styleClass="slds-select">
                                                <apex:selectOptions value="{!blendOptions}"/>
                                            </apex:selectList>
                                        </div>
                                    </div>
                                </apex:outputPanel>
                                <apex:outputPanel layout="block" styleClass="slds-col slds-large-size_1-of-12 slds-medium-size_1-of-8 slds-small-size_1-of-4 slds-float_left slds-m-right_xx-small">
                                    <div class="slds-form-element">
                                        <apex:outputLabel styleClass="slds-form-element__label" for="design" value="Design"/>
                                        <div class="slds-select_container"> 
                                            <apex:selectList id="design" size="1" value="{!ordItmDesign}" styleClass="slds-select">
                                                <apex:selectOptions value="{!designoptions}"/>
                                                <apex:actionSupport event="onchange" reRender="lensTypePanel,jsPanel" status="pageStatus" focus="lens"/>
                                            </apex:selectList>
                                        </div>
                                    </div>
                                </apex:outputPanel>
                                <apex:outputPanel layout="block" styleClass="slds-col slds-large-size_1-of-12 slds-medium-size_1-of-8 slds-small-size_1-of-4 slds-float_left slds-m-right_xx-small" id="lensTypePanel">    
                                    <div class="slds-form-element">
                                        <apex:outputLabel styleClass="slds-form-element__label" for="lens" value="Lens"/>
                                        <div class="slds-select_container"> 
                                            <apex:selectList id="lens" size="1" value="{!ordItmLens}" styleClass="slds-select">
                                                <apex:selectOptions value="{!lensoptions}"/>
                                            </apex:selectList>
                                        </div>
                                    </div>
                                </apex:outputPanel>
                                <apex:outputPanel layout="block" styleClass="slds-col slds-large-size_1-of-12 slds-medium-size_1-of-8 slds-small-size_1-of-4 slds-float_left slds-m-right_xx-small">    
                                    <div class="slds-form-element">
                                        <apex:outputLabel styleClass="slds-form-element__label" for="rgp" value="RGP"/>
                                        <div class="slds-select_container">
                                            <apex:selectList id="rgp" size="1" value="{!ordItmRGP}" styleClass="slds-select">
                                                <apex:selectOptions value="{!RGPOptions}"/>
                                                <apex:actionSupport event="onchange" reRender="materialPanel,jsPanel" status="pageStatus" focus="material"/>
                                            </apex:selectList>                                            
                                        </div>
                                    </div>
                                </apex:outputPanel>
                                <apex:outputPanel layout="block" styleClass="slds-col slds-large-size_1-of-12 slds-medium-size_1-of-8 slds-small-size_1-of-4 slds-float_left slds-m-right_xx-small" id="materialPanel">    
                                    <div class="slds-form-element">
                                        <apex:outputLabel styleClass="slds-form-element__label" for="material" value="Material"/>
                                        <div class="slds-select_container">
                                            <apex:selectList id="material" size="1" value="{!ordItmMaterial}" styleClass="slds-select">
                                                <apex:selectOptions value="{!materialOptions}"/>
                                            </apex:selectList> 
                                        </div>
                                        
                                    </div>
                                </apex:outputPanel>
                                <apex:outputPanel layout="block" styleClass="slds-col slds-large-size_1-of-12 slds-medium-size_1-of-8 slds-small-size_1-of-4 slds-float_left slds-m-right_xx-small">    
                                    <div class="slds-form-element">
                                        <apex:outputLabel styleClass="slds-form-element__label" for="odColor" value="OD Color"/>
                                        <div class="slds-select_container"> 
                                            <apex:inputfield html-autocomplete="off" id="odColor" value="{!odOrdItm.Color__c}" styleClass="slds-select"/>
                                        </div>
                                    </div>
                                </apex:outputPanel>
                                <apex:outputPanel layout="block" styleClass="slds-col slds-large-size_1-of-12 slds-medium-size_1-of-8 slds-small-size_1-of-4 slds-float_left slds-m-right_xx-small">    
                                    <div class="slds-form-element">
                                        <apex:outputLabel styleClass="slds-form-element__label" for="osColor" value="OS Color"/>
                                        <div class="slds-select_container">                                            
                                            <apex:inputfield html-autocomplete="off" id="osColor" value="{!osOrdItm.Color__c}" styleClass="slds-select"/>
                                        </div>
                                    </div>
                                </apex:outputPanel>                                     
                            </div>
                        </div>
                    </div>
                    <!-- END : Order Information Section -->

                    <!-- START : Second Panel -->
                    <div class="slds-grid slds-wrap slds-m-top_small">
                        <!-- LHS Section which consists OD and OS section  -->
                        <apex:outputPanel layout="block" styleClass="slds-large-size_9-of-12 slds-medium-size_12-of-12 slds-small-size_12-of-12">
                            <div class="slds-grid slds-wrap" id="examDatafields">                           
                                <!--START : OD Exam Data Section -->                            
                                <apex:outputPanel layout="block" styleClass="slds-large-size_4-of-8 slds-medium-size_3-of-6 slds-small-size_1-of-1 slds-float_left slds-p-right_xx-small">
                                    <apex:outputPanel layout="block" id="odExamDataFields" styleClass="slds-show">
                                        <h3 class="slds-section-title--divider">OD Exam Data</h3>
                                        <div class="slds-form slds-form_compound slds-text-align_center">
                                            <div class="slds-form-element__group slds-p-around_xx-small">                           
                                                <div class="slds-form-element__row">
                                                    <div class="slds-form-element slds-size_1-of-4 slds-p-top_large slds-text-align_right">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Cornea"/>
                                                    </div>                                                          
                                                    <div class="slds-form-element slds-size_1-of-4">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Flat K" for="OD_FlatK" />
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_FlatK" value="{!odOrdItm.FlatK__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-4">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Steep K" for="OD_SteepK" />
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_SteepK" value="{!odOrdItm.SteepK__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-4">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Axis" for="OD_KAxis" />
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_KAxis" value="{!odOrdItm.Kaxis__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="slds-form-element__row">
                                                    <div class="slds-form-element slds-size_1-of-5 slds-p-top_large slds-text-align_right">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Refraction"/>
                                                    </div>                                                          
                                                    <div class="slds-form-element slds-size_1-of-5">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Rx" for="OD_Rx" />
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Rx" value="{!odOrdItm.Rx__c}" styleClass="slds-input"/>
                                                        </div>
                                                        <apex:outputPanel layout="block" id="odLimit">
                                                            <apex:outputLabel value="(Target Limit: {!emeraldLimit})" styleClass="slds-form-element__label slds-truncate" style="font-size: .7rem;"/>
                                                        </apex:outputPanel>
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-5">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Cylinder" for="OD_RCyl" />
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_RCyl" value="{!odOrdItm.RCyl__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-5">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Axis" for="OD_RAxis" />
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_RAxis" value="{!odOrdItm.RAxis__c}" styleClass="slds-input"/>
                                                        </div>  
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-5">
                                                        <apex:outputLabel value="OAD" for="OD_Oad" styleClass="slds-form-element__label"  />
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Oad" value="{!odOrdItm.OAD__c}" styleClass="slds-input"  />
                                                        </div>  
                                                    </div>
                                                </div>

                                                <!-- <div class="slds-form-element__row slds-size_1-of-2">
                                                    <div class="slds-form-element slds-form--horizontal slds-text-align_left">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Toricity" for="OD_Toricity"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete = "off" id="OD_Toricity" value="{!ordItm.OD_Toricity__c}" styleClass="slds-input"/>
                                                        </div>                                                        
                                                    </div>
                                                </div> -->

                                                <div class="slds-form-element__row slds-p-top_large">
                                                    <div class="slds-form-element slds-size_1-of-6">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Correction" for="OD_Correct" />
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Correct" value="{!odOrdItm.Correct__c}" styleClass="slds-input" html-disabled="true"/>
                                                        </div>                                                          
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-6">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Adjustment" for="OD_Adjustment" />
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Adjustment" value="{!odOrdItm.Adjustment__c}" styleClass="slds-input"/>
                                                        </div>  
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-6">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="e" for="OD_e" />
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_e" value="{!odOrdItm.E__c}" styleClass="slds-input"/>
                                                        </div>  
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-6">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="HVID" for="OD_Hvid" />
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Hvid" value="{!odOrdItm.HVID__c}" styleClass="slds-input"/>
                                                        </div>  
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-6">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="R_Sag" for="OD_Rsag" />
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Rsag" value="{!odOrdItm.RSag__c}" styleClass="slds-input"/>
                                                        </div>  
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-6">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Tangent" for="OD_Tangent" />
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Tangent" value="{!odOrdItm.Tangent__c}" styleClass="slds-input"/> 
                                                        </div>  
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </apex:outputPanel>
                                    <apex:outputPanel layout="block" id="odExamDataNoDisplay" styleClass="slds-hide">
                                        <h3 class="slds-text-align_center">No OD Exam Data</h3>
                                    </apex:outputPanel>
                                </apex:outputPanel>
                                <!-- END: OD Exam Data Section -->

                                <!-- START : OS Exam Data Section -->
                                <apex:outputPanel layout="block" styleClass="slds-large-size_4-of-8 slds-medium-size_3-of-6 slds-small-size_1-of-1 slds-float_left slds-p-right_xx-small">
                                    <apex:outputPanel layout="block" id="osExamDataFields" styleClass="slds-show">
                                        <h3 class="slds-section-title--divider">OS Exam Data</h3>
                                        <div class="slds-form slds-form_compound slds-text-align_center">
                                            <div class="slds-form-element__group slds-p-around_xx-small">
                                                <div class="slds-form-element__row">
                                                    <div class="slds-form-element slds-size_1-of-4 slds-p-top_large slds-text-align_right">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Cornea"/>
                                                    </div>                                                          
                                                    <div class="slds-form-element slds-size_1-of-4">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Flat K" for="OS_FlatK" />
                                                        <apex:inputfield html-autocomplete="off" id="OS_FlatK" value="{!osOrdItm.FlatK__c}" styleClass="slds-input"/>
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-4">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Steep K" for="OS_SteepK" />
                                                        <apex:inputfield html-autocomplete="off" id="OS_SteepK" value="{!osOrdItm.SteepK__c}" styleClass="slds-input"/>
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-4">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Axis" for="OS_KAxis" />
                                                        <apex:inputfield html-autocomplete="off" id="OS_KAxis" value="{!osOrdItm.Kaxis__c}" styleClass="slds-input"/>
                                                    </div>
                                                </div>

                                                <div class="slds-form-element__row">
                                                    <div class="slds-form-element slds-size_1-of-5 slds-p-top_large slds-text-align_right">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Refraction"/>
                                                    </div>                                                          
                                                    <div class="slds-form-element slds-size_1-of-5">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Rx" for="OS_Rx" />
                                                        <apex:inputfield html-autocomplete="off" id="OS_Rx" value="{!osOrdItm.Rx__c}" styleClass="slds-input"/>
                                                        <apex:outputPanel layout="block" id="osLimit">
                                                            <apex:outputLabel value="(Target Limit: {!emeraldLimit})" styleClass="slds-form-element__label slds-truncate" style="font-size: .7rem;"/>
                                                        </apex:outputPanel>
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-5">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Cylinder" for="OS_RCyl" />
                                                        <apex:inputfield html-autocomplete="off" id="OS_RCyl" value="{!osOrdItm.RCyl__c}" styleClass="slds-input"/>
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-5">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Axis" for="OS_RAxis" />
                                                        <apex:inputfield html-autocomplete="off" id="OS_RAxis" value="{!osOrdItm.RAxis__c}" styleClass="slds-input"/>
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-5">
                                                        <apex:outputLabel value="OAD" for="OS_Oad" styleClass="slds-form-element__label" />
                                                        <apex:inputfield html-autocomplete="off" id="OS_Oad" value="{!osOrdItm.OAD__c}" styleClass="slds-input" />
                                                    </div>                                  
                                                </div>

                                                <!-- <div class="slds-form-element__row slds-size_1-of-2">
                                                    <div class="slds-form-element slds-form--horizontal slds-text-align_left">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Toricity" for="OS_Toricity"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete = "off" id="OS_Toricity" value="{!ordItm.OS_Toricity__c}" styleClass="slds-input"/>
                                                        </div>                                                        
                                                    </div>
                                                </div> -->

                                                <div class="slds-form-element__row slds-p-top_large">
                                                    <div class="slds-form-element slds-size_1-of-6">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Correction" for="OS_Correct" />
                                                        <apex:inputfield html-autocomplete="off" id="OS_Correct" value="{!osOrdItm.Correct__c}" styleClass="slds-input" html-disabled="true"/>
                                                        
                                                    </div>                                                    
                                                    <div class="slds-form-element slds-size_1-of-6">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Adjustment" for="OS_Adjustment" />
                                                        <apex:inputfield html-autocomplete="off" id="OS_Adjustment" value="{!osOrdItm.Adjustment__c}" styleClass="slds-input"/>
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-6">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="e" for="OS_e" />
                                                        <apex:inputfield html-autocomplete="off" id="OS_e" value="{!osOrdItm.E__c}" styleClass="slds-input"/>
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-6">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="HVID" for="OS_Hvid" />
                                                        <apex:inputfield html-autocomplete="off" id="OS_Hvid" value="{!osOrdItm.HVID__c}" styleClass="slds-input"/>
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-6">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="R_Sag" for="OS_Rsag" />
                                                        <apex:inputfield html-autocomplete="off" id="OS_Rsag" value="{!osOrdItm.RSag__c}" styleClass="slds-input"/>
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-6">
                                                        <apex:outputLabel styleClass="slds-form-element__label" value="Tangent" for="OS_Tangent" />
                                                        <apex:inputfield html-autocomplete="off" id="OS_Tangent" value="{!osOrdItm.Tangent__c}" styleClass="slds-input"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </apex:outputPanel>
                                    <apex:outputPanel layout="block" id="osExamDataNoDisplay" styleClass="slds-hide">
                                        <h3 class="slds-text-align_center">No OS Exam Data</h3>
                                    </apex:outputPanel>
                                </apex:outputPanel>
                                <!-- END : OS Exam Data Section -->
                            </div>

                            <apex:outputPanel layout="block" styleClass="slds-grid slds-wrap" id="lensFieldsData">
                                <!-- START : OD Lens Data -->
                                <apex:outputPanel layout="block" styleClass="slds-large-size_4-of-8 slds-medium-size_3-of-6 slds-small-size_1-of-1 slds-float_left slds-p-right_xx-small">
                                    <apex:outputPanel layout="block" id="odLensDataFields">
                                        <h3 class="slds-section-title--divider">OD Lens Data</h3>
                                        <div class="slds-form slds-form_compound slds-text-align_center">
                                            <div class="slds-form-element__group slds-p-around_xx-small">                           
                                                <div class="slds-form-element__row slds-p-bottom_large">
                                                    <div class="slds-form-element slds-size_1-of-3">
                                                        <apex:outputLabel value="PAR" for="OD_Par" styleClass="slds-form-element__label"  />
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Par" value="{!odOrdItm.PAR__c}" styleClass="slds-input"  />
                                                        </div>  
                                                        <apex:outputLabel value="(diopters)" styleClass="slds-form-element__label" />
                                                    </div>

                                                    <div class="slds-form-element slds-size_1-of-3">
                                                        <apex:outputLabel value="BVP" for="OD_Bvp" styleClass="slds-form-element__label" />
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Bvp" value="{!odOrdItm.BVP__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>                                  
                                    
                                                    <div class="slds-form-element slds-size_1-of-3">
                                                        <apex:outputLabel value="CT" for="OD_Ct" styleClass="slds-form-element__label" />
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Ct" value="{!odOrdItm.CT__c}" styleClass="slds-input" />
                                                        </div>  
                                                    </div>
                                                </div>

                                                <div class="slds-form-element__row">
                                                    <div class="slds-form-element slds-size_1-of-2 slds-form--horizontal">
                                                        <apex:outputLabel value="LSag" for="OD_LSag" styleClass="slds-form-element__label slds-m-right_large"/>
                                                        <div class="slds-form-element__control">    
                                                            <apex:inputfield html-autocomplete="off" id="OD_LSag" value="{!odOrdItm.LSag__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-2 slds-form--horizontal">
                                                        <apex:outputLabel value="NPC" for="OD_Npc" styleClass="slds-form-element__label slds-m-right_large"/>
                                                        <div class="slds-form-element__control">    
                                                            <apex:inputfield html-autocomplete="off" id="OD_Npc" value="{!odOrdItm.NPC__c}" styleClass="slds-input">
                                                                <apex:actionSupport event="onchange" reRender="odManualInputFields,jsPanel" status="pageStatus"/>
                                                            </apex:inputField>
                                                        </div>
                                                    </div>                                  
                                                </div>                                                

                                                <div class="slds-form-element__row">
                                                    <div class="slds-form-element slds-size_1-of-2 slds-form--horizontal">
                                                        <apex:outputLabel value="FCR" for="OD_FCR"  styleClass="slds-form-element__label slds-m-right_large"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_FCR" value="{!odOrdItm.FCR__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-2 slds-form--horizontal">
                                                        <apex:outputLabel value="POZ" for="OD_Poz" styleClass="slds-form-element__label slds-m-right_large"/>
                                                        <div class="slds-form-element__control">    
                                                            <apex:inputfield html-autocomplete="off" id="OD_Poz" value="{!odOrdItm.POZ__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>                                                    
                                                </div>
                                                <div class="slds-form-element__row">
                                                    <div class="slds-form-element slds-size_1-of-2 slds-form--horizontal">
                                                        <apex:outputLabel value="BFS" for="OD_Bfs" styleClass="slds-form-element__label slds-m-right_large"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Bfs" value="{!odOrdItm.BFS__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-2 slds-form--horizontal">
                                                        <apex:outputLabel value="CCR" for="OD_CCR" styleClass="slds-form-element__label slds-m-right_large"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_CCR" value="{!odOrdItm.CCR__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>
                                                </div>                                              
                                            </div>
                                            
                                        </div>
                                    </apex:outputPanel>
                                    <apex:outputPanel layout="block" id="odLensDataNoDisplay" styleClass="slds-hide">
                                        <h3 class="slds-text-align_center">No OD Lens Data</h3>
                                    </apex:outputPanel>
                                </apex:outputPanel>
                                <!-- END : OD Lens Data -->

                                <!-- START : OS Lens Data -->
                                <apex:outputPanel layout="block" styleClass="slds-large-size_4-of-8 slds-medium-size_3-of-6 slds-small-size_1-of-1 slds-float_left slds-p-right_xx-small">
                                    <apex:outputPanel layout="block" id="osLensDataFields">
                                        <h3 class="slds-section-title--divider">OS Lens Data</h3>
                                        <div class="slds-form slds-form_compound slds-text-align_center">
                                            <div class="slds-form-element__group slds-p-around_xx-small">                           
                                                <div class="slds-form-element__row slds-p-bottom_large">
                                                    <div class="slds-form-element slds-size_1-of-3">
                                                        <apex:outputLabel value="PAR" for="OS_Par" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_Par" value="{!osOrdItm.PAR__c}" styleClass="slds-input"/>
                                                        </div>  
                                                        <apex:outputLabel value="(diopters)" styleClass="slds-form-element__label"/>
                                                    </div>

                                                    <div class="slds-form-element slds-size_1-of-3">
                                                        <apex:outputLabel value="BVP" for="OS_Bvp" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_Bvp" value="{!osOrdItm.BVP__c}" styleClass="slds-input"/>
                                                        </div>  
                                                    </div>                                  
                                    
                                                    <div class="slds-form-element slds-size_1-of-3">
                                                        <apex:outputLabel value="CT" for="OS_Ct" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_Ct" value="{!osOrdItm.CT__c}" styleClass="slds-input"/>
                                                        </div>  
                                                    </div>
                                                </div>

                                                <div class="slds-form-element__row">
                                                    <div class="slds-form-element slds-size_1-of-2 slds-form--horizontal">
                                                        <apex:outputLabel value="LSag" for="OS_LSag" styleClass="slds-form-element__label slds-m-right_large"/>
                                                        <div class="slds-form-element__control">    
                                                            <apex:inputfield html-autocomplete="off" id="OS_LSag" value="{!osOrdItm.LSag__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>                                                    
                                                    <div class="slds-form-element slds-size_1-of-2 slds-form--horizontal">
                                                        <apex:outputLabel value="NPC" for="OS_Npc" styleClass="slds-form-element__label slds-m-right_large"/>
                                                        <div class="slds-form-element__control">    
                                                            <apex:inputfield html-autocomplete="off" id="OS_Npc" value="{!osOrdItm.NPC__c}" styleClass="slds-input">
                                                                <apex:actionSupport event="onchange" reRender="osManualInputFields, jsPanel" status="pageStatus"/>
                                                            </apex:inputField>
                                                        </div>
                                                    </div>                                  
                                                </div>

                                                <div class="slds-form-element__row">
                                                    <div class="slds-form-element slds-size_1-of-2 slds-form--horizontal">
                                                        <apex:outputLabel value="FCR" for="OS_FCR"  styleClass="slds-form-element__label slds-m-right_large"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_FCR" value="{!osOrdItm.FCR__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-2 slds-form--horizontal">
                                                        <apex:outputLabel value="POZ" for="OS_Poz" styleClass="slds-form-element__label slds-m-right_large"/>
                                                        <div class="slds-form-element__control">    
                                                            <apex:inputfield html-autocomplete="off" id="OS_Poz" value="{!osOrdItm.POZ__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>                                                    
                                                </div>
                                                <div class="slds-form-element__row">
                                                    <div class="slds-form-element slds-size_1-of-2 slds-form--horizontal">
                                                        <apex:outputLabel value="BFS" for="OS_Bfs" styleClass="slds-form-element__label slds-m-right_large"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_Bfs" value="{!osOrdItm.BFS__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-2 slds-form--horizontal">
                                                        <apex:outputLabel value="CCR" for="OS_CCR" styleClass="slds-form-element__label slds-m-right_large"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_CCR" value="{!osOrdItm.CCR__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>
                                                </div>                                              
                                            </div>
                                        </div>
                                    </apex:outputPanel>
                                    <apex:outputPanel layout="block" id="osLensDataNoDisplay" styleClass="slds-hide">
                                        <h3 class="slds-text-align_center">No OS Lens Data</h3>
                                    </apex:outputPanel>
                                </apex:outputPanel>
                                <!-- END : OS Lens Data -->
                            </apex:outputPanel>

                            <div class="slds-grid slds-wrap" id="manualInputSection">
                                <!-- START : OD Manual Input Data -->
                                <apex:outputPanel layout="block" styleClass="slds-large-size_4-of-8 slds-medium-size_3-of-6 slds-small-size_1-of-1 slds-float_left slds-p-right_xx-small">
                                    <apex:outputPanel layout="block" id="odManualInputFields">
                                        <h3 class="slds-section-title--divider">OD Manual Input Data</h3>
                                        <fieldset class="slds-box slds-m-bottom_medium" style="text-align: center; padding: 0%; padding-left: 0.5%;">
                                            <legend id="od_PCs_Form" class="slds-text-heading--small slds-p-vertical--medium">PCs</legend>  
                                            <div class="slds-form slds-wrap">
                                                <apex:outputPanel layout="block" styleClass="slds-size_1-of-4 slds-float_left slds-p-right_xxx-small slds-m-bottom_medium slds-m-bottom_medium" rendered="{!odOrdItm.NPC__c >= 1}">
                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Radius" for="OD_Ir1" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Ir1" value="{!odOrdItm.Ir1__c}" styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                        <apex:outputLabel value="(diopters)" styleClass="slds-form-element__label"/>
                                                    </div>

                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Width" for="OD_Irw1" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Irw1" value="{!odOrdItm.Irw1__c}" styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                    </div>                                                      
                                                </apex:outputPanel>


                                                <apex:outputPanel layout="block" styleClass="slds-size_1-of-4 slds-float_left slds-p-right_xxx-small slds-m-bottom_medium" rendered="{!odOrdItm.NPC__c >= 2}">
                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Radius" for="OD_Ir2" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Ir2" value="{!odOrdItm.Ir2__c}"  styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                        <apex:outputLabel value="(diopters)" styleClass="slds-form-element__label"/>
                                                    </div>

                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Width" for="OD_Irw2" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Irw2" value="{!odOrdItm.Irw2__c}" styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>  
                                                    </div>
                                                </apex:outputPanel>


                                                <apex:outputPanel layout="block" styleClass="slds-size_1-of-4 slds-float_left slds-p-right_xxx-small slds-m-bottom_medium" rendered="{!odOrdItm.NPC__c >= 3}">
                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Radius" for="OD_Ir3"  styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Ir3" value="{!odOrdItm.Ir3__c}" styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                        <apex:outputLabel value="(diopters)" styleClass="slds-form-element__label"/>
                                                    </div>  

                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Width" for="OD_Irw3" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Irw3" value="{!odOrdItm.Irw3__c}"  styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                    </div>
                                                </apex:outputPanel>
                                                

                                                <apex:outputPanel layout="block" styleClass="slds-size_1-of-4 slds-float_left slds-p-right_xxx-small slds-m-bottom_medium" rendered="{!odOrdItm.NPC__c >= 4}">
                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Radius" for="OD_Ir4" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Ir4" value="{!odOrdItm.Ir4__c}"  styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                        <apex:outputLabel value="(diopters)" styleClass="slds-form-element__label"/>
                                                    </div>  

                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Width" for="OD_Irw4" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Irw4" value="{!odOrdItm.Irw4__c}"  styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                    </div>
                                                </apex:outputPanel>


                                                <apex:outputPanel layout="block" styleClass="slds-size_1-of-4 slds-float_left slds-p-right_xxx-small slds-m-bottom_medium" rendered="{!odOrdItm.NPC__c >= 5}">
                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Radius" for="OD_Ir5" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Ir5" value="{!odOrdItm.Ir5__c}" styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                        <apex:outputLabel value="(diopters)" styleClass="slds-form-element__label"/>
                                                    </div>  

                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Width" for="OD_Irw5" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Irw5" value="{!odOrdItm.Irw5__c}"  styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                    </div>
                                                </apex:outputPanel>


                                                <apex:outputPanel layout="block" styleClass="slds-size_1-of-4 slds-float_left slds-p-right_xxx-small slds-m-bottom_medium" rendered="{!odOrdItm.NPC__c >= 6}">
                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Radius" for="OD_Ir6" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Ir6" value="{!odOrdItm.Ir6__c}"  styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                        <apex:outputLabel value="(diopters)" styleClass="slds-form-element__label"/>
                                                    </div>  

                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Width" for="OD_Irw6" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Irw6" value="{!odOrdItm.Irw6__c}" styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                    </div>
                                                </apex:outputPanel>


                                                <apex:outputPanel layout="block" styleClass="slds-size_1-of-4 slds-float_left slds-p-right_xxx-small slds-m-bottom_medium" rendered="{!odOrdItm.NPC__c >= 7}">
                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Radius" for="OD_Ir7" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Ir7" value="{!odOrdItm.Ir7__c}" styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                        <apex:outputLabel value="(diopters)" styleClass="slds-form-element__label"/>
                                                    </div>  

                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Width" for="OD_Irw7" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Irw7" value="{!odOrdItm.Irw7__c}" styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                    </div>
                                                </apex:outputPanel>
                                            </div>
                                        </fieldset>
                                        <div class="slds-form slds-form_compound">
                                            <div class="slds-form-element__group">
                                                <!-- START : OD Row 4 -->
                                                <div class="slds-form-element__row">
                                                    <div class="slds-form-element slds-size_1-of-4 slds-text-align_right">
                                                        <apex:outputLabel value="Front Zone (AOZ)" for="OD_Aoz" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_Aoz" value="{!odOrdItm.AOZ__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-4 slds-text-align_right">
                                                        <apex:outputLabel value="Min CT" for="OD_MinCT" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_MinCT" value="{!odOrdItm.MinCT__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-4 slds-text-align_right">
                                                        <apex:outputLabel value="Min JT" for="OD_MinJT" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_MinJT" value="{!odOrdItm.MinJT__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>
                                                    <div class="slds-form-element slds-size_1-of-4 slds-text-align_right">
                                                        <apex:outputLabel value="Min ET" for="OD_MinET" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OD_MinET" value="{!odOrdItm.MinET__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>                                  
                                                </div>
                                                <!-- END : OD Row 4 -->
                                            </div>  
                                        </div>
                                    </apex:outputPanel>
                                    <apex:outputPanel layout="block" id="odManualDataNoDisplay" styleClass="slds-hide">
                                        <h3 class="slds-text-align_center">No OD Manual Data</h3>
                                    </apex:outputPanel>
                                </apex:outputPanel>
                            <!-- END : OD Manual Input Data -->

                            <!-- START : OS Manual Input Data -->
                                <apex:outputPanel layout="block" styleClass="slds-large-size_4-of-8 slds-medium-size_3-of-6 slds-small-size_1-of-1 slds-float_left slds-p-right_xx-small">
                                    <apex:outputPanel layout="block" id="osManualInputFields">
                                        <h3 class="slds-section-title--divider">OS Manual Input Data</h3>
                                        <fieldset class="slds-box slds-m-bottom_medium" style="text-align: center; padding: 0%; padding-left: 0.5%;">
                                            <legend id="os_PCs_Form" class="slds-text-heading--small slds-p-vertical--medium">PCs</legend>  
                                            <div class="slds-form slds-wrap">
                                                <apex:outputPanel layout="block" styleClass="slds-size_1-of-4 slds-float_left slds-p-right_xxx-small slds-m-bottom_medium slds-m-bottom_medium" rendered="{!osOrdItm.NPC__c >= 1}">
                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Radius" for="OS_Ir1" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_Ir1" value="{!osOrdItm.Ir1__c}" styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                        <apex:outputLabel value="(diopters)" styleClass="slds-form-element__label"/>
                                                    </div>

                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Width" for="OS_Irw1" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_Irw1" value="{!osOrdItm.Irw1__c}" styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                    </div>                                                      
                                                </apex:outputPanel>


                                                <apex:outputPanel layout="block" styleClass="slds-size_1-of-4 slds-float_left slds-p-right_xxx-small slds-m-bottom_medium" rendered="{!osOrdItm.NPC__c >= 2}">
                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Radius" for="OS_Ir2" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_Ir2" value="{!osOrdItm.Ir2__c}"  styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                        <apex:outputLabel value="(diopters)" styleClass="slds-form-element__label"/>
                                                    </div>

                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Width" for="OS_Irw2"  styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_Irw2" value="{!osOrdItm.Irw2__c}" styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>  
                                                    </div>
                                                </apex:outputPanel>


                                                <apex:outputPanel layout="block" styleClass="slds-size_1-of-4 slds-float_left slds-p-right_xxx-small slds-m-bottom_medium" rendered="{!osOrdItm.NPC__c >= 3}">
                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Radius" for="OS_Ir3"  styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_Ir3" value="{!osOrdItm.Ir3__c}" styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                        <apex:outputLabel value="(diopters)" styleClass="slds-form-element__label"/>
                                                    </div>  

                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Width" for="OS_Irw3" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_Irw3" value="{!osOrdItm.Irw3__c}"  styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                    </div>
                                                </apex:outputPanel>
                                                

                                                <apex:outputPanel layout="block" styleClass="slds-size_1-of-4 slds-float_left slds-p-right_xxx-small slds-m-bottom_medium" rendered="{!osOrdItm.NPC__c >= 4}">
                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Radius" for="OS_Ir4" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_Ir4" value="{!osOrdItm.Ir4__c}"  styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                        <apex:outputLabel value="(diopters)" styleClass="slds-form-element__label"/>
                                                    </div>  

                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Width" for="OS_Irw4" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_Irw4" value="{!osOrdItm.Irw4__c}"  styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                    </div>
                                                </apex:outputPanel>


                                                <apex:outputPanel layout="block" styleClass="slds-size_1-of-4 slds-float_left slds-p-right_xxx-small slds-m-bottom_medium" rendered="{!osOrdItm.NPC__c >= 5}">
                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Radius" for="OS_Ir5" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_Ir5" value="{!osOrdItm.Ir5__c}" styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                        <apex:outputLabel value="(diopters)" styleClass="slds-form-element__label"/>
                                                    </div>  

                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Width" for="OS_Irw5" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_Irw5" value="{!osOrdItm.Irw5__c}"  styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                    </div>
                                                </apex:outputPanel>


                                                <apex:outputPanel layout="block" styleClass="slds-size_1-of-4 slds-float_left slds-p-right_xxx-small slds-m-bottom_medium" rendered="{!osOrdItm.NPC__c >= 6}">
                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Radius" for="OS_Ir6" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_Ir6" value="{!osOrdItm.Ir6__c}"  styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                        <apex:outputLabel value="(diopters)" styleClass="slds-form-element__label"/>
                                                    </div>  

                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Width" for="OS_Irw6"  styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_Irw6" value="{!osOrdItm.Irw6__c}" styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                    </div>
                                                </apex:outputPanel>


                                                <apex:outputPanel layout="block" styleClass="slds-size_1-of-4 slds-float_left slds-p-right_xxx-small slds-m-bottom_medium" rendered="{!osOrdItm.NPC__c >= 7}">
                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Radius" for="OS_Ir7" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_Ir7" value="{!osOrdItm.Ir7__c}" styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                        <apex:outputLabel value="(diopters)" styleClass="slds-form-element__label"/>
                                                    </div>  

                                                    <div class="slds-form-element slds-float_left slds-size_1-of-2">
                                                        <apex:outputLabel value="Width" for="OS_Irw7" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_Irw7" value="{!osOrdItm.Irw7__c}" styleClass="slds-input" style="font-size: 11px;padding: 0px 0.1rem 0px 0.1rem;text-align: center;"/>
                                                        </div>
                                                    </div>
                                                </apex:outputPanel>
                                            </div>
                                        </fieldset>
                                        <div class="slds-form slds-form_compound">
                                            <div class="slds-form-element__group">
                                                <!-- START : OS Row 4 -->
                                                <div class="slds-form-element__row">
                                                    <div class="slds-form-element  slds-size_1-of-4 slds-text-align_right">
                                                        <apex:outputLabel value="Front Zone (AOZ)" for="OS_Aoz" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_Aoz" value="{!osOrdItm.AOZ__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>
                                                    <div class="slds-form-element  slds-size_1-of-4 slds-text-align_right">
                                                        <apex:outputLabel value="Min CT" for="OS_MinCT" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_MinCT" value="{!osOrdItm.MinCT__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>
                                                    <div class="slds-form-element  slds-size_1-of-4 slds-text-align_right">
                                                        <apex:outputLabel value="Min JT" for="OS_MinJT" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_MinJT" value="{!osOrdItm.MinJT__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>
                                                    <div class="slds-form-element  slds-size_1-of-4 slds-text-align_right">
                                                        <apex:outputLabel value="Min ET" for="OS_MinET" styleClass="slds-form-element__label"/>
                                                        <div class="slds-form-element__control">
                                                            <apex:inputfield html-autocomplete="off" id="OS_MinET" value="{!osOrdItm.MinET__c}" styleClass="slds-input"/>
                                                        </div>
                                                    </div>                                  
                                                </div>
                                                <!-- END : OS Row 4 -->
                                            </div>
                                        </div>
                                    </apex:outputPanel>
                                    <apex:outputPanel layout="block" id="osManualDataNoDisplay" styleClass="slds-hide">
                                        <h3 class="slds-text-align_center"> No OS Manual Data</h3>
                                    </apex:outputPanel>
                                </apex:outputPanel>
                            <!-- END : OS Manual Input Data -->

                            <!-- START : Manual Input Buttons -->
                                <apex:outputPanel layout="block" id="manualInputButtons" styleClass="slds-large-size_8-of-8 slds-medium-size_6-of-6 slds-small-size_1-of-1 slds-text-align_center slds-m-around_medium">
                                    
                                    <apex:commandButton value="Manual Input (F5)" styleClass="slds-button slds-button_neutral" id="editManualInput"/>
                                    <apex:commandButton value="Edit Exam Data (F10)" styleClass="slds-button slds-button_destructive" id="editExamData"/>
                                    <apex:commandButton value="Calculate Manual (F5)" styleClass="slds-button slds-button_brand" id="saveManualInput" disabled="true"/>
                                </apex:outputPanel>
                            <!-- END : Manual Input Buttons -->
                            </div>
                        </apex:outputPanel>

                        <!-- RHS section which consistes the Additional Order Options, OTS, Duplicate -->
                        <apex:outputPanel layout="block" styleClass="slds-large-size_3-of-12 slds-medium-size_12-of-12 slds-small-size_12-of-12 slds-float_left">
                            <!-- START : Additional Order Option Section -->
                            <apex:outputPanel layout="block" id="aop">
                                <h3 class="slds-section-title--divider">Additional Order Options</h3>
                                <div class="slds-form slds-form_compound slds-text-align_center">
                                    <div class="slds-form-element__group slds-p-around_xx-small">
                                        <div class="slds-form-element__row">
                                            <div class="slds-form-element slds-size_1-of-4">
                                                <apex:outputLabel value="Laser" styleClass="slds-checkbox_toggle slds-form-element__label" style="text-align: -webkit-center">
                                                    <apex:inputfield html-autocomplete="off" id="nLaser" value="{!ord.Laser__c}"/>
                                                    <span class="slds-checkbox_faux_container">
                                                        <span class="slds-checkbox_faux"></span>
                                                        <span class="slds-checkbox_on">On</span>
                                                        <span class="slds-checkbox_off">Off</span>
                                                    </span>
                                                </apex:outputLabel>
                                            </div>
                                            <div class="slds-form-element slds-size_1-of-4">
                                                <apex:outputLabel value="Shipping" for="shipping" styleClass="slds-form-element__label"/>
                                                <apex:inputfield html-autocomplete="off" id="shipping" value="{!ord.Shipping__c}" styleClass="slds-select"/>
                                            </div>
                                            <div class="slds-form-element slds-size_1-of-4">                                
                                                <apex:outputLabel value="China Options" for="ChinaOptions" styleClass="slds-form-element__label slds-truncate slds-m-bottom_none"/>
                                                <apex:inputfield html-autocomplete="off" id="ChinaOptions" value="{!ord.China_Options__c}" styleClass="slds-select"/>
                                            </div>

                                            <div class="slds-form-element slds-size_1-of-4">
                                                <apex:outputLabel value="Priority" styleClass="slds-form-element__label"/>
                                                <div class="slds-form-element__control">
                                                    <apex:selectList id="orderPriority" value="{!ord.OrderPriority__c}" styleClass="slds-select" multiselect="false" size="1">
                                                        <apex:selectOptions value="{!orderPriorityOptions}"/>
                                                    </apex:selectList>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </apex:outputPanel>
                            <!-- END : Additional Order Option Section -->

                            <!-- START : Entry Options Section -->
                            <apex:outputPanel layout="block" id="entryOptions">
                                <h3 class="slds-section-title--divider">Entry Options</h3>
                                <div class="slds-form slds-form_compound slds-text-align_center">
                                    <div class="slds-form-element__group slds-p-around_xx-small">
                                        <div class="slds-form-element__row">

                                            <div class="slds-form-element slds-size_1-of-3">
                                                <apex:outputLabel value="Auto Name" styleClass="slds-checkbox_toggle slds-form-element__label" style="text-align: -webkit-center">
                                                    <apex:inputfield html-autocomplete="off" id="autoNameOptions" value="{!ord.Auto_Name__c}"/>
                                                    <span class="slds-checkbox_faux_container">
                                                        <span class="slds-checkbox_faux"></span>
                                                        <span class="slds-checkbox_on">On</span>
                                                        <span class="slds-checkbox_off">Off</span>
                                                    </span>
                                                </apex:outputLabel>
                                            </div>
                                           
                                            <div class="slds-form-element slds-size_2-of-3">
                                                <apex:outputLabel value="Auto Name Prefix" for="autoNamePrefix" styleClass="slds-form-element__label"/>
                                                <apex:inputfield html-autocomplete="off" value="{!ord.Auto_Name_Prefix__c}" id="autoNamePrefix" styleClass="slds-input" html-disabled="true"/>
                                            </div>                                            
                                        </div>

                                        <apex:outputPanel id="dupFields">
                                            <div class="slds-form-element__row">

                                                <div class="slds-form-element slds-size_1-of-3">
                                                    <apex:outputLabel value="Save Duplicate" styleClass="slds-checkbox_toggle slds-form-element__label" style="text-align: -webkit-center">
                                                        <apex:inputCheckbox id="saveDupOptions" value="{!saveDupCheck}"/>
                                                        <span class="slds-checkbox_faux_container">
                                                            <span class="slds-checkbox_faux"></span>
                                                            <span class="slds-checkbox_on">On</span>
                                                            <span class="slds-checkbox_off">Off</span>
                                                        </span>
                                                    </apex:outputLabel>
                                                </div>                                              

                                                <div class="slds-form-element slds-size_1-of-3">
                                                    <apex:outputLabel value="Quantity" for="qty" styleClass="slds-form-element__label"/>
                                                    <apex:inputText id="qty" styleClass="slds-input" value="{!quantity}"/>
                                                </div>

                                                <div class="slds-form-element slds-size_1-of-3 slds-p-top_large">
                                                    <button id="saveDupBtn" type="button" value="Save Duplicate" class="slds-button slds-button_neutral slds-truncate" disabled="true">Save Duplicate</button>                                                    
                                                    <apex:actionFunction name="saveDup" action="{!save}" reRender="pageScope,jsPanel,sessionCounter" status="pageStatus" oncomplete="sessionCounter();"> 
                                                        <!-- <apex:param name="quantityparam" assignTo="{!quantity}" value=""/> -->
                                                    </apex:actionFunction>                                                    
                                                </div>
                                            </div>                                            
                                        </apex:outputPanel>
                                        <div class="slds-form-element__row">
                                            <div class="slds-form-element slds-size_1-of-3">
                                                <apex:outputLabel value="Batch Toggle" styleClass="slds-checkbox_toggle slds-form-element__label" style="text-align: -webkit-center">
                                                    <apex:inputCheckbox id="batchToggle" value="{!batchToggle}"/>
                                                    <span class="slds-checkbox_faux_container">
                                                        <span class="slds-checkbox_faux"></span>
                                                        <span class="slds-checkbox_on">On</span>
                                                        <span class="slds-checkbox_off">Off</span>
                                                    </span>
                                                </apex:outputLabel>
                                            </div>

                                            <div class="slds-form-element slds-size_2-of-3">                                
                                                <apex:outputLabel value="Batch Id" for="batchId" styleClass="slds-form-element__label"/>
                                                <apex:inputfield html-autocomplete="off" id="batchId" value="{!ord.Batch_ID__c}" styleClass="slds-input" html-disabled="true"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </apex:outputPanel>     
                            <!-- END : Entry Options Section -->

                            <!-- START : One Time Ship To -->
                            <apex:outputPanel layout="block" id="ots">
                                <h3 class="slds-section-title--divider">One Time Ship To</h3>
                                <div class="slds-form slds-form_stacked slds-text-align_center">
                                    <div class="slds-form-element slds-form--horizontal">
                                        <apex:outputLabel value="Use OTS:" for="UseOTS" styleClass="slds-checkbox__label"/>
                                        <div class="slds-form-element__control">
                                            <apex:inputCheckbox id="UseOTS" value="{!ord.Use_OTS__c}" styleClass="slds-checkbox"/>
                                        </div>
                                    </div>

                                    <div class="slds-form-element slds-form--horizontal">
                                        <apex:outputLabel value="Address 1:" for="OTSAddress1" styleClass="slds-form-element__label"/>
                                        <div class="slds-form-element__control">
                                            <apex:inputfield html-autocomplete="off" id="OTSAddress1" value="{!ord.OTSAddress1__c}" styleClass="slds-input"/>
                                        </div>
                                    </div>

                                    <div class="slds-form-element slds-form--horizontal">
                                        <apex:outputLabel value="Address 2:" for="OTSAddress2" styleClass="slds-form-element__label"/>
                                        <div class="slds-form-element__control">
                                            <apex:inputfield html-autocomplete="off" id="OTSAddress2" value="{!ord.OTSAddress2__c}" styleClass="slds-input"/>
                                        </div>
                                    </div>

                                    <div class="slds-form-element slds-form--horizontal">
                                        <apex:outputLabel value="Address 3:" for="OTSAddress3" styleClass="slds-form-element__label"/>
                                        <div class="slds-form-element__control">
                                            <apex:inputfield html-autocomplete="off" id="OTSAddress3" value="{!ord.OTSAddress3__c}" styleClass="slds-input"/>
                                        </div>
                                    </div>

                                    <div class="slds-form-element slds-form--horizontal">
                                        <apex:outputLabel value="City:" for="OTSCity" styleClass="slds-form-element__label"/>
                                        <div class="slds-form-element__control">
                                            <apex:inputfield html-autocomplete="off" id="OTSCity" value="{!ord.OTSCity__c}" styleClass="slds-input"/>
                                        </div>
                                    </div>

                                    <div class="slds-form-element slds-form--horizontal">
                                        <apex:outputLabel value="State:" for="OTSState" styleClass="slds-form-element__label"/>
                                        <div class="slds-form-element__control">
                                            <apex:inputfield html-autocomplete="off" id="OTSState" value="{!ord.OTSState__c}"  styleClass="slds-input"/>
                                        </div>
                                    </div>

                                    <div class="slds-form-element slds-form--horizontal">
                                        <apex:outputLabel value="Zip:" for="OTSZip" styleClass="slds-form-element__label"/>
                                        <div class="slds-form-element__control">
                                            <apex:inputfield html-autocomplete="off" id="OTSZip" value="{!ord.OTSZip__c}" styleClass="slds-input"/>
                                        </div>
                                    </div>

                                    <div class="slds-form-element slds-form--horizontal">
                                        <apex:outputLabel value="Country:" for="OTSCountry" styleClass="slds-form-element__label"/>
                                        <div class="slds-form-element__control">
                                            <apex:inputfield html-autocomplete="off" id="OTSCountry" value="{!ord.OTSCountry__c}" styleClass="slds-input"/>
                                        </div>
                                    </div>

                                    <div class="slds-form-element slds-form--horizontal">
                                        <apex:outputLabel value="Phone:" for="OTSPhone" styleClass="slds-form-element__label"/>
                                        <div class="slds-form-element__control">
                                            <apex:inputfield html-autocomplete="off" id="OTSPhone" value="{!ord.OTSPhone__c}" styleClass="slds-input"/>
                                        </div>
                                    </div>
                                    
                                </div>
                            </apex:outputPanel>
                            <!-- END : ONe Time Ship To -->

                            <!-- START : Duplicate Section -->
                            <!-- Duplicate section has been disabled as we are going to use salesforce global search functionality for re-orders -->
                            <apex:outputPanel layout="block" id="dupSection" styleClass="slds-m-top_medium">
                                <h3 class="slds-section-title--divider">Duplicate</h3>
                                <div class="slds-form slds-form_compound slds-text-align_center">
                                    <div class="slds-form-element__group slds-p-around_xx-small">
                                        <div class="slds-form-element__row">
                                            <div class="slds-form-element slds-size_1-of-3">
                                                <apex:outputLabel value="Duplication Type" for="DuplicateType" styleClass="slds-form-element__label slds-truncate"/>
                                                <div class="slds-form-element__control">
                                                    <apex:selectList id="DuplicateType" value="{!duplicateType}" styleClass="slds-select" multiselect="false" size="1">
                                                        <apex:selectOptions value="{!duplicateOptions}"/>
                                                    </apex:selectList>
                                                </div>
                                            </div>

                                            <div class="slds-form-element slds-size_1-of-3">
                                                <apex:outputLabel value="ERP Order" styleClass="slds-form-element__label" for="ErpOrderNum"/>
                                                <div class="slds-form-element__control">
                                                    <apex:inputText value="{!dupOrderId}" id="ErpOrderNum" styleClass="slds-input" style="padding: 0 0.5rem 0 .5rem;"/>
                                                </div>
                                            </div>

                                            <div class="slds-form-element slds-size_1-of-3">
                                                <apex:outputLabel value="" styleClass="slds-form-element__label"/>
                                                <div class="slds-form-element__control slds-p-top_xx-small">
                                                    <apex:commandButton value="Duplicate" styleClass="slds-button slds-button_neutral" action="{!dupOrder}" reRender="pageScope,jsPanel,sessionCounter,errorPrompt" status="pageStatus" oncomplete="errorPrompt();"/>
                                                </div>                              
                                            </div>
                                        </div>
                                    </div>
                                </div>      
                            </apex:outputPanel>
                            <!-- END : Duplicate Section -->
                        </apex:outputPanel>
                    </div>
                    <!-- END : Second Panel -->


                    <!-- START : Third Panel  -->
                    <div class="slds-grid slds-wrap slds-border_top">
                        <div class="slds-large-size_3-of-4 slds-medium-size_2-of-3 slds-small-size_1-of-1">
                            <div class="slds-form_element slds-large-size_3-of-4 slds-medium-size_2-of-3 slds-small-size_1-of-1 slds-float_left slds-p-around_small">
                                <apex:outputLabel value="Lens Comments" for="lensComments" styleClass="slds-form-element__label"/>
                                <div class="slds-form-element__control">
                                    <apex:inputfield html-autocomplete="off" value="{!ord.Lens_Comments__c}" id="lensComments" styleClass="slds-textarea"/>
                                </div>
                            </div>
                            <div class="slds-form_element slds-large-size_1-of-4 slds-float_left slds-p-around_small">
                                <div class="slds-lookup" data-select="single" data-scope="single" data-typeahead="true">
                                    <div class="slds-form-element">
                                        <label class="slds-form-element__label" for="rmaNumber">ERP RMA #</label>
                                        <div class="slds-form-element__control slds-input-has-icon slds-input-has-icon--right">
                                            <span class="slds-input__icon" aria-hidden="true">
                                                <i class="fa fa-search"></i>
                                            </span>
                                            <div class="slds-pill__container slds-hide"></div>
                                            <apex:inputText id="rmaNumber" styleClass="slds-input slds-show" html-aria-autocomplete="list" html-role="combobox" html-aria-expanded="true" html-aria-activedescendant="" value="{!rmaName}" />
                                            <apex:inputHidden id="rmaNumberId" value="{!ord.ERP_RMA__c}" />
                                        </div>
                                    </div>
                                </div>
                                <!-- <apex:outputLabel value="ERP RMA #" for="Rma_Number" styleClass="slds-form-element__label" />
                                <div class="slds-form-element__control">
                                    <apex:inputfield html-autocomplete = "off" value="{!ord.ERP_RMA__c}" id="Rma_Number" />
                                </div> -->  
                            </div>
                        </div>
                        <div class="slds-large-size_1-of-4 slds-medium-size_1-of-3 slds-small-size_1-of-1 slds-text-align_center">
                            <apex:commandButton id="reset" value="Reset" reRender="" styleClass="slds-button slds-button_neutral slds-m-top_x-large"/>
                            <apex:commandButton id="calculate" value="Calculate Exam (F11)" styleClass="slds-button slds-button_neutral slds-m-top_x-large"/>
                            <!-- <apex:commandButton id="save" value="Save (F8)" styleClass="slds-button slds-button_brand slds-m-top_x-large"/> -->
                            <button id="save" type="button" value="save" class="slds-button slds-button_brand slds-m-top_x-large">Save (F8)</button>
                            <!-- <apex:actionFunction name="refresh" action="{!refresh}" /> -->
                            <apex:actionFunction name="calc" action="{!calculateRef}" reRender="pageScope,callEditManualInputButton,jsPanel,sessionCounter" status="pageStatus" oncomplete="callEditManualInputButton();return false;">
                                <apex:param id="calcType" name="calcTypeParam" value="" />
                            </apex:actionFunction>
                            <apex:actionFunction name="saveOrder" action="{!save}" reRender="pageScope,jsPanel,sessionCounter" status="pageStatus" oncomplete="sessionCounter(0);"/>
                            <apex:actionFunction name="emeraldLimitValue" action="{!getEmeraldLimit}" reRender="jsPanel,osLimit,odLimit"/>
                        </div>
                    </div>
                    <!-- END : Thrid Panel -->
                </apex:outputPanel>
            </body>
        </html>
        <apex:outputPanel id="jsPanel">        
            <script>
                (function($) {

                    $.widget('slds.autocomplete', $.ui.autocomplete, {

                        _create: function() {

                            this._super();

                            this.sldsMenu = $('<div >')
                                .addClass('slds-hide')
                                .attr('role', 'listbox')
                                .css({
                                        'width' : '100%'                                        
                                    });

                            this.element.parent().append(this.sldsMenu);

                            $('.ui-helper-hidden, .ui-helper-hidden-accessible').addClass('slds-hide');

                        },

                        _renderMenu: function(ul, items) {
                            var self = this;
                            ul.addClass('slds-lookup__menu');

                            // ul.addClass('slds-lookup__list').attr('role', 'presentation');
                            ul.appendTo(this.sldsMenu);

                            this.sldsMenu.addClass('slds-show').removeClass('slds-hide');
                            
                            $.each(items, function(index, item) {
                                var obj = new Object();
                                obj.value = this.Id;

                                if (this.hasOwnProperty("Name")) {
                                    obj.label = this.Name;
                                }

                                if (this.hasOwnProperty("ERP_RMA_Number__c")) {
                                    obj.label = this.ERP_RMA_Number__c;
                                }

                                if (this.hasOwnProperty("UNITYSALES__ERP_Customer_ID__c")) {
                                    obj.label = this.UNITYSALES__ERP_Customer_ID__c;
                                    obj.accName = this.Name;
                                }

                                if (this.hasOwnProperty("Patient_ID_2__c")) {
                                    obj.patientId = this.Patient_ID_2__c;
                                }                                
                                self._renderItemData(ul, obj);
                            });                             
                                                        
                        },

                        _renderItem: function(ul, item) {
                            var spanVal = '';                           
                            if (item.hasOwnProperty("patientId")) {
                                spanVal = ' - <span style="font-size:0.9em;font-style:italic;">'+item.patientId+'</span>';
                            }

                            if (item.hasOwnProperty("accName")) {
                                spanVal = ' - <span style="font-size:0.9em;font-style:italic;">'+item.accName+'</span>';
                            }
                            
                            return $('<li>')
                                .addClass('slds-lookup__item')
                                .append('<a href="#" role="option" style="border-bottom-width: 1px;border-bottom-style: double;border-bottom: #e6e4e4;">' + item.label + spanVal +'</a>')
                                .appendTo(ul);
                        },                      

                        _close: function(event) {

                            this._super(event);

                            this.sldsMenu.addClass('slds-hide').removeClass('slds-show');

                        }

                    });

                })(jQuery);

                $j(document).ready(function() {

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
                                    } else if($j.inArray(eleId, rsagArr) > -1 && {!isCalculated}){
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
                    if({!isCalculated}){
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
                                if({!isCalculated}){
                                    errorFound = validateInputFields('odExamDataFields','osExamDataFields','odLensDataFields','osLensDataFields','odManualInputFields','osManualInputFields');
                                } else {
                                    errorFound = validateInputFields('odExamDataFields','osExamDataFields');
                                }                                
                                
                            } else if($j('[id$=side]').val() == '2 - OD'){
                                if({!isCalculated}){
                                    errorFound = validateInputFields('odExamDataFields','odLensDataFields','odManualInputFields');
                                } else {
                                    errorFound = validateInputFields('odExamDataFields');
                                }
                                
                            } else {
                                if({!isCalculated}){
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

                //Fires the respective button events based on Function key button press
                $j(window).on('keydown', handleKeyEvents);
                function handleKeyEvents (event) {
                    //Function Key - F11
                    if(event.which == 122) {
                        if (event.handled !== true) {
                            event.handled = true;
                            event.preventDefault();
                            if(!$j('[id$=calculate]').prop('disabled')){
                                $j('[id$=calculate]').trigger('click');
                            }
                        }                       
                    }

                    //Function Key - F8
                    if(event.which == 119) {
                        if (event.handled !== true) {
                            event.handled = true;
                            event.preventDefault();
                            if (!$j('#save').prop('disabled')) {                                
                                $j('#save').trigger('click'); 
                            } else {
                                $j('#saveDupBtn').trigger('click');
                            }                                                       
                        }                       
                    }

                    //Function Key - F5
                    if(event.which == 116) {
                        if (event.handled !== true) {
                            event.handled = true;
                            event.preventDefault();
                            if(!$j('[id$=editManualInput]').prop('disabled')){
                                $j('[id$=editManualInput]').trigger('click');
                            } else if(!$j('[id$=saveManualInput]').prop('disabled')){
                                $j('[id$=saveManualInput]').trigger('click');
                            }
                        }                       
                    }

                    //Function Key - F10
                    if(event.which == 121) {
                        if (event.handled !== true) {
                            event.handled = true;
                            event.preventDefault();
                            if(!$j('[id$=editExamData]').prop('disabled')){
                                $j('[id$=editExamData]').trigger('click');
                            }
                        }                       
                    }                    
                }  

            </script>           
        </apex:outputPanel>
        <apex:outputPanel id="sessionCounter">
            <script>

                //Sets the Session counter local storage variable if it doesn't exists in the users local system

                //Check session counter for different browsers
                if(localStorage.getItem('sessionCounter') == '0' || localStorage.getItem('sessionCounter') == null) {
                    localStorage.setItem("sessionCounter", 0);                          
                }   

                //
                function sessionCounter(quantity){
                    var str = '{!errorMessage}';
                    var num = parseInt(localStorage.getItem('sessionCounter'));
                    if(str.length == 0){                        
                        var qty = '{!sessionCounter}';  
                        qty = parseInt(qty);                            
                        localStorage.setItem("sessionCounter", (qty+num));
                    }
                    $j('#sessionCounter').html('Session Counter:'+localStorage.getItem('sessionCounter'));
                    /*if(quantity == 0 && quantity != undefined){
                        location.reload();
                    }*/                 
                }
                $j('#sessionCounter').html('Session Counter:'+localStorage.getItem('sessionCounter'));          

                //When called resets the session counter to zero
                function resetSessionCounter(){
                    localStorage.setItem("sessionCounter", 0);
                    $j('#sessionCounter').html('Session Counter:'+localStorage.getItem('sessionCounter'));
                }

                //Batch Toggling
                function batchToggle (isOnLoad) {
                    if($j('[id$=batchToggle').prop('checked')) {
                        if (isOnLoad) {
                            $j('[id$=batchId').prop('disabled', false);
                        } else {
                            $j('[id$=batchId').prop('disabled', false);
                            var today = new Date();
                            var date = today.getFullYear()+''+("0" + (today.getMonth() + 1)).slice(-2)+''+today.getDate();
                            var time = today.getHours() + "" + (( (today.getMinutes()) < 10 ? '0':'') + today.getMinutes());
                            var dateTime = date+''+time;
                            $j('[id$=batchId').val(dateTime);
                        }                        
                    } else {
                        $j('[id$=batchId').prop('disabled', true);
                        $j('[id$=batchId').val('');
                    } 
                }

                batchToggle(true);

                $j('[id$=batchToggle').change(function(event) {
                    event.preventDefault();
                    batchToggle(false);
                });

                $j('[id$=OD_FlatK], [id$=OS_FlatK], [id$=OD_Rx], [id$=OS_Rx]').change(function() {
                    if($j(this).val().indexOf(".")==-1) {
                        var currentVal = $j(this).val();
                        currentVal = parseFloat(Math.round(currentVal * 100) / 100).toFixed(2);
                        $j(this).val(currentVal);
                    } 
                });

                $j('[id$=Patient]').change(function() {
                    if($j(this).val().length > 0 ) {
                        $j('[id$=PatientLKId]').parent().removeClass("slds-has-error");
                        $j('[id$=PatientLKId]').parent().find('.slds-form-element__help').remove();
                    } 
                });

                $j('[id$=LensAccount]').change(function() {
                    if($j(this).val().length > 0 ) {
                        $j('[id$=LensAccountId]').parent().removeClass("slds-has-error");
                        $j('[id$=LensAccountId]').parent().find('.slds-form-element__help').remove();
                    } 
                });                

                function redirectToSalesConsult () {
                    var url = '/apex/SalesConsultSearchPage';                    
                    var ordAccountId = '{!ord.AccountId}';
                    if(ordAccountId.length > 0) {
                        url = url+'?ordAccountId={!ord.AccountId}&ordAccountName={!accName}&ordPatientId={!ord.Patient_ID__c}&ordPatientName={!patientName}';
                    }
                    window.open(url);                    
                }

                function redirectToSalesforceHome () {
                    var url = '/home/home.jsp';
                    window.location = url;
                }
                

            </script>
        </apex:outputPanel>
        <apex:outputPanel id="errorPrompt">
            <script type="text/javascript">
                function errorPrompt () {
                    
                    var errorMsg = '{!errorPromptMessage}';                    
                    if(errorMsg.length > 0){
                        $j('#promptBackdrop').addClass('slds-backdrop--open');
                        $j('#promptDialog').addClass('slds-fade-in-open');
                        $j('#promptText').text(errorMsg);                        
                    }                                
                }

                function closePrompt () {
                    $j('#promptBackdrop').removeClass('slds-backdrop--open');
                    $j('#promptDialog').removeClass('slds-fade-in-open');
                }                

            </script>
        </apex:outputPanel>

        <apex:outputPanel id="callEditManualInputButton">
            <script type="text/javascript">
                function callEditManualInputButton () {
                }
            </script>
        </apex:outputPanel>
    </apex:form>        
</apex:page>
