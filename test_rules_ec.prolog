% X is working if he is at work and is not having a break
holdsFor(working(X)=true, IW) :-
	holdsFor(atWork(X)=true, IaW),
	holdsFor(takingBreak(X)=true, ITB),
	relative_complement_all(IaW, ITB, IW).

% X rests if he is at the pub or on holiday or at work and taking a break
holdsFor(resting(X)=true, IRest) :-
	holdsFor(atThePub(X)=true, IaTP),
	holdsFor(onHoliday(X)=true, IoH),
	holdsFor(atWork(X)=true, IaW),
	holdsFor(takingBreak(X)=true, ITB),
	intersect_all([IaW,ITB], IaWTB),
	union_all([IaTP,IoH,IaWTB], IRest).

% X is happy if he is rich or resting
holdsFor(happy(X)=true, IH) :-
	holdsFor(rich(X)=true, IRich),
	holdsFor(resting(X)=true, IRest),
	union_all([IRich,IRest],IH).

% X is sad if he is poor and working, or poor and changing his child's diapers at home (2 alternatives. TODO: which alternative is best?)
holdsFor(sad(X)=true, IS) :-
	holdsFor(poor(X)=true, IP),
	holdsFor(working(X)=true, IW),
	holdsFor(atHome(X)=true, IaH),
	holdsFor(changingDiapers(X)=true, ICD),
	intersect_all([IaH,ICD], IaHCD),
	intersect_all([IP,IaHCD], IPaHCD),
	intersect_all([IP,IW], IPW),
	union_all([IPaHCD,IPW], IS).

holdsFor(sad(X)=true, IS) :-
	holdsFor(poor(X)=true, IP),
	holdsFor(working(X)=true, IW),
	holdsFor(atHome(X)=true, IaH),
	holdsFor(changingDiapers(X)=true, ICD),
	intersect_all([IaH,ICD], IaHCD),
	union_all([IW,IaHCD], ISlave),
	intersect_all([IP,ISlave], IS).

% X and Y are friends if they are both at the pub and none of them is rich
holdsFor(friends(X,Y)=true, IF) :-
	holdsFor(atThePub(X)=true, IaTP1),
	holdsFor(atThePub(Y)=true, IaTP2),
	not(holdsFor(rich(X)=true, IRich1) or holdsFor(rich(Y)=true, IRich2)),
	intersect_all([IaTP1,IaTP2], ITogether),
	relative_complement_all(ITogether, [IRich1,IRich2], IF).
