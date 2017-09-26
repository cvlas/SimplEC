holdsFor(activeOrInactivePerson(P)=true, I) :-
	holdsFor(active(P)=true,I2),
	holdsFor(inactive(P)=true,I3),
	holdsFor(person(P)=true,I4),
	intersect_all([I3,I4],I5),
	union_all([I2,_11466],I).

holdsFor(close(Id1,Id2,Threshold)=false, I) :-
	holdsFor(close(Id1,Id2,Threshold)=true,I1),
	complement_all([I1],I).

initiatedAt(passenger_density(ID,VT)=Val, T) :-
	happensAt(passenger_density_change(ID,VT,Val), T).

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

initiatedAt(person(P)=true, T) :-
	happensAt(start(walking(P)=true), T),
	\+ holdsAt(disappear(P)=true, T).

initiatedAt(person(P)=true, T) :-
	happensAt(start(active(P)=true), T),
	\+ holdsAt(disappear(P)=true, T).

initiatedAt(person(P)=true, T) :-
	happensAt(start(running(P)=true), T),
	\+ holdsAt(disappear(P)=true, T).

initiatedAt(person(P)=true, T) :-
	happensAt(start(abrupt(P)=true), T),
	\+ holdsAt(disappear(P)=true, T).

terminatedAt(person(P)=true, T) :-
	happensAt(disappear(P), T).

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

happensAt(fastApproach(Vessel), T) :-
	happensAt(speedChange(Vessel), T),
	holdsAt(velocity(Vessel)=Value, T),
	Value > 20 knots,
	holdsAt(coord(Vessel)=(Lon,Lat), T),
	\+ holdsAt(nearPorts(Lon,Lat)=true, T),
	holdsAt(headingToVessels(Vessel)=true, T).

