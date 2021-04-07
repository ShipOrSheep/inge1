!classDefinition: #I category: 'Numeros Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros Naturales'!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'as yet unclassified' stamp: 'franco c 4/7/2021 16:23:15'!
* unNumero
	^unNumero.
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 4/5/2021 20:46:25'!
+ unSumando

	^unSumando next! !

!I class methodsFor: 'as yet unclassified' stamp: 'JC 4/7/2021 12:31:38'!
- unSustraendo

 ^unSustraendo loRestoA: self! !

!I class methodsFor: 'as yet unclassified' stamp: 'JC 4/7/2021 19:38:22'!
/ unNumero
	(unNumero > self) ifTrue: [ ^'Error'] ifFalse: [^I]! !

!I class methodsFor: 'as yet unclassified' stamp: 'JC 4/7/2021 17:15:19'!
< unNumero

	(unNumero = I) ifTrue: [^false] ifFalse:[^true]! !

!I class methodsFor: 'as yet unclassified' stamp: 'franco c 4/7/2021 17:02:23'!
> unNumero
	^false.! !

!I class methodsFor: 'as yet unclassified' stamp: 'initialD 4/7/2021 19:51:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JC 4/7/2021 19:37:30'!
loRestoA: unSustraendo

 ^unSustraendo previous! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 4/5/2021 20:31:42'!
next

	^II! !


!classDefinition: #II category: 'Numeros Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros Naturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'franco c 4/7/2021 16:22:48'!
* unNumero
	^((self  previous)* unNumero +  unNumero) ! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 4/5/2021 20:56:14'!
+ unSumando

	^self previous + unSumando next! !

!II class methodsFor: 'as yet unclassified' stamp: 'JC 4/7/2021 19:40:59'!
- unSustraendo
	
	^unSustraendo loRestoA: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'JC 4/7/2021 17:29:04'!
/ unNumero
	(unNumero > self) ifTrue: [ ^'Error'].
	(unNumero < self) ifTrue: [
		(self - unNumero < unNumero) ifTrue:[^I] ifFalse:[^(self - unNumero / unNumero) + I]
		] ifFalse: [^I]! !

!II class methodsFor: 'as yet unclassified' stamp: 'JC 4/7/2021 17:15:13'!
< unNumero

	(unNumero = I) ifTrue: [^false] ifFalse:[^self previous < unNumero previous]! !

!II class methodsFor: 'as yet unclassified' stamp: 'franco c 4/7/2021 17:08:07'!
> unNumero
	(unNumero = I) ifTrue:[^true].
	^(self previous) > (unNumero previous)! !

!II class methodsFor: 'as yet unclassified' stamp: 'initialD 4/7/2021 19:51:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'JC 4/7/2021 19:40:39'!
loRestoA: unNumero
	^(self previous) loRestoA: (unNumero previous).! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 4/5/2021 21:07:59'!
next

	next ifNil:[
		next _ self createChildNamed: self name, 'I'.
		next previous: self.
		].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 4/5/2021 20:57:01'!
previous
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'JC 4/7/2021 16:35:48'!
previous: unNumero

	previous := unNumero! !

I initializeAfterFileIn!
II initializeAfterFileIn!