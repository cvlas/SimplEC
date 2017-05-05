holdsFor(working(X)=true, I1) :-
	holdsFor(loc(X)=work,I2),
	holdsFor(takingBreak(X)=true,I13),
	complement_all([I13],I14),
	intersect_all([I2,I14],I1)

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
	holdsFor(loc(Y)=pub,I126),
	holdsFor(rich(X)=true,I186),
	holdsFor(rich(Y)=true,I189),
	union_all([I186,I189],I190),
	complement_all([I190],I191),
	intersect_all([I126,I191,I125],I124)

holdsFor(fighting(X,Y)=true, I194) :-
	holdsFor(abrupt(X)=true,I196),
	holdsFor(abrupt(Y)=true,I199),
	union_all([I196,I199],I200),
	holdsFor(close(X,Y)=true,I203),
	holdsFor(inactive(X)=true,I264),
	holdsFor(inactive(Y)=true,I267),
	union_all([I264,I267],I268),
	complement_all([I268],I269),
	intersect_all([I200,I203,I269],I194)

initiatedAt(moving(P1,P2)=true, T) :-
	happensAt(start(walking(P1)=true), T),
	holdsAt(walking(P2)=true, T),
	holdsAt(close(P1,P2)=true, T).

terminatedAt(moving(P1,P2)=true, T) :-
	happensAt(end(walking(P1)=true), T).

terminatedAt(moving(P1,P2)=true, T) :-
	happensAt(exit(P1), T).

