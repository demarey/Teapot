"
I'm built up from a dynamically extensible list of other components.
"
Class {
	#name : #TeaKeyValueListPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'presenters',
		'parameters'
	],
	#category : #'Teapot-Tools-UI-Components'
}

{ #category : #examples }
TeaKeyValueListPresenter class >> example [
	self new 
		items: (Dictionary 
			with: 'a' -> 1;
			with: 'b' -> 'four');
		open
]

{ #category : #protocol }
TeaKeyValueListPresenter >> addKey: keyString value: valueString [
	parameters := parameters at: keyString put: valueString.
	self rebuildLayout.
]

{ #category : #adding }
TeaKeyValueListPresenter >> addKeyValuePresenter [
	| keyInput valueInput removeButton |
	keyInput := self newTextInput placeholder: 'key'; yourself.
	valueInput := self newTextInput placeholder: 'value'; yourself.
	removeButton := self newButton label: 'Remove'; yourself.
	self focusOrder
		add: keyInput;
		add: valueInput;
		add: removeButton.
]

{ #category : #layout }
TeaKeyValueListPresenter >> defaultLayout [
	^ SpBoxLayout newTopToBottom
]

{ #category : #initialization }
TeaKeyValueListPresenter >> initialize [
	super initialize.
	parameters := OrderedDictionary new.
]

{ #category : #protocol }
TeaKeyValueListPresenter >> items [
	^ self withoutDuplicatesAndBlanks: parameters
]

{ #category : #protocol }
TeaKeyValueListPresenter >> items: keyedCollection [
	parameters addAll: (self withoutDuplicatesAndBlanks: keyedCollection).
	self rebuildLayout.
]

{ #category : #private }
TeaKeyValueListPresenter >> rebuildLayout [

	self focusOrder removeAll.
	layout := SpBoxLayout newTopToBottom.
	parameters doWithIndex: [ :assoc :i | 
		| keyValuePresenter |
		keyValuePresenter := self instantiate: TeaKeyValueInputPresenter.
		keyValuePresenter key: assoc key value: assoc value.
		layout add: keyValuePresenter.
		self focusOrder add: keyValuePresenter ].
	self layout: layout
]

{ #category : #private }
TeaKeyValueListPresenter >> withoutDuplicatesAndBlanks: keyedCollection [
	| keyset |
	keyset := PluggableSet new
		equalBlock: [ :a :b | a key = b key ];
		hashBlock: [ :x | x key hash ];
		yourself.				
	keyedCollection keysAndValuesDo: [ :key :value | 
		keyset add: (key -> value) ].
	^ keyset reject: [ :each | 
		each key isEmptyOrNil or: [ each value isEmptyOrNil ] ]
]
