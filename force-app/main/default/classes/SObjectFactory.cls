@isTest
public class SObjectFactory {
	public static final String CLASS_NAME = 'INVIVA_SObjectFactory';

	private static final String CLASS_NAME_ERROR = 'Invalid defaults class';

	private static final String UNSUPPORTED_CHARS = '__(c|C)$|__';

	/**
	 * Create record with default field values.
	 * Usable only for objects which has Field Defaults defined in this class.
	 * Doesn't perform insert.
	 * Usage: Account acc = (Account) SObjectFactory.createSObject(new Account());
	 * @param  obj Object for which you want to create new record.
	 * @return     SObject record with field defaults.
	 */
	public static SObject createSObject(SObject obj) {
		return createSObject( obj, CLASS_NAME );
	}

	/**
	 * Create record with default field values.
	 * Usable only for objects which has Field Defaults defined in this class.
	 * Insert performed on demand.
	 * Usage: Account acc = (Account) SObjectFactory.createSObject(new Account(), true);
	 * @param  obj      Object for which you want to create new record.
	 * @param  doInsert Indication if insert will be performed.
	 * @return          SObject record with field defaults.
	 */
	public static SObject createSObject(SObject obj,
			Boolean doInsert) {
		return createSObject( obj, CLASS_NAME, doInsert );
	}

	/**
	 * Create record with default field values.
	 * Doesn't perform insert.
	 * Usage: Account acc = (Account) SObjectFactory.createSObject(new Account(), CLASS_NAME);
	 * @param  obj              Object for which you want to create new record.
	 * @param  defaultClassName Class name which contains field defaults for requested object.
	 * @return                  SObject record with field defaults.
	 */
	public static SObject createSObject(SObject obj,
			String defaultClassName) {
		String objectName = String.valueOf( obj.getSObjectType() );
		String fieldDefaultClassImplementationName = objectName.replaceAll( UNSUPPORTED_CHARS, '' )
				+ 'Defaults';
		return createSObject( obj, defaultClassName, fieldDefaultClassImplementationName );
	}

	/**
	 * Create record with default field values
	 * Doesn't perform insert
	 * Usage: Account acc = (Account) SObjectFactory.createSObject(new Account(), CLASS_NAME, 'AccountDefaults');
	 * @param  obj                                 Object for which you want to create new record.
	 * @param  defaultClassName                    Class name which contains class with field defaults for requested object.
	 * @param  fieldDefaultClassImplementationName Class name which contains field defaults for requested object.
	 * @return                                     SObject record with field defaults.
	 */
	public static SObject createSObject(SObject obj,
			String defaultClassName,
			String fieldDefaultClassImplementationName) {
		String fieldDefaultClassName = defaultClassName
				+ '.'
				+ fieldDefaultClassImplementationName.replaceAll( UNSUPPORTED_CHARS, '' );
		Type t = Type.forName( fieldDefaultClassName );
		if (t == null) throw new SObjectFactoryException( CLASS_NAME_ERROR );
		SObjectFieldDefaults defaults = (SObjectFieldDefaults) t.newInstance();
		addFieldDefaults( obj, defaults.getFieldDefaults() );
		return obj;
	}

	/**
	 * Create record with default field values
	 * Insert performed on demand
	 * Usage: Account acc = (Account) SObjectFactory.createSObject(new Account(), CLASS_NAME, 'AccountDefaults', true);
	 * @param  obj                                 Object for which you want to create new record.
	 * @param  defaultClassName                    Class name which contains class with field defaults for requested object.
	 * @param  fieldDefaultClassImplementationName Class name which contains field defaults for requested object.
	 * @param  doInsert                            Indication if insert will be performed.
	 * @return                                     SObject record with field defaults.
	 */
	public static SObject createSObject(SObject obj,
			String defaultClassName,
			String fieldDefaultClassImplementationName,
			Boolean doInsert) {
		obj = createSObject( obj, defaultClassName, fieldDefaultClassImplementationName );
		if (doInsert) insert obj;
		return obj;
	}

