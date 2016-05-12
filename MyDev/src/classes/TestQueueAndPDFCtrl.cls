public with sharing class TestQueueAndPDFCtrl {

     

    public String accid {get;set;}

    public String renderAs {get;set;}

 

    public TestQueueAndPDFCtrl() {

        // get account id from parameter and set on the page

        accid = ApexPages.currentPage().getParameters().get('accId');

        renderAs = ApexPages.currentPage().getParameters().get('renderAs');

    }

 

    public static void sendPdf() {

 

        /* create an account and then send the id by email */

 

        Account a = new Account();

        a.Name = 'marco';

        insert a;

 

        Id job = System.enqueueJob(new TestQueueableWithCallout(a));

    }

}