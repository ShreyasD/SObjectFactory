@isTest
public class StandardFieldDefaults {
    public static final String CLASS_NAME = 'StandardFieldDefaults';
    
    /**
    STANDARD SOBJECT DEFAULTS
    */

	/**
	 * Fields defaults for Account Standard SObject
	 */
	public class AccountDefaults implements SObjectFactory.SObjectFieldDefaults {
		public Map<Schema.SObjectField, Object> getFieldDefaults() {
			return new Map<Schema.SObjectField, Object>{
					Account.Name => 'Test Acct' + TestUtility.generateRandomNumberStr( 2 )
			};
		}
	}

	/**
	 * Fields defaults for Contact Standard SObject
	 */
	public class ContactDefaults implements SObjectFactory.SObjectFieldDefaults {
		public Map<Schema.SObjectField, Object> getFieldDefaults() {
			return new Map<Schema.SObjectField, Object>{
					Contact.FirstName => 'First',
					Contact.LastName => 'Last'
			};
		}
	}

	/**
	 * Fields defaults for Opportunity Standard SObject
	 */
	public class OpportunityDefaults implements SObjectFactory.SObjectFieldDefaults {
		public Map<Schema.SObjectField, Object> getFieldDefaults() {
			return new Map<Schema.SObjectField, Object>{
					Opportunity.Name => 'Test Opportunity',
					Opportunity.StageName => 'Closed Won',
					Opportunity.CloseDate => System.today()
			};
		}
	}

	/**
	 * Fields defaults for Case Standard SObject
	 */
	public class CaseDefaults implements SObjectFactory.SObjectFieldDefaults {
		public Map<Schema.SObjectField, Object> getFieldDefaults() {
			return new Map<Schema.SObjectField, Object>{
					Case.Subject => 'Test Case'
			};
		}
	}

	/**
	 * Fields defaults for User Standard SObject (using Standard HOG - General User profile)
	 */
	public class UserDefaults implements SObjectFactory.SObjectFieldDefaults {

		Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User'];

		public Map<Schema.SObjectField, Object> getFieldDefaults() {
			return new Map<Schema.SObjectField, Object>{
					User.EmailEncodingKey => 'UTF-8',
					User.LanguageLocaleKey => 'en_US',
					User.LocaleSidKey => 'en_US',
					User.TimeZoneSidKey => 'America/New_York',
					User.ProfileId => p.Id
			};
		}
	}
}
