public class TriggerAccountHandler {

	public static void processarAntesDeCriarOuAtualizar(){
	}

	public static void processarDepoisDeCriarOuAtualizar(){
		if(Trigger.isExecuting && Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
			Account[] listaContas = (Account[]) Trigger.new;
			Account[] listaContasAProcessar = new Account[]{};
			for(Account conta: listaContas){
				if (Trigger.isInsert && conta.GerarCaso__c){
					listaContasAProcessar.add(conta);
				}else if(Trigger.isUpdate){
					Account contaAnterior = (Account) Trigger.oldMap.get(conta.Id);
					if(conta.GerarCaso__c && contaAnterior.GerarCaso__c!=conta.GerarCaso__c){
						listaContasAProcessar.add(conta);
					}
				}
			}
			criarCasoParaContas(listaContasAProcessar);
		}
	}

	public static void criarCasoParaContas(List<Account> listaDeContas){
		if (listaDeContas != null && !listaDeContas.isEmpty()) {
		   	List<Case> casos = new List<case>();
			for (Account conta : listaDeContas) {
				Case novo = new Case(AccountId = conta.Id);
				novo.Type = 'Other';
				novo.Reason = 'Other';
				novo.Subject = 'Caso Automático para Conta '+ conta.Name;
				novo.Comments = 'Caso criado em '+formatarData(Date.today())+' por '+UserInfo.getName();
				casos.add(novo);
			}

			Database.SaveResult[] listaResultado = Database.insert(casos, false);
			integer index = 0;

			for (Database.SaveResult resultado : listaResultado) {
			   if (!resultado.isSuccess()) {
					Id idConta = casos[index].AccountId;
					String msgErro = 'Erro ao criar caso para conta "' + idConta + '" - MsgErro: ' + resultado.getErrors()[0].getMessage();
					System.debug(msgErro);
					Trigger.newMap.get(idConta).addError(msgErro);
			   }
			   index++;
			}

		}
	}

	private static String formatarData(Date dataAFormatar) {
       String strDataFormatada = '';
       if (dataAFormatar != null) {
           String ano = String.valueOf(dataAFormatar.year());
           String mes = String.valueOf(dataAFormatar.month()).length() == 1 ? '0' + 
		   				String.valueOf(dataAFormatar.month()) : String.valueOf(dataAFormatar.month());
           String dia = String.valueOf(dataAFormatar.day()).length() == 1 ? '0' + 
		   				String.valueOf(dataAFormatar.day()) : String.valueOf(dataAFormatar.day());
           strDataFormatada = dia + '/' + mes + '/' + ano;
       }
       return strDataFormatada;
   	}
}