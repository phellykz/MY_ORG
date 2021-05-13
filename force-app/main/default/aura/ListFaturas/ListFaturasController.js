({
    doInit : function(component, event, helper) {
        helper.getData(component);
        helper.getUser(component);
    },
    
    openFatura : function (component, event, helper) {
        console.log("estou em OpenFatura");
        var index = event.target.getAttribute('data-index');
        var fatura = component.get("v.listFatura")[index];
        console.log(fatura);        
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            recordId: fatura.FaturaId
        });
        navEvt.fire();
    },
    
    openModal: function(component, event, helper) {
        component.set("v.openModal", true);
    },
    
    closeModal: function(component, event, helper) { 
        component.set("v.openModal", false);
    },
    
    onSuccess : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "Registro foi criado com Sucesso."
        });
        toastEvent.fire();
        component.set("v.openModal", false);
    },
    onError : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Error!",
            "message": "Error."
        });
        toastEvent.fire();
    },
    updateFaturas : function (component, event, helper){
        console.log("estou no controller");
        var updateId = [];
        var getAllId = component.find("boxPack");
        console.log(getAllId);
        if(!Array.isArray(getAllId)){
            if(getAllId.get("v.value") == true){                
                updateId.push(getAllId.get("v.text"));
            }            
        }else{
            for (var i =0; i<getAllId.length; i++){
                if(getAllId[i].get("v.value") == true){
                    updateId.push(getAllId[i].get("v.text"));
                }
            }
        }
        helper.updateStatus(component, event,updateId);        
    }
})