public class TestQueueable implements Queueable, Database.AllowsCallouts {
    
    
    
      //Execute Queue Job
    public void execute(QueueableContext context) {
        
      //  Page.TestQueueAndPDF.getContent(); 
      
      System.debug('context :::: '+context);

  PageReference pdf = new PageReference('/apex/TestQueueAndPDF');

       // pdf.getParameters().put('accId', a.id);

       // pdf.getParameters().put('renderAs', 'PDF');
       
       System.debug('pdf  :::: '+pdf );

 
System.debug('before getCOntent ');
   Blob b;
  
  if(pdf!=null){

 b = pdf.getContent();
 
 }

        // Blob b = Blob.valueOf('ciao');

 System.debug('aftergetCOntent() '+b);

        Messaging.EmailFileAttachment att = new Messaging.EmailFileAttachment();

        att.setFileName('ciao.pdf');

        att.setbody(b);

 

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        mail.setToAddresses(new List<String>{'riteshfzd@yahoo.co.in'});

        mail.setsubject('test');

        mail.setFileAttachments(new List<Messaging.EmailFileAttachment>{att});

        mail.sethtmlbody('body');

 

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});

 

        System.debug('done');

    

    }
    
    
    
    
    
    
    
    
    
    }