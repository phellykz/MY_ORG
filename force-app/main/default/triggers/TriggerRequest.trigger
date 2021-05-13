trigger TriggerRequest on Request__c (before insert, before update, before delete, after insert, after update, after delete) {
    TreiggerRequestHandler.atualizarTotalDeAcoesMediaDeTempo();
}