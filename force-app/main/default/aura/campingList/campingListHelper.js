({
    createItem: function(component, event, helper) {
        // component.set('v.newItem', "{'sobjectType':'Camping_Item__c','Name':'','Price__c': 0, 'Quantity__c': 0, 'Packed__c': false}");
        component.set('v.newItem', {});
    }
})