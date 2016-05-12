global class check implements Database.batchable<sObject>{

String query= '';

public void finish(Database.BatchableContext con){





}


public void execute(Database.BatchableContext con, list<Account> scope){

List<Account> accsToUpdate = new List<Account>();

       for(Account a : scope){

           a.Name = 'true';
           a.NumberOfEmployees = 70;

           accsToUpdate.add(a);
       }
       update accsToUpdate;



}


global Database.QueryLocator start(Database.BatchableContext BC){
     return Database.getQueryLocator(query);
   }








}