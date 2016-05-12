trigger AccountTrigger on Account (before update) 
{
/*
 List<Opportunity> newOpps = new List<Opportunity>();
    if(trigger.isAfter)
    {
        if(trigger.isInsert)
        {
            if(trigger.new.size() == 1) // Lets only do this if trigger size is 1
            {
                //AccountPDFGenerator.generateAccountPDF(trigger.new[0]);
                
             //   LCUReceiptQueue  lc=new LCUReceiptQueue  (trigger.new[0]);
               // ID jobID = System.enqueueJob(new LCUReceiptQueue(trigger.new[0]));
              //  ID jobID = System.enqueueJob(new TestQueueableWithCallout(trigger.new[0]));
              
              ID jobID = System.enqueueJob(new LCUReceiptQueue(trigger.new[0]));

            }
        }else if(trigger.isUpdate)
        {
            if(trigger.new.size() == 1) // Lets only do this if trigger size is 1
            {
               // AccountPDFGenerator.generateAccountPDF(trigger.new[0]);
               // LCUReceiptQueue  lc=new LCUReceiptQueue  (trigger.new[0]);
           // ID jobID = System.enqueueJob(new TestQueueableWithCallout(trigger.new[0]));
           
           ID jobID = System.enqueueJob(new LCUReceiptQueue(trigger.new[0]));

            }
        }
    }
    
    if(trigger.isafter && trigger.isinsert){
    
   
  for (Account acc : Trigger.new) {
    Opportunity opp = new Opportunity();
    opp.Name        = acc.Name + ' Opportunity';
    opp.StageName   = 'Prospecting';
    opp.CloseDate   = Date.today() + 90;
    opp.AccountId   = acc.Id; // Use the trigger record's ID
    newOpps.add(opp);
  }
  insert newOpps;
    
    }
    
    */
    
    List<Account> accId=New List<Account>();
    List<Contact> myPhaad=New List<Contact>();
     List<Opportunity> myPhaad1=New List<Opportunity>();
    accId=trigger.new;
    ID a=accId[0].ID;
    
    
 List<Contact>cont=[SELECT ID,FirstName from Contact where AccountID =:a];
 
 for (Contact con: cont ){
 
 con.FirstName='Phaad';
 myphaad.add(con);
 }
    
    update myPhaad;
    
 List<Opportunity> opp= [SELECT ID,Name from Opportunity where AccountID =:a];
 
 for (Opportunity op:opp){
 
 op.name='CoolPhaad';
 myPhaad1.add(op);
 
 }
 
 
 update myPhaad1;
    
    
    
}