({
    execMestre : function(component, event, helper) {
        alert("Escravo01 executou o Mestre com sucesso!");
        var exibir = component.get('v.exibirEscravo01');
        if (exibir) {
            exibir = false;
        } else {
            exibir = true;            
        }
        component.set('v.exibirEscravo01',exibir);
    },
    execEscarvo01 : function (component, event, helper) {
        var exibir = component.get('v.exibirEscravo01');
        if (exibir) {
            exibir = false;
        } else {
            exibir = true;            
        }
        component.set('v.exibirEscravo01',exibir);
        var escravo = component.find('Esc01');
        escravo.myMethod();
    }
})