Class {
	#name : 'ParseWikipediaTest',
	#superclass : 'ICVCardParserTest',
	#category : 'ICal-VCard-Tests',
	#package : 'ICal-VCard-Tests'
}

{ #category : 'tests - parsing' }
ParseWikipediaTest >> testParseWikipediaAddress [

	cards := ICCardHandParser parseVCardString: self wikipediaCardString.
	self assert: cards size equals: 1.
	card := cards anyOne.
	
	self assert: card addresses size equals: 1.
	address := card addresses anyOne.
	
	self deny: address isHome.
	self deny: address isDomestic.
	self deny: address isInternational.
	self deny: address isParcel.
	self deny: address isPostal.
	self assert: address isPreferred.
	self assert: address isWork.
	
	self assert: address poBox isEmptyOrNil.
	self assert: address locality isEmptyOrNil.
	
	self assert: address street equals: 'Bar Street 99'.
	self assert: address extended equals: 'Footown 12345, Fooland'.
	self assert: address region isEmptyOrNil.
	self assert: address postalcode isEmptyOrNil.
	self assert: address country isEmptyOrNil.
	
]

{ #category : 'tests - parsing' }
ParseWikipediaTest >> testParseWikipediaEmailAddress [
	
	cards := ICCardHandParser parseVCardString: self wikipediaCardString.
	self assert: cards size equals: 1.
	card := cards anyOne.
	
	self assert: card emailAddresses size equals: 1.
	emailAddress := card emailAddresses anyOne.
	self assert: emailAddress address equals: 'nobody@example.invalid'.
	self deny: emailAddress isWork.
	self deny: emailAddress isPreferred.
	self deny: emailAddress isHome.
	self assert: emailAddress isInternet.
	self deny: emailAddress isX400.
]

{ #category : 'tests - parsing' }
ParseWikipediaTest >> testParseWikipediaName [

	cards := ICCardHandParser parseVCardString: self wikipediaCardString.
	self assert: cards size equals: 1.
	card := cards anyOne.
	
	self assert: card fullname equals: 'Lastname Firstname'.
	self assert: card version equals: 3.0.
	name := card name.
	self assert: name notNil.
	self assert: name familyName equals: 'Lastname'.
	self assert: name givenName equals: 'Firstname'.
	self assert: name additionalNames isEmptyOrNil.
	self assert: name honorificPrefixes isEmptyOrNil.
	self assert: name honorificSuffixes isEmptyOrNil.
	
]

{ #category : 'tests - parsing' }
ParseWikipediaTest >> testParseWikipediaPhoneNumber [

	cards := ICCardHandParser parseVCardString: self wikipediaCardString.
	self assert: cards size equals: 1.
	card := cards anyOne.
	
	self assert: card phoneNumbers size equals: 1.
	phoneNumber := card phoneNumbers first.
	self assert: phoneNumber number equals: '+358-40-123456'.
	self deny: phoneNumber isHome.
	self deny: phoneNumber isPreferred.
	self deny: phoneNumber isWork.
	self deny: phoneNumber isBulletinBoard.
	self deny: phoneNumber isCar.
	self assert: phoneNumber isCellular.
	self deny: phoneNumber isFax.
	self deny: phoneNumber isISDN.
	self deny: phoneNumber isModem.
	self deny: phoneNumber isPager.
	self deny: phoneNumber isVoice.
	self deny: phoneNumber isVoiceMessage.

	
]
