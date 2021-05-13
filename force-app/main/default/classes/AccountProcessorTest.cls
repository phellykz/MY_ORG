@isTest 
public class AccountProcessorTest {
	@testSetup
	public static void newRecord(){
		Account testAccount = new Account();
		testAccount.Name = 'Test account';
		insert testAccount;

		Contact testContact = new Contact();
		testContact.LastName = 'Felix';
        testcontact.AccountId = testAccount.Id;
		insert testContact;
	}

	@isTest
	public static void testName(){
		List<Account> listAccounts = [SELECT Id FROM Account];
		List<Id> listIds = new List<Id>();
		for (Account c : listAccounts){
			listIds.add(c.Id);
		}

		System.Test.startTest();
			AccountProcessor.countContacts(listIds);
		System.Test.stopTest();
	}
}