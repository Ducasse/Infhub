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
		'vcard'
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

{ #category : 'class initialization' }
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
ICVCardManager >> processimportContactsFileSelection: aCollection [ 
	"Callback for processing import selection in aCollection. Answer how many contacts were imported"
	
	| importCount |
	
	importCount := 0.
	aCollection 
		select: [ : selectedFile | selectedFile extension = 'ston' ]
		thenDo: [ : selectedFile |
			(self readContactSton: selectedFile asFileReference)
				do: [ :contact | 
					importCount := importCount + 1.
					self addContact: contact ] ].
	^ importCount
	
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
ICVCardManager >> vcard [

	^ vcard ifNil: [ vcard := ICVCard new ]
]
