@isTest
public class TestData {
    /**
      * Creates Standard User records with default values.
      * @param  doInsert   Indicates if returned record are stored in DB
      * @return            User List
      */
    @TestVisible public static User createUser(Boolean doInsert) {
         User user = (User)
                SObjectFactory.createSObject( new User(),
                        StandardFieldDefaults.CLASS_NAME, 'userDefault' );
        if (doInsert) insert user;
        return user;
    }

    /**
      * Creates Standard User records with default values.
      * @param  doInsert   Indicates if returned record are stored in DB
      * @return            User List
      */
    @TestVisible public static List<User> createUserList(Boolean doInsert, 
        Integer numOfObjects) {
        List<User> userList = (List<User>)
                SObjectFactory.createSObjectList( new User(), 
                        numOfObjects, StandardFieldDefaults.CLASS_NAME, 
                        'userDefault' );
        if (doInsert) insert userList;
        return userList;
    }
}
