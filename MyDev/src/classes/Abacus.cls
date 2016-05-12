public class Abacus implements Queueable{

 public void execute(QueueableContext context) {
        Account a = new Account(Name='Acme',Phone='(415) 555-1212');
        insert a;        
    }
    
    
    public static void callFromTrigger(List<Contact> myConnection){
    
System.debug('function call from callFromTrigger ::: '+myConnection);
    
    }
    
    
    public static void callFromTriggerSingle(Contact myConnection){
    
System.debug('function call from callFromTriggerSingle::: '+myConnection);
    
    }
    
    
    
    public static void callFromClass(List<Contact> myConnection){
    
    System.debug('function call from callFromClass ::: '+myConnection);
    
    }

}