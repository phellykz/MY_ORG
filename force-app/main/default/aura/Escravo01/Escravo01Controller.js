({
    myMethod : function(component, event, helper) {
        alert('O mestre executou o Escravo 01 com sucesso!');
    },
    execMestre : function(component, event, helper) {
        var mestre = component.get('v.parent');
        mestre.execMestre();
    }
})