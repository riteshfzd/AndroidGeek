trigger ContactName on Contact (before insert,before update,before delete ) {



List<Contact> contactId=new List<Contact>();
List<Account> contactId1=new List<Account>();

List<Account> acc=new List<Account>();

if(trigger.isinsert){

for (Contact a :trigger.new){
contactId.add(a);

}



for(Contact c : contactId){
for(account a:[SELECT Id,FemaleCount__c,Female_Names__c,MaleCount__c,MaleName__c,CreatedbyID,Account.Name,(SELECT name,Contact.FirstName, Contact.LastName FROM Contacts) FROM Account Where Account.ID IN (Select Contact.AccountId from Contact) ]){


System.debug('*****************a****'+a);
if(a != null){

if(c.Test__c == 'Male'){

if(trigger.isInsert){

if(a.MaleCount__c == NULL){
a.MaleCount__c=0;
}

a.MaleCount__c++;

a.MaleName__c=c.FirstName;
}

if(trigger.isDelete){
a.MaleCount__c--;

}
}
else{
if(trigger.isInsert){
if(a.FemaleCount__c==NULL){
a.FemaleCount__c=0;
}
a.FemaleCount__c++;

a.Female_Names__c=c.FirstName;
}
if(trigger.isDelete){

a.FemaleCount__c--;
}


}

}
 contactId1.add(a);
 //insert a;
}

}

System.debug('************contactId1******'+contactId1);

update contactId1;
}


if(trigger.isDelete){

for (Contact a :trigger.old){
contactId.add(a);

}



for(Contact c : contactId){
for(account a:[SELECT Id,FemaleCount__c,Female_Names__c,MaleCount__c,MaleName__c,CreatedbyID,Account.Name,(SELECT name,Contact.FirstName, Contact.LastName FROM Contacts) FROM Account Where Account.ID IN (Select Contact.AccountId from Contact) ]){


System.debug('*****************a****'+a);
if(a != null){

if(c.Test__c == 'Male'){

if(trigger.isInsert){

if(a.MaleCount__c == NULL){
a.MaleCount__c=0;
}

a.MaleCount__c++;

a.MaleName__c=c.FirstName;
}

if(trigger.isDelete){
a.MaleCount__c--;

}
}
else{
if(trigger.isInsert){
if(a.FemaleCount__c==NULL){
a.FemaleCount__c=0;
}
a.FemaleCount__c++;

a.Female_Names__c=c.FirstName;
}
if(trigger.isDelete){

a.FemaleCount__c--;
}


}

}
 contactId1.add(a);
 //insert a;
}

}

System.debug('************contactId1******'+contactId1);

update contactId1;
}
}