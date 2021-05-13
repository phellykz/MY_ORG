public class AccountHandler  {
	public static Account insertNewAccount(String name){
		Account newAccount = new Account(Name = name);

		Database.SaveResult result = Database.insert(newAccount, false);
		if (result.isSuccess()){
			return newAccount;
		}else{
			return null;
		}
	}
}