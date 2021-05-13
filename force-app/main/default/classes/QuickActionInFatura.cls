public class QuickActionInFatura {
    
    @AuraEnabled
    public static void updateStatus(String fatId){ 
        System.debug('estou no apex!');
        fatura__c fatura = [SELECT Id,Status__c from fatura__c Where Id =:fatId];
    	fatura.Status__c = 'Paga';
        update fatura;
    }
}