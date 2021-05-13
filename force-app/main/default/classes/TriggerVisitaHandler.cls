public class TriggerVisitaHandler {

	private static final String STATUS_APROVADO = 'Aprovado';
	private static final String STATUS_RASCUNHO = 'Rascunho';

	public static void processarAntesDeCriarOuAtualizar() {
		if (Trigger.isExecuting && Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate) ) {

			Visita__c[] listaVisita = (Visita__c[]) Trigger.new;

			for (Visita__c visita : listaVisita) {

				Boolean contaNaoPreenchida = visita.Conta__c == null;

				if (contaNaoPreenchida) {
					visita.Conta__c.addError('É obrigatório o preenchimento da conta!'); // mostra logo abaixo do campo
					// visita.addError('É obrigatório o preenchimento da conta!'); // mostra no topo da tela
				}

				if (Trigger.isInsert) {
					if (visita.Status__c != STATUS_RASCUNHO) {
						visita.Status__c.addError('Visita não pode ser criada com status diferente de Rascunho!');
					}
				}
				else if (Trigger.isUpdate) {

					Visita__c visitaAntes = (Visita__c) Trigger.oldMap.get(visita.Id);
					Boolean isStatusAprovado = visita.Status__c != visitaAntes.Status__c && visita.Status__c == STATUS_APROVADO;
					if (isStatusAprovado) {
						visita.Descricao__c = 'Parabéns, o status está aprovado!';
					}
				}

			}
		}
	}
    

}

//====================================================================================================================================================================