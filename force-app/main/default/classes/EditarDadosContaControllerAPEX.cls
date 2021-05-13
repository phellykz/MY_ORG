public with sharing class EditarDadosContaControllerAPEX {
    public EditarDadosContaControllerAPEX() { }
    @AuraEnabled
    public static List<String> BuscarValoresTipoConta(){
        try {
            List<String> valoresTipo= new List<String>();
            Schema.DescribeFieldResult resultado = Account.Type.getDescribe();
            List<Schema.PicklistEntry> ValoresPickList = resultado.getPicklistValues();
            for( Schema.PicklistEntry ValorTemp : ValoresPickList){
                valoresTipo.add(ValorTemp.getLabel());
            }     
            return valoresTipo;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Account getAccount(String record_Id){
        Contact con = [SELECT Id, AccountId, Account.Name, Account.AccountNumber, Account.Type FROM contact WHERE Id=:record_Id];
        Account acc = [SELECT Id, Name, AccountNumber, Type FROM Account WHERE Id=:con.AccountId];        
        return acc;
    }

    /*@AuraEnabled
    public static void AtualizarContaAPEX(String cont){
        System.debug('Estou no try');
        try {
            AccoutModel conta = (AccoutModel)JSON.deserialize(cont, AccoutModel.class);

        } catch (Exception e) {
            throw new AuraHandledException('ERRO de execução'+e.getMessage());
        }
    }*/

    public class AccoutModel {
        public String Name {get;set;}
        public String AccountNumber {get;set;}
        public String Type {get;set;}
    }
}