public with sharing class AccountListAuraController {
    @AuraEnabled
    
    public static List<Account> getAccounts(){
        
        
        return[Select name,id from Account];
        
    }

}