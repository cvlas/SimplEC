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
	Speed > 2.0.

terminatedAt(sailing(Vessel)=true, T) :-
	happensAt(velocity(Vessel,Speed,Heading), T),
	Speed < 2.0.

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
	holdsFor(lowSpeed(Vessel)=true,I52),
	holdsFor(stopped(Vessel)=true,I55),
	union_all([I52,I55],I56),
	holdsFor(withinArea(Vessel,AreaName)=true,I59),
	intersect_all([I56,I59],I60),
	findall((S,E),(member((S,E),I60),Diff is E-S,Diff>600),I).

holdsFor(rendezVouz(Vessel1,Vessel2)=true, I) :-
	holdsFor(proximity(Vessel1,Vessel2)=true,I97),
	holdsFor(lowSpeed(Vessel1)=true,I99),
	holdsFor(stopped(Vessel1)=true,I102),
	union_all([I99,I102],I103),
	holdsFor(lowSpeed(Vessel2)=true,I119),
	holdsFor(stopped(Vessel2)=true,I122),
	union_all([I119,I122],I123),
	intersect_all([I97,I103,I123],I125),
	findall((S,E),(member((S,E),I125),Diff is E-S,Diff>600),I).

