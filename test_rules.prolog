% X is working if he is at work and is not having a break
working(X) iff
	atWork(X),
	not(takingBreak(X)).

% X rests if he is at the pub or on holiday or at work and taking a break
resting(X) iff
	atThePub(X) or
	onHoliday(X) or
	(atWork(X), takingBreak(X)).

% X is happy if he is rich or resting
happy(X) iff
	rich(X) or
	resting(X).

% X is sad if he is poor and working, or poor and changing his child's diapers at home
sad(X) iff
	poor(X),
	(working(X) or (atHome(X), changingDiapers(X))).

% X and Y are friends if they are both at the pub and none of them is rich
friends(X,Y) iff
	atThePub(X),
	atThePub(Y),
	not(rich(X) or rich(Y)).
