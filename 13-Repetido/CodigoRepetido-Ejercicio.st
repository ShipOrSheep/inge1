!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'JD 4/15/2021 12:50:37'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self executingClosure: [customerBook addCustomerNamed: 'John Lennon'] shouldNotTakeMoreThanMiliseconds:50.
	"""
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	customerBook addCustomerNamed: 'John Lennon'.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (50 * millisecond)"""
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JD 4/15/2021 12:50:44'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self executingClosure: [customerBook removeCustomerNamed: paulMcCartney] shouldNotTakeMoreThanMiliseconds:50.
	  """
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	customerBook removeCustomerNamed: 'Paul McCartney'.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (100 * millisecond)"""
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'franco c 4/15/2021 10:16:28'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self executingClosure: [ customerBook addCustomerNamed: ''.
	self fail ] shouldRaise: Error toExecute: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].
"""
	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]
"""! !

!CustomerBookTest methodsFor: 'testing' stamp: 'franco c 4/15/2021 10:19:45'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self executingClosure: [ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ] shouldRaise: NotFound toExecute:  [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].

	"""
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
	"""
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JD 4/15/2021 14:00:18'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	self addAndSuspendCustomerAndThenExecuteOperationNamed: 'void' assertNumberOfActiveCustomers: 0 assertNumberOfSuspendedCustomers: 1 assertNumberOfCustomers: 1 finallyExecuteOperationNamed: 'assert'.

	"""| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: paulMcCartney)."""
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JD 4/15/2021 14:04:19'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	self addAndSuspendCustomerAndThenExecuteOperationNamed: 'remove' assertNumberOfActiveCustomers: 0 assertNumberOfSuspendedCustomers: 0 assertNumberOfCustomers: 0 finallyExecuteOperationNamed: 'deny'.

	"""| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers.
	self deny: (customerBook includesCustomerNamed: paulMcCartney)."""! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JD 4/15/2021 14:38:46'!
test07CanNotSuspendAnInvalidCustomer
	
self addCustomerThenExecuteOperationNamed: '' thenSuspendAndCatchErrorOnCustomerNamed: 'George Harrison'.
"""| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: 'George Harrison'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]"""! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JD 4/15/2021 14:39:18'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	self addCustomerThenExecuteOperationNamed: 'suspend' thenSuspendAndCatchErrorOnCustomerNamed: 'John Lennon'.

"""| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: johnLennon.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]"""! !


!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'JD 4/15/2021 13:59:16'!
addAndSuspendCustomerAndThenExecuteOperationNamed: anOperationName1 assertNumberOfActiveCustomers: numOfActiveCustomers assertNumberOfSuspendedCustomers: numOfSuspendedCustomers  assertNumberOfCustomers: numOfCustomers finallyExecuteOperationNamed: anOperationName2
| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	(anOperationName1 = 'remove') ifTrue: [customerBook removeCustomerNamed: paulMcCartney] ifFalse: [].
	
	self assert: numOfActiveCustomers equals: customerBook numberOfActiveCustomers.
	self assert: numOfSuspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: numOfCustomers equals: customerBook numberOfCustomers.
	(anOperationName2 = 'assert') ifTrue: [self assert: (customerBook includesCustomerNamed: paulMcCartney)] ifFalse: [self deny: (customerBook includesCustomerNamed: paulMcCartney)]
	
"""| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: paulMcCartney)."""
	
	"""| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers.
	self deny: (customerBook includesCustomerNamed: paulMcCartney)."""
! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'JD 4/15/2021 14:38:00'!
addCustomerThenExecuteOperationNamed: anOperationName1 thenSuspendAndCatchErrorOnCustomerNamed: aCustomerName

	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	(anOperationName1 = 'suspend') ifTrue:[customerBook suspendCustomerNamed: johnLennon.] ifFalse:[].
	
	[ customerBook suspendCustomerNamed: aCustomerName.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
		! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'JD 4/15/2021 12:50:18'!
executingClosure: aClosure shouldNotTakeMoreThanMiliseconds: aNumberOfMiliseconds

	|millisecondsBeforeRunning milisecondsAfterRunning|
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	milisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (milisecondsAfterRunning-millisecondsBeforeRunning) < (aNumberOfMiliseconds * millisecond)! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'franco c 4/15/2021 10:18:44'!
executingClosure: Closure1 shouldRaise: anError toExecute: Closure2


             ^(	Closure1 
		on: anError
		do: Closure2 )! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'franco c 4/14/2021 17:04:20'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'franco c 4/15/2021 10:09:09'!
removeCustomerNamed: aName 
 
	(self removeCustomer: aName from: active) = aName ifTrue:[^aName].
	(self removeCustomer: aName from: suspended) = aName ifTrue:[^aName].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'franco c 4/14/2021 17:30:29'!
suspendCustomerNamed: aName 
	
	(self removeCustomer: aName from:active )= 'notFound' ifTrue:[^CantSuspend signal].
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'as yet unclassified' stamp: 'franco c 4/15/2021 10:08:34'!
removeCustomer: aName from:aList
	
	aList remove: aName ifAbsent: [^'notFound'.].
	^aName.
	

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:13'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:09'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!!!!!'! !
