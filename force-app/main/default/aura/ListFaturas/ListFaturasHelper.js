({
    getData : function(component){
        var action = component.get('c.getFaturaInContract');
        
        action.setParams({'contracId': component.get('v.recordId')});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.listFatura',JSON.parse(response.getReturnValue()));
            }            
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                    errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    getUser : function(component, event, updateId) {
        var action = component.get("c.getUserApex");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                component.set("v.userInfo", storeResponse);
            }
        });
        $A.enqueueAction(action);
    },
    
    updateStatus : function(component, event, updateId) {
        console.log(updateId);
        var update = component.get("c.updateStatusInFatura");
        update.setParams({
            "listFaturasIds": updateId
        });
        $A.enqueueAction(update);
    }
})