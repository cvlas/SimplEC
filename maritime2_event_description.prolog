

I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)=true


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)=true


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)=true


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)=true


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)=true


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)=true


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)=true


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)=true


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)=true


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)=true


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)=true


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)=true


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)=true


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)=true


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)


I just declared: 
velocity(_)=true
happensAt(fastApproach(Vessel), T) :-
	happensAt(speed_change(Vessel,NewSpeed), T),
	,
	holdsAt(velocity(Vessel)=Value, T),
	Value > 20,
	,
	holdsAt(coord(Vessel)=(Lon,Lat), T),
	\+ nearPorts(Lon,Lat),
	headingToVessels(Vessel).

happensAt(fastApproach(Vessel), T) :-
	happensAt(speed_change(Vessel,NewSpeed), T),
	,
	holdsAt(velocity(Vessel)=Value, T),
	Value > 30,
	,
	holdsAt(coord(Vessel)=(Lon,Lat), T),
	\+ nearPorts(Lon,Lat),
	headingToVessels(Vessel).

happensAt(fastApproach(Vessel), T) :-
	happensAt(speed_change(Vessel,NewSpeed), T),
	,
	holdsAt(velocity(Vessel)=Value, T),
	Value > 40,
	,
	holdsAt(coord(Vessel)=(Lon,Lat), T),
	\+ nearPorts(Lon,Lat),
	headingToVessels(Vessel).

happensAt(fastApproach(Vessel), T) :-
	happensAt(speed_change(Vessel,NewSpeed), T),
	,
	holdsAt(velocity(Vessel)=Value, T),
	Value > 50,
	,
	holdsAt(coord(Vessel)=(Lon,Lat), T),
	\+ nearPorts(Lon,Lat),
	headingToVessels(Vessel).

declFact(fastApproach(_),fastApproach(_),fastApproach(Vessel), Vessel,event,output)
declFact(speed_change(_,_),speed_change(_,_),speed_change(Vessel,_), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(coord(_),coord(_),coord(Vessel), Vessel,event,input)
declFact(coord(_)=(Lon,Lat),coord(_)=(Lon,Lat),coord(Vessel)=(Lon,Lat), Vessel,sD,input)


declFact(fastApproach(_),fastApproach(_),fastApproach(Vessel), Vessel,event,output)
declFact(speed_change(_,_),speed_change(_,_),speed_change(Vessel,_), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)
declFact(coord(_),coord(_),coord(Vessel), Vessel,event,input)
declFact(coord(_)=(Lon,Lat),coord(_)=(Lon,Lat),coord(Vessel)=(Lon,Lat), Vessel,sD,input)


declFact(coord(_),coord(_),coord(Vessel), Vessel,event,input)
declFact(coord(_)=(Lon,Lat),coord(_)=(Lon,Lat),coord(Vessel)=(Lon,Lat), Vessel,sD,input)
declFact(fastApproach(_),fastApproach(_),fastApproach(Vessel), Vessel,event,output)
declFact(speed_change(_,_),speed_change(_,_),speed_change(Vessel,_), Vessel,event,input)
declFact(velocity(_),velocity(_),velocity(Vessel), Vessel,event,input)
declFact(velocity(_)=true,velocity(_)=true,velocity(Vessel)=true, Vessel,sD,input)


