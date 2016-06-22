@isTest(SeeAllData=true)


public class SiteDetailRestServiceTest{

static testMethod void MySiteResourceDoGet() {

RestRequest req = new RestRequest(); 
RestResponse res = new RestResponse();

req.requestURI = 'https://cs19.salesforce.com/services/apexrest/SitetestInfo/';  
req.addParameter('SIFID', 'SIF385655');
req.httpMethod = 'GET';
RestContext.request = req;
RestContext.response = res;
Map<String, Object> resSiteDetails;
Object siteDetailsMap;

Map <String,String> responseMap=new Map <String,String>();

Test.startTest();
           REST_SiteDetailsRestService.getAllSiteInfo(); 
Test.stopTest();
        
resSiteDetails = (Map<String, Object>)JSON.deserializeUntyped(res.responseBody.toString());

siteDetailsMap=resSiteDetails.get('SiteDetails');

/*
String jsonstr = (String)JSON.serialize(resSiteDetails.get('SiteDetails'));

//String jsonstr = (String)JSON.serialize(parameters.get('SObject'));
SObject restoredAcme = (Site_Information_Form__c)JSON.deserialize(jsonstr, SiteDetail.class);
System.debug('jsonstr ::: '+jsonstr);
System.debug('restoredAcme ::: '+restoredAcme);
*/

Map<String, Object>siteDetailsMapFinal = (Map<String, Object>)siteDetailsMap;
System.debug('res.responseBody :: '+resSiteDetails + '   siteDetailsMap ::  ' +siteDetailsMap + '   ::: siteDetailsMapFinal ::  '+siteDetailsMapFinal.get('Account:Name'));


  

System.assertEquals(String.valueOf(siteDetailsMapFinal.get('Account__r.Name')),'Winwatt SA','Working');



}
}