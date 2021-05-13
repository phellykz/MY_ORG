public with sharing class ControllerTest {
    @AuraEnabled
    public static void sendAccont(String obj){
        Account acc = (Account) JSON.deserialize(obj, Account.class);
        
        insert acc;
    }
}