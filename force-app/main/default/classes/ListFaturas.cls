public with sharing class ListFaturas {
    public class Wrapperfatura {
        @AuraEnabled public String FaturaId;
        @AuraEnabled public String Name;
        @AuraEnabled public String Status;
        @AuraEnabled public decimal Valor;
        @AuraEnabled public date Vencimento;
        @AuraEnabled public date Pagamento;
        
    }
    @AuraEnabled
    public static user getUserApex(){
        User u = [select id,Name,ProfileID,UserType,Username from User where id =: userInfo.getUserId()];
        return u;
    }
    
    @AuraEnabled
    public static String getFaturaInContract(String contracId){     
        List<fatura__c> fatura = [SELECT Id, Name,Status__c,Valor__c,Data_de_Vencimento__c,Data_de_Pagamento__c from fatura__c  where Contrato__c =: contracId ];
        List<Wrapperfatura> listaWrapper = new List<Wrapperfatura>();
        
        for(fatura__c a : fatura){
            Wrapperfatura wp = new Wrapperfatura();
            wp.FaturaId = a.Id;
            wp.Name = a.Name;
            wp.Status = a.Status__c;
            wp.Valor = a.Valor__c;
            wp.Vencimento = a.Data_de_Vencimento__c;
            wp.Pagamento = a.Data_de_Pagamento__c;            
            
            listaWrapper.add(wp);
        }
        system.debug(JSON.serialize(listaWrapper));
        return JSON.serialize(listaWrapper);
    }
    
    @AuraEnabled
    public static void updateStatusInFatura(List<String> listFaturasIds){
        System.debug(listFaturasIds);
        List<Fatura__c> listFaturasToUpdate = [SELECT Id, Status__c FROM Fatura__c WHERE id IN:listFaturasIds ];
        System.debug(listFaturasToUpdate);
        for (Fatura__c fat : listFaturasToUpdate){
            fat.Status__c = 'Paga';
        }
        update listFaturasToUpdate;
    }
    
}