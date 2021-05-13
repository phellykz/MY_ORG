@isTest
public class Conta_Test {
	static Account acc;
    public static void setup(){
        acc = new Account();
        acc.Name = 'Test';
        insert acc;
    }
    
    public static testmethod void test01(){
        setup();
        conta co = new conta();
        co.updateConta(acc.Id);
    }
}