	/**
	 * Create record with default field values.
	 * Insert performed on demand.
	 * Usage: Account acc = (Account) SObjectFactory.createSObject(new Account(), CLASS_NAME, true);
	 * @param  obj              Object for which you want to create new record.
	 * @param  defaultClassName Class name which contains field defaults for requested object.
	 * @param  doInsert         Indication if insert will be performed.
	 * @return                  SObject record with field defaults.
	 */
	public static SObject createSObject(SObject obj,
			String defaultClassName,
			Boolean doInsert) {
		SObject retObject = createSObject( obj, defaultClassName );
		if (doInsert) insert retObject;
		return retObject;
	}

/**
CREATE LIST
*/
	/**
	 * Create list of records with default values and iterated name field.
	 * Usable only for objects which has Field Defaults defined in this class.
	 * Doesn't perform insert.
	 * Usage: List<Account> accounts = (List<Account>) SObjectFactory.createSObjectList(new Account(), 10);
	 * @param  obj          Object for which you want to create new record.
	 * @param  numOfObjects Indicates number of records which will be created.
	 * @return              List of SObjects record with field defaults.
	 */
	public static List<SObject> createSObjectList(SObject obj,
			Integer numOfObjects) {
		return createSObjectList( obj, numOfObjects, (String) null );
	}

	/**
	 * Create list of records with default values and iterated name field.
	 * Usable only for objects which has Field Defaults defined in this class.
	 * Insert performed on demand.
	 * Usage: List<Account> accounts = (List<Account>) SObjectFactory.createSObjectList(new Account(), 10, true);
	 * @param  obj          Object for which you want to create new record.
	 * @param  numOfObjects Indicates number of records which will be created.
	 * @param  doInsert     Indication if insert will be performed.
	 * @return              List of SObjects record with field defaults.
	 */
	public static List<SObject> createSObjectList(SObject obj,
			Integer numOfObjects,
			Boolean doInsert) {
		return createSObjectList( obj, numOfObjects, (String) null, false );
	}

	/**
	 * Create list of records with default values and iterated name field.
	 * Doesn't perform insert.
	 * Usage: List<Account> accounts = (List<Account>) SObjectFactory.createSObjectList(new Account(), 10, CLASS_NAME);
	 * @param  obj              Object for which you want to create new record.
	 * @param  numOfObjects     Indicates number of records which will be created.
	 * @param  defaultClassName Class name which contains class with field defaults for requested object.
	 * @return                  List of SObjects record with field defaults.
	 */
	public static List<SObject> createSObjectList(SObject obj,
			Integer numOfObjects,
			String defaultClassName) {
		return createSObjectList( obj, numOfObjects, defaultClassName, (String) null );
	}

	/**
	 * Create list of records with default values and iterated name field.
	 * Insert performed on demand.
	 * Usage: List<Account> accounts = (List<Account>) SObjectFactory.createSObjectList(new Account(), 10, CLASS_NAME, true);
	 * @param  obj              Object for which you want to create new record.
	 * @param  numOfObjects     Indicates number of records which will be created.
	 * @param  defaultClassName Class name which contains field defaults for requested object.
	 * @param  doInsert         Indication if insert will be performed.
	 * @return                  List of SObjects record with field defaults.
	 */
	public static List<SObject> createSObjectList(SObject obj,
			Integer numOfObjects,
			String defaultClassName,
			Boolean doInsert) {
		List<SObject> retList = createSObjectList( obj, numOfObjects, defaultClassName );
		if (doInsert) insert retList;
		return retList;
	}

	/**
	 * Create list of records with default values and iterated name field.
	 * Insert performed on demand.
	 * Usage: List<Account> accounts = (List<Account>) SObjectFactory.createSObjectList(new Account(), 10, CLASS_NAME, 'AccountDefaults', true);
	 * @param  obj                                 Object for which you want to create new record.
	 * @param  numOfObjects                        Indicates number of records which will be created.
	 * @param  defaultClassName                    Class name which contains class with field defaults for requested object.
	 * @param  fieldDefaultClassImplementationName Class name which contains field defaults for requested object.
	 * @param  doInsert                            Indication if insert will be performed.
	 * @return                                     List of SObjects record with field defaults.
	 */
	public static List<SObject> createSObjectList(SObject obj,
			Integer numOfObjects,
			String defaultClassName,
			String fieldDefaultClassImplementationName,
			Boolean doInsert) {
		List<SObject> retList = createSObjectList( obj, numOfObjects, defaultClassName, fieldDefaultClassImplementationName );
		if (doInsert) insert retList;
		return retList;
	}

