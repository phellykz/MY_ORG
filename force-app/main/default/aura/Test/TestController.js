({
	doInit : function(component, event, helper) {
		var arr = [];
        for(var i=0; i<10;i++){
            arr.push('sensualizador '+i);
        }
        component.set('v.listaNome', arr);
    },
    
    execEventCMP : function(component, event, helper) {
		alert('Component event executado com sucesso!');
    },
    
    execEventAPP : function(component, event, helper) {
        alert('Aplication event executado com sucesso!');		
	},
    
})