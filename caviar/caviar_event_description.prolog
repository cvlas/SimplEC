holdsFir(close(Id1,Id2,24)=true, I) :-
	holdsFir(distance(Id1,Id2,24)=true,I).

holdsFir(close(Id1,Id2,25)=true, I) :-
	holdsFir(close(Id1,Id2,24)=true,I2),
	holdsFir(distance(Id1,Id2,25)=true,I3),
	union_all([I2,I3],I).

holdsFir(close(Id1,Id2,30)=true, I) :-
	holdsFir(close(Id1,Id2,25)=true,I2),
	holdsFir(distance(Id1,Id2,30)=true,I3),
	union_all([I2,I3],I).

holdsFir(close(Id1,Id2,34)=true, I) :-
	holdsFir(close(Id1,Id2,30)=true,I2),
	holdsFir(distance(Id1,Id2,34)=true,I3),
	union_all([I2,I3],I).

holdsFir(close(Id1,Id2,Threshold)=false, I) :-
	holdsFir(close(Id1,Id2,Threshold)=true,I1),
	complement_all([I1],I).

holdsFir(closeSymmetric(Id1,Id2,Threshold)=true, I) :-
	holdsFir(close(Id1,Id2,Threshold)=true,I2),
	holdsFir(close(Id2,Id1,Threshold)=true,I3),
	union_all([I2,I3],I).

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

holdsFir(greeting1(P1,P2)=true, I) :-
	holdsFir(activeOrInactivePerson(P1)=true,I1),
	holdsFir(person(P2)=true,I2),
	holdsFir(close(P1,P2,25)=true,I3),
	holdsFir(running(P2)=true,I5),
	holdsFir(abrupt(P2)=true,I6),
	union_all([I5,I6],I7),
	intersect_all([I1,I2,I3],I9),
	relative_complement_all(I9,[I7],I).

holdsFir(greeting2(P1,P2)=true, I) :-
	holdsFir(walking(P1)=true,I1),
	holdsFir(activeOrInactivePerson(P2)=true,I2),
	holdsFir(close(P2,P1,25)=true,I3),
	intersect_all([I1,I2,I3],I).

holdsFir(activeOrInactivePerson(P)=true, I) :-
	holdsFir(active(P)=true,I2),
	holdsFir(inactive(P)=true,I3),
	holdsFir(person(P)=true,I4),
	intersect_all([I3,I4],I5),
	union_all([I2,I5],I).

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

holdsFir(moving(P1,P2)=true, I) :-
	holdsFir(walking(P1)=true,I1),
	holdsFir(walking(P2)=true,I2),
	holdsFir(close(P1,P2,34)=true,I3),
	intersect_all([I1,I2,I3],I).

holdsFir(fighting(P1,P2)=true, I) :-
	holdsFir(abrupt(P1)=true,I1),
	holdsFir(abrupt(P2)=true,I2),
	union_all([I1,I2],I3),
	holdsFir(close(P1,P2,24)=true,I4),
	holdsFir(inactive(P1)=true,I6),
	holdsFir(inactive(P2)=true,I7),
	union_all([I6,I7],I8),
	intersect_all([I3,I4],I10),
	relative_complement_all(I10,[I8],I).

