Class {
	#name : 'ICAddCategoryTest',
	#superclass : 'ICTest',
	#instVars : [
		'calendar'
	],
	#category : 'ICal-Tests',
	#package : 'ICal-Tests'
}

{ #category : 'running' }
ICAddCategoryTest >> setUp [
	calendar := ICCalendar new

]

{ #category : 'testing' }
ICAddCategoryTest >> testSave [
	| savedCategory category |
	category := ICCategory new
				color: 'green';
				summary: 'greenpeace';
				textualDescription: 'this is a category for all greenpeace events';
				yourself.
	calendar addCategory: category.
	savedCategory := calendar categories anyOne .
	self assert: calendar categories size = 1.
	self assert: savedCategory summary = 'greenpeace'.
	self assert: savedCategory color = 'green'.
	self assert: savedCategory textualDescription  
				= 'this is a category for all greenpeace events'

]
