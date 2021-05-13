({
    enviar : function(component, event, helper) {
        /*var Name = component.get('v.objeto.Name');
        var AccountNumber = component.get('v.objeto.AccountNumber');

        alert("Name:  "+Name);
        alert("AccountNumber:  "+AccountNumber);*/

        var objeto = component.get('v.objeto');

        if (objeto.Name !='') {
            helper.enviarContas(component);
            alert('Objeto enviado para o helper');
        } else {
            alert('Campos vazios');
        }

        /*var appEvent = $A.get("e.c:TestEvent");
        appEvent.setParams({ "message" : objeto.Name });
        appEvent.fire();*/

    }
})