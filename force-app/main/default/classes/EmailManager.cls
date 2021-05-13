/**
 * @File Name          : EmailManager.cls
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 08/01/2020 12:09:37
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    08/01/2020   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
public with sharing class EmailManager {
    
    public void sendMail(String[] addresses, String[] subjects, String [] messages ){
        
        Messaging.SingleEmailMessage [] emails = new Messaging.SingleEmailMessage []{};
        Integer totalMails = addresses.size();
        for (Integer i = 0; i < totalMails; i++) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setSubject(subjects[i]);
            email.setToAddresses(new List<String>{ addresses[i] });
            email.setPlainTextBody(messages[i]);
            emails.add(email);
        }
        Messaging.sendEmail(emails);
    }
    
    
    
    
    
    
    
    
    
    /*public void sendEmail(String address, String subject, String body){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddress = new String[] {Address};
        mail.setToAddresses(toAddress);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        
        Messaging.SendEmailResult[] results = Messaging.sendEmail( new Messaging.SingleEmailMessage[] {mail});
        
        inspectResults(results);
    }
    
    private static Boolean inspectResults(Messaging.SendEmailResult[] results){
        Boolean sendResult = true;
        
        for (Messaging.SendEmailResult res: results){
            if(res.isSuccess()){
                System.debug('Email send successfully');
            }
            else{
                sendResult = false;
                System.debug('The following erros occurred: ' + res.getErrors());
            }
        }
        return sendResult;
    }*/
}