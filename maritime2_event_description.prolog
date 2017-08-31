happensAt(fastApproach(Vessel), T) :-
	happensAt(speed_change(Vessel,NewSpeed), T),
	holdsAt(velocity(Vessel)=Value, T),
	Value > 20,
	holdsAt(coord(Vessel)=(Lon,Lat), T).

happensAt(fastApproach(Vessel), T) :-
	happensAt(speed_change(Vessel,NewSpeed), T),
	holdsAt(velocity(Vessel)=Value, T),
	Value > 30,
	holdsAt(coord(Vessel)=(Lon,Lat), T).

happensAt(fastApproach(Vessel), T) :-
	happensAt(speed_change(Vessel,NewSpeed), T),
	holdsAt(velocity(Vessel)=Value, T),
	Value > 40,
	holdsAt(coord(Vessel)=(Lon,Lat), T).

happensAt(fastApproach(Vessel), T) :-
	happensAt(speed_change(Vessel,NewSpeed), T),
	holdsAt(velocity(Vessel)=Value, T),
	Value > 50,
	holdsAt(coord(Vessel)=(Lon,Lat), T).

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

holdsFor(greeting1(P1,P2)=true, I) :-
	holdsFor(activeOrInactivePerson(P1)=true,I1),
	holdsFor(person(P2)=true,I2),
	holdsFor(close(P1,P2,25)=true,I3),
	holdsFor(running(P2)=true,I63),
	holdsFor(abrupt(P2)=true,I66),
	union_all([I63,I66],I67),
	relative_complement_all(I3,[I67],I69),
	intersect_all([I1,I2,I69],I).

holdsFor(fighting(P1,P2)=true, I) :-
	holdsFor(abrupt(P1)=true,I2),
	holdsFor(abrupt(P2)=true,I5),
	union_all([I2,I5],I6),
	holdsFor(close(P1,P2,24)=true,I7),
	holdsFor(inactive(P1)=true,I67),
	holdsFor(inactive(P2)=true,I70),
	union_all([I67,I70],I71),
	relative_complement_all(I7,[I71],I73),
	intersect_all([I6,I73],I).

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

