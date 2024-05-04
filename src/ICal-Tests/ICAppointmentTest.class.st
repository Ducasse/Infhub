Class {
	#name : 'ICAppointmentTest',
	#superclass : 'ICTest',
	#instVars : [
		'appointment'
	],
	#category : 'ICal-Tests',
	#package : 'ICal-Tests'
}

{ #category : 'running' }
ICAppointmentTest >> setUp [
	appointment := ICEvent summary: 'aTitle'.
	appointment location: 'Bern'.
	appointment textualDescription: 'description'.
	appointment addCategory: (ICCategory summary: 'first').
	appointment start: (self dateAndTimeClass  
				year: 2005
				month: 4
				day: 18
				hour: 21
				minute: 1
				second: 0).
	appointment end: (self dateAndTimeClass  
				year: 2005
				month: 4
				day: 18
				hour: 23
				minute: 59
				second: 0).

]

{ #category : 'testing' }
ICAppointmentTest >> testBasicInformation [

	self assert: appointment summary equals: 'aTitle'.
	appointment categories do: [ :each |
		self assert: each class equals: ICCategory ].
	self assert: appointment location equals: 'Bern'.
	self assert: appointment textualDescription equals: 'description'.
	self assert: appointment start class equals: self dateAndTimeClass.
	self assert: appointment start
		> (self dateAndTimeClass year: 2005 month: 4 day: 18).
	self assert: appointment end class equals: self dateAndTimeClass.
	self assert:
		appointment end
		> (self dateAndTimeClass year: 2005 month: 4 day: 18)
]
