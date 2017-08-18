holdsFor(close(Id1,Id2,24)=true, I) :-
	holdsFor(distance(Id1,Id2,24)=true,I).

holdsFor(close(Id1,Id2,25)=true, I) :-
	holdsFor(close(Id1,Id2,24)=true,I9),
	holdsFor(distance(Id1,Id2,25)=true,I12),
	union_all([I9,I12],I).

holdsFor(close(Id1,Id2,30)=true, I) :-
	holdsFor(close(Id1,Id2,25)=true,I9),
	holdsFor(distance(Id1,Id2,30)=true,I12),
	union_all([I9,I12],I).

holdsFor(close(Id1,Id2,34)=true, I) :-
	holdsFor(close(Id1,Id2,30)=true,I9),
	holdsFor(distance(Id1,Id2,34)=true,I12),
	union_all([I9,I12],I).

holdsFor(close(Id1,Id2,Threshold)=false, I) :-
	holdsFor(close(Id1,Id2,Threshold)=true,I23),
	complement_all([I23],I).

holdsFor(closeSymmetric(Id1,Id2,Threshold)=true, I) :-
	holdsFor(close(Id1,Id2,Threshold)=true,I9),
	holdsFor(close(Id2,Id1,Threshold)=true,I12),
	union_all([I9,I12],I).

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
	holdsFor(activeOrInactivePerson(P1)=true,I104),
	holdsFor(person(P2)=true,I105),
	holdsFor(close(P1,P2,25)=true,I108),
	intersect_all([I104,I105,I108],I110),
	holdsFor(running(P2)=true,I170),
	holdsFor(abrupt(P2)=true,I173),
	union_all([I170,I173],I174),
	relative_complement_all(I110,[I174],I).

holdsFor(greeting2(P1,P2)=true, I) :-
	holdsFor(walking(P1)=true,I13),
	holdsFor(activeOrInactivePerson(P2)=true,I14),
	holdsFor(close(P2,P1,25)=true,I17),
	intersect_all([I13,I14,I17],I).

holdsFor(activeOrInactivePerson(P)=true, I) :-
	holdsFor(active(P)=true,I27),
	holdsFor(inactive(P)=true,I42),
	holdsFor(person(P)=true,I45),
	intersect_all([I42,I45],I46),
	union_all([I27,I46],I).

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

holdsFor(moving(P1,P2)=true, I) :-
	holdsFor(walking(P1)=true,I13),
	holdsFor(walking(P2)=true,I14),
	holdsFor(close(P1,P2,34)=true,I17),
	intersect_all([I13,I14,I17],I).

holdsFor(fighting(P1,P2)=true, I) :-
	holdsFor(abrupt(P1)=true,I144),
	holdsFor(abrupt(P2)=true,I147),
	union_all([I144,I147],I148),
	holdsFor(close(P1,P2,24)=true,I151),
	intersect_all([I148,I151],I152),
	holdsFor(inactive(P1)=true,I212),
	holdsFor(inactive(P2)=true,I215),
	union_all([I212,I215],I216),
	relative_complement_all(I152,[I216],I).

