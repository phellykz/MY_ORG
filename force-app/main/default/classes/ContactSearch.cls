public class ContactSearch  {
	public static List<Contact> searchForContacts(String lastName, String postalCode){
		List<Contact> listContacts = (List<Contact>) [select Id, Name from contact where LastName =: lastName and MailingPostalCode =: postalCode];
		return listContacts;
	}
}