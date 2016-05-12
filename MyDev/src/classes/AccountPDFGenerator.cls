public with sharing class AccountPDFGenerator
{
    
    public static final String FORM_HTML_START = '<HTML><BODY>';
    public static final String FORM_HTML_END = '</BODY></HTML>';

    public static void generateAccountPDF(Account account)
    {
    System.debug('inside generateAccountPDF  ');
        String pdfContent = '' + FORM_HTML_START;
        try
        {
            pdfContent = '' + FORM_HTML_START;
            pdfContent = pdfContent + '<H2>Account Information in PDF</H2>';
            
            //Dynamically grab all the fields to store in the PDF
            Map<String, Schema.SObjectType> sobjectSchemaMap = Schema.getGlobalDescribe();
            Schema.DescribeSObjectResult objDescribe = sobjectSchemaMap.get('Account').getDescribe();
            Map<String, Schema.SObjectField> fieldMap = objDescribe.fields.getMap();
            
            //Append each Field to the PDF
            for(Schema.SObjectField fieldDef : fieldMap.values()) 
            {
                Schema.Describefieldresult fieldDescResult = fieldDef.getDescribe();
                String name = fieldDescResult.getName();
                pdfContent = pdfContent + '<P>' + name + ': ' + account.get(name) + '</P>';
            }
            pdfContent = pdfContent + FORM_HTML_END;
        }catch(Exception e)
        {
            pdfContent = '' + FORM_HTML_START;
            pdfContent = pdfContent + '<P>THERE WAS AN ERROR GENERATING PDF: ' + e.getMessage() + '</P>';
            pdfContent = pdfContent + FORM_HTML_END;
        }
        attachPDF(account,pdfContent);
    }
    
    public static void attachPDF(Account account, String pdfContent)
    {
        try
        {
            Attachment attachmentPDF = new Attachment();
            attachmentPDF.parentId = account.Id;
            attachmentPDF.Name = account.Name + '.pdf';
            attachmentPDF.body = Blob.toPDF(pdfContent); //This creates the PDF content
            insert attachmentPDF;
        }catch(Exception e)
        {
            account.addError(e.getMessage());
        }
    }
    
    
    public static void generateAccountPDF1(){
    
  //  PageReference pdf = Page.TestQueueAndPDF;
    
    PageReference pdf = new PageReference('/apex/TestQueueAndPDF');

       // pdf.getParameters().put('accId', a.id);

       // pdf.getParameters().put('renderAs', 'PDF');
       
       System.debug('pdf  :::: '+pdf );

 
System.debug('before getPDFAsCOntent() ');
   Blob b;
  
  if(pdf!=null){

 b = pdf.getContentAsPDF();
 
 }

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
    
    public static void generateAccountPDF2(){
    
    PageReference pdf = Page.TestQueueAndPDF;

       // pdf.getParameters().put('accId', a.id);

       // pdf.getParameters().put('renderAs', 'PDF');

 
System.debug('before getPDFAsCOntent() ');

  Blob b;
  
  if(pdf!=null){

 b = pdf.getContentAsPDF();
 
 }

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
  
  
 public static void generateAccountPDF6(){
    
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