	/**
	 * Create list of records with default values and iterated name field.
	 * Doesn't perform insert.
	 * Usage: List<Account> accounts = (List<Account>) SObjectFactory.createSObjectList(new Account(), 10, CLASS_NAME, 'AccountDefaults');
	 * @param  obj                                 Object for which you want to create new record.
	 * @param  numOfObjects                        Indicates number of records which will be created.
	 * @param  defaultClassName                    Class name which contains class with field defaults for requested object.
	 * @param  fieldDefaultClassImplementationName Class name which contains field defaults for requested object.
	 * @return                                     List of SObjects record with field defaults.
	 */
	public static List<SObject> createSObjectList(SObject obj,
			Integer numOfObjects,
			String defaultClassName,
			String fieldDefaultClassImplementationName) {
		SObject newObj = createTemplateObject( obj, defaultClassName, fieldDefaultClassImplementationName );

		String objectName = String.valueOf( obj.getSObjectType() );
		String nameField = getNameField( objectName );
		Double rnd = Math.random();

		List<SObject> objects = new List<SObject>();
		for (Integer i = 0; i < numOfObjects; i++) {
			SObject clonedObj = newObj.clone( false, true );

			if (!isFieldAutoNumber( objectName, nameField )) {
				clonedObj.put( nameField, (String) clonedObj.get( nameField ) + ' ' + String.valueOf( rnd ) + i );
			}

			objects.add( clonedObj );
		}
		return objects;
	}

	/**
	 * Create Template record with field defaults based on parameters.
	 * If no fieldDefaultClassImplementationName is providing use SObject API Name to get FieldDefaults class
	 * If no defaultClassName is providing use SObjectFactory class as place to look for field defaults
	 * @param  obj                                 Which will be used as template
	 * @param  defaultClassName                    Class name which would be used to look for field defaults
	 * @param  fieldDefaultClassImplementationName Class containing field defaults for SObject
	 * @return                                     Template SObject with field defaults
	 */
	private static SObject createTemplateObject(SObject obj,
			String defaultClassName,
			String fieldDefaultClassImplementationName) {
		SObject newObj;
		if (String.isBlank( fieldDefaultClassImplementationName )) {
			if (String.isBlank( defaultClassName )) {
				newObj = createSObject( obj );
			} else {
				newObj = createSObject( obj, defaultClassName );
			}
		} else {
			newObj = createSObject( obj, defaultClassName, fieldDefaultClassImplementationName );
		}
		return newObj;
	}

	/**
	 * Get API name for Name field.
	 * @param  objectName SObject API Name for which you want to get Name field name
	 * @return            Name field API name
	 */
	private static String getNameField(String objectName) {
		String nameField = nameFieldMap.get( objectName );
		if (String.isBlank( nameField )) nameField = 'Name';
		return nameField;
	}

	/**
	 * Adds default values to record.
	 * @param obj      Record for which fields should be populated.
	 * @param defaults Field Defaults map.
	 */
	private static void addFieldDefaults(SObject obj, Map<Schema.SObjectField, Object> defaults) {
		Map<String, Object> populatedFields = obj.getPopulatedFieldsAsMap();
		for (Schema.SObjectField field : defaults.keySet()) {
			if (!populatedFields.containsKey( String.valueOf( field ) )) {
				obj.put( field, defaults.get( field ) );
			}
		}
	}

	/**
	 * Checks if Field on SObject is Autonumber
	 * @param  objectName Object API Name to use
	 * @param  nameField  Field API Name to check
	 * @return            if applies.
	 */
	private static Boolean isFieldAutoNumber(String objectName, String nameField) {
		return Schema.getGlobalDescribe().get( objectName ).getDescribe().fields.getMap().get( nameField ).getDescribe().isAutoNumber();
	}

	/**
	 * Contains SObjects with different API names for Name fields.
	 */
	private static Map<String, String> nameFieldMap = new Map<String, String>{
			'Contact' => 'LastName',
			'Case' => 'Subject'
	};

	/**
	 * Exception class.
	 */
	public class SObjectFactoryException extends Exception {
	}

/**
INTERFACE FOR DEFAULTS
*/
	/**
	 * Interface for Field Defaults.
	 * Contains getter which return Map<Schema.SObjectField, Object> with defaults.
	 */
	public interface SObjectFieldDefaults {
		Map<Schema.SObjectField, Object> getFieldDefaults();
	}
}