public with sharing class CampingListController {
    @AuraEnabled
    public static List<Camping_Item__c> getItems(){
        List<Camping_Item__c> itens = [SELECT Id, Price__c, Quantity__c, Packed__c FROM Camping_Item__c];
        return itens;
    }

    @AuraEnabled
    public static Camping_Item__c saveItem(Camping_Item__c item){
        insert item;
        return item;
    }
}