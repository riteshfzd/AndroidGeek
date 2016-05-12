public class LCUReceiptQueue implements Queueable, Database.AllowsCallouts {
    
    private Opportunity donation;
    private id donationId;
    
    private string receiptType;
    
    public Account ac1=new Account();
    
   // private list<AuditLog__c> auditlogs = new list<AuditLog__c>();
   // private list<Service_Call_Log__c> svcLogs = new list<Service_Call_Log__c>();
    
    //private list<WrapperAttachment> reciptAttachs = new list<WrapperAttachment>();    
    
    private list<Task> reciptActivity = new list<Task>();
    
    private Boolean loggingEnabled = false;
    
    private Blob receiptBody;
    
    //Added by Offshore 07/13/2015
    //US-102421: Non Standard 8283 letter
    private boolean nonStdVehicle = false;
    
    public LCUReceiptQueue(){
    
    
    }
    
    public LCUReceiptQueue (Account acc){
    
    ac1=acc;
    
    System.debug('inside constrictor :::' +ac1);
    }
    
   
    
    //Execute Queue Job
    public void execute(QueueableContext context) {
        
        runReceipt();
              
    }
    
   
    
    //Receipt Logic
    public void runReceipt(){
    
    getPDFReceipt();
        
        }
        
        
       
        
        
        private void getPDFReceipt(){ 
        
        System.debug('getPDFReceipt function');
        
     //   AccountPDFGenerator.generateAccountPDF(ac1);
     
     AccountPDFGenerator.generateAccountPDF1();
    }
    
    
    /*
    
     //private static Blob createPDFReceipt(string DonationId){
    private void getPDFReceipt(){  
        
        system.debug('IN getPDFReceipt IN LCU');
        
        String ipAddress;
        try {
            ipAddress = SessionHelper.GetSourceIpAddress();
        } 
        catch (Exception e) {
            system.debug(Logginglevel.WARN, 'Service Call Log Helper Failed to initialize properly: ' + e.getMessage()); 
        }
        
        try{                                                                    
            
            String donAmt = string.valueOf(donation.Amount);
            String saleDate = string.valueof(donation.Sold_Date__c);
            String pickDate = string.valueof(donation.Pickup_Date__c);
            
            PDFServiceClient.ReceiptData receiptData = new PDFServiceClient.ReceiptData();
            receiptData.donationId = '112231241241';
            receiptData.receiptType = 'riteshfzd@yahoo.co.in';
            receiptData.saleAmt ='45' ;
            receiptData.soldDate = '22/12/2005';
            receiptData.pickupDate = '22/12/2005';
           
            
            if(!test.isRunningTest()){
                system.debug('CALLING PDF service FROM LCU');
                this.receiptBody = PDFServiceClient.getPDFReceipt(receiptData);
                if(this.receiptBody == null){
                    svcLogs.add(new Service_Call_Log__c(Direction__c = 'Outbound', Opportunity__c = donation.Id, Source__c = ipAddress, Method_Name__c = 'LCUReceiptQueue - getPDFReceipt', Additional_Info__c = 'LCU Emails skipped as PDF Attachment is null, check PDFService', Status__c = 'Failure - Unknown'));
                }
            }else{
                receiptBody = Blob.valueOf('Created During Testing');
            }
            
      
    
    
    
    
    
    
    */
    
    }