public class exe01Carlos {
	public class WrapperConta {
        @AuraEnabled public String recordId;
        @AuraEnabled public String Name;
        @AuraEnabled public String Phone;
        @AuraEnabled public String tipo_de_registro;
        @AuraEnabled public String devName;
        @AuraEnabled public String CNPJ;
        
    }
    
    public class WrapperContato{
        @AuraEnabled public String recordId;
        @AuraEnabled public String FirstName;
        @AuraEnabled public String LastName;
        @AuraEnabled public String Email;       
        @AuraEnabled public String CPF;
        @AuraEnabled public String contaId;
    }
    
    @AuraEnabled
    public static String buscarContas(){
        
        List<Account> contas = [SELECT Id, Name, Phone, RecordTypeId,RecordType.DeveloperName, BR_CNPJ__c FROM Account
                                Where RecordType.DeveloperName IN ('Pessoa_Fisica','Pessoa_Juridica')];
        List<WrapperConta> listaWrapper = new List<WrapperConta>();
        
        for(Account a : contas){
            WrapperConta wp = new WrapperConta();
            wp.recordId = a.Id;
            wp.Name = a.Name;
            wp.Phone = a.Phone;
            wp.tipo_de_registro = a.RecordTypeId;
            wp.devName = a.RecordType.DeveloperName;
            wp.CNPJ = a.BR_CNPJ__c;
            
            listaWrapper.add(wp);
        }
        system.debug(JSON.serialize(listaWrapper));
        return JSON.serialize(listaWrapper);
    }
    @AuraEnabled
    public static void cadastrarConta(String conta){
        try{
            List<Account> contas = new List<Account>();
            List<WrapperConta> contasTela = (List<WrapperConta>) JSON.deserialize(conta, List<WrapperConta>.class);
            String regExp = '[^0-9]';
            Id  recordTypeId = [Select Id FROM RecordType WHERE SobjectType  = 'Account' AND DeveloperName = 'Pessoa_Juridica' LIMIT 1].Id;
            for(WrapperConta c : contasTela){
                Account ca = new Account();
                ca.Id= (c.recordId != null && String.isNotBlank(c.recordId))? c.recordId : null;
                ca.Name = c.Name;
                ca.Phone = c.Phone;
                ca.BR_CNPJ__c = c.CNPJ.replaceAll(regExp, '');
                ca.RecordTypeId =  recordTypeId;
                contas.add(ca);
            }
            System.debug(JSON.serialize(contas));
            upsert contas;
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
        
    }
    
    @AuraEnabled
    public static String buscarContatos(String contaId){
        List<Contact> contatos = [Select Id,FirstName,LastName,Email,BR_CPF__c FROM Contact Where AccountId =:contaId];
        List<WrapperContato> wrapperList = new List<WrapperContato>();
        for(Contact c :contatos ){
            WrapperContato wp = new WrapperContato();
            wp.recordId = c.Id;
            wp.FirstName = c.FirstName;
            wp.LastName = c.LastName;
            wp.Email = c.Email;
            wp.CPF = c.BR_CPF__c;
            wrapperList.add(wp);
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
                ca.FirstName = c.FirstName;  
                ca.LastName = c.LastName;
                ca.BR_CPF__c = c.CPF.replaceAll(regExp, '');
                ca.Email = c.Email;
                ca.AccountId = c.contaId;
                contas.add(ca);
            }
            System.debug(JSON.serialize(contas));
            upsert contas;
        }catch(Exception e){
            throw new AuraHandledException(e.getStackTraceString());
        }
        
    }
}