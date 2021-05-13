({
    getPicklistValues : function(component, event, helper) {
        var action = component.get("c.BuscarValoresTipoConta");
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var retorno = response.getReturnValue()
                var pickList = [];                
                retorno.forEach(function(valor){
                    var obj = {
                        label: valor,
                        value: valor
                    };
                    pickList.push(obj);
                });
                component.set("v.type",pickList)
                console.log('retorno data: '+retorno)
                console.log('pickList: '+pickList)
            }
        });
        $A.enqueueAction(action);
    },
    getAccountOfContact : function(component, event, helper, record_Id) {
        var action = component.get("c.getAccount");
        action.setParams({
            record_Id : record_Id
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var retorno = response.getReturnValue()                
                component.set("v.conta",retorno)
            }
        });
        $A.enqueueAction(action);
    },

    atualizarContaHelper: function(component, event, helper, conta) {
        var action = component.get("c.AtualizarContaAPEX");
        action.setParams({
            cont : conta
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                alert('Tudo OK!!!!!');
            }
        });
        $A.enqueueAction(action);
    }

})