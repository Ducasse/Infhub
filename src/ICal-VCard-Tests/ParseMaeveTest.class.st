Class {
	#name : 'ParseMaeveTest',
	#superclass : 'ICVCardParserTest',
	#category : 'ICal-VCard-Tests',
	#package : 'ICal-VCard-Tests'
}

{ #category : 'tests - parsing' }
ParseMaeveTest >> testParseMaeveAimids [
	
	cards := ICCardHandParser parseVCardString: self maeveCardString.
	self assert: cards size equals: 1.
	card := cards anyOne.
	
	self assert: card aimids size equals: 1.
	imid := card aimids anyOne.
	self assert: imid isPreferred.
	self deny: imid isWork.
	self assert: imid isHome.
	self assert: imid id equals: 'Mahaevey'.
	
]

{ #category : 'tests - parsing' }
ParseMaeveTest >> testParseMaeveCategoriesAndNotes [
	
	cards := ICCardHandParser parseVCardString: self maeveCardString.
	self assert: cards size equals: 1.
	card := cards anyOne.
	
	self assert: card categories size equals: 3.
	#('Friends' 'Columbia College Chicago' 'Family') do: [ :each |
		self assert: (card categories anySatisfy: [ :cat | cat summary = each  ]) ].
	
	self assert: card contacts isEmpty	
]

{ #category : 'tests - parsing' }
ParseMaeveTest >> testParseMaeveMsnidsAndIcqids [

	cards := ICCardHandParser parseVCardString: self maeveCardString.
	self assert: cards size equals: 1.
	card := cards anyOne.
	
	
	self assert: card msnids size equals: 1.
	imid := card msnids anyOne.
	self assert: (imid isKindOf: ICMSNId).
	self assert: imid isPreferred.
	self deny: imid isWork.
	self assert: imid isHome.
	self assert: imid id equals: 'dgu186@hotmail.com'.


	self assert: card icqids isEmpty.
]

{ #category : 'tests - parsing' }
ParseMaeveTest >> testParseMaeveName [

	cards := ICCardHandParser parseVCardString: self maeveCardString.
	self assert: cards size equals: 1.
	card := cards anyOne.
	
	self assert: card fullname equals: 'Maeve Price'.
	self assert: card title equals: 'Digital Editor'.
	self assert: card version equals: 3.0.
	name := card name.
	self assert: name notNil.
	self assert: name familyName equals: 'Price'.
	self assert: name givenName equals: 'Maeve'.
	self assert: name additionalNames isEmptyOrNil.
	self assert: name honorificPrefixes isEmptyOrNil.
	self assert: name honorificSuffixes isEmptyOrNil.
	
]

{ #category : 'tests - parsing' }
ParseMaeveTest >> testParseMaeveUrl [
	"The vCard uses backslashes (\) to escape characters in URLs, which is not compliant with the vCard 3.0 specification. According to RFC 6350, URLs should be encoded properly without needing to escape characters. For example, spaces in URLs should be encoded as %20 instead of being escaped with a backslash."

	cards := ICCardHandParser parseVCardString: self maeveCardString.
	self assert: cards size equals: 1.
	card := cards anyOne.

	self
		assert: card url asVCardString
		equals: 'http://www.myspace.com/maeveprice'
]

{ #category : 'tests - parsing' }
ParseMaeveTest >> testParseMaeveYahooids [

	cards := ICCardHandParser parseVCardString: self maeveCardString.
	self assert: cards size equals: 1.
	card := cards anyOne.
	
	self assert: card yahooids isEmpty.
	
]
