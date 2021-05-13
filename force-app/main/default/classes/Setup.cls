public class Setup {
	public class WrapperSeting {
        @AuraEnabled public integer newRequest;
        @AuraEnabled public integer changeRequest;
        @AuraEnabled public integer defect;                
    }
    
    @AuraEnabled
    public static void setConfig(string conta){
        System.debug('estou no apex '+conta );
        WrapperSeting s = (WrapperSeting) JSON.deserialize(conta, WrapperSeting.class);
        System.debug(s.newRequest);
        System.debug(s.changeRequest);
        System.debug(s.defect);
    }
}