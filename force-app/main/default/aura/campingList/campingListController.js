({
    doInit : function(component, event, helper) {
        var action = component.get('c.getItems');
        action.setCallback(this,  function(response) { 
            var state = response.getState();
            if (state=='SUCCESS') {
                component.set('v.items', response.getReturnValue());
            } else {
                console.log("Failed with state: " + state);
            }
        });

    },

    clickCreateItem : function(component, event, helper) {
        var validForm =  component.find('form').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        if (validForm) {
            var itemsList = component.get('v.items');
            var newItem = component.get('v.newItem');
            newItem = JSON.parse(JSON.stringify(newItem));
            itemsList.push(newItem);
            component.set('v.items', itemsList);
            component.set('v.newItem',"{'sobjectType':'Camping_Item__c','Name':'','Price__c': 0, 'Quantity__c': 0, 'Packed__c': false}");
        }
    },

    handleAdditem: function(component, event, helper) {
        var newItem = event.getParam('Item');
        // alert('Event OK!   '+newItem.Name);
        // alert('Event OK!   '+newItem.Price__c);
        // alert('Event OK!   '+newItem.Quantity__c);
        // alert('Event OK!   '+newItem.Packed__c);
        var action = component.get('c.saveItem');
        //var item = component.get('v.newItem');
        action.setParams({
            "item":newItem
        });
        action.setCallback(this,  function(response) {
            var state = response.getState();
            if (state=='SUCCESS') {
                var items = component.get('v.items');
                items.push(response.getReturnValue());
                component.set('v.items', items);
                //component.set('v.newItem', "{'sobjectType':'Camping_Item__c','Name':'','Price__c': 0, 'Quantity__c': 0, 'Packed__c': false}");
                helper.createItem(component, event, helper);
            } else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    }

})