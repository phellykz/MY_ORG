@isTest 
private class DailyLeadProcessorTest {
	 public static String CRON_EXP = '0 0 0 15 3 ? 2022';
	@TestSetup
	private static void newRecords(){
		List<Lead> listLeads = new List<Lead>();
		for (Integer i = 0; i < 200; i++){
			Lead l = new Lead();
			l.LastName = 'Test'+i;
			l.Company = 'sjdj';
			l.Status = 'Closed';
			listLeads.add(l);
		}
		insert listLeads;
	}

	@isTest
	private static void testName() {
		DailyLeadProcessor leadPro = new DailyLeadProcessor();
		System.Test.startTest();
			System.schedule('ScheduledApexTest', CRON_EXP, leadPro);
		System.Test.stopTest();
	}
}