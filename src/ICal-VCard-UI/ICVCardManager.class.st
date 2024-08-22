"
`ICContactManager` is a class responsible for managing contacts. It allows for the addition, removal, and retrieval of contacts. Contacts are represented as instances of `ICVCard` class. This class provides methods to add contacts either individually or by providing a name, phone number, and email address.

## Usage examples

Adding a contact:
```
ICContactManager uniqueInstance 
	addContactName: 'John Doe' 
	phoneNumber: '1234567890' 
	email: 'john@example.com'.
```

Accessing contacts:
```
ICContactManager uniqueInstance contacts.
```

Removing a contact:
```
ICContactManager uniqueInstance removeContact: aContact
```
"
Class {
	#name : 'ICVCardManager',
	#superclass : 'Object',
	#instVars : [
		'contacts',
		'vcard',
		'vcardGenerator'
	],
	#classVars : [
		'UniqueInstance'
	],
	#classInstVars : [
		'contacts'
	],
	#category : 'ICal-VCard-UI-Core',
	#package : 'ICal-VCard-UI',
	#tag : 'Core'
}

{ #category : 'class initialization' }
ICVCardManager class >> initialize [

	self uniqueInstance reset
]

{ #category : 'instance creation' }
ICVCardManager class >> reset [
	<script>
	
	UniqueInstance := nil
]

{ #category : 'instance creation' }
ICVCardManager class >> uniqueInstance [

	^ UniqueInstance ifNil: [ UniqueInstance := self basicNew ]
]

{ #category : 'initialization' }
ICVCardManager >> addContact: aContact [

	self contacts add: aContact.
	self saveContactInSton
]

{ #category : 'adding' }
ICVCardManager >> addContactName: icName phoneNumber1: aString3 address: aString4 email: aString5 birthday: aString6 phoneNumber2: aString7 photo: aPicture [

	self addContact: (ICVCard new
			 name: icName;
			 addPhoneNumber: aString3;
			 addPhoneNumber: aString7;
			 addAddress: aString4;
			 addEmailAddress: aString5;
			 birthday: aString6;
			 photo: aPicture;
			 yourself).
		self saveContactInSton
]

{ #category : 'accessing' }
ICVCardManager >> contacts [
	^ contacts 
		ifNil: [ contacts := OrderedCollection new ]
]

{ #category : 'actions' }
ICVCardManager >> importContact [

	| contactsImported file |
	file := self selectFile.
	contactsImported := OrderedCollection new.
	(file extension = 'ston' ) ifTrue: [ contactsImported := self readContactSton:
		                    (file asFileReference )].
	

	contactsImported do: [ :contact | self addContact: contact ]
]

{ #category : 'writing' }
ICVCardManager >> readContactSton: aContactSton [

	
	^ STON reader
		  on: aContactSton readStream;
		  next
]

{ #category : 'accessing' }
ICVCardManager >> removeContact: anICVCard [

	self contacts remove: anICVCard.
	self saveContactInSton 
]

{ #category : 'initialization' }
ICVCardManager >> reset [

	UniqueInstance := nil.
]

{ #category : 'writing' }
ICVCardManager >> saveContactInSton [

	'contacts.ston' asFileReference writeStreamDo: [ :stream |
		STON writer
			on: stream;
			nextPut: (self contacts do: [ :each | each saveContactInSton ]) ] 
]

{ #category : 'accessing' }
ICVCardManager >> selectFile [ 

	| selectedFile |
	((selectedFile := StOpenFilePresenter new openModal) notNil and: [
		 selectedFile isFile ])
	ifTrue: [ ^ selectedFile ]
]

{ #category : 'accessing' }
ICVCardManager >> vcard [

	^ vcard ifNil: [ vcard := ICVCard new ]
]
