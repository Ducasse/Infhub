"
This class provides the displayer of phone numbers for the class `ICAddPresenter`.


"
Class {
	#name : 'ICVCardPhonePresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'textField',
		'countryCodePresenter',
		'selectedCountry'
	],
	#category : 'ICal-VCard-UI-Spec',
	#package : 'ICal-VCard-UI',
	#tag : 'Spec'
}

{ #category : 'initialization' }
ICVCardPhonePresenter >> country [

	^ selectedCountry
]

{ #category : 'layout' }
ICVCardPhonePresenter >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		  add: countryCodePresenter width: 70;
		  add: textField width: 100;
		  yourself  
]

{ #category : 'initialization' }
ICVCardPhonePresenter >> editable: aBoolean [ 

	textField editable: aBoolean.
	 
]

{ #category : 'initialization' }
ICVCardPhonePresenter >> initializePresenters [ 

countryCodePresenter := SpCountryCodesPresenter new.
countryCodePresenter initializePresenters.

textField := self newTextInput.
selectedCountry := ''
]

{ #category : 'initialization' }
ICVCardPhonePresenter >> text [ 

	^ textField text
]

{ #category : 'initialization' }
ICVCardPhonePresenter >> text: aText [ 

	textField text: aText number asString
]

{ #category : 'initialization' }
ICVCardPhonePresenter >> updateCountry [ 

selectedCountry := countryCodePresenter selectedItem
]
