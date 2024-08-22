"
A toolbar with a text entry which has the role when text is typed:  

A search for notes begins always, if any match then matching notes are returned.


"
Class {
	#name : 'ICSearchCreatePresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'contactsSearchCreateTextPresenter',
		'contactsSearchButtonPresenter',
		'model'
	],
	#category : 'ICal-VCard-UI-Spec',
	#package : 'ICal-VCard-UI',
	#tag : 'Spec'
}

{ #category : 'layout' }
ICSearchCreatePresenter >> contacts [
	"Answer a <Collection> of <ICVVCard> representing all the application's contacts"

	^ self model contacts 
]

{ #category : 'layout' }
ICSearchCreatePresenter >> contactsList [

	^ self owner contactList
]

{ #category : 'layout' }
ICSearchCreatePresenter >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		  add: contactsSearchCreateTextPresenter;
		  add: contactsSearchButtonPresenter expand: false;
		  yourself
]

{ #category : 'layout' }
ICSearchCreatePresenter >> filteredContactFor: aString [
	"Answer a <Collection> of <ICVCard> whose names match aString"

	^ self contacts select: [ :contact | contact fullname includesSubstring: aString ]
]

{ #category : 'initialization' }
ICSearchCreatePresenter >> initializePresenters [

	contactsSearchCreateTextPresenter := self newTextInput
		                                  placeholder:
			                                  'Type contact to search';
		                                  whenTextChangedDo: [
			                                  self updateContactsList ];
		                                  yourself.
	contactsSearchButtonPresenter := self newButton
		                              icon: (self iconNamed: #smallFind);
		                              action: [ self updateContactsList ];
		                              help: 'Search contact';
		                              yourself
]

{ #category : 'layout' }
ICSearchCreatePresenter >> model [

	^ model
]

{ #category : 'accessing - model' }
ICSearchCreatePresenter >> setModelBeforeInitialization: aNotesObject [

	model := aNotesObject
]

{ #category : 'layout' }
ICSearchCreatePresenter >> updateContactsList [

	self contactsList items: (contactsSearchCreateTextPresenter text
			 ifEmpty: [ self contacts ]
			 ifNotEmpty: [ :pattern | self filteredContactFor: pattern ])
]
