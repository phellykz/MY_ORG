({
	doInit : function(component, event, helper) {
		helper.iniciarForm(component);
	},
    insertConfig : function(component, event, helper) {
        console.log("estou na função do controller");
		var form = component.get('v.form');        
        helper.salvarConfig(component, form);
        helper.iniciarForm(component);
	}
})