sDFluent(working(_)=true).
outputEntity(working(_)=true).
index(working(X)=true, X).

sDFluent(loc(_)=true).
inputEntity(loc(_)=true).
index(loc(X)=true, X).

sDFluent(loc(_)=w).
inputEntity(loc(_)=w).
index(loc(X)=w, X).

sDFluent(loc(_)=wo).
inputEntity(loc(_)=wo).
index(loc(X)=wo, X).

sDFluent(loc(_)=wor).
inputEntity(loc(_)=wor).
index(loc(X)=wor, X).

sDFluent(loc(_)=work).
inputEntity(loc(_)=work).
index(loc(X)=work, X).

sDFluent(takingBreak(_)=true).
inputEntity(takingBreak(_)=true).
index(takingBreak(X)=true, X).

sDFluent(resting(_)=true).
outputEntity(resting(_)=true).
index(resting(X)=true, X).

sDFluent(loc(_)=p).
inputEntity(loc(_)=p).
index(loc(X)=p, X).

sDFluent(loc(_)=pu).
inputEntity(loc(_)=pu).
index(loc(X)=pu, X).

sDFluent(loc(_)=pub).
inputEntity(loc(_)=pub).
index(loc(X)=pub, X).

sDFluent(onHoliday(_)=true).
inputEntity(onHoliday(_)=true).
index(onHoliday(X)=true, X).

sDFluent(happy(_)=true).
outputEntity(happy(_)=true).
index(happy(X)=true, X).

sDFluent(happy(_)=t).
outputEntity(happy(_)=t).
index(happy(X)=t, X).

sDFluent(happy(_)=tr).
outputEntity(happy(_)=tr).
index(happy(X)=tr, X).

sDFluent(happy(_)=tru).
outputEntity(happy(_)=tru).
index(happy(X)=tru, X).

sDFluent(rich(_)=true).
inputEntity(rich(_)=true).
index(rich(X)=true, X).

sDFluent(rich(_)=t).
inputEntity(rich(_)=t).
index(rich(X)=t, X).

sDFluent(rich(_)=tr).
inputEntity(rich(_)=tr).
index(rich(X)=tr, X).

sDFluent(rich(_)=tru).
inputEntity(rich(_)=tru).
index(rich(X)=tru, X).

sDFluent(resting(_)=t).
inputEntity(resting(_)=t).
index(resting(X)=t, X).

sDFluent(resting(_)=tr).
inputEntity(resting(_)=tr).
index(resting(X)=tr, X).

sDFluent(resting(_)=tru).
inputEntity(resting(_)=tru).
index(resting(X)=tru, X).

sDFluent(sad(_)=true).
outputEntity(sad(_)=true).
index(sad(X)=true, X).

sDFluent(poor(_)=true).
inputEntity(poor(_)=true).
index(poor(X)=true, X).

sDFluent(loc(_)=h).
inputEntity(loc(_)=h).
index(loc(X)=h, X).

sDFluent(loc(_)=ho).
inputEntity(loc(_)=ho).
index(loc(X)=ho, X).

sDFluent(loc(_)=hom).
inputEntity(loc(_)=hom).
index(loc(X)=hom, X).

sDFluent(loc(_)=home).
inputEntity(loc(_)=home).
index(loc(X)=home, X).

sDFluent(changingDiapers(_)=true).
inputEntity(changingDiapers(_)=true).
index(changingDiapers(X)=true, X).

sDFluent(friends(_,_)=true).
outputEntity(friends(_,_)=true).
index(friends(X,_)=true, X).

sDFluent(loc(_)=true).
inputEntity(loc(_)=true).
index(loc(Y)=true, Y).

sDFluent(loc(_)=p).
inputEntity(loc(_)=p).
index(loc(Y)=p, Y).

sDFluent(loc(_)=pu).
inputEntity(loc(_)=pu).
index(loc(Y)=pu, Y).

sDFluent(loc(_)=pub).
inputEntity(loc(_)=pub).
index(loc(Y)=pub, Y).

sDFluent(rich(_)=true).
inputEntity(rich(_)=true).
index(rich(Y)=true, Y).

sDFluent(fighting(_,_)=true).
outputEntity(fighting(_,_)=true).
index(fighting(X,_)=true, X).

sDFluent(abrupt(_)=true).
inputEntity(abrupt(_)=true).
index(abrupt(X)=true, X).

sDFluent(abrupt(_)=true).
inputEntity(abrupt(_)=true).
index(abrupt(Y)=true, Y).

sDFluent(close(_,_)=true).
inputEntity(close(_,_)=true).
index(close(X,_)=true, X).

sDFluent(inactive(_)=true).
inputEntity(inactive(_)=true).
index(inactive(X)=true, X).

sDFluent(inactive(_)=true).
inputEntity(inactive(_)=true).
index(inactive(Y)=true, Y).

simpleFluent(moving(_,_)=true).
outputEntity(moving(_,_)=true).
index(moving(P1,_)=true, P1).

_20885Fluent(walking(_)=true).
_20887Entity(walking(_)=true).
index(walking(P1)=true, P1).

simpleFluent(walking(_)=true).
outputEntity(walking(_)=true).
index(walking(P2)=true, P2).

simpleFluent(close(_,_)=true).
outputEntity(close(_,_)=true).
index(close(P1,_)=true, P1).

event(exit(_)).
inputEntity(exit(_)).
index(exit(P1), P1).

