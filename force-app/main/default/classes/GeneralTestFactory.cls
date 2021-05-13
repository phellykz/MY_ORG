@isTest
public class GeneralTestFactory {
	public GeneralTestFactory() {
		
	}

	public static Account configurarAccount(){
		Account conta = new Account();
		conta.Name = 'Conta test';
		conta.Industry = 'Government';
		return conta;
	}

	public static Case ConfigurarCaso(Id conta){
		Case caso = new Case();
		return caso;
	}

	public static Opportunity configurarOportunidade(Id conta){
		Opportunity oportunidade = new Opportunity();
		oportunidade.Name = 'Oportunidade test';
		oportunidade.AccountId = conta;
		oportunidade.StageName = 'Prospect';
		oportunidade.CloseDate = System.today()+30;
		return oportunidade;
	}

	public static Opportunity configurarOportunidade(Id conta, Date dataFechamento){
		Opportunity oportunidade = configurarOportunidade(conta);
		oportunidade.CloseDate = dataFechamento;
		return oportunidade;
	}

	public static Task configurarTarefa(Id idObjRelacionado){
		Task tarefa = new Task();
		tarefa.Subject = 'Assunto teste';
		tarefa.Status = 'In Progress';
		tarefa.ActivityDate = System.today()+30;
		tarefa.Description = 'Descrição da tarefe';
		return tarefa;
	}
}