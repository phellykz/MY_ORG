({
    doInit : function(component, event, helper) {
        var record_Id = component.get('v.recordId');
        helper.getPicklistValues(component, event, helper);
        helper.getAccountOfContact(component, event, helper, record_Id);
    },

    salvarConta: function (component, event, helper) {
        // This will contain the string of the "value" attribute of the selected option
        //var valor = cmp.find('tipo').value;
        var conta = component.get('v.conta');
        helper.atualizarContaHelper(component, event, helper, conta);
        //alert(cmp.get('v.conta').type);
        //var selectedOptionValue = event.getParam("value");
        //alert("Option selected with value: '" + selectedOptionValue + "'");

    }
})