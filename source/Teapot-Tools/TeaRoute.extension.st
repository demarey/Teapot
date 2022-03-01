Extension { #name : #TeaRoute }

{ #category : #'*Teapot-Tools' }
TeaRoute >> gtInspectorRouteIn: composite [
	<gtInspectorPresentationOrder: 80>
	| presentation |
	presentation := composite morph.
	presentation
		title: 'Teaspoon';
		display: 
			[ | teaspoon |
				teaspoon := Teaspoon new 
					method: requestMatcher methodMatcher asString
					url: requestMatcher urlPattern asTeaspoonPath
					port: port.
				teaspoon onHttpResultDo: [ :result | presentation selection: result ].
				teaspoon buildWithSpec ]
]

{ #category : #'*Teapot-Tools' }
TeaRoute >> inspectionItems: aBuilder [
	<inspectorPresentationOrder: 80 title: 'Teaspoon'>
	
	(aBuilder instantiate: Teaspoon)
			method: requestMatcher methodMatcher asString
				url: requestMatcher urlPattern asTeaspoonPath
				port: port.
	"TODO: onHttpResultDo: [ :result | presentation selection: result ]."
]
