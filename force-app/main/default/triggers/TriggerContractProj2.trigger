trigger TriggerContractProj2 on Contract (after insert) {
    TriggerContractProj2Handler.changeStatusAfterCreated();   
}