public class ContactAndLeadSearch  {
	public static List<List<SObject>> searchContactsAndLeads(String buscar){
		List<List<SObject>> result = [FIND :buscar IN Name FIELDS RETURNING Contact(FirstName), Lead(Name)];
		return result;
	}
}