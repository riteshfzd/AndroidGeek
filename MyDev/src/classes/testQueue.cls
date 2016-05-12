public class testQueue{


public testQueue(){


 List<Contact> checkLead = [Select Id, FirstName, LastName from Contact];

system.debug('checkLead:: '+checkLead);
Abacus.callFromClass(checkLead);
}



}