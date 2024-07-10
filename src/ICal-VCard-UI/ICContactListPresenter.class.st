"
This presenter provides the list of contacts that will be displayed. 

To start the application , please evaluate: 
``` 
ICContactListPresenter new open. 
``` 
"
Class {
	#name : 'ICContactListPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'contactList',
		'contactPresenter',
		'icGenerator'
	],
	#category : 'ICal-VCard-UI-Spec',
	#package : 'ICal-VCard-UI',
	#tag : 'Spec'
}

{ #category : 'operations' }
ICContactListPresenter >> addContact [

	| newContact |
	icGenerator := ICVCardGenerator new.
	contactPresenter := self instantiate: ICContactPresenter.
	contactPresenter openModal isOk ifFalse: [ ^ self ].

	newContact := self createNewContact.
	self updateItems

	
]

{ #category : 'operations' }
ICContactListPresenter >> createNewContact [

	self vcardManager
		addContactName: (icGenerator createName: (ICName new
					  givenName: contactPresenter name;
					  familyName: contactPresenter lastname;
					  yourself) asVCardString)
		phoneNumber1:
		(icGenerator createPhoneNumber: contactPresenter phoneNumber1)
		address: (icGenerator createAddress:
				 (ICAddress new street: contactPresenter address) asVCardString)
		email: (icGenerator createEmailAddress: contactPresenter email)
		birthday: contactPresenter birthday
		phoneNumber2:
		(icGenerator createPhoneNumber: contactPresenter phoneNumber2)
		photo: (icGenerator photo: contactPresenter photo)

]

{ #category : 'layout' }
ICContactListPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: contactList;
		  yourself
]

{ #category : 'initialization' }
ICContactListPresenter >> emailAddressesFor: contact [

	^ contact emailAddresses
		  inject: String empty
		  into: [ :acc :n | acc ifEmpty: [n address]
			ifNotEmpty: [ acc,  ', ' , n address ]  ]
]

{ #category : 'operations' }
ICContactListPresenter >> initialExtentForWindow [

	^ (840 @ 80) scaledByDisplayScaleFactor
]

{ #category : 'initialization' }
ICContactListPresenter >> initializePresenters [

	contactList := self newTable
		               addColumn: (SpStringTableColumn new
				                title: 'Fullname';
				                evaluated: [ :e | e fullname ];
				                yourself);
		               addColumn: (SpStringTableColumn new
				                title: 'Number(s)';
				                evaluated: [ :contact |
					                self phoneNumbersFor: contact ];
				                yourself);
		               addColumn: (SpStringTableColumn new
				                title: 'Address';
				                evaluated: [ :contact |
					                contact addresses joinUsing: ',' ];
				                yourself);
		               addColumn: (SpStringTableColumn new
				                title: 'Email';
				                evaluated: [ :contact |
					                self emailAddressesFor: contact ];
				                yourself);
		               addColumn: (SpStringTableColumn new
				                title: 'Birthday';
				                evaluated: #birthday;
				                yourself);
		               contextMenu: [
			               (self rootCommandsGroup / 'contact manager commands')
				               beRoot asMenuPresenter ];
		               whenSelectedItemChangedDo: [ :selection |
		               self owner updateDetail: selection ];
		               items: self vcardManager contacts;
		               yourself
]

{ #category : 'initialization' }
ICContactListPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		initialExtent: self initialExtentForWindow
]

{ #category : 'operations' }
ICContactListPresenter >> items: aCollection [
	"Shortcut method to set the receiver's plugins to aCollection"

	contactList items: aCollection
]

{ #category : 'initialization' }
ICContactListPresenter >> phoneNumbersFor: contact [

	^ contact phoneNumbers 
		  inject: String empty
		  into: [ :acc :n | acc ifEmpty: [n number]
			ifNotEmpty: [ acc,  ', ' , n number ]  ]
]

{ #category : 'operations' }
ICContactListPresenter >> removeContact [

	self vcardManager removeContact: self selectedContact.
	self updateItems
]

{ #category : 'accessing' }
ICContactListPresenter >> selectedContact [
	"Answer a <ICVCard> representing the currently selected contact"
	
	^ contactList selectedItem
	
]

{ #category : 'operations' }
ICContactListPresenter >> updateItems [

	contactList items: self vcardManager contacts.
	self updatePresenter
]

{ #category : 'operations' }
ICContactListPresenter >> vcardManager [

		^ ICVCardManager uniqueInstance
]
