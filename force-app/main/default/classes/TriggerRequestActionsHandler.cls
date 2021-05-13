public with sharing class TriggerRequestActionsHandler {
    public static void atualizarTotalDeAcoesMediaDeTempo(){        
        Action__c[] acao = (Action__c[]) Trigger.new;
        Set<Id> idPedidos = new Set<Id>();
        system.debug(idPedidos);
        for(Action__c act : acao){
            idPedidos.Add(act.Request__c);    
        }
        
        List<Request__c> AcoesPorPedido = new List<Request__c>();
        AcoesPorPedido = [SELECT Id, Date__c,(SELECT Id, Date__c FROM Actions__r ) FROM Request__c WHERE Id IN :idPedidos];
        
        for(Request__c r : AcoesPorPedido){
            if(Trigger.isExecuting && Trigger.isAfter && Trigger.isInsert){
                r.Total_of_Actions__c = r.Actions__r.size();
                
                Integer total = 0;
                for(Action__c ra : r.Actions__r){
                    total += ra.Date__c.daysBetween(r.Date__c);
                }
                r.Time_average_per_Action__c = total/r.Actions__r.size();
            }
        }
        update AcoesPorPedido;
    }
    public static void atualizarStatus(){
        Action__c[] acao = (Action__c[]) Trigger.new;
        Set<Id> idPedidos = new Set<Id>();
        for(Action__c act : acao){
            idPedidos.Add(act.Request__c);    
        }
        List<Request__c> listaPedidos =  [select Id, (SELECT Id, Status__c, CreatedDate FROM Actions__r order by CreatedDate desc limit 1) from  Request__c WHERE Id IN :idPedidos];
        for(Request__c pedido : listaPedidos){
            if(Trigger.isExecuting  && (Trigger.isInsert || Trigger.isUpdate)){
                pedido.Status__c = pedido.Actions__r[0].Status__c;
            }
        } 
        update listaPedidos;
    }
    
    public static void atualizaStatus(){
        if( Trigger.isInsert || Trigger.isUpdate){
            Set<Request__c> listaRequest = new Set<Request__c>();
            Action__c[] action = [SELECT Id, Status__c, Request__c FROM Action__c];
            Request__c[] req = [SELECT Id, Status__c,TECH_Waiting_Date_Max__c FROM Request__c];
            for(Action__c temp : action){
                for( Request__c reqTemp : req){
                    if(reqTemp.Id == temp.Request__c){
                        reqTemp.Status__c= temp.Status__c;
                        if(temp.Status__c == 'Waiting for User'){
                            reqTemp.TECH_Waiting_Date_Max__c= System.today();
                            listaRequest.add(reqTemp);
                        }
                    }                
                }
            }
            List<Request__c> listR = new List<Request__c>(listaRequest);
            
            update listR;
        }
    }
}