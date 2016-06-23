@RestResource(urlMapping='/yobabe/*')
global class MyTestService{


public MyTestService(){





}


@httpget

global static list<Lead> getAllLead(){

List<Lead> company = [Select ID, Name from Lead ];

return company;

}










}