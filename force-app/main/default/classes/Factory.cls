public with sharing class Factory {
    public Factory() {}
    public static Account gerarAccountPF(){
        Id parceiroRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Pessoa_Fisica').getRecordTypeId();
        Account acc = new Account();
        acc.RecordTypeId = parceiroRecordTypeId;
        acc.Name = 'Teste pessoa Fisica';
        acc.AccountNumber = '123456';
        acc.type = 'CPF';
        acc.BR_CPF__c = '12332112332';
        insert acc;
        return acc;
    } 
    public static Account gerarAccountPJ(){
        Id ConsumidorFinalRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Pessoa_Juridida').getRecordTypeId();
        Account acc = new Account();
        acc.RecordTypeId = ConsumidorFinalRecordTypeId;
        acc.Name = 'Teste pessoa Juridica';
        acc.AccountNumber = '1234567';
        acc.type = 'CNPJ';
        acc.BR_CPF__c = '123321123322112';
        insert acc;
        return acc;
    } 
}