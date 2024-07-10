Class {
	#name : 'CMIntegrationTest',
	#superclass : 'TestCase',
	#instVars : [
		'contactManager',
		'app',
		'nameContact1',
		'nameContact2',
		'vcard1',
		'vcard2',
		'presenter',
		'vcardManager'
	],
	#category : 'ICal-VCard-UI-Tests',
	#package : 'ICal-VCard-UI-Tests'
}

{ #category : 'running' }
CMIntegrationTest >> setUp [

	super setUp.
	contactManager := ICVCardManager new.
	app := ICVCardApp new.
	presenter := app newPresenter: ICVCardMainPresenter.
	vcardManager := presenter contactList vcardManager.

	nameContact1 := ICName new
		                givenName: 'Julie';
		                familyName: 'Mangui'.

	nameContact2 := ICName new
		                givenName: 'Fafa';
		                familyName: 'Poitier'.

	vcard1 := ICVCard new.
	vcard1
		name: nameContact1;
		addPhoneNumber: (ICPhoneNumber new number: '0514887520');
		addAddress: (ICAddress new
				 street: '18 rue Volet';
				 postalcode: '54510';
				 region: 'Charmont').

	vcard2 := ICVCard new.
	vcard2
		name: nameContact2;
		addPhoneNumber: (ICPhoneNumber new number: '0310225863')
]

{ #category : 'tests' }
CMIntegrationTest >> testAddContact [

	| nameContact |
	nameContact := ICName new
		               familyName: 'claire';
		               givenName: 'lune'.

	contactManager    
		addContactName: nameContact
		phoneNumber1: '05664'
		address: '50 rue pont, 78000 bg'
		email: 'lune@gmail.com'
		birthday: '08-01-2000'
		phoneNumber2: ''
		photo: 'inria.png'.

	self assert: contactManager contacts size equals: 1
]

{ #category : 'tests' }
CMIntegrationTest >> testAddContact2 [

	| nameContact |
	nameContact := ICName new
		               familyName: 'claire';
		               givenName: 'lune'.

	contactManager addContact: vcard1.

	self assert: contactManager contacts size equals: 1
]

{ #category : 'tests' }
CMIntegrationTest >> testContactDeletion [

]

{ #category : 'tests' }
CMIntegrationTest >> testContactExport [

	| contacts lastContact |
	vcardManager addContact: vcard1.
	contacts := vcardManager readContactSton:
		            'contacts.ston' asFileReference.
	lastContact := contacts last.
	self assert: lastContact equals: vcard1
]

{ #category : 'tests' }
CMIntegrationTest >> testContactGrouping [

]

{ #category : 'tests' }
CMIntegrationTest >> testContactHistory [
]

{ #category : 'tests' }
CMIntegrationTest >> testContactImport [

]

{ #category : 'tests' }
CMIntegrationTest >> testContactMerge [
]

{ #category : 'tests' }
CMIntegrationTest >> testContactNotifications [
	"Check that notifications related to contacts are appropriately triggered and handled within the contact manager"
]

{ #category : 'tests' }
CMIntegrationTest >> testContactOwnership [
]

{ #category : 'tests' }
CMIntegrationTest >> testContactPermissions [
]

{ #category : 'tests' }
CMIntegrationTest >> testContactSearch [

	| searchText1 searchText2 searchPresenter  result |
	searchPresenter := presenter contactsToolbar.

	searchText1 := 'Sarah'.
	result := searchPresenter filteredContactFor: searchText1.
	self assert: result size equals: 0.

	searchText2 := 'jjj'.
	result := searchPresenter filteredContactFor: searchText2.
	self assert: result size equals: 0
]

{ #category : 'tests' }
CMIntegrationTest >> testContactSharing [

]

{ #category : 'tests' }
CMIntegrationTest >> testContactSorting [

]

{ #category : 'tests' }
CMIntegrationTest >> testContactValidation [
]

{ #category : 'tests' }
CMIntegrationTest >> testDuplicateContactPrevention [

]

{ #category : 'tests' }
CMIntegrationTest >> testListContacts [

]

{ #category : 'tests' }
CMIntegrationTest >> testRemoveContact [
	"Test removing a single contact in the contact manager"

	contactManager addContact: vcard1.

	contactManager removeContact: (contactManager contacts at: 1).
	self assert: contactManager contacts isEmpty
]

{ #category : 'tests' }
CMIntegrationTest >> testRetrieveContact [
	"Test obtaining a contact object"

]

{ #category : 'tests' }
CMIntegrationTest >> testUpdateContact [


]
