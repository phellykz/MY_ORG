public class AddPrimaryContact implements Queueable {

	private Contact cont;
	private String txt;
	public AddPrimaryContact(Contact c, String text){
		this.cont = c;
		this.txt = text;
	}

	public void execute(QueueableContext context){
		List<Account> listAccount = [SELECT  Id, (SELECT Id FROM Contacts) FROM Account WHERE Account.BillingState =:this.txt LIMIT 200];
		Contact contactClone = this.cont.clone();

		for (Account a : listAccount){
			a.Contacts.add(contactClone);
		}
	}

}