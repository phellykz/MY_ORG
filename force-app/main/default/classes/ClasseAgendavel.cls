global class ClasseAgendavel implements Database.Batchable<SObject>, Database.Stateful {

	String query;
	Boolean remover = false;

	global ClasseAgendavel(){}

	global ClasseAgendavel(Boolean remover){
		this.remover = remover;
	}
// start faz uma consulta na base
	global Database.QueryLocator  start(Database.BatchableContext db) {
		query = 'SELECT Id FROM Task WHERE ActivityDate < TODAY AND IsClosed = False AND TarefaVencida__c=false';
		return Database.getQueryLocator(query);
	}
// 
	global void execute(Database.BatchableContext db, List<Task> ListaTask) {
		for (Task tarefa : listaTask) {
		   if (!remover) {
			  tarefa.TarefaVencida__c = true;
		   }
		}

		Integer cont;
		if (remover) {
		   Database.DeleteResult[] listaDelecao = Database.delete(listaTask, false);
		   for (Database.DeleteResult dr : listaDelecao) {
			   if (!dr.isSuccess()) {
				  Id idTarefa = listaDelecao[cont].Id;
				  
			   }
		   }
		}
	}

	global void finish(Database.BatchableContext db) {
		
	}
}