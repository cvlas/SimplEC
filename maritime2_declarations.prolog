event(coord(_)).	inputEntity(coord(_)).	index(coord(Vessel), Vessel).
event(speed_change(_,_)).	inputEntity(speed_change(_,_)).	index(speed_change(Vessel,_), Vessel).
event(velocity(_)).	inputEntity(velocity(_)).	index(velocity(Vessel), Vessel).

sDFluent(coord(_)=(Lon,Lat)).	inputEntity(coord(_)=(Lon,Lat)).	index(coord(Vessel)=(Lon,Lat), Vessel).
sDFluent(velocity(_)=true).	inputEntity(velocity(_)=true).	index(velocity(Vessel)=true, Vessel).

event(fastApproach(_)).	outputEntity(fastApproach(_)).	index(fastApproach(Vessel), Vessel).



cachingOrder(fastApproach(_)).	%1
