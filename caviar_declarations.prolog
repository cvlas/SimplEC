sDFluent(close(_,_,_)=true).
outputEntity(close(_,_,_)=true).
index(close(Id1,_,_)=true, Id1).

sDFluent(distance(_,_,_)=true).
inputEntity(distance(_,_,_)=true).
index(distance(Id1,_,_)=true, Id1).

sDFluent(close(_,_,_)=false).
outputEntity(close(_,_,_)=false).
index(close(Id1,_,_)=false, Id1).

sDFluent(closeSymmetric(_,_,_)=true).
outputEntity(closeSymmetric(_,_,_)=true).
index(closeSymmetric(Id1,_,_)=true, Id1).

simpleFluent(person(_)=true).
outputEntity(person(_)=true).
index(person(Id)=true, Id).

sDFluent(walking(_)=true).
inputEntity(walking(_)=true).
index(walking(Id)=true, Id).

event(disappear(_)).
inputEntity(disappear(_)).
index(disappear(Id), Id).

sDFluent(running(_)=true).
inputEntity(running(_)=true).
index(running(Id)=true, Id).

sDFluent(active(_)=true).
inputEntity(active(_)=true).
index(active(Id)=true, Id).

sDFluent(abrupt(_)=true).
inputEntity(abrupt(_)=true).
index(abrupt(Id)=true, Id).

simpleFluent(person(_)=false).
outputEntity(person(_)=false).
index(person(Id)=false, Id).

cachingOrder(person(_)=true). %1
cachingOrder(person(_)=false). %1
cachingOrder(close(_,_,_)=true). %4
cachingOrder(close(_,_,_)=false). %5
cachingOrder(closeSymmetric(_,_,_)=true). %9
