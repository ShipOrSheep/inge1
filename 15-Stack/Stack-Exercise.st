!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 4/22/2021 17:25:26'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstObject'.
	secondPushedObject := 'secondObject'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'finder emptyStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'franco c 4/28/2021 15:35:51'!
test01FindsSentence

	|expectedResult|
	
	
	self pushElementsFrom: #('uno dos' 'tres') into: emptyStack. 
	expectedResult := OrderedCollection with: 'uno dos'.
	
	self assert: expectedResult equals: (finder find: 'u' in: emptyStack).! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'franco c 4/28/2021 15:36:02'!
test02FindDoesntModifyStack

	|stack|
	
	stack := OOStack new.
	self pushElementsFrom: #('uno' 'dos') into: stack.
	finder find: 'u' in: stack.
	
	self assert: stack size equals: 2.
	self assert: stack pop equals: 'dos'.
	self assert: stack pop equals: 'uno'! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'franco c 4/28/2021 14:44:12'!
test03EmptyPrefixIsInvalid

	
	|stack|
	
	stack := OOStack new.
	stack push: 'uno'.
	
	self 
		should: [finder find: '' in: stack]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: (SentenceFinderByPrefix invalidPrefixErrorDescription)]. ! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'franco c 4/28/2021 15:11:35'!
test04PrefixWithSpaceIsInvalid

	|stack|
	
	stack := OOStack new.
	stack push: 'uno dos'.
	
	self 
		should: [finder find: 'uno dos' in: stack]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: (SentenceFinderByPrefix emptySpaceErrorDescription)]. ! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'franco c 4/28/2021 15:41:28'!
test05FinderIsCaseSensitive

	|stack expectedResult|
	
	stack := OOStack new.
	self pushElementsFrom: #('uno' 'Uno') into: stack.
	expectedResult := OrderedCollection with: 'Uno'.
	
	self assert: expectedResult equals: (finder find: 'Uno' in: stack).! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'franco c 4/28/2021 14:55:41'!
test06FindsMultipleInstances

	|stack expectedResult|
	
	stack := OOStack new.
	self pushElementsFrom: #('uno dos' 'dos tres' 'dos') into: stack.
	expectedResult := OrderedCollection with: 'dos' with: 'dos tres'.
	
	self assert: expectedResult equals: (finder find: 'dos' in: stack).
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'franco c 4/28/2021 14:44:48'!
test07PrefixLongerThanSentencesDoesntFail

	|stack expectedResult|
	
	stack := OOStack new.
	stack push: 'uno'. 
	expectedResult := OrderedCollection new.
	
	self assert: expectedResult equals: (finder find: 'unos' in: stack).! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'franco c 4/28/2021 14:44:59'!
test08PrefixNotPresentReturnsEmptyCollection

	|stack expectedResult|
	
	stack := OOStack new.
	stack push: 'uno'.
	expectedResult := OrderedCollection new.
	
	self assert: expectedResult equals: (finder find: 'dos' in: stack).! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'franco c 4/28/2021 14:45:07'!
test09FinderOnEmptyStackReturnsEmptyCollection

	|expectedResult|
	
	expectedResult := OrderedCollection new.
	
	self assert: expectedResult equals: (finder find: 'tres' in: emptyStack).! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'franco c 4/28/2021 14:45:23'!
test10FindsSentencesWithSpaces

	|stack expectedResult|
	
	stack := OOStack new.
	stack push: 'uno dos'. 
	expectedResult := OrderedCollection with: 'uno dos'.
	
	self assert: expectedResult equals: (finder find: 'uno' in: stack).! !


!SentenceFinderByPrefixTest methodsFor: 'actions' stamp: 'franco c 4/28/2021 14:47:39'!
pushElementsFrom: array into: stack

	array do: [:element | stack push: element]! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'franco c 4/28/2021 14:42:36'!
setUp

	finder := SentenceFinderByPrefix new.
	emptyStack := OOStack new.
! !


!classDefinition: #Node category: #'Stack-Exercise'!
Object subclass: #Node
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Node methodsFor: 'getters' stamp: 'franco c 4/28/2021 14:29:07'!
isEmpty
	
	self subclassResponsibility. ! !

!Node methodsFor: 'getters' stamp: 'franco c 4/28/2021 14:29:18'!
previousIfNone: blockToExecuteIfNone
	
	self subclassResponsibility.! !

!Node methodsFor: 'getters' stamp: 'franco c 4/28/2021 14:29:44'!
storedObjectIfNone: blockToExecuteIfNone

	self subclassResponsibility.! !


!classDefinition: #RootNode category: #'Stack-Exercise'!
Node subclass: #RootNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!RootNode methodsFor: 'getters' stamp: 'franco c 4/28/2021 14:30:02'!
isEmpty

	^true.! !

!RootNode methodsFor: 'getters' stamp: 'franco c 4/28/2021 14:30:18'!
previousIfNone: blockToExecuteIfNone

	^blockToExecuteIfNone value.

	! !

!RootNode methodsFor: 'getters' stamp: 'franco c 4/28/2021 14:35:22'!
storedObjectIfNone: blockToExecuteIfNone

	^blockToExecuteIfNone value.! !


!classDefinition: #ValidNode category: #'Stack-Exercise'!
Node subclass: #ValidNode
	instanceVariableNames: 'storedObject previousNode'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ValidNode methodsFor: 'getters' stamp: 'franco c 4/28/2021 14:36:33'!
isEmpty
	
	^false.! !

!ValidNode methodsFor: 'getters' stamp: 'franco c 4/28/2021 14:36:47'!
previousIfNone: blockToExecuteIfNone
	
	^previousNode.! !

