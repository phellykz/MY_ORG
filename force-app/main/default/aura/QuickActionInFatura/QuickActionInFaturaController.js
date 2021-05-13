({
    doInit: function (component, event, helper) {
        console.log('estou no controller js');
        helper.buscarDados(component);
    
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "O status da fatura foi alterado para Paga."
        });
        toastEvent.fire();
    }
})