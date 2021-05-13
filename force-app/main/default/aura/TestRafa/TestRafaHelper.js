({
    enviarContas : function(cmp) {
        var action = cmp.get('c.sendAccont');
        action.setParams({'obj': JSON.stringify(cmp.get('v.objeto'))});
        action.setCallback(this, function(response) {
            if (response.getState()=='SUCCESS') {
                alert("registros salvos com sucessiiss!!!");
            } else {
                alert("Deu ruim! mais sorte na proxima");
            }
        });
        $A.enqueueAction(action);
    }
    
})