!ValidNode methodsFor: 'getters' stamp: 'franco c 4/28/2021 14:36:56'!
storedObjectIfNone: blockToExecuteIfNone

	^storedObject copy.! !


!ValidNode methodsFor: 'initialization' stamp: 'franco c 4/28/2021 14:35:50'!
initializeWith: objectToStore asChildOf: parentNode

	storedObject  := objectToStore.
	previousNode := parentNode.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ValidNode class' category: #'Stack-Exercise'!
ValidNode class
	instanceVariableNames: ''!

!ValidNode class methodsFor: 'initialization' stamp: 'franco c 4/28/2021 14:40:02'!
with: objectToStore asChildOf: parentNode

	^self new initializeWith: objectToStore asChildOf: 	parentNode. ! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'actions' stamp: 'franco c 4/28/2021 14:37:58'!
pop
	
	|poppedTop|
	
	poppedTop := top.
	top := poppedTop previousIfNone: [self raiseEmptyStackError].
	size := size - 1.
	
	^poppedTop storedObjectIfNone: [self raiseEmptyStackError]. ! !

!OOStack methodsFor: 'actions' stamp: 'franco c 4/28/2021 14:39:04'!
push: objectToStore

	|newTop|
	
	newTop := ValidNode with: objectToStore asChildOf: top.
	
	top := newTop. 
	size := size + 1.! !


!OOStack methodsFor: 'getters' stamp: 'franco c 4/28/2021 14:37:35'!
isEmpty
	
	^top isEmpty.! !

!OOStack methodsFor: 'getters' stamp: 'franco c 4/28/2021 14:39:27'!
size 

	^size.! !

!OOStack methodsFor: 'getters' stamp: 'franco c 4/28/2021 14:39:38'!
top
	
	^top storedObjectIfNone: [self raiseEmptyStackError].! !


!OOStack methodsFor: 'errors' stamp: 'franco c 4/28/2021 14:39:18'!
raiseEmptyStackError

	^self error: self class stackEmptyErrorDescription.! !


!OOStack methodsFor: 'initialization' stamp: 'franco c 4/28/2021 14:37:23'!
initialize
	
	top := RootNode new.
	size := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 4/22/2021 17:22:41'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'foundElements popedElements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'comparers' stamp: 'franco c 4/28/2021 15:57:43'!
check: popedElement biggerthan: aString

	^(popedElement size >= aString size)! !

!SentenceFinderByPrefix methodsFor: 'comparers' stamp: 'franco c 4/28/2021 15:46:59'!
checkPrefixhasnoSpaces: aString

	^1 to: (aString size) do: [:a | (aString at: a) = $   ifTrue:[^self raisePrefixCantContainEmptySpaces]].! !

!SentenceFinderByPrefix methodsFor: 'comparers' stamp: 'franco c 4/28/2021 15:46:47'!
checkPrefixisValid: aString
	
	self checkPrefixnotEmpty: aString.
	
	self checkPrefixhasnoSpaces: aString.
	
! !

!SentenceFinderByPrefix methodsFor: 'comparers' stamp: 'franco c 4/28/2021 15:45:37'!
checkPrefixnotEmpty: aString

	^aString size = 0 ifTrue:[^self raisePrefixCantBeEmpty].! !


!SentenceFinderByPrefix methodsFor: 'errors' stamp: 'franco c 4/28/2021 15:04:20'!
raisePrefixCantBeEmpty
	^self error: self class invalidPrefixErrorDescription! !

!SentenceFinderByPrefix methodsFor: 'errors' stamp: 'franco c 4/28/2021 15:10:57'!
raisePrefixCantContainEmptySpaces

	^self error: self class emptySpaceErrorDescription.! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'franco c 4/28/2021 15:00:26'!
initialize

	popedElements :=OrderedCollection new.
	foundElements  := OrderedCollection new.! !


!SentenceFinderByPrefix methodsFor: 'actions' stamp: 'franco c 4/28/2021 16:07:49'!
addtoMatchingElementslistif:aString matches: popedElement 

	aString = (popedElement copyFrom: 1 to: aString size)  ifTrue:[foundElements add:popedElement]! !

!SentenceFinderByPrefix methodsFor: 'actions' stamp: 'franco c 4/28/2021 15:52:05'!
find: aString in: aStack
	
	self checkPrefixisValid: aString.
	
	self saveElementsWhere: aString Matches: aStack.
	
	self pushBackElementstoStack: aStack.
	
	^foundElements
	
! !

!SentenceFinderByPrefix methodsFor: 'actions' stamp: 'franco c 4/28/2021 15:49:11'!
pushBackElementstoStack: aStack

	1 to: (popedElements size) do: [:a|
		aStack push: (popedElements at: ((popedElements size) +1 -a) )
		].! !

!SentenceFinderByPrefix methodsFor: 'actions' stamp: 'franco c 4/28/2021 16:08:16'!
saveElementsWhere: aString Matches: aStack
	|popedElement|
	1 to: (aStack size) do: [:a | 
		popedElement:= aStack pop.
		popedElements add: popedElement.
		(self check: popedElement biggerthan: aString)  ifTrue:[
			self addtoMatchingElementslistif:aString matches: popedElement
			]
		].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'errorsdescription' stamp: 'franco c 4/28/2021 15:11:17'!
emptySpaceErrorDescription

	^'prefix cant contain spaces'! !

!SentenceFinderByPrefix class methodsFor: 'errorsdescription' stamp: 'franco c 4/28/2021 15:04:45'!
invalidPrefixErrorDescription
	^'Prefix cant be empty'! !
