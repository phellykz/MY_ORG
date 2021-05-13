trigger ClosedOpportunityTrigger on Opportunity (before insert, before update){
	List<Task> listTask = new List<Task>();
	For(Opportunity opp : Trigger.New){
		if(opp.StageName=='Closed Won'){
			Task newTask = new Task();
			newTask.Subject = 'Follow Up Test Task';
			newTask.WhatId = opp.Id;
			listTask.add(newTask);
		}
	}
	insert listTask;
}