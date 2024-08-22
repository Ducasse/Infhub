"
Implements the ""Remove contact"" operation in the Contact Manager application.
"
Class {
	#name : 'ICRemoveVCardCommand',
	#superclass : 'ICAbstractCommand',
	#category : 'ICal-VCard-UI-Command',
	#package : 'ICal-VCard-UI',
	#tag : 'Command'
}

{ #category : 'testing' }
ICRemoveVCardCommand >> canBeExecuted [ 

	^ self selectedContact notNil.
]

{ #category : 'executing' }
ICRemoveVCardCommand >> execute [

	(self confirm: 'Do you want to remove the selected contact?')
		ifTrue: [ self contactManagerPresenter removeContact: self selectedContact ]
]

{ #category : 'as yet unclassified' }
ICRemoveVCardCommand >> initialize [
	super initialize.
	self
		name: 'Remove';
		iconNamed: #glamorousRemove;
		description: 'Remove the selected contact from the contact manager'
]
