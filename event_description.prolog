initiatedAt(stopped(Vessel)=true, T) :-
	happensAt(stop_start(Vessel), T),
	happensAt(coord(Vessel,Lon,Lat), T),
	nearPorts(Lon,Lat,[]).

terminatedAt(stopped(Vessel)=true, T) :-
	happensAt(stop_end(Vessel), T).

initiatedAt(lowSpeed(Vessel)=true, T) :-
	happensAt(slow_motion_start(Vessel), T),
	happensAt(coord(Vessel,Lon,Lat), T),
	nearPorts(Lon,Lat,[]).

terminatedAt(lowSpeed(Vessel)=true, T) :-
	happensAt(slow_motion_end(Vessel), T).

terminatedAt(lowSpeed(Vessel)=true, T) :-
	happensAt(start(stopped(Vessel)=true), T).

initiatedAt(withinArea(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T).

terminatedAt(withinArea(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

initiatedAt(sailing(Vessel)=true, T) :-
	happensAt(velocity(Vessel,Speed,Heading), T),
	Speed > 20.

terminatedAt(sailing(Vessel)=true, T) :-
	happensAt(velocity(Vessel,Speed,Heading), T),
	Speed < 20.

terminatedAt(sailing(Vessel)=true, T) :-
	happensAt(gap_start(Vessel), T).

initiatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T),
	speedArea(AreaName,SpeedArea),
	Speed > SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T),
	speedArea(AreaName,SpeedArea),
	Speed < SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

holdsFor(loitering(Vessel)=true, I) :-
	holdsFor(lowSpeed(Vessel)=true,I1),
	holdsFor(stopped(Vessel)=true,I2),
	union_all([I1,I2],I3),
	holdsFor(withinArea(Vessel,AreaName)=true,I4),
	intersect_all([I3,I4],I5),
	findall((S,E),(member((S,E),I5),Diff is E-S,Diff>600),I).

holdsFor(rendezVouz(Vessel1,Vessel2)=true, I) :-
	holdsFor(proximity(Vessel1,Vessel2)=true,I1),
	holdsFor(lowSpeed(Vessel1)=true,I2),
	holdsFor(stopped(Vessel1)=true,I3),
	union_all([I2,I3],I4),
	holdsFor(lowSpeed(Vessel2)=true,I5),
	holdsFor(stopped(Vessel2)=true,I6),
	union_all([I5,I6],I7),
	intersect_all([I1,I4,I7],I8),
	findall((S,E),(member((S,E),I8),Diff is E-S,Diff>600),I).

happensAt(fastApproach(Vessel), T) :-
	happensAt(speedChange(Vessel), T),
	holdsAt(velocity(Vessel)=Value, T),
	Value > 20,
	holdsAt(coord(Vessel)=(Lon,Lat), T),
	\+ nearPorts(Lon,Lat),
	holdsAt(headingToVessels(Vessel)=true, T).

