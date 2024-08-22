Class {
	#name : 'ICVCardTest',
	#superclass : 'ICTest',
	#instVars : [
		'vcard',
		'imid'
	],
	#category : 'ICal-VCard-Tests',
	#package : 'ICal-VCard-Tests'
}

{ #category : 'running' }
ICVCardTest >> setUp [ 

super setUp. 
vcard := ICVCard new.


]

{ #category : 'tests' }
ICVCardTest >> testICVCardAddAIMId [
		
	| vaimid | 
	vaimid := ICAIMId new.
	vaimid id: 'sth'. 
	vcard addAimid: vaimid.
	imid := vcard aimids first.
	self assert: imid id equals: 'sth'.
	self assert: (imid isKindOf: ICAIMId).
	

]

{ #category : 'tests' }
ICVCardTest >> testICVCardAddAIMIdByParser [

	| vaimid | 
	vaimid := ICAIMId fromICalString: 'sth' parameters: Dictionary new.
	vcard addAimid: vaimid.
	imid := vcard aimids first.
	self assert: imid id equals: 'sth'.
	self assert: (imid isKindOf: ICAIMId).
]

{ #category : 'tests' }
ICVCardTest >> testICVCardAddAVersion [
 
	vcard version: 3.0.

	self assert: vcard version equals: 3.0.
    


]

{ #category : 'tests' }
ICVCardTest >> testICVCardAddAddress [ 

	|vaddress address | 
	vaddress := ICAddress new.
	vaddress country: 'France'.
	vaddress postalcode: '59000'; street: '40 Avenue Edmund Halley'; locality: 'Villeneuve d''Ascq'.
	vaddress postalcode: '59000'; locality: 'Villeneuve d''Ascq'; country: 'France'.
	vaddress region: 'Hauts-de-France'.
	vcard addAddress: vaddress. 
	address := vcard addresses anyOne.
	self assert: address street equals: '40 Avenue Edmund Halley'.
	self assert: address locality equals: 'Villeneuve d''Ascq'.
	self assert: address postalcode equals: '59000'.
	self assert: address region equals: 'Hauts-de-France'.
	self assert: address country equals: 'France'.





]

{ #category : 'tests' }
ICVCardTest >> testICVCardAddAddressByParser [

	|vaddress address stringAddress| 

	stringAddress := ';;40 Avenue Edmund Halley;Villeneuve d''Ascq;Hauts-de-France;59000;France'.
	vaddress := ICAddress fromVCardString: stringAddress parameters: Dictionary new. 
	vcard addAddress: vaddress. 
	address := vcard addresses anyOne.
	self assert: address postalcode equals: '59000'.
	self assert: address region equals: 'Hauts-de-France'.
	self assert: address street equals: '40 Avenue Edmund Halley'.
	self assert: address country equals: 'France'.
	self assert: address locality equals: 'Villeneuve d''Ascq'.




]

{ #category : 'tests' }
ICVCardTest >> testICVCardAddBirthday [

	| date | 

	date := self dateClass year: 2002 month: 08 day: 28.

	vcard birthday: date.
	self assert: date equals: (self dateClass year: 2002 month: 08 day: 28).
]

{ #category : 'tests' }
ICVCardTest >> testICVCardAddBirthdayByParser [

	| date | 

	date := self dateClass fromVCardString: '2002-08-28'.
	vcard birthday: date.
	self assert: vcard birthday asVCardString equals: '2002-08-28'.
]

{ #category : 'tests' }
ICVCardTest >> testICVCardAddEmailAddress [ 

	|vemail email | 
	vemail := ICEmailAddress new.
	vemail address: 'addosarahb@gmail.com'.
	vemail internet: true.
	vcard addEmailAddress: vemail.
	email := vcard emailAddresses first.
	self assert: email address equals: 'addosarahb@gmail.com'.
	self assert: email internet equals: true.
]

{ #category : 'tests' }
ICVCardTest >> testICVCardAddEmailAddressByParser [

	|vemail email | 
	vemail := ICEmailAddress fromICalString: 'addosarahb@gmail.com' parameters: Dictionary new.
	vemail internet: true.
	vcard addEmailAddress: vemail.
	email := vcard emailAddresses first.
	self assert: email address equals: 'addosarahb@gmail.com'.
	self assert: email internet equals: true.
]

{ #category : 'tests' }
ICVCardTest >> testICVCardAddMSNId [

	| vmsnid | 
	vmsnid := ICMSNId new.
	vmsnid id: 'unknown'. 
	vcard addMsnid: vmsnid.
	imid := vcard msnids first.
	self assert: imid id equals: 'unknown'.
	self assert: (imid isKindOf: ICMSNId).
]

{ #category : 'tests' }
ICVCardTest >> testICVCardAddMSNIdByParser [

	|vmsnid | 
	vmsnid := ICMSNId fromICalString: 'unknown' parameters: Dictionary new.
	vcard addMsnid: vmsnid.
	imid := vcard msnids first.
	self assert: imid id equals: 'unknown'.
	self assert: (imid isKindOf: ICMSNId).
]

{ #category : 'tests' }
ICVCardTest >> testICVCardAddNote [

	|note | 

	note := 'Un nouveau contact'.
	vcard addNote: note.

	self assert: vcard contacts first equals: 'Un nouveau contact'.



]

{ #category : 'tests' }
ICVCardTest >> testICVCardAddPhoneNumber [ 

	|vphone phone | 
	vphone := ICPhoneNumber new.
	vphone number: '0614060814'.
	vphone cellular: true.
	vcard addPhoneNumber: vphone.
	phone := vcard phoneNumbers first.
	self assert: phone number equals: '0614060814'.
	self assert: phone cellular equals: true.
]

{ #category : 'tests' }
ICVCardTest >> testICVCardAddPhoneNumberByParser [

	|vphone phone | 
	vphone := ICPhoneNumber fromICalString: '0614060814' parameters: Dictionary new. 
	vphone cellular: true.
	vcard addPhoneNumber: vphone.
	phone := vcard phoneNumbers first.
	self assert: phone number equals: '0614060814'.
	self assert: phone cellular equals: true.
]

{ #category : 'tests' }
ICVCardTest >> testICVCardAddPhoto [
	
	"this test is to be reviewed"
	
	|vphoto | 
	
	vphoto := ByteArray streamContents: [ :stream | (ZnEasy getJpeg:'https://picsum.photos/536/354') writeOn: stream ]. 
	vcard photo: vphoto.

	self assert: (vcard photo isKindOf: ByteArray).



]

{ #category : 'tests' }
ICVCardTest >> testICVCardCreateName [ 
	 
	|vname | 
	vname := ICName new.
	vname familyName: 'Tathy'.
	vname givenName: 'Sarah'.

	vcard name: vname. 
	self assert: vcard name asVCardString equals: 'Tathy;Sarah;;;'.

	vcard fullname: 'Tathy Sarah'. 
	self assert: vcard fullname equals: 'Tathy Sarah'.



]

{ #category : 'tests' }
ICVCardTest >> testICVCardCreateNameByParser [
	 
	|vname | 
	vname := ICName fromICalString: 'Tathy;Sarah'.
	vcard name: vname. 
	self assert: vcard name asVCardString equals: 'Tathy;Sarah;;;'.

	vcard fullname: 'Tathy Sarah'. 
	self assert: vcard fullname equals: 'Tathy Sarah'.



]

{ #category : 'tests' }
ICVCardTest >> testICVCardNullAddressException [

	|newVcard | 

	newVcard := ICVCard new fullname: 'Sarah Tathy'.
	"[ newVcard checkAddress ]
	        on: ICVCardNullAddressException 
	        do: [ :exception | 
	            self assert: (exception message equals: 'Vcard Sarah Tathy has a nil address!') ]."
	    
	self should: [newVcard checkAddress]
			raise: ICVCardNullAddressException
			description: 'The Vcard Sarah Tathy has a nil address'. 


]

{ #category : 'tests' }
ICVCardTest >> testICVCardNullPostalCodeException [

	|newVcard address| 

	newVcard := ICVCard new fullname: 'Sarah Tathy'.
	address := ICAddress new street: '10 avenue halley'; postalcode: '5900a'.
	newVcard addAddress: address.
	"self should: [newVcard checkAddress] raise: ICVCardNullAddressException "
	self should: [newVcard checkPostalcode ]
			raise: ICVCardNullPostalCodeException 
			description: 'The postal code 5900a is invalid, please correct!'
		




]
