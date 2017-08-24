happensAt(fastApproach(Vessel), T) :-
	happensAt(speed_change(Vessel,NewSpeed), T),
	holdsAt(velocity(Vessel)=Value, T),
	Value > 20 knots,
	holdsAt(coord(Vessel)=(Lon,Lat), T),
	\+ nearPorts(Lon,Lat),
	headingToVessels(Vessel).

declFact(fastApproach(_),fastApproach(_),fastApproach(Vessel), Vessel,event,output)
declFact(speed_change(_,_),speed_change(_,_),speed_change(Vessel,_), Vessel,event,input)
declFact(coord(_)=(Lon,Lat),coord(_)=(Lon,Lat),coord(Vessel)=(Lon,Lat), Vessel,sD,input)


declFact(fastApproach(_),fastApproach(_),fastApproach(Vessel), Vessel,event,output)
declFact(speed_change(_,_),speed_change(_,_),speed_change(Vessel,_), Vessel,event,input)
declFact(coord(_)=(Lon,Lat),coord(_)=(Lon,Lat),coord(Vessel)=(Lon,Lat), Vessel,sD,input)


declFact(coord(_)=(Lon,Lat),coord(_)=(Lon,Lat),coord(Vessel)=(Lon,Lat), Vessel,sD,input)
declFact(fastApproach(_),fastApproach(_),fastApproach(Vessel), Vessel,event,output)
declFact(speed_change(_,_),speed_change(_,_),speed_change(Vessel,_), Vessel,event,input)


