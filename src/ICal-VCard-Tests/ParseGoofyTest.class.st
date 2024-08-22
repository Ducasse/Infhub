Class {
	#name : 'ParseGoofyTest',
	#superclass : 'ICVCardParserTest',
	#category : 'ICal-VCard-Tests',
	#package : 'ICal-VCard-Tests'
}

{ #category : 'tests - parsing' }
ParseGoofyTest >> testParseGoofyAddress [ 

	cards := ICCardHandParser parseVCardString: self goofyCardString.
	self assert: cards size equals: 1.
	card := cards anyOne.
	
	self assert: card addresses size equals: 1.
	address := card addresses anyOne.
	
	self assert: address isHome.
	self deny: address isDomestic.
	self deny: address isInternational.
	self deny: address isParcel.
	self deny: address isPostal.
	self deny: address isPreferred.
	self deny: address isWork.
	
	self assert: address poBox isEmptyOrNil.
	self assert: address extended isEmptyOrNil.
	
	self assert: address street equals: 'Neufeldstrasse 11'.
	self assert: address locality equals: 'Bern'.
	self assert: address region isEmptyOrNil.
	self assert: address postalcode equals: '3012'.
	self assert: address country equals: 'Schweiz'.
	
	
]

{ #category : 'tests - parsing' }
ParseGoofyTest >> testParseGoofyFirstPhoneNumber [ 

	cards := ICCardHandParser parseVCardString: self goofyCardString.
	self assert: cards size equals: 1.
	card := cards anyOne.
	
	self assert: card phoneNumbers size equals: 2.
	phoneNumber := card phoneNumbers first.
	self assert: phoneNumber number equals: '+41 31 302 08 56'.
	self assert: phoneNumber isHome.
	self deny: phoneNumber isPreferred.
	self deny: phoneNumber isWork.
	self deny: phoneNumber isBulletinBoard.
	self deny: phoneNumber isCar.
	self deny: phoneNumber isCellular.
	self deny: phoneNumber isFax.
	self deny: phoneNumber isISDN.
	self deny: phoneNumber isModem.
	self deny: phoneNumber isPager.
	self assert: phoneNumber isVoice.
	self deny: phoneNumber isVoiceMessage.
	
	
	
	
]

{ #category : 'tests - parsing' }
ParseGoofyTest >> testParseGoofyName [

	cards := ICCardHandParser parseVCardString: self goofyCardString.
	self assert: cards size equals: 1.
	card := cards anyOne.

	self assert: card fullname equals: 'Tschannen Markus'.
	self assert: card version equals: 2.1.
	self
		assert: card birthday
		equals: (self dateClass year: 1980 month: 10 day: 30).
	name := card name.
	self assert: name notNil.
	self assert: name familyName equals: 'Tschannen'.
	self assert: name givenName equals: 'Markus'.
	self assert: name additionalNames isEmptyOrNil.
	self assert: name honorificPrefixes isEmptyOrNil.
	self assert: name honorificSuffixes isEmptyOrNil.

	self assert: card emailAddresses isEmpty
]

{ #category : 'tests - parsing' }
ParseGoofyTest >> testParseGoofyPosition [ 
	cards := ICCardHandParser parseVCardString: self goofyCardString.
	self assert: cards size equals: 1.
	card := cards anyOne.
	
	self assert: (card timeZone isKindOf: String).
	self assert: card timeZone equals: '-05:00; EST; Raleigh/North America'.
	self assert: card geo equals: (37.386013@ (-122.082932))
]

{ #category : 'tests - parsing' }
ParseGoofyTest >> testParseGoofySecondPhoneNumber [ 

	cards := ICCardHandParser parseVCardString: self goofyCardString.
	self assert: cards size equals: 1.
	card := cards anyOne.
	
	self assert: card phoneNumbers size equals: 2.

	phoneNumber := card phoneNumbers second.
	self assert: phoneNumber number equals: '+41 78 845 24 12'.
	self assert: phoneNumber isHome.
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
