event(appear(_)).	inputEntity(appear(_)).	index(appear(Object), Object).
event(disappear(_)).	inputEntity(disappear(_)).	index(disappear(Id), Id).

sDFluent(abrupt(_)=true).	inputEntity(abrupt(_)=true).	index(abrupt(Id)=true, Id).
sDFluent(active(_)=true).	inputEntity(active(_)=true).	index(active(Id)=true, Id).
sDFluent(distance(_,_,_)=true).	inputEntity(distance(_,_,_)=true).	index(distance(Id1,_,_)=true, Id1).
sDFluent(inactive(_)=true).	inputEntity(inactive(_)=true).	index(inactive(Object)=true, Object).
sDFluent(running(_)=true).	inputEntity(running(_)=true).	index(running(Id)=true, Id).
sDFluent(walking(_)=true).	inputEntity(walking(_)=true).	index(walking(Id)=true, Id).


simpleFluent(leaving_object(_,_)=false).	outputEntity(leaving_object(_,_)=false).	index(leaving_object(Person,_)=false, Person).
simpleFluent(leaving_object(_,_)=true).	outputEntity(leaving_object(_,_)=true).	index(leaving_object(Person,_)=true, Person).
simpleFluent(meeting(_,_)=false).	outputEntity(meeting(_,_)=false).	index(meeting(P1,_)=false, P1).
simpleFluent(meeting(_,_)=true).	outputEntity(meeting(_,_)=true).	index(meeting(P1,_)=true, P1).
simpleFluent(person(_)=false).	outputEntity(person(_)=false).	index(person(Id)=false, Id).
simpleFluent(person(_)=true).	outputEntity(person(_)=true).	index(person(Id)=true, Id).

sDFluent(activeOrInactivePerson(_)=true).	outputEntity(activeOrInactivePerson(_)=true).	index(activeOrInactivePerson(P)=true, P).
sDFluent(close(_,_,_)=false).	outputEntity(close(_,_,_)=false).	index(close(Id1,_,_)=false, Id1).
sDFluent(close(_,_,_)=true).	outputEntity(close(_,_,_)=true).	index(close(Id1,_,_)=true, Id1).
sDFluent(closeSymmetric(_,_,_)=true).	outputEntity(closeSymmetric(_,_,_)=true).	index(closeSymmetric(Id1,_,_)=true, Id1).
sDFluent(greeting1(_,_)=true).	outputEntity(greeting1(_,_)=true).	index(greeting1(P1,_)=true, P1).
sDFluent(greeting2(_,_)=true).	outputEntity(greeting2(_,_)=true).	index(greeting2(P1,_)=true, P1).

cachingOrder(leaving_object(_,_)=false).	%1
cachingOrder(person(_)=false).	%1
cachingOrder(person(_)=true).	%1
cachingOrder(activeOrInactivePerson(_)=true).	%2
cachingOrder(close(_,_,_)=true).	%4
cachingOrder(close(_,_,_)=false).	%5
cachingOrder(meeting(_,_)=false).	%6
cachingOrder(closeSymmetric(_,_,_)=true).	%9
cachingOrder(leaving_object(_,_)=true).	%11
cachingOrder(greeting2(_,_)=true).	%15
cachingOrder(greeting1(_,_)=true).	%16
cachingOrder(meeting(_,_)=true).	%32
