({
    paiTest : function(component, event, helper) {
        alert('TUDO CERTO COM O PAI!');
        var avo = component.get('v.parent');
        avo.exetuceGrandFather();
    },

    execFilho : function(component, event, helper) {
        var filho = component.find("testID");
        filho.executarFilho();
    }

})