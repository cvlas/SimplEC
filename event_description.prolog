holdsFor(working(X)=true, I1) :-
	holdsFor(loc(X)=work,I2),
	holdsFor(takingBreak(X)=true,I13),
	relative_complement_all(I2,[I13],I1)

holdsFor(resting(X)=true, I16) :-
	holdsFor(loc(X)=pub,I18),
	holdsFor(onHoliday(X)=true,I20),
	holdsFor(loc(X)=work,I35),
	holdsFor(takingBreak(X)=true,I38),
	intersect_all([I35,I38],I39),
	union_all([I20,I39,I18],I16)

holdsFor(happy(X)=true, I42) :-
	holdsFor(rich(X)=true,I44),
	holdsFor(resting(X)=true,I47),
	union_all([I44,I47],I42)

holdsFor(sad(X)=true, I49) :-
	holdsFor(poor(X)=true,I50),
	holdsFor(working(X)=true,I102),
	holdsFor(loc(X)=home,I117),
	holdsFor(changingDiapers(X)=true,I120),
	intersect_all([I117,I120],I121),
	union_all([I102,I121],I122),
	intersect_all([I50,I122],I49)

holdsFor(friends(X,Y)=true, I124) :-
	holdsFor(loc(X)=pub,I125),
	holdsFor(loc(Y)=pub,I128),
	intersect_all([I125,I128],I129),
	holdsFor(rich(X)=true,I189),
	holdsFor(rich(Y)=true,I192),
	union_all([I189,I192],I193),
	relative_complement_all(I129,[I193],I124)

holdsFor(fighting(X,Y)=true, I196) :-
	holdsFor(abrupt(X)=true,I198),
	holdsFor(abrupt(Y)=true,I201),
	union_all([I198,I201],I202),
	holdsFor(close(X,Y)=true,I205),
	intersect_all([I202,I205],I206),
	holdsFor(inactive(X)=true,I266),
	holdsFor(inactive(Y)=true,I269),
	union_all([I266,I269],I270),
	relative_complement_all(I206,[I270],I196)

initiatedAt(moving(P1,P2)=true, T) :-
	happensAt(start(walking(P1)=true), T),
	holdsAt(walking(P2)=true, T),
	holdsAt(close(P1,P2)=true, T).

terminatedAt(moving(P1,P2)=true, T) :-
	happensAt(end(walking(P1)=true), T).

terminatedAt(moving(P1,P2)=true, T) :-
	happensAt(exit(P1), T).

