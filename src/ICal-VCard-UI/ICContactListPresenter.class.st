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
		'contactPresenter'
	],
	#category : 'ICal-VCard-UI-Spec',
	#package : 'ICal-VCard-UI',
	#tag : 'Spec'
}

{ #category : 'operations' }
ICContactListPresenter >> addContact [

	contactPresenter := self instantiate: ICContactPresenter.
	contactPresenter openModal isOk ifFalse: [ ^ self ].

	self vcardManager    
		addContactName: contactPresenter name
		lastname: contactPresenter lastname
		phoneNumber1: contactPresenter phoneNumber1
		address: contactPresenter address
		email: contactPresenter email
		birthday: contactPresenter birthday
		phoneNumber2: contactPresenter phoneNumber2.

	self updateItems
]

{ #category : 'layout' }
ICContactListPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: contactList;
		  yourself
]

{ #category : 'operations' }
ICContactListPresenter >> initialExtentForWindow [ 

 ^ (900 @ 100) scaledByDisplayScaleFactor 
]

{ #category : 'initialization' }
ICContactListPresenter >> initializePresenters [

	contactList := self newTable 
		               addColumn: (SpStringTableColumn new
				                title: 'Fullname';
				                evaluated: #fullname;
				                yourself);
		               addColumn: (SpStringTableColumn new
				                title: 'Number(s)';
				                evaluated: [ :contact |
					                contact phoneNumbers joinUsing: ',' "collect: #phoneNumber" ];
				                yourself);
		               addColumn: (SpStringTableColumn new
				                title: 'Address';
				                evaluated: [ :contact |
					                contact addresses joinUsing: ',' "collect: #phoneNumber" ];
				                yourself);
		               addColumn: (SpStringTableColumn new
				                title: 'Email';
				                evaluated: [ :contact |
					                contact emailAddresses joinUsing: ',' "collect: #address" ];
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
