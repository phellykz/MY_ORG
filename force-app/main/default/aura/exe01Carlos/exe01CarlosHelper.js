({
    buscarDados : function(component){
        var action = component.get('c.buscarContas');
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
               
                component.set('v.listCadastro',JSON.parse(response.getReturnValue()));
                
            }
            
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                    errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });        
        $A.enqueueAction(action);
    },
    buscarContatos : function(component){
        var action = component.get('c.buscarContatos');
        action.setParams({'contaId': component.get('v.contaSelecionada')});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
               
                component.set('v.listContatos',JSON.parse(response.getReturnValue()));
                component.set('v.showModal',true);
                
            }
            
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                    errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },
    salvarConta: function(component,listaContas) {
        var action = component.get('c.cadastrarConta');        
        action.setParams({conta: JSON.stringify(listaContas)});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {      
                
                
                this.iniciarFormulario(component);
                this.buscarDados(component);
            }
            
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                    errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },
     salvarContato: function(component,listaCotatos) {
        var action = component.get('c.cadastrarContato');        
        action.setParams({contato: JSON.stringify(listaCotatos)});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {                      
                
                this.fecharContato(component);
                
            }
            
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                    errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },
    fecharContato: function(component){
        component.set('v.showModal',false);
        component.set('v.listContatos',[]);
    },
    iniciarFormulario : function(component) {
        var form = {
            'recordId':'',            
            'Name':'',
            'Phone':'',
            'tipo_de_registro':'',
            'devName':'',
            'CNPJ':''
        }
        component.set('v.form',form);
        
        
    }
})