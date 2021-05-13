@isTest
public class TestActionFactory {
    public static Request__c configurarRequest(){
        Request__c request = new Request__c();
        request.Status__c = 'New';
        request.Type__c= 'New Request';
        request.Date__c= System.today();
        request.Description__c='testando';
        request.Priority__c= 'Low';
        return request;
    }
    
    public static Action__c configurarAction(Request__c request) {
        Action__c action = new Action__c();
        action.Status__c = 'Waiting for User';
        action.Request__c= request.Id;
        return action;
    }
}