/***********************************************************************************
ClassName: LRPopup 
Created By : Upendra Kumar
Last Modified By: Upendra Kumar
Las Modified Date : 29-NOV-2013
CalledFrom : LR Restricted PopUp
Description : Class to show Popup when Lr Restricted Checkbox is checked;
* ---------------------------------------
* Revision History
*Added Try and Catch Block.
***********************************************************************************/

/* Class Starts */
public class LRPopup {
    /**** Variales ****/
    public String strlink = '';
    public DateTime tempDateTime;    
    public String cseId {get; set;}     
    /****Variables End ****/

   /**** Properties Start ****/
      public Case cse{get;set;}
      public boolean showPopup{get;set;}
      public String propfullFileURL {get ; set;}
      public String propstrlink {get ; set; } 
    
    /**** Properties End ****/
    
    /*** Constructor Starts ***/
    public LRPopup(ApexPages.StandardController controller) {
        showPopup=false;
        propstrlink = ApexPages.currentPage().getHeaders().get('Host');
        cseId = controller.getId();
        caseDetail();
        showHidePopup();
        propfullFileURL = URL.getSalesforceBaseUrl().toExternalForm();
    }
    /*** Constructor Ends ***/
    /** Functions Start **/
    public void caseDetail(){
        cse = [SELECT Id, CreatedDate,Status, LastModifiedDate FROM Case WHERE Id =: cseId Limit 1] ;                     
        
    }
    public pageReference createLink(){
        PageReference pg;
        pg = New PageReference(propfullFileURL+'/apex/LRIframe') ;
        return pg;   
    }
    public void showHidePopup(){ 
        
    }
    public void closeCase(){
        
    }
}// Class Ends