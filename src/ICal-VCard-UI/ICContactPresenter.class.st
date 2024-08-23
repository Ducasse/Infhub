"
This is the Spec Application class for adding a contact.

To start the application, please evaluate:
```
ICAddPresenter new open.
```
"
Class {
	#name : 'ICContactPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'nameTextPresenter',
		'phoneNumber1Presenter',
		'phoneNumber2Presenter',
		'emailTextPresenter',
		'lastNameTextPresenter',
		'addressTextPresenter',
		'birthdayPresenter',
		'picturePresenter',
		'selectImageButtonPresenter'
	],
	#category : 'ICal-VCard-UI-Spec',
	#package : 'ICal-VCard-UI',
	#tag : 'Spec'
}

{ #category : 'layout' }
ICContactPresenter >> address [

	^ addressTextPresenter text
]

{ #category : 'layout' }
ICContactPresenter >> address: anAddress [

	addressTextPresenter text: anAddress asString
]

{ #category : 'layout' }
ICContactPresenter >> birthday [

	^ birthdayPresenter text
]

{ #category : 'layout' }
ICContactPresenter >> birthday: aBirthday [

	birthdayPresenter text: aBirthday
]

{ #category : 'layout' }
ICContactPresenter >> checkName [
	" Answer <true> if the the name and surname of the contact is valid
		If empty, alert and answer <false>.
		If not empty, we check if it's written correctly."

	^ (self name isEmptyOrNil and: [ self lastname isEmptyOrNil ])
		ifFalse: [ self hasGoodName ]
		ifTrue: [ 
			self alert: 'Please write the contact''s name or lastname'.
			^ false ]
]

{ #category : 'layout' }
ICContactPresenter >> checkPrincipalPhoneNumber [

	^ self phoneNumber1 isEmptyOrNil
		ifFalse: [ self hasGoodPhoneNumber ]
		ifTrue: [
			self alert: 'Please write phone number for the contact'.
			true ]
]

{ #category : 'layout' }
ICContactPresenter >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		  add: (SpGridLayout build: [ :builder |
					   builder
						   beColumnNotHomogeneous;
						   add: 'Name';
						   add: nameTextPresenter;
						   nextRow;
						   add: 'Lastname';
						   add: lastNameTextPresenter;
						   nextRow;
						   add: 'Principal phone number';
						   add: phoneNumber1Presenter;
						   nextRow;
						   add: 'Second phone number';
						   add: phoneNumber2Presenter;
						   nextRow;
						   add: 'Address';
						   add: addressTextPresenter;
						   nextRow;
						   add: 'Email';
						   add: emailTextPresenter;
						   nextRow;
						   add: 'Birthday';
						   add: birthdayPresenter ])
		  width: 450;
		  add: (SpBoxLayout newTopToBottom
				   add: 'Picture' expand: false;
					add: selectImageButtonPresenter expand: false;
				   add: picturePresenter;
				   yourself);
		  yourself
]

{ #category : 'layout' }
ICContactPresenter >> email [

	^ emailTextPresenter text
]

{ #category : 'layout' }
ICContactPresenter >> email: anEmail [

	emailTextPresenter text: anEmail address 
]

{ #category : 'testing' }
ICContactPresenter >> hasGoodName [

	(self name asUnsignedInteger isNotNil or: [
		 self lastname asUnsignedInteger isNotNil ])
		ifTrue: [
			self alert: 'You cannot have number in the name or lastname. 
Please correct it.'.
			^ true ]
		ifFalse: [ ^ false ]
]

{ #category : 'layout' }
ICContactPresenter >> hasGoodPhoneNumber [
	"Answer <true> if the receiver has a valid phone number"

	^ (self isValidPhoneNumber: self phoneNumber1) 
		ifTrue: [ self isValidOptionalPhoneNumber: self phoneNumber2 ]
		ifFalse: [ false ]

]

{ #category : 'layout' }
ICContactPresenter >> initialExtentForWindow [

	^ (600 @ 350) scaledByDisplayScaleFactor
]

{ #category : 'initialization' }
ICContactPresenter >> initializeDialogWindow: aDialogPresenter [

	| cancelButton saveButton |
	aDialogPresenter centered.
	cancelButton := aDialogPresenter
		                addButton: 'Cancel'
		                do: [ :presenter | presenter close ].
	cancelButton icon: (self iconNamed: #smallCancel). "Appliquer le style visuel du bouton Cancel"

	saveButton := aDialogPresenter 
		addButton: 'Save' 
		do: [ :presenter | 
			self validateNewContact ifTrue: [
			    presenter
				              beOk;
				              close ] ].
	saveButton icon: (self iconNamed: #smallOk)
]

{ #category : 'initialization' }
ICContactPresenter >> initializePresenters [

	nameTextPresenter := self newTextInput.
	lastNameTextPresenter := self newTextInput.
	addressTextPresenter := self newTextInput.
	emailTextPresenter := self newTextInput.
	phoneNumber1Presenter := self instantiate: ICVCardPhonePresenter.
	phoneNumber2Presenter := self instantiate: ICVCardPhonePresenter.
	birthdayPresenter := self newTextInput.
	selectImageButtonPresenter := self newButton 
		label: 'Select';
		action: [ self selectImage ];
		yourself.
	picturePresenter := self newImage
]

{ #category : 'initialization' }
ICContactPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Contact';
		initialExtent: self initialExtentForWindow 
]

{ #category : 'testing' }
ICContactPresenter >> isValidOptionalPhoneNumber: aPhoneNumberOrString [
	"Answer <true> if the receiver has a valid optional phone number"

	^ aPhoneNumberOrString isEmpty
		ifTrue: [ true ]
		ifFalse: [ aPhoneNumberOrString isAllDigits ]
]

{ #category : 'testing' }
ICContactPresenter >> isValidPhoneNumber: aPhoneNumberOrString [
	"Answer <true> if the receiver has a valid phone number"

	^ aPhoneNumberOrString isNotEmpty and: [ aPhoneNumberOrString isAllDigits ]
]

{ #category : 'layout' }
ICContactPresenter >> lastname [

	^ lastNameTextPresenter text
]

{ #category : 'layout' }
ICContactPresenter >> lastname: aLastName [

	lastNameTextPresenter text: aLastName
]

{ #category : 'layout' }
ICContactPresenter >> name [

	^ nameTextPresenter text
]

{ #category : 'accessing' }
ICContactPresenter >> name: aName [

	nameTextPresenter text: aName
]

{ #category : 'layout' }
ICContactPresenter >> phoneNumber1 [

	^ phoneNumber1Presenter text
]

{ #category : 'layout' }
ICContactPresenter >> phoneNumber1: number1 [

	phoneNumber1Presenter text: number1
]

{ #category : 'layout' }
ICContactPresenter >> phoneNumber2 [

	^ phoneNumber2Presenter text
]

{ #category : 'layout' }
ICContactPresenter >> phoneNumber2: number2 [

	phoneNumber2Presenter text: number2
]

{ #category : 'layout' }
ICContactPresenter >> photo [

	^ picturePresenter image
]

{ #category : 'accessing' }
ICContactPresenter >> picturePresenter [

	^ picturePresenter
]

{ #category : 'accessing' }
ICContactPresenter >> picturePresenter: anObject [

	picturePresenter := anObject
]

{ #category : 'private' }
ICContactPresenter >> selectImage [

	| selectedFile |
	((selectedFile := StOpenFilePresenter new openModal) notNil and: [  selectedFile isFile ]) 
		ifTrue: [ picturePresenter image: (ImageReadWriter formFromFileNamed: selectedFile fullName) ]
]

{ #category : 'layout' }
ICContactPresenter >> updateModel: anICvcard [

	| firstNumber secondNumber |
	firstNumber := anICvcard phoneNumbers at: 1.
	secondNumber := anICvcard phoneNumbers at: 2.
	self address: anICvcard addresses first.
	self name: anICvcard name givenName.
	self lastname: anICvcard name familyName.
	self email: anICvcard emailAddresses first.
	self birthday: anICvcard birthday.
	self phoneNumber1: firstNumber.
	self phoneNumber2: secondNumber.
	self picturePresenter image: anICvcard photo 
]

{ #category : 'testing' }
ICContactPresenter >> validateNewContact [
	"Answer <true> if the new contact information is valid"
	
	^ self checkName "or: [ self checkPrincipalPhoneNumber ]"
]
