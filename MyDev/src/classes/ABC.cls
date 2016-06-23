global  class  ABC{

 InnerClassToDelete innerDelete=new InnerClassToDelete();
 public ABC(){
 innerDelete.delAttachAndNote();
 }
 
 
    
    public with sharing class InnerClassToDelete{
       
        public void delAttachAndNote(){
            try{
                
                List<Account> acc=[SELECT ID from Account LIMIT 1];

         system.debug('acc:: '+acc);

         Database.delete(acc);
            }catch(DmlException e){
          
                System.debug(e);
            }
        }
        
      
       
 
 }
    }