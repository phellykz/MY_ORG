({
    doInit : function(component,event,helper){
        helper.iniciarFormulario(component);
        helper.buscarDados(component);
    },
    
    insertRecord: function(component,event,helper){
        var form = component.get('v.form');
        
        var lista = component.get('v.listCadastro');
        
        lista.push(form);
        helper.salvarConta(component,lista);
        //helper.iniciarFormulario(component);
    },    
    changeCPF: function(component,event) {
        var cmp = event.getSource();
        var recordId = cmp.get('v.name');
        var listaContatos = component.get('v.listContatos');
        
        for(var i in listaContatos){
            if(listaContatos[i].recordId = recordId){
                var value = listaContatos[i].CPF;
                value = value.replace(/[^0-9]+/g, '');
                if (value.length > 11)
                    value = value.substring(0, 11);
                
                var newValue = '';
                
                var valido = true;
                
                if (value.length > 0) {
                    newValue = value.substring(0, ((value.length > 3) ? 3 : value.length));
                    
                    if (value.length > 3)
                        newValue += '.' + value.substring(3, ((value.length > 6) ? 6 : value.length));
                    
                    if (value.length > 6)
                        newValue += '.' + value.substring(6, ((value.length > 9) ? 9 : value.length));
                    
                    if (value.length > 9)
                        newValue += '-' + value.substring(9, ((value.length > 11) ? 11 : value.length));
                    
                }
                
                listaContatos[i].CPF = newValue;
            }   
        }
        
        component.set('v.listContatos', listaContatos);
        
    },
    changeCNPJ: function(component) {
        var value = component.get('v.form.CNPJ');
        value = value.replace(/[^0-9]+/g, '');
        if (value.length > 14)
            value = value.substring(0, 14);
        
        var newValue = '';
        
        var valido = true;
        
        if (value.length > 0) {
            newValue = value.substring(0, ((value.length > 2) ? 2 : value.length));
            
            if (value.length > 2)
                newValue += '.' + value.substring(2, ((value.length > 5) ? 5 : value.length));
            
            if (value.length > 5)
                newValue += '.' + value.substring(5, ((value.length > 8) ? 8 : value.length));
            
            if (value.length > 8)
                newValue += '/' + value.substring(8, ((value.length > 12) ? 12 : value.length));
            
            if (value.length > 12)
                newValue += '-' + value.substring(12, ((value.length > 14) ? 14 : value.length));
            
        }
        
        component.set('v.form.CNPJ', newValue);
        
    },
    visulizarContato: function(component,event,helper){
        var recordId = event.currentTarget.dataset.index;
        component.set('v.contaSelecionada',recordId);
        helper.buscarContatos(component);
        
    },
    fecharContato: function(component,event,helper){
        helper.fecharContato(component);
    },
    
    addContato: function(component,event,helper){
        var contato = {
            'recordId' : '',
            'FirstName' : '',
            'LastName' : '',
            'CPF': '',
            'email':'',
            'contaId': component.get('v.contaSelecionada')
        }
        
        var listaContato = component.get('v.listContatos');
        listaContato.push(contato);
        component.set('v.listContatos',listaContato);
    },
    saveContact: function(component,event,helper){
        var listaContatos = component.get('v.listContatos');
        helper.salvarContato(component,listaContatos);
    }
})