@isTest 
private class TestRestrictContactByName {

	@isTest
	private static void testName() {
		Contact newContact = new Contact();
		newContact.LastName = 'INVALIDNAME';

		insert newContact;
	}
}