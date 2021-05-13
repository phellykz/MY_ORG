trigger AccountAddressTrigger on Account (before insert, before update) {
    for (Account conta: Trigger.new){
        if(conta.Match_Billing_Address__c && conta.BillingPostalCode!=null){
            conta.ShippingPostalCode = conta.BillingPostalCode;
        }    
    }
}