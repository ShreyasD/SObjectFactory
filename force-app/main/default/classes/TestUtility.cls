@isTest
public class TestUtility {
	/**
    * Static Utility Functions
    */
    /**
      * Generates a random number string
      * @param  length  number of characters to include in string
      * @return Random String
      **/
    @TestVisible public static String generateRandomNumberStr(Integer length) {
        Long l = Math.abs(crypto.getRandomLong());
        String lstr = String.valueOf(l);
        return (lstr.length() <= length) ? lstr.leftPad(length - lstr.length(), '0') :
            lstr.substring(0, length);
    }

    /**
      * Generates a random integer
      * @param  length  number of digits to include in integer
      * @return Random Integer
      **/
    @TestVisible public static Integer generateRandomNumber(Integer length) {
        return Math.abs(Crypto.getRandomInteger());
    }

    /**
      * Generates a fake id for an SObjectType
      * @param    objectType object to create fake id for
      * @return Random Id
      **/
    @TestVisible static Integer s_num = 1;
    @TestVisible public static String getFakeId(Schema.SObjectType objectType) {
        String result = String.valueOf(s_num++);
        return objectType.getDescribe().getKeyPrefix() +
                '0'.repeat(12-result.length()) + result;
    }
}
