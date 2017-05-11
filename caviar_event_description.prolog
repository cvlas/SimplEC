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
	holdsFor(close(Id1,Id2,Threshold)=true,I11),
	complement_all([I11],I).

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

