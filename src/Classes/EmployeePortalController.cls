public class EmployeePortalController {
   	//private static Contact ContactDetails =[select id,name, Emergency_Contact__c from Contact];
    private static User userdetails = [select name,id from user where id=:userinfo.getuserid()];
    public static list<contact> c ;
    @AuraEnabled
    public static String getUserInfo() {
        //String userinfo[] = new String[]();
        //System.debug(userdetails);
        system.debug(userdetails.Name);
        return userdetails.Name;
    }
    
    @AuraEnabled
    public static id getUserFullInformation() {
        //System.debug(userdetails);
        Contact c = [select id FROM Contact WHERE Current_User_Contact__c=:userinfo.getUserId()];
        system.debug('Info is---' +c);
        return (c.id);
    }
    
    @AuraEnabled
    public static List<Certificate__c> getCertificateInformation() {
        //System.debug(userdetails);
        return  [select Name,Link__c,Valid_till__c from Certificate__c WHERE CreatedById =: userdetails.id];
    }
    
    @AuraEnabled
    public static List<Contact> getEmergencyContacts() {
        //System.debug(userdetails);
        Contact ContactDetails =[select id,name, Emergency_Contact__c from Contact where name=:userinfo.getname()];
        List<Contact> w = [select Name__c,email,phone,RelationShip__c FROM Contact where Emergency_Contact__c =: ContactDetails.id];
        //List<Contact> a= [select Name__c,email,phone,RelationShip__c FROM Contact where];
        system.debug(w);
         return w;
    }
    @AuraEnabled
    public static List<Contact> getContacts(String searchkeyword) {
        System.debug(searchkeyword);
        searchkeyword += '%';
        return [select Name,id,Total_No_of_Certificates__c FROM Contact WHERE name LIKE :searchkeyword];
    }
    
    @AuraEnabled
    public static List<Contact> getColleaguesDetails(String searchkeyid) {
        contact c = new Contact();
        System.debug(searchkeyid); 
        return [select id,Name,FirstName,LastName FROM Contact WHERE Id =: searchkeyid];
    }
    
    @Auraenabled
    public static Id addEmployeeCertificates(String certiname, String certifLink, date validtill){
        System.debug('passed values ' + certiname + ' '+certifLink);
        //System.debug(validtill);
        Date d = date.newInstance(2018, 11, 21);
        Certificate__c certiobj =  new Certificate__c();
        certiobj.Name = certiname;
        certiobj.Link__c = certifLink;
        certiobj.Valid_Till__c=d;
        certiobj.Contact_Certificates__c ='0037F00000gIeNhQAK';
        System.debug(certiobj);
        upsert certiobj;
        return certiObj.id;
    }
}