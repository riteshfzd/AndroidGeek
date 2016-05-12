trigger EmailMessageAfterUpdate on EmailMessage (after insert) {

 

    for (Integer i = 0; i < Trigger.new.size(); i++ )

    {

    System.debug('******Entering EmailAfterUpdate******');

 

        
    }

    
 

}