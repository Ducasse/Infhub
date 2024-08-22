"
This class provides the flags of countries in a drop list
"
Class {
	#name : 'SpCountryCodesPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'list',
		'dictionaryImages'
	],
	#classVars : [
		'Icons'
	],
	#category : 'ICal-VCard-UI-Spec',
	#package : 'ICal-VCard-UI',
	#tag : 'Spec'
}

{ #category : 'layout' }
SpCountryCodesPresenter >> asIdentifier: aFilename [

	| mainPart capitalizedMainPart |
	mainPart := (aFilename copyUpToLast: $.) select: [ :each |
		            each isAlphaNumeric or: [ each = $_ ] ].
	[ mainPart first isDigit ] whileTrue: [
		mainPart := mainPart allButFirst ].
	capitalizedMainPart := mainPart "asLowercase" 
		                       copyReplaceAll: '_'
		                       with: ' '.
	^ capitalizedMainPart capitalized
]

{ #category : 'layout' }
SpCountryCodesPresenter >> defaultLayout [ 

	^ SpBoxLayout newVertical 
			add: list height: 30;
			yourself 
]

{ #category : 'layout' }
SpCountryCodesPresenter >> iconFor: imageEntry [ 
    "Return the flag corresponding to the country" 
	"| imageForm request png| 
	
	request := ZnClient new.
	request get: 'https://flagcdn.com/w20/' , aCountry , '.png'.
	request isSuccess ifFalse: [ ^ nil ].
	png := request response contents. 
	
   imageForm := PNGReadWriter formFromStream: png readStream.
	^ imageForm "
	

	"Return the flag corresponding to the country"

	| image |
	image := imageEntry binaryReadStreamDo: [ :stream |
		         Form fromBinaryStream: stream ].
	^ image
]

{ #category : 'layout' }
SpCountryCodesPresenter >> initializeFlags [
	"| aFilename |
	dictionaryImages := Dictionary new.
	aFilename := 'tiny'.
	aFilename asFileReference entries do: [ :entry |
		dictionaryImages
			at: (self asIdentifier: entry name)
			put: entry asFileReference ]
		
		
	
	dictionaryImages := Dictionary new.
	1 to: (self listOfCountries size) by: 2 do: [ :index | 
		dictionaryImages at: (self listOfCountries at: index) put: (self listOfCountries at: (index +1)) asLowercase. ]

Here we collect methods of ICCountryIconAndContent , put them into the dictionary for display the country and the flag that correspond: 
dictionaryImages := Dictionary new.
	ICCountryIconAndContent class methods
		select: [ :m | m selector endsWith: #Icon ]
		thenCollect: [ :m |
			dictionaryImages
				at: (self asIdentifier: (m selector allButLast: 4))
				put: (ICCountryIconAndContent perform: m selector) ]"

	dictionaryImages := Dictionary new.
	ICCountryFlag class methods
		select: [ :m | m selector endsWith: #Flag ]
		thenCollect: [ :m |
			dictionaryImages
				at: (self asIdentifier: (m selector allButLast: 4))
				put: (ICCountryFlag perform: m selector) ]
]

{ #category : 'initialization' }
SpCountryCodesPresenter >> initializePresenters [

	self initializeFlags.
	list := SpDropListPresenter new.
	list items: dictionaryImages keys asSortedCollection.
	list displayIcon: [ :item | dictionaryImages at: item ]
]

{ #category : 'initialization' }
SpCountryCodesPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter initialExtent: 10@10
]

{ #category : 'flags' }
SpCountryCodesPresenter >> listOfCountries [ ^  #('Andorra' 'AD' 'United Arab Emirates' 'AE' 'Afghanistan' 'AF' 'Antigua and Barbuda' 'AG' 'Anguilla' 'AI' 'Albania' 'AL' 'Armenia' 'AM' 'Angola' 'AO' 'Argentina' 'AR' 'American Samoa' 'AS' 'Austria' 'AT' 'Australia' 'AU' 'Aruba' 'AW' 'Aland Islands' 'AX' 'Azerbaijan' 'AZ' 'Bosnia and Herzegovina' 'BA' 'Barbados' 'BB' 'Bangladesh' 'BD' 'Belgium' 'BE' 'Burkina Faso' 'BF' 'Bulgaria' 'BG' 'Bahrain' 'BH' 'Burundi' 'BI' 'Benin' 'BJ' 'Saint Barthelemy' 'BL' 'Brunei Darussalam' 'BN' 'Bolivia' 'BO' 'Bermuda' 'BM' 'Bonaire,  Saint Eustachius and Saba' 'BQ' 'Brazil' 'BR' 'Bahamas' 'BS' 'Bhutan' 'BT' 'Bouvet Island' 'BV' 'Botswana' 'BW' 'Belarus' 'BY' 'Belize' 'BZ' 'Canada' 'CA' 'Cocos (Keeling) Islands' 'CC' 'Democratic Republic of Congo' 'CD' 'Central African Republic' 'CF' 'Republic of Congo' 'CG' 'Switzerland' 'CH' 'Côte d''Ivoire' 'CI' 'Cook Islands' 'CK' 'Chile' 'CL' 'Cameroon' 'CM' 'China' 'CN' 'Colombia' 'CO' 'Costa Rica' 'CR' 'Cuba' 'CU' 'Cape Verde' 'CV' 'Curaçao' 'CW' 'Christmas Island' 'CX' 'Cyprus' 'CY' 'Czech Republic' 'CZ' 'Germany' 'DE' 'Djibouti' 'DJ' 'Denmark' 'DK' 'Dominica' 'DM' 'Dominican Republic' 'DO' 'Algeria' 'DZ' 'Ecuador' 'EC' 'Egypt' 'EG' 'Estonia' 'EE' 'Western Sahara' 'EH' 'Eritrea' 'ER' 'Spain' 'ES' 'Ethiopia' 'ET' 'Finland' 'FI' 'Fiji' 'FJ' 'Falkland Islands' 'FK' 'Federated States of Micronesia' 'FM' 'Faroe Islands' 'FO' 'France' 'FR' 'Gabon' 'GA' 'United Kingdom' 'GB' 'Georgia' 'GE' 'Grenada' 'GD' 'French Guiana' 'GF' 'Guernsey' 'GG' 'Ghana' 'GH' 'Gibraltar' 'GI' 'Greenland' 'GL' 'Gambia' 'GM' 'Guinea' 'GN' 'Guadeloupe' 'GP' 'Equatorial Guinea' 'GQ' 'Greece' 'GR' 'South Georgia and South Sandwich Islands' 'GS' 'Guatemala' 'GT' 'Guam' 'GU' 'Guinea-Bissau' 'GW' 'Guyana' 'GY' 'Hong Kong' 'HK' 'Heard Island and McDonald Islands' 'HM' 'Honduras' 'HN' 'Croatia' 'HR' 'Haiti' 'HT' 'Hungary' 'HU' 'Indonesia' 'ID' 'Ireland' 'IE' 'Israel' 'IL' 'Isle of Man' 'IM' 'India' 'IN' 'British Indian Ocean Territory' 'IO' 'Iraq' 'IQ' 'Iran' 'IR' 'Iceland' 'IS' 'Italy' 'IT' 'Jersey' 'JE' 'Jamaica' 'JM' 'Jordan' 'JO' 'Japan' 'JP' 'Kenya' 'KE' 'Kyrgyzstan' 'KG' 'Cambodia' 'KH' 'Kiribati' 'KI' 'Comoros' 'KM' 'Saint Kitts and Nevis' 'KN' 'North Korea' 'KP' 'South Korea' 'KR' 'Kosovo' 'XK' 'Kuwait' 'KW' 'Cayman Islands' 'KY' 'Kazakhstan' 'KZ' 'Lao People''s Democratic Republic' 'LA' 'Lebanon' 'LB' 'Saint Lucia' 'LC' 'Liechtenstein' 'LI' 'Sri Lanka' 'LK' 'Liberia' 'LR' 'Lesotho' 'LS' 'Lithuania' 'LT' 'Luxembourg' 'LU' 'Latvia' 'LV' 'Libya' 'LY' 'Morocco' 'MA' 'Monaco' 'MC' 'Moldova' 'MD' 'Madagascar' 'MG' 'Montenegro' 'ME' 'Saint Martin' 'MF' 'Marshall Islands' 'MH' 'Macedonia' 'MK' 'Mali' 'ML' 'Macau' 'MO' 'Myanmar' 'MM' 'Mongolia' 'MN' 'Northern Mariana Islands' 'MP' 'Martinique' 'MQ' 'Mauritania' 'MR' 'Montserrat' 'MS' 'Malta' 'MT' 'Mauritius' 'MU' 'Maldives' 'MV' 'Malawi' 'MW' 'Mexico' 'MX' 'Malaysia' 'MY' 'Mozambique' 'MZ' 'Namibia' 'NA' 'New Caledonia' 'NC' 'Niger' 'NE' 'Norfolk Island' 'NF' 'Nigeria' 'NG' 'Nicaragua' 'NI' 'Netherlands' 'NL' 'Norway' 'NO' 'Nepal' 'NP' 'Nauru' 'NR' 'Niue' 'NU' 'New Zealand' 'NZ' 'Oman' 'OM' 'Panama' 'PA' 'Peru' 'PE' 'French Polynesia' 'PF' 'Papua New Guinea' 'PG' 'Philippines' 'PH' 'Pakistan' 'PK' 'Poland' 'PL' 'Saint Pierre and Miquelon' 'PM' 'Pitcairn Islands' 'PN' 'Puerto Rico' 'PR' 'Palestinian Territories' 'PS' 'Portugal' 'PT' 'Palau' 'PW' 'Paraguay' 'PY' 'Qatar' 'QA' 'Reunion' 'RE' 'Romania' 'RO' 'Serbia' 'RS' 'Russia' 'RU' 'Rwanda' 'RW' 'Saudi Arabia' 'SA' 'Solomon Islands' 'SB' 'Seychelles' 'SC' 'Sudan' 'SD' 'Sweden' 'SE' 'Singapore' 'SG' 'Saint Helena' 'SH' 'Slovenia' 'SI' 'Svalbard and Jan Mayen' 'SJ' 'Slovakia' 'SK' 'Sierra Leone' 'SL' 'San Marino' 'SM' 'Senegal' 'SN' 'Somalia' 'SO' 'Suriname' 'SR' 'South Sudan' 'SS' 'Sao Tome and Principe' 'ST' 'El Salvador' 'SV' 'Saint Martin' 'SX' 'Syria' 'SY' 'Swaziland' 'SZ' 'Turks and Caicos Islands' 'TC' 'Chad' 'TD' 'French Southern and Antarctic Lands' 'TF' 'Togo' 'TG' 'Thailand' 'TH' 'Tajikistan' 'TJ' 'Tokelau' 'TK' 'Timor-Leste' 'TL' 'Turkmenistan' 'TM' 'Tunisia' 'TN' 'Tonga' 'TO' 'Turkey' 'TR' 'Trinidad and Tobago' 'TT' 'Tuvalu' 'TV' 'Taiwan' 'TW' 'Tanzania' 'TZ' 'Ukraine' 'UA' 'Uganda' 'UG' 'United States' 'US' 'Uruguay' 'UY' 'Uzbekistan' 'UZ' 'Vatican City' 'VA' 'Saint Vincent and the Grenadines' 'VC' 'Venezuela' 'VE' 'British Virgin Islands' 'VG' 'US Virgin Islands' 'VI' 'Vietnam' 'VN' 'Vanuatu' 'VU' 'Wallis and Futuna' 'WF' 'Samoa' 'WS' 'Yemen' 'YE' 'Mayotte' 'YT' 'South Africa' 'ZA' 'Zambia' 'ZM' 'Zimbabwe' 'ZW')
]
