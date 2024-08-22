Class {
	#name : 'ParseSurendarTest',
	#superclass : 'ICVCardParserTest',
	#category : 'ICal-VCard-Tests',
	#package : 'ICal-VCard-Tests'
}

{ #category : 'tests - parsing' }
ParseSurendarTest >> testParseSurendarAimids [

	cards := ICCardHandParser parseVCardString: self surendarCardString.
	self assert: cards size equals: 1.
	card := cards anyOne.

	self assert: card aimids size equals: 1.
	imid := card aimids anyOne.
	self assert: (imid isKindOf: ICAIMId).
	self assert: imid isPreferred.
	self deny: imid isWork.
	self assert: imid isHome.
	self assert: imid id equals: 'surendar'.

	
]

{ #category : 'tests - parsing' }
ParseSurendarTest >> testParseSurendarIcqidsAndMsnids [

	cards := ICCardHandParser parseVCardString: self surendarCardString.
	self assert: cards size equals: 1.
	card := cards anyOne.

	self assert: card icqids isEmpty.

	self assert: card msnids size equals: 1.
	imid := card msnids anyOne.
	self assert: (imid isKindOf: ICMSNId).
	self assert: imid isPreferred.
	self deny: imid isWork.
	self assert: imid isHome.
	self assert: imid id equals: 'surendar'.


]

{ #category : 'tests - parsing' }
ParseSurendarTest >> testParseSurendarName [

	cards := ICCardHandParser parseVCardString: self surendarCardString.
	self assert: cards size equals: 1.
	card := cards anyOne.

	self assert: card fullname equals: 'Surendar Chandra'.
	self assert: card title equals: 'Asst. Professor'.
	self assert: card version equals: 3.0.
	name := card name.
	self assert: name notNil.
	self assert: name familyName equals: 'Chandra'.
	self assert: name givenName equals: 'Surendar'.
	self assert: name additionalNames isEmptyOrNil.
	self assert: name honorificPrefixes isEmptyOrNil.
	self assert: name honorificSuffixes isEmptyOrNil.

	
]

{ #category : 'tests - parsing' }
ParseSurendarTest >> testParseSurendarNotes [

	cards := ICCardHandParser parseVCardString: self surendarCardString.
	self assert: cards size equals: 1.
	card := cards anyOne.

	self assert: card contacts size equals: 1.
	self assert: card contacts anyOne equals: 'SMS message
12/22/2003 18:12
wassup

SMS message
12/23/2003 13:12
Hello'
]

{ #category : 'tests - parsing' }
ParseSurendarTest >> testParseSurendarOrganization [
	
	| organization |
	cards := ICCardHandParser parseVCardString: self surendarCardString.
	self assert: cards size equals: 1.
	card := cards anyOne.

	organization := card organization.
	self assert: organization name equals: 'Univ. of Notre Dame'.
	self assert: organization unitNames size equals: 1.
	self
		assert: organization unitNames anyOne
		equals: 'Computer Science and Engg'.
	
]

{ #category : 'tests - parsing' }
ParseSurendarTest >> testParseSurendarUrl [

	cards := ICCardHandParser parseVCardString: self surendarCardString.
	self assert: cards size equals: 1.
	card := cards anyOne.

	self assert: card url asVCardString equals: 'http://www.cse.nd.edu/~surendar/'.
]

{ #category : 'tests - parsing' }
ParseSurendarTest >> testParseSurendarYahooids [

	cards := ICCardHandParser parseVCardString: self surendarCardString.
	self assert: cards size equals: 1.
	card := cards anyOne.

	self assert: card yahooids size equals: 1.
	imid := card yahooids anyOne.
	self assert: (imid isKindOf: ICYahooId).
	self assert: imid isPreferred.
	self assert: imid isWork.
	self deny: imid isHome.
	self assert: imid id equals: 'surendarcsdukeedu'.


]
