@RestResource(urlMapping='/SitetestInfo/*')
global with sharing class REST_SiteDetailsRestService {
    
    
    @HttpGet
    global static void getAllSiteInfo(){
        
        RestRequest req = RestContext.request; 
        RestResponse res = RestContext.response;
        String sIFId; //String to get Param
        Map<String,String> siteDeatilsResponse=new Map<String, String>(); // Map for Json Response
        sIFId=  req.params.get('SIFID');  
        Site_Information_Form__c  siteObject; // Object Return for Query
        String query= 'Select ';
        
        Map<String, SiteInfoSettings__c> allSiteFields = SiteInfoSettings__c.getAll();  // Get All records from Custom Settings
        Set<String> siteFields = new Set<String>(); // Preparing Set for all keys
        
        if(allSiteFields !=null && allSiteFields.size() > 0){ 
            System.debug(LoggingLevel.ERROR, 'Map Having all Custom Settings: allSiteFields ' + allSiteFields );
            siteFields.addAll(allSiteFields.keySet()); // Adding keys to Set to avoid duplicate
        }
        // Making Dynamic Query String for Execution
        if(siteFields !=null && siteFields.size() > 0 ){
            System.debug(LoggingLevel.ERROR, 'Set : siteFields ' + siteFields);
            for (String key :siteFields ){
                query=query+key+',';
                siteDeatilsResponse.put(key,'');
            }
            
        }
        siteFields.add('Projected_Dev_Stage_end_of_this_Year__c'); //Adding this value in code as api name  is large for custom seting range
        query=query+'Projected_Dev_Stage_end_of_this_Year__c From Site_Information_Form__c WHERE Name =:sIFId'; 
        System.debug('query to be run : ' + query);
        
        try{
            
            siteObject=database.query(query); // Query to get Object  As per req it will return single Object
            
            // Putting Value in Map for Json Return
            
            for(String key :siteFields){
                
                // Condition 1 for Relationship Field Handling 
                if(key.contains('.')){
                    String fieldValue = key.substringAfter('.'); //Getting Field Name
                    String relation = key.substringBefore('.'); // Getting Relationship Name
                    String relObjChild = (String)(siteObject.getSObject(relation)).get(fieldValue); // TypeCast to String
                    siteDeatilsResponse.put(key,relObjChild); // Putting Value in response Map
                    
                }
                
                
                else{
                    //Condition 2 or Normal Field apI handling
                    if(siteObject.get(key) != null){
                        
                        siteDeatilsResponse.put(key,String.valueOf(siteObject.get(key))); // Putting Value in response Map
                    }
                    
                }
                
            }  
            
            System.debug('Response Map  : ' + siteDeatilsResponse);
            JSONGenerator jsonResponse = JSON.createGenerator(true);
            jsonResponse.writeStartObject();
            jsonResponse.writeObjectField('SiteDetails',siteDeatilsResponse); // Writing Map as an Object
            jsonResponse.writeEndObject();
            String result = jsonResponse.getAsString();
            System.debug('Response String : ' + result );
            res.responseBody = blob.valueOf(result); // Writing Response
            
        }
        
        catch(Exception e) {
            
            String error = REST_QuoteServiceUtility.formatErrorMessage('Error :::  ' + e.getMessage(),'getAllSiteInfo()',REST_QuoteServiceUtility.errorCode.QUERY);
            res.responseBody = blob.valueOf(error);
            return;
            
        }
        
     
    }
    
}