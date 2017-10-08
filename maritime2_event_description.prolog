holdsFor(activeOrInactivePerson(P)=true, I) :-
	holdsFor(active(P)=true,I2),
	holdsFor(inactive(P)=true,I3),
	holdsFor(person(P)=true,I4),
	intersect_all([I3,I4],I5),
	union_all([I2,I5],I).

holdsFor(close(Id1,Id2,Threshold)=false, I) :-
	holdsFor(close(Id1,Id2,Threshold)=true,I1),
	complement_all([I1],I).

initiatedAt(moving(P1,P2)=true, T) :-
	happensAt(start(walking(P1)=true), T),
	holdsAt(walking(P2)=true, T),
	holdsAt(close(P1,P2)=true, T).

initiatedAt(moving(P1,P2)=true, T) :-
	happensAt(start(walking(P2)=true), T),
	holdsAt(walking(P1)=true, T),
	holdsAt(close(P1,P2)=true, T).

initiatedAt(moving(P1,P2)=true, T) :-
	happensAt(start(close(P1,P2)=true), T),
	holdsAt(walking(P1)=true, T),
	holdsAt(walking(P2)=true, T).

terminatedAt(moving(P1,P2)=true, T) :-
	happensAt(end(walking(P1)=true), T).

terminatedAt(moving(P1,P2)=true, T) :-
	happensAt(end(walking(P2)=true), T).

terminatedAt(moving(P1,P2)=true, T) :-
	happensAt(end(close(P1,P2)=true), T).

holdsFor(moving(P1,P2)=true, I) :-
	holdsFor(walking(P1)=true,I1),
	holdsFor(walking(P2)=true,I2),
	holdsFor(close(P1,P2)=true,I3),
	intersect_all([I1,I2,I3],I).

holdsFor(greeting1(P1,P2)=true, I) :-
	holdsFor(activeOrInactivePerson(P1)=true,I1),
	holdsFor(person(P2)=true,I2),
	holdsFor(close(P1,P2,25)=true,I3),
	holdsFor(running(P2)=true,I5),
	holdsFor(abrupt(P2)=true,I6),
	union_all([I5,I6],I7),
	intersect_all([I1,I2,I3],I9),
	relative_complement_all(I9,[I7],I).

holdsFor(fighting(P1,P2)=true, I) :-
	holdsFor(abrupt(P1)=true,I1),
	holdsFor(abrupt(P2)=true,I2),
	union_all([I1,I2],I3),
	holdsFor(close(P1,P2)=true,I4),
	holdsFor(inactive(P1)=true,I6),
	holdsFor(inactive(P2)=true,I7),
	union_all([I6,I7],I8),
	intersect_all([I3,I4],I10),
	relative_complement_all(I10,[I8],I).

