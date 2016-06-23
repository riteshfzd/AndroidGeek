trigger AccountTriggerDataLoader on Account (after update,after insert) 
{
 
 List<Account> myAccount=new List<Account>();
 List<Id> accId=new List<Id>();
 Set<Contact>myCOntact=new Set<Contact>();
 List<Contact>myCOntact1=new List<Contact>();
 
 public static boolean runFirst=true;
 
 //if(runFirst){
 
 myAccount=trigger.new;
 
 for(Account acc :myAccount){
 
 Contact con=new Contact();
 
 con.FirstName=acc.Name+'Maardala';
  con.LastName='Srivastava'+'Maardala';
 con.AccountId=acc.Id;
 myContact.add(con);
 
 
 
 }
 System.debug('myContact ::: '+myContact);
 myContact1.addAll(myContact);
 upsert myContact1;
 //runFirst=false;
 
 //}
    
}