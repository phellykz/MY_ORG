({
    helperMethod : function(component) {
        alert('Teste OK!');
    },
    createExpense: function(component, newExpense) {
        var createEvent = component.getEvent("createExpense");
        createEvent.setParams({ "expense": newExpense });
        createEvent.fire();
    },

})