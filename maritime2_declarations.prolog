event(speed_change(_,_)).	inputEntity(speed_change(_,_)).	index(speed_change(Vessel,_), Vessel).

sDFluent(coord(_)=(Lon,Lat)).	inputEntity(coord(_)=(Lon,Lat)).	index(coord(Vessel)=(Lon,Lat), Vessel).

event(fastApproach(_)).	outputEntity(fastApproach(_)).	index(fastApproach(Vessel), Vessel).



cachingOrder(fastApproach(_)).	%1
