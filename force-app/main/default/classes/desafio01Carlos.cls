public class desafio01Carlos {
    public class WrapperConta {
        @AuraEnabled public String recordId;
        @AuraEnabled public String BillingStreet;
        @AuraEnabled public String BillingCity;
        @AuraEnabled public String BillingState;
        @AuraEnabled public String BillingPostalCode;
        @AuraEnabled public String BillingCountry;       
    }
    
	public class WrapperContato{
        @AuraEnabled public String recordId;
        @AuraEnabled public String MailingStreet;    
        @AuraEnabled public String BillingCity;  
        @AuraEnabled public String BillingState;  
        @AuraEnabled public String BillingPostalCode;  
        @AuraEnabled public String BillingCountry;  
    }
    
    @AuraEnabled
    public static void buscarConta(String contaId){
        
        Account conta = [SELECT Id, Name FROM Account Where Id =:contaId];
        List<WrapperConta> listaWrapper = new List<WrapperConta>();
        
            WrapperConta wp = new WrapperConta();
            wp.recordId = conta.Id;
            wp.BillingStreet = conta.BillingStreet;
            wp.BillingCity = conta.BillingCity;
            wp.BillingState = conta.BillingState;
            wp.BillingPostalCode = conta.BillingPostalCode;
            wp.BillingCountry = conta.BillingCountry;
            
            listaWrapper.add(wp);
        	//cadastrarContato();
        //system.debug(JSON.serialize(listaWrapper));
        //return JSON.serialize(listaWrapper);
    }
    
    @AuraEnabled
    public static String buscarContatos(String contaId){
        List<Contact> contatos = [Select Id,MailingAddress FROM Contact Where AccountId =:contaId];
        List<WrapperContato> wrapperList = new List<WrapperContato>();
        for(Contact c :contatos ){
            WrapperConta wp = new WrapperConta();
            //wp.recordId = c.Id;
            //wp.BillingStreet = c.BillingStreet;
            //wp.BillingCity = c.BillingCity;
            //wp.BillingState = c.BillingState;
            //wp.BillingPostalCode = c.BillingPostalCode;
            //wp.BillingCountry = c.BillingCountry;
        }
        return JSON.serialize(wrapperList);
    }
    
    @AuraEnabled
    public static void cadastrarContato(String contato){
        try{
            List<Contact> contas = new List<Contact>();
            List<WrapperContato> contasTela = (List<WrapperContato>) JSON.deserialize(contato, List<WrapperContato>.class);
            String regExp = '[^0-9]';            
            for(WrapperContato c : contasTela){
                Contact ca = new Contact();
                ca.Id= (c.recordId != null && String.isNotBlank(c.recordId))? c.recordId : null;
    //            ca.FirstName = c.FirstName;
                contas.add(ca);
            }
            System.debug(JSON.serialize(contas));
            upsert contas;
        }catch(Exception e){
            throw new AuraHandledException(e.getStackTraceString());
        }
        
    }
}