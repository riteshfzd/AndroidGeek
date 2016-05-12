trigger onCaseUpdate on Case bulk ( before update) {


List<Case> newCase= new List<Case>();

newCase=trigger.new;

System.debug('newCase :::' +newCase);

System.debug('ID :::' +newCase[0].ID);


List <ProcessInstance> newCase1=[SELECT Id,TargetObjectid, Status,(select id,actor.name from Workitems),(SELECT Id, StepStatus, Comments,Actor.Name FROM Steps) FROM ProcessInstance where TargetObjectId = '5009000001B7sso'];

System.debug('newCase1:::' +newCase1);

//Query SELECT Id, ActorId, StepStatus FROM StepsAndWorkitems where StepStatus='Approved' 

/*

SELECT Id, Status,TargetObjectId, (SELECT Id, ActorId, StepStatus FROM StepsAndWorkitems where StepStatus='Approved' ) 
FROM ProcessInstance WHERE TargetObjectId IN :CR_ID_List AND status='Pending']

*/

 /*
 
 for (Integer i = 0; i < Trigger.new.size(); i++) {
        Case acct = System.Trigger.new[i];
       
    }
    
    */
    
    
    /** 
* Handle all bussiness logic for Before Update 
*/ 
if(trigger.isBefore && trigger.isUpdate ){ 
// Req: Need to identify the user who has approved the record in current step 
//so that user can be removed from the list of user who will be set dynamically for next step. 
} 


}