trigger TriggerFaturaProj2 on Fatura__c (before Update, after Update) {
        TriggerFaturaProj2Handler.changePaymentDate();
        TriggerFaturaProj2Handler.calculateInterestValue(); 
}