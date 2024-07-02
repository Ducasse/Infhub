Class {
	#name : 'CMIntegrationTest',
	#superclass : 'TestCase',
	#instVars : [
		'contactManager',
		'app'
	],
	#category : 'ICal-VCard-UI-Tests',
	#package : 'ICal-VCard-UI-Tests'
}

{ #category : 'running' }
CMIntegrationTest >> setUp [

	super setUp.
	contactManager := ICVCardManager new.
	app := ICVCardApp new.
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
CMIntegrationTest >> testContactDeletion [

]

{ #category : 'tests' }
CMIntegrationTest >> testContactExport [
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

	| searchText1 searchText2 searchPresenter presenter result |
	presenter := app newPresenter: ICVCardMainPresenter.
	presenter initializePresenters.
	searchPresenter := presenter contactsToolbar.
	
	searchText1 := 'Sarah'.
	result := searchPresenter filteredContactFor: searchText1.
	self assert: result size equals: 0.
	
	searchText2 := 'john'.
	result := searchPresenter filteredContactFor: searchText2.
	self assert: result size equals: 1.
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
