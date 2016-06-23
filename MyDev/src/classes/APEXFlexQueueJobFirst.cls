global class APEXFlexQueueJobFirst implements Database.Batchable<sObject>{
global Database.QueryLocator start(Database.BatchableContext BC){
return Database.getQueryLocator('Select Id,Name from Account Where Name !=null LIMIT 2000');
}

global void execute(Database.BatchableContext BC, List<Account> scope){
// for(Account a : scope){
System.debug('---------------------->>>>>+This Apex Flex Queue Jobs....!'); 


// } 
//List<Account> acc=[select id,Name from Account where ID != null LIMIT 2000];
// List<Account> la=new List<Account>();
// la= acc;
}

global void finish(Database.BatchableContext BC){
//submitting the same batch again.
//ID batchprocessid = Database.executeBatch(new APEXFlexQueueJobs());
System.scheduleBatch(new APEXFlexQueueJobFirst(),'APEXFlexQueueJobFirst '+(DateTime.Now().format()),1,1); 
}
}