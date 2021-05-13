public class AccountProcessor  {
	@Future
	public static void countContacts(List<Id> ids){
		List<Account> listaContas  = [SELECT Id,Number_of_Contacts__c, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :Ids];
		Map <String, List<Contact>> contatoslist = new Map<String, List<Contact>>();
		for(Account contat : listaContas){
			contatoslist.put(contat.Id, contat.Contacts);

		}
		for(Account temp : listaContas){
		
			temp.Number_of_Contacts__c = contatoslist.get(temp.Id).size();
		}
		update listaContas;
	}
}