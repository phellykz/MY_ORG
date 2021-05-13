({
	doInit : function(component, event, helper) {
        var form = {
            'nome': '',
            'sobrenome':''
        }
        component.set('v.form', form);
	},
    
    insertName : function(component, event, helper) {
     	var form = component.get('v.form');
        var arr = component.get('v.listaNomes');
        arr.push(form);
        component.set('v.listaNomes', arr);
        
        var form = {
            'nome': '',
            'sobrenome':''
        }
        component.set('v.form', form);
    }
})