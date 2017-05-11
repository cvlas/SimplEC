holdsFor(working(X)=true, I) :-
	holdsFor(loc(X)=work,I1),
	holdsFor(takingBreak(X)=true,I12),
	relative_complement_all(I1,[I12],I).

holdsFor(resting(X)=true, I) :-
	holdsFor(loc(X)=pub,I2),
	holdsFor(onHoliday(X)=true,I4),
	holdsFor(loc(X)=work,I19),
	holdsFor(takingBreak(X)=true,I22),
	intersect_all([I19,I22],I23),
	union_all([I4,I23,I2],I).

holdsFor(happy(X)=true, I) :-
	holdsFor(rich(X)=true,I2),
	holdsFor(resting(X)=true,I5),
	union_all([I2,I5],I).

holdsFor(sad(X)=true, I) :-
	holdsFor(poor(X)=true,I1),
	holdsFor(working(X)=true,I53),
	holdsFor(loc(X)=home,I68),
	holdsFor(changingDiapers(X)=true,I71),
	intersect_all([I68,I71],I72),
	union_all([I53,I72],I73),
	intersect_all([I1,I73],I).

holdsFor(friends(X,Y)=true, I) :-
	holdsFor(loc(X)=pub,I1),
	holdsFor(loc(Y)=pub,I4),
	intersect_all([I1,I4],I5),
	holdsFor(rich(X)=true,I65),
	holdsFor(rich(Y)=true,I68),
	union_all([I65,I68],I69),
	relative_complement_all(I5,[I69],I).

holdsFor(fighting(X,Y)=true, I) :-
	holdsFor(abrupt(X)=true,I2),
	holdsFor(abrupt(Y)=true,I5),
	union_all([I2,I5],I6),
	holdsFor(close(X,Y)=true,I9),
	intersect_all([I6,I9],I10),
	holdsFor(inactive(X)=true,I70),
	holdsFor(inactive(Y)=true,I73),
	union_all([I70,I73],I74),
	relative_complement_all(I10,[I74],I).

initiatedAt(moving(P1,P2)=true, T) :-
	happensAt(start(walking(P1)=true), T),
	holdsAt(walking(P2)=true, T),
	holdsAt(close(P1,P2)=true, T).

terminatedAt(moving(P1,P2)=true, T) :-
	happensAt(end(walking(P1)=true), T).

terminatedAt(moving(P1,P2)=true, T) :-
	happensAt(exit(P1), T).

