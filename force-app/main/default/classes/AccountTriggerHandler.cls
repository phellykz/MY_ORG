public class AccountTriggerHandler {
	
    public static void UpdateAccount(List<Account> newAccounts){
        List<Account> accountsToUpdade = new List<Account>();
        for (Account accTemp : newAccounts) {
            Boolean cpfValido;
            Boolean cnpjValido;
            if(accTemp.AccountNumber != null && accTemp.AccountNumber.length()>3){                    
                if (accTemp.Type=='CPF') {
                    cpfValido = Util.validarCPF(accTemp.BR_CPF__c);
                }else if (accTemp.Type=='CNPJ'){
                    cnpjValido = Util.validarCNPJ(accTemp.BR_CNPJ__c);
                }
                accountsToUpdade.add(accTemp);
            }else{
                accTemp.addError('Número do cliente é inválido');
            }
            
        }
        GenerateOpportunityOrTasck(accountsToUpdade);
    }

    public static void GenerateOpportunityOrTasck(List<Account> accts){
        Id parceiroRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Pessoa_Fisica').getRecordTypeId();
        Id ConsumidorFinalRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Pessoa_Juridida').getRecordTypeId();
        List<Account> listAccount = new List<Account>();
        List<Task> listTask = new List<Task>();
        List<Opportunity> listOpportunity = new List<Opportunity>();
        for (Account acc : accts) {
            if (acc.RecordTypeId==parceiroRecordTypeId) {
                Opportunity opp = new Opportunity();
                opp.AccountId = acc.Id;
                opp.Name = acc.Name+' – opp Parceiro';
                opp.CloseDate = System.today().addDays(30);
                opp.StageName = 'Qualification';
                listOpportunity.add(opp);
            }else if (acc.RecordTypeId==ConsumidorFinalRecordTypeId) {
                Task task = new task();
                task.Subject = 'Consumidor Final';
                task.WhatId = acc.Id;
                task.Status ='Not Started';
                task.Priority = 'Normal';
                listTask.add(task);
            }
        }
        insert listTask;       
        insert listOpportunity;
    }
}