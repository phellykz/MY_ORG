@isTest
public class TriggerCaseTest {
	
	@isTest static void testarCenario1(){
		Account conta = generalTestFactory.configurarAccount();
		conta.Industry = 'entertainment';
		conta.GerarCaso__c = true;
		insert conta;

		conta.Industry = 'Government';
		update conta;

		Case caso = generalTestFactory.ConfigurarCaso(conta.Id);
		insert caso;

		caso.Status = 'Closed';
		update caso;
	}

	@isTest static void testarWorkflowDesmarcarGerarCaso(){
		Account conta = generalTestFactory.configurarAccount();
		conta.GerarCaso__c = true;
		insert conta;

		Account[] contas = [SELECT GerarCaso__c FROM Account WHERE Id = :conta.Id];
		System.assert(contas.size()==1);
		conta = contas[0];
		System.assert(!conta.GerarCaso__c, 'Falha no funcionamento do workflow que desmarca a flag GerarCaso__c');
	}
}