global class BatchUpdateStatus implements Database.Batchable<sObject>, Database.Stateful, Schedulable{
    
    String Query;
    integer contador = 0;
	integer qtdErros = 0;
    
    global BatchUpdateStatus(){}
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        query = 'select Id, Status__c, Data_de_Vencimento__c from Fatura__c';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Object> scope){
        Fatura__c[] ListFaturas = (Fatura__c[]) scope;
        Fatura__c[] ListFaturasToSave = new Fatura__c[]{};
            for(Fatura__c f : ListFaturas){
                if(f.Status__c!='Paga' && f.Data_de_Vencimento__c<System.today()){
                    f.Status__c='Atrasada';
                    contador++;
                    ListFaturasToSave.add(f);
                }
            }
        update ListFaturasToSave;
    }
    
    global void finish(Database.BatchableContext BC){
        String assunto = 'Execução de Rotina de Adiamento de Oportunidades Elegíveis';
        String mensagem;
        
        If (contador == 0){
            mensagem = 'Rotina foi executada por' + Userinfo.getName() + ', em ' + System.now() +', não existem faturas atrasadas';
        }
        else {
            mensagem = 'Rotina foi executada por' + Userinfo.getName() + ', em ' + System.now() +', existem '+contador+' faturas atrasadas';
        }

        Messaging.SingleEmailMessage email = enviarEmail(UserInfo.getUserEmail(), assunto, mensagem);
        
        try{
            Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
        }
        catch(Exception ex){
            System.debug(ex.getMessage());
        }
        
        FeedItem novoFeed = new FeedItem (ParentId = UserInfo.getUserId(), CreatedById = UserInfo.getUserId());
        novoFeed.Body = assunto + '\n' + mensagem;
        try{
            insert novoFeed;
        }
        catch(Exception ex){
            System.debug(ex.getMessage());
        }
    }
    
    global void execute(SchedulableContext sc) {
		String TEMPO = '0 0 00 * *';
        System.schedule('Processar Adiar Oportunidades Job', TEMPO, new BatchUpdateStatus());
	}
    
    private static Messaging.SingleEmailMessage enviarEmail (String enviarPara, String assunto, String conteudo){
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toaddresses = new String[]{enviarPara};
        message.subject = assunto;
        message.plaintextbody = conteudo;
        
        return message;
    }
}