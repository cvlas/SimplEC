event(disappear(_)).	inputEntity(disappear(_)).	index(disappear(P), P).
event(speedChange(_)).	inputEntity(speedChange(_)).	index(speedChange(Vessel), Vessel).

sDFluent(abrupt(_)=true).	inputEntity(abrupt(_)=true).	index(abrupt(P)=true, P).
sDFluent(active(_)=true).	inputEntity(active(_)=true).	index(active(P)=true, P).
sDFluent(activeOrInactivePerson(_)=true).	inputEntity(activeOrInactivePerson(_)=true).	index(activeOrInactivePerson(P1)=true, P1).
sDFluent(close(_,_)=true).	inputEntity(close(_,_)=true).	index(close(P1,_)=true, P1).
sDFluent(close(_,_,_)=true).	inputEntity(close(_,_,_)=true).	index(close(P1,_,_)=true, P1).
sDFluent(disappear(_)=true).	inputEntity(disappear(_)=true).	index(disappear(P)=true, P).
sDFluent(headingToVessels(_)=true).	inputEntity(headingToVessels(_)=true).	index(headingToVessels(Vessel)=true, Vessel).
sDFluent(inactive(_)=true).	inputEntity(inactive(_)=true).	index(inactive(P1)=true, P1).
sDFluent(nearPorts(_,_)=true).	inputEntity(nearPorts(_,_)=true).	index(nearPorts(Lon,_)=true, Lon).
sDFluent(running(_)=true).	inputEntity(running(_)=true).	index(running(P)=true, P).
sDFluent(speedChange(_)=true).	inputEntity(speedChange(_)=true).	index(speedChange(Vessel)=true, Vessel).
sDFluent(velocity(_)=true).	inputEntity(velocity(_)=true).	index(velocity(Vessel)=true, Vessel).
sDFluent(walking(_)=true).	inputEntity(walking(_)=true).	index(walking(P1)=true, P1).

event(fastApproach(_)).	outputEntity(fastApproach(_)).	index(fastApproach(Vessel), Vessel).

simpleFluent(moving(_,_)=true).	outputEntity(moving(_,_)=true).	index(moving(P1,_)=true, P1).
simpleFluent(person(_)=true).	outputEntity(person(_)=true).	index(person(P)=true, P).

sDFluent(fighting(_,_)=true).	outputEntity(fighting(_,_)=true).	index(fighting(P1,_)=true, P1).
sDFluent(greeting1(_,_)=true).	outputEntity(greeting1(_,_)=true).	index(greeting1(P1,_)=true, P1).

cachingOrder(fastApproach(_)).	%1
cachingOrder(fighting(_,_)=true).	%1
cachingOrder(moving(_,_)=true).	%1
cachingOrder(person(_)=true).	%1
cachingOrder(greeting1(_,_)=true).	%2
