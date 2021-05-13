public class StringArrayTest {
    public static List<String> generateStringArray(Integer numbers){
        List<String> arrayNumbers = new List<String>();
            
        for (Integer i= 0; i<numbers;i++){
            arrayNumbers.add('Test ' + i);
        }
        
        return arrayNumbers;
    }    
}