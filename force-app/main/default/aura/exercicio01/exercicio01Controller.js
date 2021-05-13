({
    doInit : function(component, event, helper) {
        //Razão Social, CNPJ, Data de Abertura da Empresa e Número de telefone
        var formPF = {
            'nome': '',
            'cpf':'',
            'nascimento': '',
            'email': ''
        }
        var formPJ = {
            'razaoSocial': '',
            'cnpj': '',
            'abertura': '',
            'telefone': ''
        }
        component.set('v.formPF', formPF);
        component.set('v.formPJ', formPJ);
    },
    
    onGroup: function(cmp, evt) {
        var selected = evt.getSource().get("v.label");
        resultCmp = cmp.find("radioGroupResult");
        resultCmp.set("v.value", selected);
    },
    
    cadastrarPF: function(component, event, helper) {
        alert("cadastrarPF");
        var formPF = component.get('v.formPF');
        var arr = component.get('v.listaPessoasFisicas');
        arr.push(form);
        component.set('v.listaPessoasFisicas', arr);
		console.log(formPF);
        var formPF = {
            'nome': '',
            'Nascimento': '',
            'cpf':'',
            'email': ''
        }
        component.set('v.formPF', formPF);
        
        },
    
    cadastrarPJ: function(component, event, helper) {
        alert("cadastrarPJ");
        var formPJ = component.get('v.formPJ');
        var arr = component.get('v.listaPessoasJuridicas');
        arr.push(formPJ);
        component.set('v.listaPessoasJuridicas', arr);
        console.log(formPJ);
        console.log(arr);
        var formPJ = {
            'razaoSocial': '',
            'cnpj': '',
            'abertura': '',
            'telefone': ''
        }
        component.set('v.formPJ', formPJ);
        
        }
})