global class DailyLeadProcessor implements Schedulable {
	
	global void execute(SchedulableContext sc) {
		List<Lead> listLead = [select Id, LeadSource from Lead WHERE LeadSource = null LIMIT 200];
		for (Lead l : listLead){
			l.LeadSource = 'Dreamforce';
		}
		update listLead;
	}
}