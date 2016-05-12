public class BankAcct {
 // TODO: Declare a private integer attribute called balance initalize to zero
 private integer balance=0;

 // TODO: Declare a public string attribute called acctName
 public string acctName;

 //Declare a public string attribute called accttype
 public string accttype;


 //TODO: Declare a method named makeDeposit that does not return anything and one input parameter of type integer called deposit
 public void makeDeposit (integer deposit){
                //TODO: Add the deposit input parameter to the balance attribute
  		balance = balance + deposit;
 }

 //Declare a method named getBalance that returns an integer and no input parameter	
 public integer getBalance(){
          //Return the balance attribute
	  return balance;
 }
}