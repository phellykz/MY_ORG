({
    iniciarForm : function(component) {
        var form = {
            'newRequest':'',
            'changeRequest':'',
            'defect':''
        }
        component.set('v.form',form);
    },
    salvarConfig : function(component, form) {
         console.log("estou na função do helper");
        var setings = component.get('c.setConfig');        
        setings.setParams({conta: JSON.stringify(form)});
        setings.setCallback(this, function(response) {             
            var state = response.getState();             
            if (state === "SUCCESS") {                                                         
                this.iniciarFor(component);
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
        $A.enqueueAction(setings);
    }    
})