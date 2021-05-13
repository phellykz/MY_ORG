@isTest 
private class AddPrimaryContactTest {
	@TestSetup
	public static void newRecord(){
	List<Account> listAccounts = new List<Account>();
		for (Integer i = 0; i < 50; i++){
			Account newAccount = new Account();
			newAccount.Name = 'test'+i;
			newAccount.BillingState = 'NY';
			listAccounts.add(newAccount);
		}
		for (Integer i = 0; i < 50; i++){
			Account newAccount = new Account();
			newAccount.Name = 'test'+i;
			newAccount.BillingState = 'CA';
			listAccounts.add(newAccount);
		}
		insert listAccounts;
	}

	@isTest
	private static void testName() {
		System.Test.startTest();
			Contact c = new Contact();
			c.LastName = 'Test';
			AddPrimaryContact pc = new AddPrimaryContact(c, 'NY');
			System.enqueueJob(pc);
		System.Test.stopTest();

	}
}