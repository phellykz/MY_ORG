public class TriggerOpportunityProj2Handler {
    public static void insertContract(){
        if(Trigger.isAfter && Trigger.isUpdate){
            Opportunity[] listOpportunities=  Trigger.new;
            if(listOpportunities!=null && !listOpportunities.isEmpty()){
                List<Contract> contractTosave = new List<Contract>();                
                for(Opportunity opportunity : listOpportunities){
                    Opportunity opportunityOld = (Opportunity) Trigger.oldMap.get(opportunity.Id);
                    if((opportunityOld.StageName != 'Closed Won') &&  (opportunity.StageName == 'Closed Won') && (opportunity.Modalidade__c =='Contrato de Serviço') ){
                        Contract newContract = new Contract();
                        newContract.AccountId = opportunity.AccountId;
                        newContract.Oportunidade__c = opportunity.Id;
                        newContract.Gerado_automaticamente__c = True;
                        newContract.StartDate = System.today();
                        if(opportunity.Periodo_de_Servico__c == '3 meses'){
                            newContract.ContractTerm = 3;
                        } else if(opportunity.Periodo_de_Servico__c == '6 meses'){
                            newContract.ContractTerm = 6 ;
                        } else if (opportunity.Periodo_de_Servico__c == '1 ano'){
                            newContract.ContractTerm = 12;
                        } else if(opportunity.Periodo_de_Servico__c == '1 ano e 6 meses'){
                            newContract.ContractTerm = 18;
                        } else if(opportunity.Periodo_de_Servico__c == '2 ano'){
                            newContract.ContractTerm = 24;
                        }
                        contractTosave.add(newContract);
                    }
                }
                insert contractTosave;
                
                Opportunity[] opportunities =  (Opportunity[])[SELECT id, ContractId FROM Opportunity Where id in :trigger.newMap.keySet()];
                if(opportunities!=null && !opportunities.isEmpty()){
                    List<Opportunity> opportunitiesToSave = new List<Opportunity>();
                    
                    for (Opportunity opp : opportunities){
                        for( Contract contract : contractTosave){
                            if(contract.Oportunidade__c == opp.Id){
                                opp.ContractId = contract.Id;
                                opportunitiesToSave.add(opp);
                            }
                        }
                    }
                    update opportunitiesToSave;
                }
            }
        }
    }
    
    public static void updateInAddress(){
        if(Trigger.isAfter && Trigger.isUpdate){
            Opportunity[] oportunities = (Opportunity[])[SELECT id, AccountId, ContractId FROM Opportunity Where id in :trigger.newMap.keySet()];
            if(oportunities!=null && !oportunities.isEmpty()){
                Account[]  accounts = (Account[])[SELECT Id, BillingCountry, BillingState, BillingPostalCode, BillingStreet, BillingCity FROM Account];
                if(accounts!=null && !accounts.isEmpty()){
                    Contract[] contracts = (Contract[]) [SELECT Id, BillingAddress, Oportunidade__c FROM Contract];
                    if(contracts!=null && !contracts.isEmpty()){
                        List<Contract> contractsToSave = new List<Contract>();
                        
                        for(Opportunity opportunity : oportunities){
                            for(Account account : accounts){
                                if(opportunity.AccountId == account.Id){
                                    for(Contract contract : contracts){
                                        if(opportunity.ContractId == contract.Id ){
                                            
                                            contract.BillingCountry = account.BillingCountry;
                                            contract.BillingState = account.BillingState;
                                            contract.BillingPostalCode= account.BillingPostalCode;
                                            contract.BillingStreet= account.BillingStreet;
                                            contract.BillingCity = account.BillingCity;
                                            
                                            contractsToSave.add(contract);
                                        }
                                    }
                                }
                            }
                        }
                        update contractsToSave;
                    }
                }
            }
        }
    }
}