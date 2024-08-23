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

{ #category : 'commands' }
ICContactListPresenter >> contactListCmdGroup [

	^ CmCommandGroup forSpec
		  beRoot;
		  register:
			  ((CmCommandGroup named: 'contact manager commands') asSpecGroup
				   register: ((ICAddVCardCommand forSpecContext: self)
						    name: 'Add Contact';
						    iconName: #smallAdd;
						    shortcutKey: $A;
						    yourself);
				   register: ((ICRemoveVCardCommand forSpecContext: self)
						    name: 'Remove contact';
						    iconName: #smallDelete;
						    shortcutKey: $B;
						    yourself);
				   beDisplayedAsGroup;
				   yourself);
		  yourself
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

{ #category : 'private' }
ICContactListPresenter >> emailAddressesFor: contact [

	^ contact emailAddresses
		  inject: String empty
		  into: [ :acc :n | acc ifEmpty: [n address]
			ifNotEmpty: [ acc,  ', ' , n address ]  ]
]

{ #category : 'initialization' }
ICContactListPresenter >> initialExtentForWindow [

	^ (840 @ 80) scaledByDisplayScaleFactor
]

{ #category : 'initialization' }
ICContactListPresenter >> initializeContactListColumns [

	contactList
		addColumn: (SpStringTableColumn new
				 title: 'Fullname';
				 evaluated: [ :e | e fullname ];
				 yourself);
		addColumn: (SpStringTableColumn new
				 title: 'Number(s)';
				 evaluated: [ :contact | self phoneNumbersFor: contact ];
				 yourself);
		addColumn: (SpStringTableColumn new
				 title: 'Address';
				 evaluated: [ :contact | contact addresses joinUsing: ',' ];
				 yourself);
		addColumn: (SpStringTableColumn new
				 title: 'Email';
				 evaluated: [ :contact | self emailAddressesFor: contact ];
				 yourself);
		addColumn: (SpStringTableColumn new
				 title: 'Birthday';
				 evaluated: #birthday;
				 yourself)
]

{ #category : 'initialization' }
ICContactListPresenter >> initializePresenters [

	| cmdGroup |
	
	cmdGroup := self contactListCmdGroup.
	contactList := self newTable.
	self initializeContactListColumns.
	contactList
		contextMenu: [ cmdGroup asMenuPresenter ];
		contextKeyBindings: (self keybindsForFromContextMenu: cmdGroup);
		whenSelectedItemChangedDo: [ :selection | self owner updateDetail: selection ];
		items: self vcardManager contacts
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

{ #category : 'private' }
ICContactListPresenter >> keybindsForFromContextMenu: aGroupElement [
	| keybinds keybindsCommands |
	keybinds := KMCategory new.

	keybindsCommands := aGroupElement allCommands select: [ :aCommand | aCommand hasShortcutKey ].

	keybindsCommands do: [ :aCommand | | action |
		action := [ :aSelectedElement | aCommand execute ].
		keybinds addKeymapEntry: (KMKeymap
			shortcut: aCommand shortcutKey
			action: action).
		].

	^ keybinds
]

{ #category : 'private' }
ICContactListPresenter >> phoneNumbersFor: contact [

	^ contact phoneNumbers 
		  inject: String empty
		  into: [ :acc :n | 
			| phoneNumberString |
			phoneNumberString := n number asString.
			acc 
				ifEmpty: [ phoneNumberString ]
				ifNotEmpty: [ 
					String streamContents: [ : stream | 
						stream 
							<< acc;
							<< ', ';
							<< phoneNumberString ] ] ]
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

{ #category : 'accessing' }
ICContactListPresenter >> vcardManager [

	^ ICVCardManager uniqueInstance
]
