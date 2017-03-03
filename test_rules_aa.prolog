% X is working if he is at work and is not having a break
working(X) iff
	loc(X)=work,
	not takingBreak(X).

holdsFor(working(X)=true, I) :-
	holdsFor(loc(X)=work, I1),
	holdsFor(takingBreak(X)=true, I2),
	relative_complement_all(I1, [I2], I).

% X rests if he is at the pub or on holiday or at work and taking a break
resting(X) iff
	loc(X)=pub or onHoliday(X) or (loc(X)=work, takingBreak(X)).

holdsFor(working(X)=true, I) :-
	holdsFor(loc(X)=pub, I1),
	holdsFor(onHoliday(X)=true, I2),
	holdsFor(loc(X)=work, I3),
	holdsFor(takingBreak(X)=true, I4),
	intersect_all([I3,I4], I5),
	union_all([I1,I2,I5], I).

% X is sad if he is poor and working, or poor and changing his child's diapers at home
sad(X) iff
	poor(X),
	(working(X) or (loc(X)=home, changingDiapers(X))).

holdsFor(sad(X)=true, I) :-
	holdsFor(poor(X)=true, I1),
	holdsFor(working(X)=true, I2),
	holdsFor(loc(X)=home, I3),
	holdsFor(changingDiapers(X)=true, I4),
	intersect_all([I3,I4], I5), 
	union_all([I2,I5], I6),
	intersect_all([I1,I6], I).

% X and Y are fighting
fighting(X,Y) iff
	( (abrupt(X) or abrupt(Y)), close(X,Y) ),
	not (inactive(X) or inactive(Y) ).

holdsFor(fighting(X,Y)=true, I) :-
	holdsFor(active(X)=true, I1),
	holdsFor(active(X)=true, I2),
	union_all([I1,I2], I3),
	holdsFor(close(X,Y)=true, I4),
	intersect_all([I3,I4], I5), 
	holdsFor(inactive(X)=true, I6),
	holdsFor(inactive(X)=true, I7),
	relative_complement_all(I5, [I6,I7], I).


% for initiated/terminated rules: the first condition is always an event, and the remaining conditions are treated as fluents unless otherwise indicated in the declarations or by means of the 'happens' keyword

initiate moving(P1,P2) if
	start walking(P1),	% start is a built-in event, the argument of which is a fluent
	walking(P2),		
	close(P1,P2)

initiatedAt(moving(P1,P2)=true, T) :-
	happensAt(start(walking(P1)=true), T),
	holdsAt(walking(P2)=true, T),
	holdsAt(close(P1,P2)=true, T).

terminate moving(P1,P2) if
	end walking(P1)		% end is a built-in event, the argument of which is a fluent

terminatedAt(moving(P1,P2)=true, T) :-
	happensAt(end(walking(P1)=true), T).	

terminate moving(P1,P2) if
	happens exit(P1)	% 'happens' may be omitted since the first condition is always an event

terminatedAt(moving(P1,P2)=true, T) :-
	happensAt(exit(P1), T).


% future work: automated generation/completion of declarations, consistency checking wrt to the declarations, dependency graph generation for cycle checking and the automated generation of the caching order, nested initiatedAt and terminatedAt rules, introduction of optimisation checks, simple to sd fluent conversion for optimisation, graphical user interface

% Note: backward compatibility with the existing compiler must be preserved.


