trigger updateContactTest on Contact (after insert, after update) {


  List<Contact> checkLead = [Select Id, FirstName, LastName from Contact];
  
  system.debug('checkLead:: '+checkLead);
  
  Abacus.callFromTrigger(checkLead);


for (Contact c : Trigger.new){

Abacus.callFromTriggerSingle(c);
}

}