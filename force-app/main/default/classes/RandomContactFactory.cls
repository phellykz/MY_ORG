public class RandomContactFactory  {
	public static List<Contact> generateRandomContacts(Integer qtd, String Name){
		List<Contact> listContact =  new List<Contact>();
		for(Integer i=0; i<qtd; i++){
			Contact newContact = new Contact();
			newContact.FirstName = 'Test'+i;
			listContact.add(newContact);
		}
		return listContact;
	}
}