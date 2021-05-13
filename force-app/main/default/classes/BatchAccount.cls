global class BatchAccount implements Database.Batchable<sObject>, Database.Stateful, Schedulable{
    String query;
    Integer cont =0;
    global Database.QueryLocator start(Database.BatchableContext BC) {
        query = 'SELECT Id,Name, Inativa__c FROM Account';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        Datetime limitTask = system.today()-90;
        Datetime limitOpp = system.today()-120;
        Set<Id> idsContas = new Set<Id>();
        List<Account> listAccount = (List<Account>) scope;
        List<Account> listAccountToUpdate = new List<Account>();
        Map<Id, Account> mapAccounts = new Map<Id, Account>();
        List<Opportunity> listOpps = [SELECT Id, name, AccountId, StageName, CreatedDate FROM Opportunity WHERE (StageName ='Closed Won' and CreatedDate<= :limitOpp) or StageName ='Negotiation/Review'];
        List<Task> listTasks = [SELECT Id, AccountId, CreatedDate FROM task WHERE CreatedDate<= :limitTask];
        for (Opportunity oppTemp : listOpps) {
            idsContas.add(oppTemp.AccountId);
        }
        for (Task taskTemp : listTasks) {
            idsContas.add(taskTemp.AccountId);
        }
        for (Account accTemp : listAccount) {
            mapAccounts.put(accTemp.Id, accTemp);
        }
        for (Id idAccTemp : idsContas) {
            Account acc = mapAccounts.get(idAccTemp);
            if (acc!=null) {
                acc.Inativa__c = true;
                listAccountToUpdate.add(acc);
                cont++;
            }
        }
        update listAccountToUpdate;
    }

    global void finish(Database.BatchableContext BC) {
        String msg ='Total de contas inativadas' + cont ;

		String assunto = 'Execução de Rotina de desativar contas de acordo com os parametro data e stageName ' + UserInfo.getName() + ' em ' + System.now().format();

		Messaging.SingleEmailMessage email = configurarEmail(UserInfo.getUserEmail(), assunto, msg);

		try {
        	Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    	}
    	catch (Exception e) {
    		System.debug(e.getMessage());
    	}
    }

    global void execute(SchedulableContext sc) {
        System.schedule('Processar contas por createdDate e stageName', '0 0 0 * * NOM-FRI', new BatchAccount());
        System.schedule('Processar contas por createdDate e stageName', '0 0 6 * * NOM-FRI', new BatchAccount());
        System.schedule('Processar contas por createdDate e stageName', '0 0 12 * * NOM-FRI', new BatchAccount());
        System.schedule('Processar contas por createdDate e stageName', '0 0 18 * * NOM-FRI', new BatchAccount());
    }
    
    private static Messaging.SingleEmailMessage configurarEmail(String emailResponsavel, String assunto, String conteudo) {
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] {emailResponsavel};
        message.subject = assunto;
        message.plainTextBody = conteudo;
        return message;
}
}