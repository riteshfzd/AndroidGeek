@IsTest
public class NotifyWsServiceTest
{
 static Case objCase;

 public static void createDefaultData()
 {
    
 }       
  
 public static testMethod void testNotifyWsSer()
 {
        
        
    
    }
   public static TestMethod void AsyncNotifyWSServicesUnitTest()
    {
                
        Test.startTest();
         Test.setMock(System.WebServiceMock.class, new MockWebServiceCalloutFuture());  
      //  Order__c order = [select id,M6_OrderId__c,PONR_Reached__c,Notes_Status_In_M6__c from Order__c where id=:odr.Id];
        javaComRitterSfdcM6Types.NotesRequest orderNotesRequest = new javaComRitterSfdcM6Types.NotesRequest();
        orderNotesRequest.NoteText = 'Test body for test method';
        orderNotesRequest.OrderId = '123';
        orderNotesRequest.OrderType = 'SO';
        orderNotesRequest.UserId = 'Test User for the Test method';
       
       System.Continuation continuation = new Continuation(3000);
      // continuation.continuationMethod = 'processResponse';
       AsyncComRitterSfdcM6Notes.updateSONotesResponse_elementFuture ob1 = new AsyncComRitterSfdcM6Notes.updateSONotesResponse_elementFuture(); 
       AsyncComRitterSfdcM6Notes.updateTTNotesResponse_elementFuture ob2 = new AsyncComRitterSfdcM6Notes.updateTTNotesResponse_elementFuture();
       AsyncComRitterSfdcM6Notes.AsyncNotifyWsPort ob3 = new AsyncComRitterSfdcM6Notes.AsyncNotifyWsPort();
       ob3.timeout_x = 2000;
       try{
       
       system.debug('before call updateSONotesResponse_elementFuture ');
       AsyncComRitterSfdcM6Notes.updateSONotesResponse_elementFuture objSORes = ob3.beginUpdateSONotes(continuation,orderNotesRequest);
        system.debug('after call updateSONotesResponse_elementFuture objSORes : '+objSORes );
        
       javaComRitterSfdcM6Types.NotesResponse noteRes = objSORes.getValue();
        system.debug('aftercall javaComRitterSfdcM6Types.NotesResponse noteRes : '+noteRes );
       }
       catch(exception ex)
       {
       
           System.debug('exception===>>'+ex);
       }
       //ob3.beginUpdateTTNotes(continuation,noteRequest);
       Test.stopTest();
        
    }
    
    public static void processResponse() {
        System.debug('%%%%%%%%%%%%%%%%% 2222222222 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% test ***********************************');
        //result = GetWeatherRequestService.getValue();
    }
}