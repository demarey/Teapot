"
Two inputs and a remove button.
"
Class {
	#name : #TeaKeyValueInputPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'keyInput',
		'valueInput',
		'removeButton'
	],
	#category : #'Teapot-Tools-UI-Components'
}

{ #category : #examples }
TeaKeyValueInputPresenter class >> example [
	(self key: '1' value: 'One' removeAction: [  ]) open 
]

{ #category : #'instance creation' }
TeaKeyValueInputPresenter class >> key: keyString value: valueString removeAction: aBlock [
	^ self new
		setKey: keyString 
		value: valueString
		removeAction: aBlock
]

{ #category : #converting }
TeaKeyValueInputPresenter >> asAssociation [
	^ keyInput text -> valueInput text
]

{ #category : #layout }
TeaKeyValueInputPresenter >> defaultLayout [

	^ SpGridLayout build: [ :builder | 
		  builder
			  add: keyInput;
			  add: valueInput;
			  add: removeButton;
			  yourself ]
]

{ #category : #initialization }
TeaKeyValueInputPresenter >> initializePresenters [	
	keyInput := self newTextInput placeholder: 'key'; yourself.
	valueInput := self newTextInput placeholder: 'value'; yourself.
	removeButton := self newButton label: 'Remove'; yourself.
	self focusOrder
		add: keyInput;
		add: valueInput;
		add: removeButton.
		

]

{ #category : #initialization }
TeaKeyValueInputPresenter >> setKey: keyString value: valueString removeAction: aBlock [
	keyInput text: keyString.
	valueInput text: valueString.
	removeButton action: [ aBlock value: self ].
	^ self
]
