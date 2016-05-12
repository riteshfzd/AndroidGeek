trigger leadtask on Lead (before update) {

/*
 
 
 Set<ID> ids = Trigger.newMap.keySet();
 System.debug('ids  ::: '+ids );
 list<Lead> theLeads = new list<Lead>(); 
 
 for(Lead l:trigger.new) { 
            theLeads.add(l);
            ids.add(l.ID);
            } 
            
   System.debug('ids     qqqqq ::: '+ids );          
   
      System.debug('theLeads  qqqqq ::: '+theLeads);      
for (Lead l:theLeads) {
//List<task> t = [SELECT Id FROM user WHERE mileageid__c in :ids];
list <task> t = [select id from task where whoid =: l.id];

   
      System.debug('t  qqqqq ::: '+t);  
l.NumberofLocations__c =  t.size();
}



for(lead l : trigger.new){
list <task> t = [select id from task where whoid =: l.id];


l.NumberofLocations__c =  t.size();

}

*/


map <id, integer> mp = new map<id,integer>();


for(task t  : [select id,whoid from task where whoid in : trigger.new]){

//mp.put(t.whoid, 0);

if(mp.containskey(t.whoid)){
integer temp = mp.get(t.whoid);



mp.put(t.whoid, temp+1);

}
else{
mp.put(t.whoid,1);

}

}

for(lead l : trigger.new){
if(mp.containskey(l.id)){
l.description = string.valueof(mp.get(l.id));

}


}




}