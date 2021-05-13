public with sharing class AccountController {
    public static List<Account> getAllActiveAccounts() {
        String termo = 'Yes';
        return [SELECT Id,Name,Active__c FROM Account WHERE Active__c = 'Yes'];
        //teste
    }
}
