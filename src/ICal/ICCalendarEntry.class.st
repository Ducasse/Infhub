Class {
	#name : 'ICCalendarEntry',
	#superclass : 'ICComponent',
	#instVars : [
		'comments',
		'url',
		'uid',
		'stamp'
	],
	#classVars : [
		'UidStrategy'
	],
	#category : 'ICal-Abstract',
	#package : 'ICal',
	#tag : 'Abstract'
}

{ #category : 'class initialization' }
ICCalendarEntry class >> initialize [
	"self initialize"
	self uidStrategy: self selectStrategy
]

{ #category : 'class initialization' }
ICCalendarEntry class >> selectStrategy [
	^ICSqueakUUIDStrategy new 
]

{ #category : 'accessing' }
ICCalendarEntry class >> uidStrategy [
	^UidStrategy
]

{ #category : 'accessing' }
ICCalendarEntry class >> uidStrategy: aStrategy [
	UidStrategy := aStrategy
]

{ #category : 'accessing' }
ICCalendarEntry >> addComment: aString [
	^self comments add: aString
]

{ #category : 'accessing' }
ICCalendarEntry >> comments [
	^comments
]

{ #category : 'accessing' }
ICCalendarEntry >> comments: aCollection [ 
	comments := aCollection
]

{ #category : 'exporting' }
ICCalendarEntry >> exportOn: anExporter [
	anExporter exportUid: self uid.
	anExporter exportUrl: self url.
	anExporter exportComments: self comments.
	anExporter exportStamp: self stamp
]

{ #category : 'private' }
ICCalendarEntry >> generateUid [
	^self uidStrategy generateUid
]

{ #category : 'initialization' }
ICCalendarEntry >> initialize [
	super initialize.
	self uid: self generateUid.
	self comments: OrderedCollection new
]

{ #category : 'accessing' }
ICCalendarEntry >> stamp [
	^stamp
]

{ #category : 'accessing' }
ICCalendarEntry >> stamp: aDateAndTime [ 
	stamp := aDateAndTime
]

{ #category : 'accessing' }
ICCalendarEntry >> uid [
	^uid
]

{ #category : 'accessing' }
ICCalendarEntry >> uid: aString [ 
	uid := aString
]

{ #category : 'accessing' }
ICCalendarEntry >> uidStrategy [

	^ UidStrategy
		ifNil: [ UidStrategy := ICRecommendedByStandardStrategy uuidstragetyClass new ]
]

{ #category : 'accessing' }
ICCalendarEntry >> uidStrategy: aStrategy [
	UidStrategy := aStrategy
]

{ #category : 'accessing' }
ICCalendarEntry >> url [
	^url
]

{ #category : 'accessing' }
ICCalendarEntry >> url: aUrl [ 
	url := aUrl
]
