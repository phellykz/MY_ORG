({
	doInit : function(component, event, helper) {
		console.log("OK!");
        helper.buscarDados(component);
        
        var lista = component.get('v.listContatos');
	}
})