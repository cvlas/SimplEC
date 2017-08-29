happensAt(fastApproach(Vessel), T) :-
	happensAt(speed_change(Vessel,NewSpeed), T),
	holdsAt(velocity(Vessel)=Value, T),
	Value > 20,
	holdsAt(coord(Vessel)=(Lon,Lat), T),
	\+ nearPorts(Lon,Lat),
	headingToVessels(Vessel).

happensAt(fastApproach(Vessel), T) :-
	happensAt(speed_change(Vessel,NewSpeed), T),
	holdsAt(velocity(Vessel)=Value, T),
	Value > 30,
	holdsAt(coord(Vessel)=(Lon,Lat), T),
	\+ nearPorts(Lon,Lat),
	headingToVessels(Vessel).

happensAt(fastApproach(Vessel), T) :-
	happensAt(speed_change(Vessel,NewSpeed), T),
	holdsAt(velocity(Vessel)=Value, T),
	Value > 40,
	holdsAt(coord(Vessel)=(Lon,Lat), T),
	\+ nearPorts(Lon,Lat),
	headingToVessels(Vessel).

happensAt(fastApproach(Vessel), T) :-
	happensAt(speed_change(Vessel,NewSpeed), T),
	holdsAt(velocity(Vessel)=Value, T),
	Value > 50,
	holdsAt(coord(Vessel)=(Lon,Lat), T),
	\+ nearPorts(Lon,Lat),
	headingToVessels(Vessel).

