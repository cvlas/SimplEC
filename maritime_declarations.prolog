
sDFluent(proximity(_,_)=true).	inputEntity(proximity(_,_)=true).	index(proximity(Vessel1,_)=true, Vessel1).

event(fastApproach(_)).	outputEntity(fastApproach(_)).	index(fastApproach(Vessel), Vessel).

simpleFluent(highSpeedIn(_,_)=true).	outputEntity(highSpeedIn(_,_)=true).	index(highSpeedIn(Vessel,_)=true, Vessel).
simpleFluent(lowSpeed(_)=true).	outputEntity(lowSpeed(_)=true).	index(lowSpeed(Vessel)=true, Vessel).
simpleFluent(sailing(_)=true).	outputEntity(sailing(_)=true).	index(sailing(Vessel)=true, Vessel).
simpleFluent(stopped(_)=true).	outputEntity(stopped(_)=true).	index(stopped(Vessel)=true, Vessel).
simpleFluent(withinArea(_,_)=true).	outputEntity(withinArea(_,_)=true).	index(withinArea(Vessel,_)=true, Vessel).

sDFluent(loitering(_)=true).	outputEntity(loitering(_)=true).	index(loitering(Vessel)=true, Vessel).
sDFluent(rendezVouz(_,_)=true).	outputEntity(rendezVouz(_,_)=true).	index(rendezVouz(Vessel1,_)=true, Vessel1).




cachingOrder(fastApproach(_)).	%0
cachingOrder(highSpeedIn(_,_)=true).	%0
cachingOrder(lowSpeed(_)=true).	%0
cachingOrder(sailing(_)=true).	%0
cachingOrder(stopped(_)=true).	%0
cachingOrder(withinArea(_,_)=true).	%0
cachingOrder(loitering(_)=true).	%1
cachingOrder(rendezVouz(_,_)=true).	%1
