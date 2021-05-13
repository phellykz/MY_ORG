trigger TriggerRequestAction on Action__c ( before insert, before update, after insert, after update) {
	if(Trigger.isBefore){

   	} else if (Trigger.isAfter){
	   	TriggerRequestActionsHandler.atualizarTotalDeAcoesMediaDeTempo();
	    TriggerRequestActionsHandler.atualizarStatus();
	    TriggerRequestActionsHandler.atualizaStatus();

   	}
}