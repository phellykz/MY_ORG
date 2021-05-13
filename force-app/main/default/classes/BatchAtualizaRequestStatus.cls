global class BatchAtualizaRequestStatus implements Database.Batchable<sObject>, Database.Stateful, Schedulable {
	
	String query;
	Integer cont =0;
	
    private static Messaging.SingleEmailMessage configurarEmail(String emailResponsavel, String assunto, String conteudo) {
	        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
	        message.toAddresses = new String[] {emailResponsavel};
	        message.subject = assunto;
	        message.plainTextBody = conteudo;
	        return message;
    }    
    
	global Database.QueryLocator start(Database.BatchableContext BC) {		
		query = 'SELECT Id, Name, TECH_Waiting_Date_Max__c FROM Request__c WHERE Status__c= \'Waiting for User\' ';
        System.debug(query);
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
   		Request__c[] requestList = (Request__c[]) scope;
        for (Request__c temp : requestList){
   			System.debug(temp.TECH_Waiting_Date_Max__c < System.today());
   			if(temp.TECH_Waiting_Date_Max__c < System.today() ){
   				temp.Status__c = 'Canceled';
   				cont++;
   				
   			}
   		}

   		update requestList;
	
	}
	
	global void finish(Database.BatchableContext BC) {
		String msg ='Ateração no Status de ' + cont + ' Request';

		String assunto = 'Execução de Rotina de Atualização de Status de Request ' + UserInfo.getName() + ' em ' + System.now().format();

		Messaging.SingleEmailMessage email = configurarEmail(UserInfo.getUserEmail(), assunto, msg);

		try {
        	Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    	}
    	catch (Exception e) {
    		System.debug(e.getMessage());
    	}

    	FeedItem novoFeedItem = new FeedItem(ParentId = UserInfo.getUserId(), CreatedById = UserInfo.getUserId());
		novoFeedItem.Body = assunto + '\n' + msg;

		try {
			insert novoFeedItem;
		}
		catch (Exception e) {
    		System.debug(e.getMessage());
    	}
    }

    global void execute(SchedulableContext sc) {
    	 BatchAtualizaRequestStatus b = new BatchAtualizaRequestStatus();
	     Database.executeBatch(b, 5);
    }
    
    public static void scheduleMe() {
		String CRON_EXP = '0 0 23 * * ?';
		System.schedule('Processar Tarefas Vencidas Job', CRON_EXP, new BatchAdiarOportunidade());
	} 
}