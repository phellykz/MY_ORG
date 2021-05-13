({
    createItem : function(component, event, helper, newItem) {
        var validForm =  component.find('form').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        if (validForm) {
            var addItemEvent = component.getEvent('addItem');
            addItemEvent.setParams({"Item": newItem});
            addItemEvent.fire();
            component.set('v.newItem', "{'sobjectType':'Camping_Item__c','Name':'','Price__c': 0, 'Quantity__c': 0, 'Packed__c': false}");
        }
    }
})