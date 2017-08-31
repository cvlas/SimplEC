event(disappear(_)).	inputEntity(disappear(_)).	index(disappear(Id), Id).
event(speed_change(_,_)).	inputEntity(speed_change(_,_)).	index(speed_change(Vessel,_), Vessel).

sDFluent(abrupt(_)=true).	inputEntity(abrupt(_)=true).	index(abrupt(Id)=true, Id).
sDFluent(active(_)=true).	inputEntity(active(_)=true).	index(active(Id)=true, Id).
sDFluent(activeOrInactivePerson(_)=true).	inputEntity(activeOrInactivePerson(_)=true).	index(activeOrInactivePerson(P1)=true, P1).
sDFluent(close(_,_,_)=false).	inputEntity(close(_,_,_)=false).	index(close(P1,_,_)=false, P1).
sDFluent(close(_,_,_)=true).	inputEntity(close(_,_,_)=true).	index(close(P1,_,_)=true, P1).
sDFluent(coord(_)=(0,0)).	inputEntity(coord(_)=(0,0)).	index(coord(Vessel)=(0,0), Vessel).
sDFluent(coord(_)=(1,0)).	inputEntity(coord(_)=(1,0)).	index(coord(Vessel)=(1,0), Vessel).
sDFluent(coord(_)=(2,0)).	inputEntity(coord(_)=(2,0)).	index(coord(Vessel)=(2,0), Vessel).
sDFluent(coord(_)=(3,0)).	inputEntity(coord(_)=(3,0)).	index(coord(Vessel)=(3,0), Vessel).
sDFluent(coord(_)=(4,0)).	inputEntity(coord(_)=(4,0)).	index(coord(Vessel)=(4,0), Vessel).
sDFluent(coord(_)=(5,0)).	inputEntity(coord(_)=(5,0)).	index(coord(Vessel)=(5,0), Vessel).
sDFluent(coord(_)=(5,1)).	inputEntity(coord(_)=(5,1)).	index(coord(Vessel)=(5,1), Vessel).
sDFluent(coord(_)=(5,2)).	inputEntity(coord(_)=(5,2)).	index(coord(Vessel)=(5,2), Vessel).
sDFluent(coord(_)=(5,3)).	inputEntity(coord(_)=(5,3)).	index(coord(Vessel)=(5,3), Vessel).
sDFluent(coord(_)=(5,4)).	inputEntity(coord(_)=(5,4)).	index(coord(Vessel)=(5,4), Vessel).
sDFluent(coord(_)=(5,5)).	inputEntity(coord(_)=(5,5)).	index(coord(Vessel)=(5,5), Vessel).
sDFluent(inactive(_)=true).	inputEntity(inactive(_)=true).	index(inactive(P1)=true, P1).
sDFluent(running(_)=true).	inputEntity(running(_)=true).	index(running(Id)=true, Id).
sDFluent(speed_change(_,_)=true).	inputEntity(speed_change(_,_)=true).	index(speed_change(Vessel,_)=true, Vessel).
sDFluent(velocity(_)=0).	inputEntity(velocity(_)=0).	index(velocity(Vessel)=0, Vessel).
sDFluent(velocity(_)=10).	inputEntity(velocity(_)=10).	index(velocity(Vessel)=10, Vessel).
sDFluent(velocity(_)=15).	inputEntity(velocity(_)=15).	index(velocity(Vessel)=15, Vessel).
sDFluent(velocity(_)=20).	inputEntity(velocity(_)=20).	index(velocity(Vessel)=20, Vessel).
sDFluent(velocity(_)=25).	inputEntity(velocity(_)=25).	index(velocity(Vessel)=25, Vessel).
sDFluent(velocity(_)=30).	inputEntity(velocity(_)=30).	index(velocity(Vessel)=30, Vessel).
sDFluent(velocity(_)=35).	inputEntity(velocity(_)=35).	index(velocity(Vessel)=35, Vessel).
sDFluent(velocity(_)=40).	inputEntity(velocity(_)=40).	index(velocity(Vessel)=40, Vessel).
sDFluent(velocity(_)=45).	inputEntity(velocity(_)=45).	index(velocity(Vessel)=45, Vessel).
sDFluent(velocity(_)=5).	inputEntity(velocity(_)=5).	index(velocity(Vessel)=5, Vessel).
sDFluent(velocity(_)=50).	inputEntity(velocity(_)=50).	index(velocity(Vessel)=50, Vessel).
sDFluent(velocity(_)=55).	inputEntity(velocity(_)=55).	index(velocity(Vessel)=55, Vessel).
sDFluent(velocity(_)=60).	inputEntity(velocity(_)=60).	index(velocity(Vessel)=60, Vessel).
sDFluent(velocity(_)=65).	inputEntity(velocity(_)=65).	index(velocity(Vessel)=65, Vessel).
sDFluent(velocity(_)=70).	inputEntity(velocity(_)=70).	index(velocity(Vessel)=70, Vessel).
sDFluent(velocity(_)=true).	inputEntity(velocity(_)=true).	index(velocity(Vessel)=true, Vessel).
sDFluent(walking(_)=true).	inputEntity(walking(_)=true).	index(walking(Id)=true, Id).

event(fastApproach(_)).	outputEntity(fastApproach(_)).	index(fastApproach(Vessel), Vessel).

simpleFluent(meeting(_,_)=false).	outputEntity(meeting(_,_)=false).	index(meeting(P1,_)=false, P1).
simpleFluent(person(_)=true).	outputEntity(person(_)=true).	index(person(Id)=true, Id).

sDFluent(fighting(_,_)=true).	outputEntity(fighting(_,_)=true).	index(fighting(P1,_)=true, P1).
sDFluent(greeting1(_,_)=true).	outputEntity(greeting1(_,_)=true).	index(greeting1(P1,_)=true, P1).

cachingOrder(fastApproach(_)).	%1
cachingOrder(fighting(_,_)=true).	%1
cachingOrder(meeting(_,_)=false).	%1
cachingOrder(person(_)=true).	%1
cachingOrder(greeting1(_,_)=true).	%2
