global class LeadProcessor implements Database.Batchable<SObject> {
	
	global LeadProcessor() {
		
	}

	global Database.QueryLocator start(Database.BatchableContext context) {
		return Database.getQueryLocator('SELECT Id, Name FROM Lead');
	}

   	global void execute(Database.BatchableContext context, List<Lead> scope) {
		List<Lead> listLeads = (List<Lead>) scope;
		for (Lead l : listLeads){
			l.LeadSource = 'Dreamforce';
		}
		update listLeads;
	}
	 
	global void finish(Database.BatchableContext context) {
		
	}
}