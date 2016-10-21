happy(X) iff
	rich(X) or
	atThePub(X).
	
friends(X,Y) iff
	atThePub(X),
	atThePub(Y),
	not(rich(X) or rich(Y)).