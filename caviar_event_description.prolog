holdsFor(close(Id1,Id2,24)=true, I1) :-
	holdsFor(distance(Id1,Id2,24)=true,I1).

holdsFor(close(Id1,Id2,25)=true, I5) :-
	holdsFor(close(Id1,Id2,24)=true,I7),
	holdsFor(distance(Id1,Id2,25)=true,I10),
	union_all([I7,I10],I5).

holdsFor(close(Id1,Id2,30)=true, I12) :-
	holdsFor(close(Id1,Id2,25)=true,I14),
	holdsFor(distance(Id1,Id2,30)=true,I17),
	union_all([I14,I17],I12).

holdsFor(close(Id1,Id2,34)=true, I19) :-
	holdsFor(close(Id1,Id2,30)=true,I21),
	holdsFor(distance(Id1,Id2,34)=true,I24),
	union_all([I21,I24],I19).

holdsFor(close(Id1,Id2,Threshold)=false, I26) :-
	holdsFor(close(Id1,Id2,Threshold)=true,I37),
	complement_all([I37],I26).

holdsFor(closeSymmetric(Id1,Id2,Threshold)=true, I39) :-
	holdsFor(close(Id1,Id2,Threshold)=true,I41),
	holdsFor(close(Id2,Id1,Threshold)=true,I44),
	union_all([I41,I44],I39).

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

