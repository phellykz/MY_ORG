@isTest 
private class AccountTriggerTest {

	@TestSetup
	static void gerarDados(){
		Factory.gerarAccountPF();
		Factory.gerarAccountPJ();
	}
	private static testmethod void test01() {
		Account acc = [SELECT Id, Name, AccountNumber FROM Account WHERE Name = 'Teste pessoa Fisica'];
		System.assertEquals(acc.AccountNumber, '123456');
		acc.AccountNumber = '12345';
		System.Test.startTest();
			update acc;
		System.Test.stopTest();
	}
	private static testmethod void test02() {
		Account acc = [SELECT Id, Name, AccountNumber FROM Account WHERE Name = 'Teste pessoa Fisica'];
		System.assertEquals(acc.AccountNumber, '123456');
		acc.AccountNumber = '123';
		System.Test.startTest();
			update acc;
		System.Test.stopTest();
	}
	private static testmethod void test03() {
		Account acc = [SELECT Id, Name, AccountNumber FROM Account WHERE Name = 'Teste pessoa Juridica'];
		System.assertEquals(acc.AccountNumber, '1234567');
		acc.AccountNumber = '123456';
		System.Test.startTest();
			update acc;
		System.Test.stopTest();
	}
}