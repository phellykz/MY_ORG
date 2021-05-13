({
    // Load expenses from Salesforce
    doInit: function(component, event, helper) {
        // Create the action
        var action = component.get("c.getExpenses");
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.expenses", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },
    
    handleUpdateExpense: function(component, event, helper) {
        var updatedExp = event.getParam("expense");
        helper.updateExpense(component, updatedExp);
    },

    handleCreateExpense: function(component, event, helper) {
        alert('Event está funcionando');
        var newExpense = event.getParam("expense");
        alert(newExpense);
        helper.createExpense(component, newExpense);
    },

    clickReimbursed: function(component, event, helper) {
        var expense = component.get("v.newExpense");
        var updateEvent = component.getEvent("createExpense");
        updateEvent.setParams({ "expense": expense });
        updateEvent.fire();
    },
})