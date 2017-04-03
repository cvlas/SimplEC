sDFluent(working(_)=true).
outputEntity(working(_)=true).
index(working(X)=true, X).

sDFluent(loc(_)=work).
inputEntity(loc(_)=work).
index(loc(X)=work, X).

sDFluent(takingBreak(_)=true).
inputEntity(takingBreak(_)=true).
index(takingBreak(X)=true, X).

sDFluent(resting(_)=true).
outputEntity(resting(_)=true).
index(resting(X)=true, X).

sDFluent(loc(_)=pub).
inputEntity(loc(_)=pub).
index(loc(X)=pub, X).

sDFluent(onHoliday(_)=true).
inputEntity(onHoliday(_)=true).
index(onHoliday(X)=true, X).

sDFluent(happy(_)=true).
outputEntity(happy(_)=true).
index(happy(X)=true, X).

sDFluent(rich(_)=true).
inputEntity(rich(_)=true).
index(rich(X)=true, X).

sDFluent(sad(_)=true).
outputEntity(sad(_)=true).
index(sad(X)=true, X).

sDFluent(poor(_)=true).
inputEntity(poor(_)=true).
index(poor(X)=true, X).

sDFluent(loc(_)=home).
inputEntity(loc(_)=home).
index(loc(X)=home, X).

sDFluent(changingDiapers(_)=true).
inputEntity(changingDiapers(_)=true).
index(changingDiapers(X)=true, X).

sDFluent(friends(_,_)=true).
outputEntity(friends(_,_)=true).
index(friends(X,_)=true, X).

sDFluent(fighting(_,_)=true).
outputEntity(fighting(_,_)=true).
index(fighting(X,_)=true, X).

sDFluent(abrupt(_)=true).
inputEntity(abrupt(_)=true).
index(abrupt(X)=true, X).

sDFluent(close(_,_)=true).
inputEntity(close(_,_)=true).
index(close(X,_)=true, X).

sDFluent(inactive(_)=true).
inputEntity(inactive(_)=true).
index(inactive(X)=true, X).

simpleFluent(moving(_,_)=true).
outputEntity(moving(_,_)=true).
index(moving(P1,_)=true, P1).

sDFluent(walking(_)=true).
inputEntity(walking(_)=true).
index(walking(P1)=true, P1).

event(exit(_)).
inputEntity(exit(_)).
index(exit(P1), P1).

