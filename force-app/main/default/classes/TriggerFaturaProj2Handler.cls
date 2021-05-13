public class TriggerFaturaProj2Handler {
    public static void changePaymentDate() {
        if(Trigger.isAfter && Trigger.isUpdate){
            Fatura__c[] listFaturas = (Fatura__c[]) [SELECT id,Status__c FROM Fatura__c Where id in :trigger.newMap.keySet()];
            if(listFaturas!=null && !listFaturas.isEmpty()){
                List<Fatura__c> listFaturasToUpdate = new List<Fatura__c>();
                for(Fatura__c fatura : listFaturas){
                    Fatura__c faturaOld = (Fatura__c) Trigger.oldMap.get(fatura.Id);
                    if(faturaOld.Status__c != 'Paga' && fatura.Status__c== 'Paga'){
                        fatura.Data_de_Pagamento__c = System.today();
                        listFaturasToUpdate.add(fatura);
                    }
                }
                update listFaturasToUpdate;
            }
        }
    }
    
    public static void calculateInterestValue(){
        if(Trigger.isBefore && Trigger.isUpdate){
            Fatura__c[] listFaturas =  Trigger.new;
            System.debug(listFaturas);
            if(listFaturas!=null && !listFaturas.isEmpty()){
                List<Fatura__c> listFat = new List<Fatura__c>();
                for(Fatura__c f : listFaturas){
                    if(f.Data_de_Vencimento__c<f.Data_de_Pagamento__c){
                        f.Valor__c = f.Valor__c + (f.Data_de_Vencimento__c.daysBetween(f.Data_de_Pagamento__c) * 0.02 * f.Valor__c);
                    }
                }
            }
        }
    }
    
}