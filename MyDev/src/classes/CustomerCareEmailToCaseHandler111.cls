/**
 * This class is used to retrieve the incoming email from customer.care mailbox and all other alias and create cases in salesforce.com
 * 
 */
global class CustomerCareEmailToCaseHandler111 implements Messaging.InboundEmailHandler {
    protected Case theCase = null;
    public Messaging.InboundEmail inboundEmail;

    /**
     * This method is the entry point of an incoming email.
     */
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = processInboundEmail( email );
        sendHeaderEmail(email,envelope);
        return result;   
    }

    /**
     * This method is used send an email with all the headers information to the admin users.
     *
     */
    public static void sendHeaderEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        String headerInfo = '<html><body><table border="1"><tr><td><b>Header</b></td><td><b>Header Value</b></td></tr>';
        String htmlTable = '';
        // iterating the headers and adding the header value into a html table
        for (Messaging.InboundEmail.Header header : email.headers) {
            System.debug(header.name + ' === ' + header.value);
            htmlTable =  htmlTable + ' <tr> <td>' + header.name + '</td><td> ' + header.value + '</td></tr>';
            
        }
        String body = '';
        body = email.htmlBody != null ? email.htmlBody : '';
        body = email.plainTextBody != null ? email.plainTextBody : ''; 
        System.debug('HTML Email Body == ' + email.htmlBody);
        System.debug('Plan HTML Body == ' + email.plainTextBody);
        htmlTable =  htmlTable + '<tr><td> Email body </td><td>' + body + '</td></tr>';
        headerInfo = headerInfo + htmlTable + ' </body></html>';
        String[] toaddress = new String[]{};
        // Add the admin users the email to be send
        toaddress.add('harvin.vincent@efi.com');
        toaddress.add('Subapriya.Anandan@efi.com');
        toaddress.add('Glenn.Auyoung@efi.com');  
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(toaddress);
        mail.setsubject('Customer Care Email Handler Header Info');
        mail.setHTMLBody(headerInfo);
        // Sending email
        //Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });    
    }

    /**
     * This method is used to process the incoming email and create cases in salesforce.om
     *  (i) getting the record type of customer care 
     *  (ii) Checks Subject contains *NEW ORDER* key word
     *  (iii) Retriving case thread id if it exists (iv) locating the existing cases
     *  (iv) If the email contains the keyword 'fw:','re:', 'automatic reply:', 'out of office autoreply:', 'out of office', then attach to an exiting case
     *  (v) Identify the contact based on the email address, if contact found then attach to the case
     *  (vi) Set the assignment rules 
     *  (vii) Create the case record
     *  (viii) Create an email message to add the email contents and attachment in the email
     */
    public Messaging.InboundEmailResult processInboundEmail(Messaging.InboundEmail email) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        result.success = true;
        this.inboundEmail = email;
        String caseNumber = null;
        String subjectString = email.subject;
        subjectString = subjectString != null ? subjectString.toUpperCase() : '';
        System.debug(subjectString + ' === subjectString');
        String orderString = '*NEW ORDER*';
        String newRequest = '*NEW REQUEST*';
        // Modified for Parts Order
        List<String> list_subjecttoavoid = new List<String>();
        List<String> list_newcaseString = new List<String>();
        for(Email_Subject_To_Exclude__c obj : Email_Subject_To_Exclude__c.getall().values()) {
            if (obj.From_Address__c == 'customercare') {
                System.debug(obj.Subject_to_exclude__c + ' === ' + obj.Subject_to_include__c + ' === ');
                if (obj.Subject_to_exclude__c != null && obj.Subject_to_exclude__c.trim() != '') {
                    list_subjecttoavoid.add(obj.Subject_to_exclude__c);
                }
                if (obj.Subject_to_include__c != null && obj.Subject_to_include__c.trim() != '') {
                    list_newcaseString.add((obj.Subject_to_include__c).toUpperCase());
                }
                
            }
        }
        Boolean isNewCase = false;
        for(String key : list_newcaseString) {
            System.debug(key + ' === ' + subjectString);
            if (subjectString.indexOf(key) != -1) {
                isNewCase = true;
                break;
            }
        }
        // Modified for Parts Order
        // Retrieving the record type
        RecordType oRecordType = [Select Id From RecordType Where SobjectType='Case' And Name='my record'];
        // checking the subject if it contains *NEW ORDER*
        if (isNewCase) {
            caseNumber = null;   
        } else {
            // retrive the reference no, if the case have thread id
            caseNumber = extractRef(email.subject);
        }
        System.debug('Case Number == ' +   caseNumber);
        if (caseNumber != null) {
             // if the thread id not null, retrieve the case by using number
             this.theCase = locateByCaseNumberAsString(caseNumber);
        } else {
             // this logic checks if the subject contains the 'fw:','re:', 'automatic reply:', 'out of office autoreply:', 'out of office' keyword 
             String[] prefixes = new String[] {'fw:','re:', 'automatic reply:', 'out of office autoreply:', 'out of office'};  
             String target = email.subject.toLowerCase();
             Boolean isPrefix = false;
             for(String prefix: prefixes) {
                Integer index = target.indexOf(prefix); 
                if(index == 0 ){
                    isPrefix = true;
                }  
             }
             System.debug(isPrefix + ' === prefix');
            if (isPrefix) {
                Boolean isMatchingCase = false;
                String subjectWithoutPrefix = checkREorFW(email.subject);
                Contact[] contacts = [SELECT Id, Name, AccountId, Email,Language_Preference__c FROM Contact WHERE Email = :email.fromAddress];
                // determine case if exact match of contact
                if (contacts != null && contacts.size() > 0) {
                    String accountId = contacts.get(0).AccountId;

                    // identify the existing case based on the subject
                    Case[] matchingCases = [Select Id, CaseNumber, Subject, Description from Case where Subject = :subjectWithoutPrefix And RecordTypeId=:oRecordType.Id
                                    and AccountId=:accountId And Origin='Email-Customer.Care@efi.com' Order by CreatedDate desc];
                    System.debug(subjectWithoutPrefix + 'email.subject' + email.subject);
                    if(matchingCases.size() > 0) {
                        this.theCase = matchingCases[0];
                        isMatchingCase = true;
                    } else {
                        matchingCases = [Select Id, CaseNumber, Subject, Description from Case where Subject = :email.subject And RecordTypeId=:oRecordType.Id
                                    and AccountId=:accountId And Origin='Email-Customer.Care@efi.com' Order by CreatedDate desc];
                        System.debug(subjectWithoutPrefix + 'email.subject' + email.subject);
                        if(matchingCases.size() > 0) {
                            this.theCase = matchingCases[0];
                            isMatchingCase = true;
                        }
                    }
                }
                // determine case match of email domain
                if (!isMatchingCase) {
                    String fromAddress = email.fromAddress;
                    if (fromAddress != null && fromAddress.indexOf('@') != -1) {
                        fromAddress = fromAddress.substring(fromAddress.indexOf('@'));
                        System.debug('fromAddress =' + fromAddress);
                        fromAddress = '%'+ fromAddress;
                        List<Contact> list_contact = [Select Id,AccountId From Contact Where Email like:fromAddress limit 1];
                        System.debug(list_contact);
                        String accountId = '';//contacts.get(0).AccountId;
                        if (list_contact != null && list_contact.size() > 0) {
                            accountId = list_contact.get(0).AccountId;
                            // identify the existing case based on the subject
                            Case[] matchingCases = [Select Id, CaseNumber, Subject, Description from Case where Subject = :subjectWithoutPrefix And RecordTypeId=:oRecordType.Id
                                            and AccountId=:accountId And Origin='Email-Customer.Care@efi.com' Order by CreatedDate desc];
                            System.debug(subjectWithoutPrefix + 'email.subject' + email.subject);
                            if(matchingCases.size() > 0) {
                                this.theCase = matchingCases[0];
                                isMatchingCase = true; 
                            } else {
                                matchingCases = [Select Id, CaseNumber, Subject, Description from Case where Subject = :email.subject And RecordTypeId=:oRecordType.Id
                                            and AccountId=:accountId And Origin='Email-Customer.Care@efi.com' Order by CreatedDate desc];
                                System.debug(subjectWithoutPrefix + 'email.subject' + email.subject);
                                if(matchingCases.size() > 0) {
                                    this.theCase = matchingCases[0];
                                    isMatchingCase = true;
                                }
                            }
                        }
                    }
                }
                // determine case match of email domain subject only
                if (!isMatchingCase) {
                    // identify the existing case based on the subject
                    Case[] matchingCases = [Select Id, CaseNumber, Subject, Description from Case where Subject = :subjectWithoutPrefix And RecordTypeId=:oRecordType.Id
                        and CreatedDate = LAST_N_DAYS:5 And Origin='Email-Customer.Care@efi.com'];
                    System.debug(subjectWithoutPrefix + 'email.subject' + email.subject);
                    if(matchingCases.size() > 0) {
                        this.theCase = matchingCases[0];
                        isMatchingCase = true;
                    } else {
                        matchingCases = [Select Id, CaseNumber, Subject, Description from Case where Subject = :email.subject And RecordTypeId=:oRecordType.Id
                        and CreatedDate = LAST_N_DAYS:5 And Origin='Email-Customer.Care@efi.com'];
                        System.debug(subjectWithoutPrefix + 'email.subject' + email.subject);
                        if(matchingCases.size() > 0) {
                            this.theCase = matchingCases[0];
                            isMatchingCase = true;
                        }
                    }
                }
                if (!isMatchingCase) {
                    this.theCase = null;
                }
            }
        }
        if(this.theCase == null) {
              this.theCase = new Case();
              theCase.SuppliedEmail = email.fromAddress;
              theCase.SuppliedName = email.fromName;
              theCase.Status = '01 - New';
              theCase.Priority = 'P3';
              theCase.OwnerId = UserInfo.getUserId();
              theCase.Origin = 'Email-Customer.Care@efi.com';
              String subjectString1 = email.subject;
              subjectString1 = subjectString1 != null ? subjectString1.toUpperCase() : '';
              System.debug(subjectString1 + ' === subjectString1');
              String contentLanguage = '';
              if (contentLanguage == '') contentLanguage = 'English'; 
              orderString = '*NEW ORDER*';
          newRequest = '*NEW REQUEST*'; 
              // if the subject contains *NEW ORDER* then retrive the email body/subject without the thread id
              if (subjectString1.indexOf(orderString) != -1 || subjectString1.indexOf(newRequest) != -1) {
                    if (email.subject != null && email.subject.indexOf('[ ref:_') != -1) {
                        theCase.Subject = email.subject.substring(0, email.subject.indexOf('[ ref:_'));
                    }
                    if (email.plainTextBody != null && email.plainTextBody.indexOf('ref:_') != -1) {
                        theCase.Description = email.plainTextBody.substring(0, email.plainTextBody.indexOf('ref:_'));
                    }

              } else {
                    theCase.Subject = email.Subject;
                    theCase.Description = email.plainTextBody;
              }
              theCase.recordTypeId = oRecordType.Id;
              // retrive the contact based on the email address
              Contact[] contacts = [SELECT Id, Name, AccountId, Email,Language_Preference__c FROM Contact WHERE Email = :email.fromAddress];
              if( contacts.size() >0 ) {
                Contact theContact = contacts[0];
                theCase.ContactId = theContact.Id;
                theCase.AccountId = theContact.AccountId;   
                theCase.language__c = theContact.Language_Preference__c;   
                if ( contacts.size() > 1 ) {
                    // Could-Should create a new Case here to get CS to resolve this....
                    theCase.Description = 'Note: there is more than on Contact with this email address. Fix this. ' + theCase.Description;
                }
            } else {
                theCase.language__c = contentLanguage;
            }
            // set the assignment rules
            AssignmentRule AR = new AssignmentRule();
            AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
            Database.DMLOptions dmlOpts = new Database.DMLOptions();
            dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
            dmlOpts.EmailHeader.triggerAutoResponseEmail = true;   
            theCase.setOptions(dmlOpts);
            // insert the case
            insertSObject(this.theCase);
            /*Database.DMLOptions dlo = new Database.DMLOptions();
            dlo.assignmentRuleHeader.assignmentRuleId= AR.id;
      dlo.EmailHeader.triggerAutoResponseEmail = true;
      database.insert(this.theCase, dlo);*/
            
        } 
        // create an email message record and map it into the case
        createEmailMessage(theCase,email);
        return result;
    }

    /*
     * This method is a common method to insert the record
     */
    public void insertSObject(sObject obj) {
        try {
                insert obj;
        } catch (System.DmlException e) {
            handleError(e, 'Could not insert obj '+ obj);
        }
    }
    
    /**
     * This method is used to create an email message and map it into the case record
     */
    public void createEmailMessage(Case theCase, Messaging.InboundEmail email) {
        String value;
        Integer maxlength;
        EmailMessage theEmail = new EmailMessage();
        theEmail.ParentId = theCase.Id;
        theEmail.Incoming = true;
        theEmail.Status = '0';
        Schema.DescribeFieldResult F = EmailMessage.HtmlBody.getDescribe();
        //.HtmlBody.getDescribe();
        maxlength = F.getLength();
        theEmail.Subject = limitLength(email.Subject, EmailMessage.Subject.getDescribe().getLength());
        theEmail.MessageDate = datetime.now();
        theEmail.HtmlBody = limitLength(email.htmlBody,EmailMessage.HtmlBody.getDescribe().getLength());  
        theEmail.TextBody = limitLength(email.plainTextBody,EmailMessage.TextBody.getDescribe().getLength());
        // retrive the from address
        /* **** To */
        value = '';
        if(email.toAddresses != null) {
            Boolean seenOne= false;
            for(String to : email.toAddresses) {
                if(seenOne) {
                    value += ';\n';
                }
                to  = extractAddress(to);
                system.debug('ToAddress: ' + to);
                value += to;
                seenOne = true;
            }
        }
        theEmail.ToAddress = limitLength(value,EmailMessage.ToAddress.getDescribe().getLength());
 
        /* **** From */
        theEmail.FromName = email.fromName;
        theEmail.FromAddress = email.fromAddress;
         // retrive the CC address
        /* **** CC */
        value = '';
        if(email.ccAddresses != null) {
            Boolean seenOne= false;
            for(String cc : email.ccAddresses) {
                if(seenOne) {
                    value += ';\n';
                }
                cc  = extractAddress(cc);
                system.debug('CcAddress: ' + cc);
                value += cc;
                seenOne = true;
            }
        }
        theEmail.CcAddress = limitLength(value,EmailMessage.CcAddress.getDescribe().getLength()); 
        // create an email message
        insertSObject(theEmail);
        // if the email contains any attachments then this method will attach the attachments
        handleEmailAttachments(theEmail, email);
    }

    /**
     * This utility method is used to return the string for a specify no of characters.
     */
    public String limitLength(String input, Integer maxLength) {
        String results;
        if(input != null && input.length() > maxLength)
          results = input.substring(0,maxLength);
        else 
          results = input;
        return results;
    }

    /**
     * This method is used to check if the incoming email has attachment, if the email has attachment then add the attachment to an email message.
     */
    public void handleEmailAttachments(EmailMessage theEmailMessage, Messaging.InboundEmail email) {
         if(email.textAttachments!=null && email.textAttachments.size() >0) { 
          // checking for an incoming email have text attachments
          for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {
            Attachment attachment = new Attachment();  
            attachment.Name = tAttachment.fileName;
            attachment.Body = Blob.valueOf(tAttachment.body);
            System.debug('Attachment Content Type === ' + tAttachment.mimeTypeSubType);
            attachment.ParentId = theEmailMessage.Id;
            insertSObject(attachment);
          }
         }
         
         if(email.binaryAttachments!=null && email.binaryAttachments.size() >0) {
             // checking for an incoming email have binary attachments
          for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments) {
            Attachment attachment = new Attachment();
            attachment.Name = bAttachment.fileName;
            attachment.Body = bAttachment.body;
            System.debug('Attachment Content Type binary === ' + bAttachment.mimeTypeSubType);
            attachment.ParentId = theEmailMessage.Id;
            insertSObject(attachment);
          }
         } 
    }

    /**
     * This method is used send if there was an error/exception.
     * 
     */
    public void handleError(System.DmlException e,  String message){
        String baseURL = URL.getSalesforceBaseUrl().toExternalForm() + '/';
        system.debug(baseURL);
        String caseURL;  
        String msg = message + '\n';
        if(this.theCase != null)        {
            caseURL = baseURL + theCase.Id;
            msg += '\n';
            msg += 'Originating Case Number: ' + theCase.CaseNumber + '  '+ caseURL+'\n';   
        }
        // currently it is commented
        /*if(this.inboundEmail != null) {
            msg += '\nEmail:';
            msg += '  subject: ' + inboundEmail.Subject + '\n'; 
            msg += '  from: ' + inboundEmail.FromName + '\n'; 
            msg += '  address: ' + inboundEmail.FromAddress + '\n'; 
        }
        if(e != null) { // compose the DmlException message on one line to minimize the number of untested lines.  AFAIK easy to instantiate a DmlException in a unit test. 
            msg += '\n';
            msg += 'EXCEPTION:\n  Error: ' + e.getMessage() + '\n  Type: ' + e.getTypeName() + '\n  Line Number: ' + e.getLineNumber() + '\n  Trace:\n' + e.getStackTraceString() + '\n(end stack trace)\n';
        }*/ 

    }

    /*
     * This method is used to retrive the case based on the case number
     */
    public Case locateByCaseNumberAsString(String caseNumberStr){
        Integer target = Integer.valueOf(caseNumberStr);
        Case theResult = null;
        String caseNumber = '%' + String.valueOf(target);
        Case[] matchingCases = [Select Id, CaseNumber, Subject, Description from Case where CaseNumber like :caseNumber Limit 50000];
        for(Case aCase: matchingCases) {
            Integer cnum = Integer.valueOf(aCase.CaseNumber);
            if(cnum == target) {
                theResult = aCase;
                break;
            }
        }
        return theResult;
    }
    
    /**
     * This method is used to extract the case reference no(Thread Id)
     *
     */
    public String extractRef(String emailSubject) {
         String itemRef = null;
         String target = emailSubject.toLowerCase();
         String patternString;
         Pattern thePattern;
         Matcher matcher;

         System.debug('Reference === :  ' + emailSubject);
        // Pattern String is different from sandbox and production
        // for sandbox the patternstring string will be : '.*ref:(.{12}).(.{5})(.+):ref.*'; 
        // for production the patternstring will be : '.*ref:(.{11}).(.{5})(.+):ref.*'; 
        patternString = '.*ref:(.{11}).(.{5})(.+):ref.*'; 
        thePattern = Pattern.compile(patternString);
        matcher = thePattern.matcher(emailSubject);
        // patternString = '.*ref:(.{8}).(.{8})(.+):ref.*';
        // thePattern = Pattern.compile(patternString);
        // matcher = thePattern.matcher(emailSubject); // do not change to lower case for this test because Id's are case sensitive

        if (matcher.matches()) {
            System.debug(' Inside the if loop ' + matcher.matches());
            String caseIdLen = matcher.group(2)+matcher.group(3);
            caseIdLen = caseIdLen.trim();
            System.debug('caseIdLen' + caseIdLen.length());
            String noOfZero = '';
            if (caseIdLen.length() == 11) {
                noOfZero = '0000';
            } else if (caseIdLen.length() == 10) {
                noOfZero = '00000';
            } else if (caseIdLen.length() == 9) {
                noOfZero = '000000';
            }  else if (caseIdLen.length() == 12) {
                noOfZero = '000';
            }
            //String caseId = matcher.group(2) + '0000' + matcher.group(3);
            String caseId = matcher.group(2) + noOfZero + matcher.group(3);
            //String caseId = matcher.group(2) + '0000' + matcher.group(3);
            System.debug('Case Id === ' + caseId);
            system.debug(Logginglevel.ERROR,'extractRef "' + caseId + '"');
            // locate the case based on the thread id
            Case[] matchingCases = [Select CaseNumber from Case where Id = :caseId];
            if(matchingCases.size() == 1) {
                Case theCase = matchingCases[0];
                itemRef = theCase.CaseNumber;
            }    
        }  
        if(itemRef == null) {
            // extract the Case Number from the email Subject
            // Re: Test two numbers Case: 30088 and Case: 30089'
            // returns 30089, the last pattern matched
            patternString = '.*case[;:=]?\\s*([0-9]+).*';
            thePattern = Pattern.compile(patternString);
            matcher = thePattern.matcher(target);
      
            if (matcher.matches()) {
                itemRef = matcher.group(1);
                system.debug('Extracted case number ' + itemRef); 
            }
        }

        return itemRef; 
    }
 
     /**
      * This method is used to extract the mail subject
      */
     public String extractMainSubject(String emailSubject) {
        if(emailSubject == null || emailSubject.length() < 3)
            return emailSubject;
        String[] prefixes = new String[] {'fw:','re:', 'automatic reply:', 'out of office autoreply:', 'out of office'};  
        String target = emailSubject.toLowerCase();
        for(String prefix: prefixes) {
            Integer index = target.indexOf(prefix); 
            if(index == 0 ){
                String mainSubject = emailSubject.substring(prefix.length(),emailSubject.length());
                return mainSubject.trim();
            }  
        }
        return emailSubject; 
    }
 
     /** 
      * This utility method is used to extract the address from the email
      */
     public String extractAddress(String inAddress) {
        String address;
        String patternString;
        Pattern thePattern;
        Matcher matcher;
        patternString = '.*<(.*)>.*';
        thePattern = Pattern.compile(patternString);
        matcher = thePattern.matcher(inAddress);
        if (matcher.matches()) {
            address = matcher.group(1);
            system.debug('Extracted address ' + address); 
        } else {
            address = inAddress;
            system.debug('Did not match angle-address ' + address);   
        }
        return address;
     }

     /**
      * This method is used to retrive email subject, if the email subject contains this keywords 'fw:','re:', 'automatic reply:', 'out of office autoreply:', 'out of office'
      * (i)  Create a map all the key strings as key and no of characters of the key strings as value
      * (ii) iterate the key strings and identify if the subject contains the key string
      * (iii) if the subject contains the prefixes then remove the prefixes from the subject
      */
     public static String checkREorFW(String subject) {
        String[] prefixes = new String[] {'fw:','re:', 'automatic reply:', 'out of office autoreply:', 'out of office'};
        Map<String, Integer> map_prefix = new Map<String, Integer>();
        map_prefix.put('fw:',3);
        map_prefix.put('re:',3);
        map_prefix.put('automatic reply:',16);
        map_prefix.put('out of office autoreply:',24);
        map_prefix.put('out of office',13);
        String subjectWithoutPrefix = '';
        String subjectNew = subject.trim();
        subjectWithoutPrefix = subject.trim();
        Boolean isPrefix = false;
        for(String prefix: prefixes) {
            subjectNew = subjectNew.toLowerCase();
            Integer index = subjectNew.indexOf(prefix);
            if (index != -1) {
                isPrefix = true;
                subjectWithoutPrefix = subjectWithoutPrefix.substring(subjectWithoutPrefix.lastIndexOfIgnoreCase(prefix)+map_prefix.get(prefix));
            }
            subjectNew = subjectWithoutPrefix.trim();
        }
        return subjectWithoutPrefix.trim();
    }

}