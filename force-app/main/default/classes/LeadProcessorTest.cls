@isTest
private class LeadProcessorTest {
	
	@testSetup
	public static void newRecord(){
		List<Lead>  listLeads = new List<Lead>();
		for(Integer i=0; i<200; i++){
			Lead newLead = new Lead();
			newLead.LastName = 'Lead Test';
			newLead.Company = 'Smith and Co.';
			newLead.Status = 'Open - Not Contacted';

			listLeads.add(newLead);
		}
		insert listLeads;
	}

	@isTest
	private static void testName() {
		System.Test.startTest();
			LeadProcessor b = new LeadProcessor();
			Database.executeBatch(b);
		System.Test.stopTest();
	}

	private static testmethod void test01(){
		System.Test.startTest();
			Test.Test02 var = new Test.Test02();
			var.nomemetodo();
		System.Test.stopTest();
	}
}