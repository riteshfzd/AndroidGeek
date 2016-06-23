public class GetLastLogin

{

public static Datetime lastLoginDate{get;set;}

public static DateTime returnLastLogin(List<User> user){



User [] u = [SELECT LastLoginDate FROM User WHERE Id =:user[0].id];

lastLoginDate= u[0].LastLoginDate;

return lastLoginDate;



}





}