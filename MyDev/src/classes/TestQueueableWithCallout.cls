public class TestQueueableWithCallout implements Queueable, Database.AllowsCallouts {

     

    private Account a;

 

    public TestQueueableWithCallout(Account a) {

        this.a = a;
System.debug('Account a '+a);

    }


    public void execute(QueueableContext context) {

 

        System.debug('queueble started!!!');

 

        PageReference pdf = Page.TestQueueAndPDF;

       // pdf.getParameters().put('accId', a.id);

       // pdf.getParameters().put('renderAs', 'PDF');

 
System.debug('before getPDFAsCOntent() ');
        Blob b = pdf.getContentAsPDF();

        // Blob b = Blob.valueOf('ciao');

 System.debug('aftergetPDFAsCOntent() '+b);

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