holdsFor(close(Id1,Id2,24)=true, I) :-
	holdsFor(distance(Id1,Id2,24)=true,I).

holdsFor(close(Id1,Id2,25)=true, I) :-
	holdsFor(close(Id1,Id2,24)=true,I2),
	holdsFor(distance(Id1,Id2,25)=true,I5),
	union_all([I2,I5],I).

holdsFor(close(Id1,Id2,30)=true, I) :-
	holdsFor(close(Id1,Id2,25)=true,I2),
	holdsFor(distance(Id1,Id2,30)=true,I5),
	union_all([I2,I5],I).

holdsFor(close(Id1,Id2,34)=true, I) :-
	holdsFor(close(Id1,Id2,30)=true,I2),
	holdsFor(distance(Id1,Id2,34)=true,I5),
	union_all([I2,I5],I).

holdsFor(close(Id1,Id2,Threshold)=false, I) :-
	holdsFor(close(Id1,Id2,Threshold)=true,I19),
	complement_all([I19],I).

holdsFor(closeSymmetric(Id1,Id2,Threshold)=true, I) :-
	holdsFor(close(Id1,Id2,Threshold)=true,I2),
	holdsFor(close(Id2,Id1,Threshold)=true,I5),
	union_all([I2,I5],I).

initiatedAt(person(Id)=true, T) :-
	happensAt(start(walking(Id)=true), T),
	\+ happensAt(disappear(Id), T).

initiatedAt(person(Id)=true, T) :-
	happensAt(start(running(Id)=true), T),
	\+ happensAt(disappear(Id), T).

initiatedAt(person(Id)=true, T) :-
	happensAt(start(active(Id)=true), T),
	\+ happensAt(disappear(Id), T).

initiatedAt(person(Id)=true, T) :-
	happensAt(start(abrupt(Id)=true), T),
	\+ happensAt(disappear(Id), T).

initiatedAt(person(Id)=false, T) :-
	happensAt(disappear(Id), T).

initiatedAt(leaving_object(Person,Object)=true, T) :-
	happensAt(appear(Object), T),
	holdsAt(inactive(Object)=true, T),
	holdsAt(person(Person)=true, T),
	holdsAt(closeSymmetric(Person,Object,30)=true, T).

initiatedAt(leaving_object(Person,Object)=false, T) :-
	happensAt(disappear(Object), T).

initiatedAt(meeting(P1,P2)=true, T) :-
	happensAt(start(greeting1(P1,P2)=true), T),
	\+ happensAt(disappear(P1), T),
	\+ happensAt(disappear(P2), T).

initiatedAt(meeting(P1,P2)=true, T) :-
	happensAt(start(greeting2(P1,P2)=true), T),
	\+ happensAt(disappear(P1), T),
	\+ happensAt(disappear(P2), T).

holdsFor(greeting1(P1,P2)=true, I) :-
	holdsFor(activeOrInactivePerson(P1)=true,I1),
	holdsFor(person(P2)=true,I2),
	holdsFor(close(P1,P2,25)=true,I5),
	intersect_all([I1,I2,I5],I7),
	holdsFor(running(P2)=true,I121),
	holdsFor(abrupt(P2)=true,I124),
	union_all([I121,I124],I125),
	relative_complement_all(I7,[I125],I).

holdsFor(greeting2(P1,P2)=true, I) :-
	holdsFor(walking(P1)=true,I1),
	holdsFor(activeOrInactivePerson(P2)=true,I2),
	holdsFor(close(P2,P1,25)=true,I5),
	intersect_all([I1,I2,I5],I).

holdsFor(activeOrInactivePerson(P)=true, I) :-
	holdsFor(active(P)=true,I2),
	holdsFor(inactive(P)=true,I65),
	holdsFor(person(P)=true,I68),
	intersect_all([I65,I68],I69),
	union_all([I2,I69],I).

initiatedAt(meeting(P1,P2)=false, T) :-
	happensAt(start(running(P1)=true), T).

initiatedAt(meeting(P1,P2)=false, T) :-
	happensAt(start(running(P2)=true), T).

initiatedAt(meeting(P1,P2)=false, T) :-
	happensAt(start(abrupt(P1)=true), T).

initiatedAt(meeting(P1,P2)=false, T) :-
	happensAt(start(abrupt(P2)=true), T).

initiatedAt(meeting(P1,P2)=false, T) :-
	happensAt(start(close(P1,P2,34)=false), T).

