event(disappear(_)).	inputEntity(disappear(_)).	index(disappear(P), P).
event(gap_start(_)).	inputEntity(gap_start(_)).	index(gap_start(Vessel), Vessel).
event(isInArea(_,_)).	inputEntity(isInArea(_,_)).	index(isInArea(Vessel,_), Vessel).
event(leavesArea(_,_)).	inputEntity(leavesArea(_,_)).	index(leavesArea(Vessel,_), Vessel).
event(passenger_density_change(_,_,_)).	inputEntity(passenger_density_change(_,_,_)).	index(passenger_density_change(ID,_,_), ID).
event(speedChange(_)).	inputEntity(speedChange(_)).	index(speedChange(Vessel), Vessel).
event(velocity(_,_,_)).	inputEntity(velocity(_,_,_)).	index(velocity(Vessel,_,_), Vessel).

sDFluent(abrupt(_)=true).	inputEntity(abrupt(_)=true).	index(abrupt(P)=true, P).
sDFluent(active(_)=true).	inputEntity(active(_)=true).	index(active(P)=true, P).
sDFluent(close(_,_)=true).	inputEntity(close(_,_)=true).	index(close(P1,_)=true, P1).
sDFluent(close(_,_,_)=true).	inputEntity(close(_,_,_)=true).	index(close(Id1,_,_)=true, Id1).
sDFluent(disappear(_)=true).	inputEntity(disappear(_)=true).	index(disappear(P)=true, P).
sDFluent(headingToVessels(_)=true).	inputEntity(headingToVessels(_)=true).	index(headingToVessels(Vessel)=true, Vessel).
sDFluent(inactive(_)=true).	inputEntity(inactive(_)=true).	index(inactive(P)=true, P).
sDFluent(running(_)=true).	inputEntity(running(_)=true).	index(running(P)=true, P).
sDFluent(velocity(_)=true).	inputEntity(velocity(_)=true).	index(velocity(Vessel)=true, Vessel).
sDFluent(walking(_)=true).	inputEntity(walking(_)=true).	index(walking(P1)=true, P1).

event(fastApproach(_)).	outputEntity(fastApproach(_)).	index(fastApproach(Vessel), Vessel).

simpleFluent(highSpeedIn(_,_)=true).	outputEntity(highSpeedIn(_,_)=true).	index(highSpeedIn(Vessel,_)=true, Vessel).
simpleFluent(moving(_,_)=true).	outputEntity(moving(_,_)=true).	index(moving(P1,_)=true, P1).
simpleFluent(person(_)=true).	outputEntity(person(_)=true).	index(person(P)=true, P).
simpleFluent(sailing(_)=true).	outputEntity(sailing(_)=true).	index(sailing(Vessel)=true, Vessel).

sDFluent(activeOrInactivePerson(_)=true).	outputEntity(activeOrInactivePerson(_)=true).	index(activeOrInactivePerson(P)=true, P).
sDFluent(close(_,_,_)=false).	outputEntity(close(_,_,_)=false).	index(close(Id1,_,_)=false, Id1).
sDFluent(fighting(_,_)=true).	outputEntity(fighting(_,_)=true).	index(fighting(P1,_)=true, P1).
sDFluent(greeting1(_,_)=true).	outputEntity(greeting1(_,_)=true).	index(greeting1(P1,_)=true, P1).




cachingOrder(close(_,_,_)=false).	%1
cachingOrder(fastApproach(_)).	%1
cachingOrder(fighting(_,_)=true).	%1
cachingOrder(highSpeedIn(_,_)=true).	%1
cachingOrder(moving(_,_)=true).	%1
cachingOrder(person(_)=true).	%1
cachingOrder(sailing(_)=true).	%1
cachingOrder(activeOrInactivePerson(_)=true).	%2
cachingOrder(greeting1(_,_)=true).	%3
