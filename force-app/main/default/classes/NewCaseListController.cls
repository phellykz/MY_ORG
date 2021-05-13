public inherited sharing class NewCaseListController {
    
    public List<Case> getNewCases(){
        List<Case> resultCases = [Select Id, CaseNumber from Case where Status='new'];
        return resultCases;
    }
   
}