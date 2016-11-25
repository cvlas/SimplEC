sDFluent(atThePub(_)=true).
sDFluent(atWork(_)=true).
sDFluent(changingDiapers(_)=true).
sDFluent(friends(_,_)=true).
sDFluent(happy(_)=true).
sDFluent(onHoliday(_)=true).
sDFluent(poor(_)=true).
sDFluent(resting(_)=true).
sDFluent(rich(_)=true).
sDFluent(sad(_)=true).
sDFluent(takingBreak(_)=true).
sDFluent(working(_)=true).

inputEntity(atThePub(_)=true).
inputEntity(atWork(_)=true).
inputEntity(changingDiapers(_)=true).
inputEntity(onHoliday(_)=true).
inputEntity(poor(_)=true).
inputEntity(rich(_)=true).
inputEntity(takingBreak(_)=true).
outputEntity(friends(_,_)=true).
outputEntity(happy(_)=true).
outputEntity(resting(_)=true).
outputEntity(sad(_)=true).
outputEntity(working(_)=true).

index(atThePub(X)=true,X).
index(atWork(X)=true,X).
index(changingDiapers(X)=true,X).
index(friends(X,_)=true,X).
index(happy(X)=true,X).
index(onHoliday(X)=true,X).
index(poor(X)=true,X).
index(resting(X)=true,X).
index(rich(X)=true,X).
index(sad(X)=true,X).
index(takingBreak(X)=true,X).
index(working(X)=true,X).

collectIntervals(atThePub(_)=true).
collectIntervals(atWork(_)=true).
collectIntervals(changingDiapers(_)=true).
collectIntervals(onHoliday(_)=true).
collectIntervals(poor(_)=true).
collectIntervals(rich(_)=true).
collectIntervals(takingBreak(_)=true).

grounding(atThePub(X)=true)		:- person(X).
grounding(atWork(X)=true) 		:- person(X).
grounding(changingDiapers(X)=true) 	:- person(X).
grounding(friends(X,Y)=true) 		:- person(X),person(Y).
grounding(happy(X)=true) 		:- person(X).
grounding(onHoliday(X)=true) 		:- person(X).
grounding(poor(X)=true) 		:- person(X).
grounding(resting(X)=true) 		:- person(X).
grounding(rich(X)=true) 		:- person(X).
grounding(sad(X)=true) 			:- person(X).
grounding(takingBreak(X)=true) 		:- person(X).
grounding(working(X)=true) 		:- person(X).

cachingOrder(resting(_)=true).
cachingOrder(working(_)=true).
cachingOrder(friends(_,_)=true).
cachingOrder(happy(_)=true).
cachingOrder(sad(_)=true).

