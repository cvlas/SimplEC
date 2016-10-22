working(X) iff
	atWork(X),
	not(takeBreak(X)).
	
rest(X) iff
	atThePub(X) or onHoliday(X) or takeBreak(X).

happy(X) iff
	rich(X) or rest(X).
	
sad(X) iff
	poor(X),
	(working(X) or (atHome(X), changeDiapers(X))).
	
friends(X,Y) iff
	atThePub(X),
	atThePub(Y),
	not(rich(X) or rich(Y)).
