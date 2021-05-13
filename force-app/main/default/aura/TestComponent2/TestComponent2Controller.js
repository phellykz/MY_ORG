({
    handleApplicationEvent : function(component, event, helper) {
        var message = event.getParam("message");

        component.set('v.objetoSegundoComponent.Name', message);
    }
})