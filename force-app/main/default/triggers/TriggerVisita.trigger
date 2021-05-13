trigger TriggerVisita on Visita__c (before insert, before update, before delete, 
                                    after insert, after update, after delete) {

	if(Trigger.isBefore){
        TriggerVisitaHandler.processarAntesDeCriarOuAtualizar();
    }
    
    else if(Trigger.isAfter){
        
    }
}