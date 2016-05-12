trigger ContactTrigger on Contact (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) 
{
  //  if(Trigger.isBefore)
 //   {
        for(Contact contact : trigger.new)
        {
            /*if(contact.EmailBouncedDate == null && contact.EmailBouncedReason == null )
            {
                contact.EmailBouncedDate = DateTime.now();
                contact.EmailBouncedReason = 'Invalid Email Address Set By User';
            }
            
            */
            
            System.debug('TO TEST TRANSACTION');
            
        }
  //  }
}