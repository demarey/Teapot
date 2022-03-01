"
I'm built up from a dynamically extensible key value pair list (TeaKeyValueInput). I can represent POST parameters or HTTP headers for example.
"
Class {
	#name : #TeaFormPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'form',
		'addButton'
	],
	#category : #'Teapot-Tools-UI-Components'
}

{ #category : #examples }
TeaFormPresenter class >> example [
	self new open
]

{ #category : #layout }
TeaFormPresenter >> defaultLayout [
	^ SpBoxLayout newTopToBottom
				add: form;
				add: addButton expand: false;
				yourself
]

{ #category : #initialization }
TeaFormPresenter >> initializePresenters [

	addButton := self newButton
		             label: 'Add parameter';
		             action: [ form addKey: '' value: '' ]; yourself.
	form := self instantiate: TeaKeyValueListPresenter.
	self focusOrder
		add: form;
		add: addButton
]

{ #category : #protocol }
TeaFormPresenter >> updateKeyValus: keyValueCollection [
	form items: keyValueCollection
]

{ #category : #private }
TeaFormPresenter >> urlEncoded [
	| url formParams |
	url := '/' asZnUrl.
	formParams := form items.
	formParams ifEmpty: [ ^ '' ].
	formParams do: [ :association | url := url withQuery: association ].
	^ url asString allButFirst: 2
	
]

{ #category : #protocol }
TeaFormPresenter >> writeUrlEncodedTo: aTextModel [
	self urlEncoded 
		ifNotEmpty: [ aTextModel text: self urlEncoded ]
]
