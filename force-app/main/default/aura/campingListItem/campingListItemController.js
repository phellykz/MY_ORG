({
    doInit : function(component, event, helper) {
        component.set('v.disabled', true);
        var item = component.get('v.item');
        if (item!=null) {
            component.set(item.Packed__c,true);            
        }
    }
})