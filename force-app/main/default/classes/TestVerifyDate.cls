@isTest 
private class TestVerifyDate {

	@isTest
	private static void testName() {
		Date data1 = System.today();
		Date data2 = System.today()+5;
		VerifyDate.CheckDates(data1, data2);
		data2 = data1+40;
		VerifyDate.CheckDates(data1, data2);
	}
}