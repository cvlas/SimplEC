
sDFluent(abrupt(_)=true).	inputEntity(abrupt(_)=true).	index(abrupt(P2)=true, P2).
sDFluent(active(_)=true).	inputEntity(active(_)=true).	index(active(P)=true, P).
sDFluent(distance(_,_,_)=true).	inputEntity(distance(_,_,_)=true).	index(distance(Id1,_,24)=true, Id1).
sDFluent(inactive(_)=true).	inputEntity(inactive(_)=true).	index(inactive(P)=true, P).
sDFluent(running(_)=true).	inputEntity(running(_)=true).	index(running(P2)=true, P2).
sDFluent(walking(_)=true).	inputEntity(walking(_)=true).	index(walking(Id)=true, Id).


simpleFluent(leaving_object(_,_)=false).	outputEntity(leaving_object(_,_)=false).	index(leaving_object(Person,_)=false, Person).
simpleFluent(leaving_object(_,_)=true).	outputEntity(leaving_object(_,_)=true).	index(leaving_object(Person,_)=true, Person).
simpleFluent(meeting(_,_)=false).	outputEntity(meeting(_,_)=false).	index(meeting(P1,_)=false, P1).
simpleFluent(meeting(_,_)=true).	outputEntity(meeting(_,_)=true).	index(meeting(P1,_)=true, P1).
simpleFluent(person(_)=false).	outputEntity(person(_)=false).	index(person(Id)=false, Id).
simpleFluent(person(_)=true).	outputEntity(person(_)=true).	index(person(Id)=true, Id).

sDFluent(activeOrInactivePerson(_)=true).	outputEntity(activeOrInactivePerson(_)=true).	index(activeOrInactivePerson(P)=true, P).
sDFluent(close(_,_,_)=false).	outputEntity(close(_,_,_)=false).	index(close(Id1,_,_)=false, Id1).
sDFluent(close(_,_,_)=true).	outputEntity(close(_,_,_)=true).	index(close(Id1,_,24)=true, Id1).
sDFluent(closeSymmetric(_,_,_)=true).	outputEntity(closeSymmetric(_,_,_)=true).	index(closeSymmetric(Id1,_,_)=true, Id1).
sDFluent(fighting(_,_)=true).	outputEntity(fighting(_,_)=true).	index(fighting(P1,_)=true, P1).
sDFluent(greeting1(_,_)=true).	outputEntity(greeting1(_,_)=true).	index(greeting1(P1,_)=true, P1).
sDFluent(greeting2(_,_)=true).	outputEntity(greeting2(_,_)=true).	index(greeting2(P1,_)=true, P1).
sDFluent(moving(_,_)=true).	outputEntity(moving(_,_)=true).	index(moving(P1,_)=true, P1).


buildFromPoints(walking(_)=true).
buildFromPoints(active(_)=true).
buildFromPoints(inactive(_)=true).
buildFromPoints(running(_)=true).
buildFromPoints(abrupt(_)=true).

grounding(close(P1,P2,24)=true)	:-	id_pair(P1, P2).
grounding(close(P1,P2,25)=true)	:-	id_pair(P1, P2).
grounding(close(P1,P2,30)=true)	:-	id_pair(P1, P2).
grounding(close(P1,P2,34)=true)	:-	id_pair(P1, P2).
grounding(close(P1,P2,34)=false)	:-	id_pair(P1, P2).
grounding(closeSymmetric(P1,P2,30)=true)	:-	id_pair(P1, P2).
grounding(walking(P)=true)	:-	list_of_ids(P).
grounding(active(P)=true)	:-	list_of_ids(P).
grounding(inactive(P)=true)	:-	list_of_ids(P).
grounding(abrupt(P)=true)	:-	list_of_ids(P).
grounding(running(P)=true)	:-	list_of_ids(P).
grounding(person(P)=true)	:-	list_of_ids(P).
grounding(activeOrInactivePerson(P)=true)	:-	list_of_ids(P).
grounding(greeting1(P1,P2)=true)	:-	id_pair(P1, P2).
grounding(greeting2(P1,P2)=true)	:-	id_pair(P1, P2).
grounding(leaving_object(Person,Object)=true)	:-	id_pair(Person, Object).
grounding(leaving_object(Person,Object)=true)	:-	symmetric_id_pair(Person, Object).
grounding(meeting(P1,P2)=true)	:-	id_pair(P1, P2).
grounding(moving(P1,P2)=true)	:-	id_pair(P1, P2).
grounding(fighting(P1,P2)=true)	:-	id_pair(P1, P2).

cachingOrder(leaving_object(_,_)=false).	%0
cachingOrder(leaving_object(_,_)=true).	%0
cachingOrder(person(_)=false).	%0
cachingOrder(close(_,_,_)=true).	%1
cachingOrder(person(_)=true).	%1
cachingOrder(activeOrInactivePerson(_)=true).	%2
cachingOrder(close(_,_,_)=false).	%2
cachingOrder(closeSymmetric(_,_,_)=true).	%2
cachingOrder(fighting(_,_)=true).	%2
cachingOrder(moving(_,_)=true).	%2
cachingOrder(greeting1(_,_)=true).	%3
cachingOrder(greeting2(_,_)=true).	%3
cachingOrder(meeting(_,_)=false).	%3
cachingOrder(meeting(_,_)=true).	%4
