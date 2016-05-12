public with sharing class Xtra_CheckStringEqualsController {

public String getStringEqualsIsCaseSensitive() {

String myString1 = 'abcd';
String myString2 = 'ABCD';



if(myString1 == myString2 ){
return 'true';

}
else {

return 'false';

}


/*
if(myString1.equalsIgnoreCase(myString2 )){


return 'true';


}
else {


return 'false';

}*/

/*if(myString1.equals(myString2 )){


return 'true';


}
else {


return 'false';

}*/
//return '\'STRING\' == \'string\'? ' + ('STRING' == 'string');
}


}