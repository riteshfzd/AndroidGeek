/*
        Class:          CT_SendEmailExtension 
        @Author:        Cloud Sherpas, Inc.
        @Created Date:  13-Sept-2013
        @Description:   Apex class for sending custom values to SFDC Standard 
                            Email Publisher.                    
Change History
************************************************************************************
    ModifiedBy      Date        Requested By        Description         Tag
************************************************************************************
Jay 5.15.14 GCS - SS 4893 Add Ref Id in Subject <T01>
------------------------------------------------------------------------------< T01>

------------------------------------------------------------------------------</T01>
*/
public class CT_SendEmailExtension {
    
    //Member Variables
    public String emailBody {get;set;}
    public String emailSubject {get;set;}
    public String emailto {get;set;}
    public String emailcc {get;set;}
    public String mode {get; set;}
    public String CaseId {get; set;}
    public String Ids {get; set;}
    
    //Constructor
    public CT_SendEmailExtension(ApexPages.StandardController controller) {
                
        //Get URL parameters        
      //  mode = System.currentPagereference().getParameters().get('mode');
     //   CaseId = System.currentPagereference().getParameters().get('id');
      //  Case cs = [SELECT CaseNumber, Case_Ref_ID__c, Contact.Email, Contact.Name, Contact.FirstName FROM Case WHERE id = : CaseId]; //<T01>
        
        emailSubject = 'Case ' ;  //<T01>
        emailto = 'abc@gmail.com';
        //List<KB_Article__c> lSelectedKBs = new List<KB_Article__c>();
        //List<Id> sKBIds = new List<Id>();
        
        
        emailBody = 'Dear '+ ', <br><br>';
        
        emailBody += 'Following is(are) link(s) to the KB document(s), related to the problem you are experiencing. Please click the link(s) below to access our Customer Support Knowledge base. (NOTE: If you are not logged in to mysupport.informatica.com it will prompt you for login).<br><br>';

      //  String KBArticleURL = Informatica_Settings__c.getValues('KBArticleURL').Values__c;
     //   String MySupport = Informatica_Settings__c.getValues('MySupport').Values__c;

      
        emailBody += '<br>';
        emailBody += 'Thank you for contacting Informatica Technical Support.<br><br>';
        emailBody += 'Regards, <br>Informatica Support';
        
        System.debug(LoggingLevel.INFO, '== emailBody ==' + emailBody);
    }
}