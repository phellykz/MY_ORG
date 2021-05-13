public class TriggerContractProj2Handler {
    
    public static void changeStatusAfterCreated(){
        if(Trigger.isAfter && Trigger.isInsert){
            System.debug('estou no methodo changeStatusAfterCreated');
            Contract[] listContracts = (Contract[]) [SELECT id, Gerado_automaticamente__c, Status FROM Contract Where id in :trigger.newMap.keySet()];
            System.debug(listContracts);
            if(listContracts!=null && !listContracts.isEmpty()){
                System.debug(listContracts);
                List<Contract> listContractsToSave = new List<Contract>();
                System.debug(listContractsToSave);
                for(Contract cont : listContracts){
                    if(cont.Gerado_automaticamente__c && cont.Status !='Activated'){                        
                        cont.Status = 'Activated';
                        listContractsToSave.add(cont);
                    }                    
                }
                update listContractsToSave;
            }            
        }
    }
    
}