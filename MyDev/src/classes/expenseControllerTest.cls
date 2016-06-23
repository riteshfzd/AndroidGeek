@isTest
public class expenseControllerTest
{
@isTest
Public static void expenseController_method()
{
 Test.startTest();
 // Run as User
 
  Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];

  User u = new User(Alias = 'standt', Email='SystemAdministrator@testorg.com', EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p.Id, TimeZoneSidKey='America/Los_Angeles', UserName='systemadmin@testorg.com');



  System.runAs(u) {
  
  Expense__c exp= new Expense__c();
           exp.Name='test1';
           exp.Amount__c=20; 
           exp.Client__c='abc';
           exp.Date__c=Date.Today();
           exp.Reimbursed__c=true;
           //exp.CreatedDate= Date.Today();
           insert exp;
           
           expenseController ct=new expenseController();
           expenseController.saveExpense(exp);
           expenseController.getExpenses();
           }
           Test.stopTest();
           
           }
           
           }