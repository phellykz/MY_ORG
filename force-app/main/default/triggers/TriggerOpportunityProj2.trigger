trigger TriggerOpportunityProj2 on Opportunity (after update) {
    
    TriggerOpportunityProj2Handler.insertContract();
    
    TriggerOpportunityProj2Handler.updateInAddress();
    
}