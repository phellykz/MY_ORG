global class BatchAdiarOportunidade implements Database.Batchable<sObject>, Database.Stateful, Schedulable {
    
    String query;
    boolean checkAtivo;
    integer contador = 0;
    integer qtdErros = 0;
    integer numDiasAdiamento = 30;
    
    global BatchAdiarOportunidade() {
        
    }

    global BatchAdiarOportunidade(integer p_NumDiasAdiamento) {
        if (p_NumDiasAdiamento!=null&&p_NumDiasAdiamento>0) {
           this.numDiasAdiamento = p_NumDiasAdiamento;
        }
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        query = 'SELECT CloseDate FROM Opportunity WHERE CloseDate = TODAY AND Probability<=60 AND OportunidadeAdiada__c = false LIMIT 200';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        Opportunity[] oportunidades = (Opportunity[]) scope;

        for (Opportunity oportunidade : oportunidades) {
            oportunidade.OportunidadeAdiada__c = true;
            oportunidade.CloseDate += numDiasAdiamento;
        }

        Database.SaveResult[] resultList = Database.update(oportunidades, false);
        for (Database.SaveResult rsList : resultList) {
           if (rsList.isSuccess()) {
              this.contador++;
           }else {
                for (Database.Error erro : rsList.getErrors()) {
                    System.debug(erro.getStatusCode() + ':'+erro.getMessage());
                    System.debug('Campo de Oportunidade que foi afetado pelo erro: '+ erro.getFields());
                }
                this.qtdErros++;
           }
        }

    }
    
    global void finish(Database.BatchableContext BC) {
               
        String assunto = 'Execução de Rotina de Adiamento de Oportunidades Elegíveis';
        String mensagem;
        
        If (contador == 0){
            mensagem = 'Rotina foi executada por' + Userinfo.getName() + ', em ' + System.now() +', não houve nenhuma oportunidade elegível';
        }
        else if (contador >0 && qtdErros == 0){
            mensagem = 'Rotina foi executada por' + Userinfo.getName() + ', em ' + System.now()+
                    +', adiou em '+ numDiasAdiamento + 'dias o fechamento de ' + contador + ' oportunidades.';
        }
        else {
            mensagem = 'Rotina foi executada por' + Userinfo.getName() + ', em ' + System.now() +
                +', adiou em '+ numDiasAdiamento + 'dias o fechamento de ' + contador + ' oportunidades.'+
                + 'Falha em processamento de ' + qtdErros + 'oportunidades.' ;
        }

        Messaging.SingleEmailMessage email = enviarEmail(UserInfo.getUserEmail(), assunto, mensagem);
        
        try{
            Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
        }
        catch(Exception ex){
            System.debug(ex.getMessage());
        }
        
        FeedItem novoFeed = new FeedItem (ParentId = UserInfo.getUserId(), CreatedById = UserInfo.getUserId());
        novoFeed.Body = assunto + '\n' + mensagem;
        try{
            insert novoFeed;
        }
        catch(Exception ex){
            System.debug(ex.getMessage());
        }
    }

    global void execute(SchedulableContext sc) {
        String TEMPO = '0 12 02 21 08 ?';
        System.schedule('Processar Adiar Oportunidades Job', TEMPO, new BatchAdiarOportunidade());
    }

    private static Messaging.SingleEmailMessage enviarEmail (String enviarPara, String assunto, String conteudo){
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toaddresses = new String[]{enviarPara};
        message.subject = assunto;
        message.plaintextbody = conteudo;
        
        return message;
    }
    
}