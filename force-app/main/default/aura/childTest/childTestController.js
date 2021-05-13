({
    myAction : function(component, event, helper) {
        var pai = component.get('v.parent');
        pai.paiTest();
    },
    executarFilho : function(component, event, helper) {
        alert('Method do filho executado com sucesso!');
    }
})