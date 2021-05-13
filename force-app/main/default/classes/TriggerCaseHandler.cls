public class TriggerCaseHandler {
    /*Public static void ProcessarDepoisDeCriarOuAtualizar(){
        if (Trigger.isExecuting && Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
           Case[] casos = (case[]) Trigger.new;
           Set<Id> idsContas = new Set<Id>();

           for (Case caso : casos) {
              if (Trigger.isInsert) {
                idsContas.add(caso.Account.Id);
              }else if (Trigger.isUpdate) {
                Case casoAntigo = (Case) Trigger.oldMap.get(caso.Id);
                Boolean mudouIsClosed = casoAntigo.IsClosed != caso.IsClosed;
              }
           }
            atualizarStatusContasRelacinadas(idsContas);
        }
    }

    Private static void atualizarStatusContasRelacinadas(Set<Id> idsContas){
        if (idsContas!= null && idsContas.size()>0) {
            String consulta = 'SELECT Id, StatusChamados__c, (SELECT Id, IsClosed FROM Cases) FROM Account WHERE Id IN :idsContas';
            Account[] contas = Database.query(consulta);
            Account[] listaContaAtualizar = new List<Account>();

            String statusInexistente = 'Inexistente';
            String statusHaChamadosAbertos = 'Ha Chamados Abertos';
            String StatusTodosFechados = 'TodosFechados';

            for (Account conta : contas) {
               
            }

        }
    }*/

}