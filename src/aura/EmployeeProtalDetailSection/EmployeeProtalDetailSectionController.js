({
    UserPersonalDetailsEvent : function(component, event, helper) {
        var msg= event.getParam("message");
        if(msg == 'PersonalDetails'){
            component.set("v.tab" ,msg)
            helper.helpermethod(component);
        }
        
        if(msg == 'Certificates'){
            component.set("v.tab" ,msg)
            helper.certificatesDetails(component);
        }
        
        if(msg == 'Emergencycontact'){
            component.set("v.tab" ,msg)
            helper.Emergencycontacts(component);
        }
        
        if(msg == 'knowYourColleagues'){
            component.set("v.tab" ,msg)
            //var searchValue = component.find("knowYourColleagues").get('v.value');
            //console.log(searchValue);
            //helper.searchContact(component);
        }
    },
    
    searchContact : function(component, event, helper) {
        var searchValue = component.find("keyword").get('v.value');
        helper.searchContact(component, searchValue);        
    },
    
    colleaguesDetails : function(component, event, helper) {
        var Value = event.getSource().get("v.value");
        //console.log(Value);
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": Value,
            "isredirect" : "true",
            "slideDevName": "related"
        });
        navEvt.fire();        
    },
    handleRecordUpdated: function(component, event, helper) {
        var eventParams = event.getParams();
        if(eventParams.changeType === "LOADED") {
            // record is loaded (render other component which needs record data value)
            console.log("Record is loaded successfully.");
        } else if(eventParams.changeType === "CHANGED") {
            // record is changed
        } else if(eventParams.changeType === "REMOVED") {
            // record is deleted
        } else if(eventParams.changeType === "ERROR") {
            // there’s an error while loading, saving, or deleting the record
        }
    },
    deleteEmergencyContacts: function(component, event, helper){
         
        console.log("delete emergency contact");
         var result = confirm("Want to delete?");
        if (result) {
            component.set("v.delemrId",event.getSource().get("v.value"));
            component.set("v.countemergency",true);
            component.find("delemergencycon").reloadRecord();
        }
    },
     emer_con_update : function(component){
        component.find("delemergencycon").deleteRecord($A.getCallback(function(deleteResult) {
            if (deleteResult.state === "SUCCESS" || deleteResult.state === "DRAFT") {
                //helper.helperMethod(component);
                alert("Record is deleted.");
            }               
        }));
               
        $A.get('e.force:refreshView').fire();  
  }  
 

    
})