public class Test {	
	public class Test02{
		public void nomemetodo() {
			List<Account> contas = [SELECT Id, (SELECT Id,AccountId FROM Opportunities), 
								(SELECT Id FROM Visitas__r) FROM Account LIMIT 100];
			for(Account a: contas){
				System.debug(a);
			}
			System.debug(':: consegui!');
		}
	}

	public static void setMock(System.Type t, System.StaticResourceCalloutMock mock){
	
	} 

	public static void setMock(System.Type t, AnimalsHttpCalloutMock a){
	} 
}