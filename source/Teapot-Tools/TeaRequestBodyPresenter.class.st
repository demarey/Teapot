"
I graphically represent a request body that can be viewed in multiple ways.
"
Class {
	#name : #TeaRequestBodyPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'label',
		'raw',
		'form',
		'requestBodyLayout',
		'rawButton',
		'formButton'
	],
	#category : #'Teapot-Tools-UI-Components'
}

{ #category : #examples }
TeaRequestBodyPresenter class >> example [
	self new open
]

{ #category : #layout }
TeaRequestBodyPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: 'Request body' expand: false;
		  add: (SpBoxLayout newLeftToRight
				   add: rawButton expand: false;
				   add: formButton expand: false;
				   yourself)
		  expand: false;
		  add: requestBodyLayout;
		  yourself
]

{ #category : #private }
TeaRequestBodyPresenter >> formTabTitle [
	^ 'Form'
]

{ #category : #initialization }
TeaRequestBodyPresenter >> initializePresenters [

	rawButton := self newButton 
		label: 'Raw';
		action: [ self showRawPresenter ]
		yourself.
	formButton := self newButton 
		label: 'Form';
		action: [ self showFormPresenter ]
		yourself.
		
	raw := self newText
		autoAccept: true;
		yourself.
	form := TeaFormPresenter new.
	requestBodyLayout := form.
]

{ #category : #private }
TeaRequestBodyPresenter >> rawTabTitle [
	^ 'Raw'
]

{ #category : #accessing }
TeaRequestBodyPresenter >> requestBody [
	^ requestBodyLayout
]

{ #category : #private }
TeaRequestBodyPresenter >> showFormPresenter [
	requestBodyLayout := form.
	rawButton enabled: true.
	formButton enabled: false.
	self rebuildLayout
]

{ #category : #private }
TeaRequestBodyPresenter >> showRawPresenter [
	requestBodyLayout := raw.
	rawButton enabled: false.
	formButton enabled: true.
]

{ #category : #protocol }
TeaRequestBodyPresenter >> urlEncoded [
	requestBodyLayout selectedTab label = self formTabTitle
		ifTrue: [ raw text: form urlEncoded ].
	^ raw text
]
