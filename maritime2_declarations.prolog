event(speed_change(_,_)).	inputEntity(speed_change(_,_)).	index(speed_change(Vessel,_), Vessel).

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

event(fastApproach(_)).	outputEntity(fastApproach(_)).	index(fastApproach(Vessel), Vessel).



cachingOrder(fastApproach(_)).	%1
