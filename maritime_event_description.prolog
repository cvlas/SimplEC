initiatedAt(stopped(Vessel)=true, T) :-
	happensAt(stop_start(Vessel), T),
	happensAt(coord(Vessel,Lon,Lat), T)nearPorts(Lon,Lat,[]).

terminatedAt(stopped(Vessel)=true, T) :-
	happensAt(stop_end(Vessel), T).

initiatedAt(lowSpeed(Vessel)=true, T) :-
	happensAt(slow_motion_start(Vessel), T),
	happensAt(coord(Vessel,Lon,Lat), T)nearPorts(Lon,Lat,[]).

terminatedAt(lowSpeed(Vessel)=true, T) :-
	happensAt(slow_motion_end(Vessel), T).

terminatedAt(lowSpeed(Vessel)=true, T) :-
	happensAt(start(stopped(Vessel)=true), T).

initiatedAt(withinArea(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T).

terminatedAt(withinArea(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

initiatedAt(sailing(Vessel)=true, T) :-
	happensAt(velocity(Vessel,Speed,Heading), T)Speed > 2.0.

terminatedAt(sailing(Vessel)=true, T) :-
	happensAt(velocity(Vessel,Speed,Heading), T)Speed < 2.0.

terminatedAt(sailing(Vessel)=true, T) :-
	happensAt(gap_start(Vessel), T).

initiatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed > SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed < SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed < SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed < SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed < SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed < SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

initiatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed > SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed < SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed < SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed < SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed < SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed < SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

initiatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed > SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed < SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed < SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed < SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed < SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed < SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

initiatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed > SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed < SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed < SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed < SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed < SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(isInArea(Vessel,AreaName), T),
	happensAt(velocity(Vessel,Speed,Heading), T)speedArea(AreaName,SpeedArea)Speed < SpeedArea.

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(leavesArea(Vessel,AreaName), T).

terminatedAt(highSpeedIn(Vessel,AreaName)=true, T) :-
	happensAt(gap_start(Vessel), T).

