public class conta {
	
    public void updateConta(Id accountId){
        Account conta = [SELECT Id, Name FROM Account WHERE Id =: accountId];
        conta.Name = 'Test Novo';
        update conta;
    }
}