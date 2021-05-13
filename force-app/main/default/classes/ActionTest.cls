@isTest
public class ActionTest {
	@isTest public static void testCenario1() {
		Request__c novoRequest= TestActionFactory.configurarRequest();
		insert novoRequest;
		Action__c novoAction = TestActionFactory.configurarAction(novoRequest);
		insert novoAction;
		novoAction.Description__c= 'testando';
		update novoAction;
	}
}