
/***************************************************************************************************
 This program compiles an event description into a more efficient representation.
 It also compiles some types of declaration into a format that allows for more efficient reasoning.
 Input: 
 (a) Event Calculus axioms.
 (b) Declarations.

 Event processing should be performed on the event description 
 produced by this compiler, along with the declarations.
 ***************************************************************************************************/

:- dynamic initially/1, initiatedAt/2, terminatedAt/2, initiates/3, terminates/3, happensAt/2, holdsFor/2, holdsAt/2, grounding/1.


compileEventDescription(Declarations, InputDescription, OutputDescription) :- 
	consult(Declarations),
	consult(InputDescription),
	tell(OutputDescription),
	% compile initially/1 rules	
	compileInitially.

% compile initiatedAt/2 rules
compileEventDescription(_, _, _) :- compileInitiatedAt.
% compile terminatedAt/2 rules
compileEventDescription(_, _, _) :- compileTerminatedAt.
% compile initiates/3 rules
compileEventDescription(_, _, _) :- compileInitiates.
% compile terminates/3 rules
compileEventDescription(_, _, _) :- compileTerminates.
% compile holdsFor/2 rules
compileEventDescription(_, _, _) :- compileHoldsFor.
% compile happensAt/2 rules
compileEventDescription(_, _, _) :- compileHappensAt.
% compile cachingOrder/1 declarations:
% combine cachingOrder/1, grounding/1 and indexOf/2 to produce cachingOrder2/2
compileEventDescription(_, _, _) :- compileCachingOrder.
% compile collectIntervals/1 declarations: 
% combine collectIntervals/1, grounding/1 and indexOf/2 to produce collectIntervals2/2
compileEventDescription(_, _, _) :- compileCollectIntervals.
% compile buildFromPoints/1 declarations:
% combine buildFromPoints/1, grounding/1 and indexOf/2 to produce buildFromPoints2/2
compileEventDescription(_, _, _) :- compileBuildFromPoints.
% close the new event description file
compileEventDescription(_, _, _) :-  told, !.


% compile initially/1 rules
compileInitially :-
        clause(initially(F=V), Body),	
	\+ var(F), 
	compileConditions(Body, NewBody),	
	writeCompiledRule('initially', [F=V], NewBody), fail.

% compile initiatedAt/2 rules 
compileInitiatedAt :-
        clause(initiatedAt(U,T), Body),	
	compileConditions(Body, NewBody),	
	writeCompiledRule('initiatedAt', [U,T], NewBody), fail.

% compile terminatedAt/2 rules 
compileTerminatedAt :-
        clause(terminatedAt(U,T), Body),
	compileConditions(Body, NewBody),	
	writeCompiledRule('terminatedAt', [U,T], NewBody), fail.

% compile initiates/3 rules
compileInitiates :-
        clause(initiates(E,U,T), (Body)),
	compileConditions((happensAt(E,T),Body), NewBody),	
	writeCompiledRule('initiates', [U,T], NewBody), fail.

% compile terminates/3 rules
compileTerminates :-
        clause(terminates(E,U,T), (Body)),
	compileConditions((happensAt(E,T),Body), NewBody),	
	writeCompiledRule('terminates', [U,T], NewBody), fail.

% compile holdsFor/2 rules
compileHoldsFor :-
        clause(holdsFor(F=V,I), Body),	
	% the condition below makes sure that we do not compile rules from RTEC.prolog 
	% or any other domain-independent code
	\+ var(F),
	compileConditions(Body, NewBody),	
	writeCompiledRule('holdsFor', [F=V,I], NewBody), fail.

% compile happensAt/2 rules 
compileHappensAt :-
        clause(happensAt(E,T), Body),	
	% the condition below makes sure that we do not compile rules from RTEC.prolog 
	% or any other domain-independent code
	\+ var(E),
	compileConditions(Body, NewBody),	
	writeCompiledRule('happensAt', [E,T], NewBody), fail.


% compile cachingOrder/1 rules
compileCachingOrder :-
        cachingOrder(Entity),
	clause(grounding(Entity), Body),
	indexOf(Index, Entity),	 
	write('cachingOrder2('), write(Index), write(', '), write(Entity), write(') :-'), nl, 
	tab(5), write(Body), write('.'), nl, nl, fail.

% compile collectIntervals/1 rules
compileCollectIntervals :-
        collectIntervals(F=V),
	clause(grounding(F=V), Body),
	indexOf(Index, F=V),	 
	write('collectIntervals2('), write(Index), write(', '), write(F=V), write(') :-'), nl, 
	tab(5), write(Body), write('.'), nl, nl, fail.

% compile buildFromPoints/1 rules
compileCollectIntervals :-
        buildFromPoints(F=V),
	clause(grounding(F=V), Body),
	indexOf(Index, F=V),	 
	write('buildFromPoints2('), write(Index), write(', '), write(F=V), write(') :-'), nl, 
	tab(5), write(Body), write('.'), nl, nl, fail.

%%%%%%%% compile body predicates %%%%%%%%

%%%% recursive definition of compileConditions %%%%

compileConditions((\+Head,Rest), (\+NewHead,NewRest)) :-	
	!, compileConditions1(Head, NewHead), 
	compileConditions(Rest, NewRest).

compileConditions((Head,Rest), (NewHead,NewRest)) :-	
	!, compileConditions1(Head, NewHead), 
	compileConditions(Rest, NewRest).

compileConditions(\+Body, \+NewBody) :-	
	!, compileConditions1(Body, NewBody).

compileConditions(Body, NewBody) :-	
	compileConditions1(Body, NewBody).


%%%% auxiliary predicate dealing with a single condition %%%%

%%% happensAt

% special event: start of simple fluent
compileConditions1(happensAt(start(U),T), happensAtProcessedSimpleFluent(Index,start(U),T)) :-
	simpleFluent(U), indexOf(Index, U), !.

% special event: start of input entity/statically determined fluent
compileConditions1(happensAt(start(U),T), happensAtProcessedIE(Index,start(U),T)) :-
	sDFluent(U), inputEntity(U), indexOf(Index, U), !.

% special event: start of internal entity/statically determined fluent
compileConditions1(happensAt(start(U),T), happensAtProcessedIE(Index,start(U),T)) :-
	sDFluent(U), internalEntity(U), indexOf(Index, U), !.

% special event: start of output entity/statically determined fluent
compileConditions1(happensAt(start(U),T), happensAtProcessedSDFluent(Index,start(U),T)) :-
	sDFluent(U), outputEntity(U), indexOf(Index, U), !.



% special event: end of simple fluent
compileConditions1(happensAt(end(U),T), happensAtProcessedSimpleFluent(Index,end(U),T)) :-
	simpleFluent(U), indexOf(Index, U), !.

% special event: end of input entity/statically determined fluent
compileConditions1(happensAt(end(U),T), happensAtProcessedIE(Index,end(U),T)) :-
	sDFluent(U), inputEntity(U), indexOf(Index, U), !.

% special event: end of internal entity/statically determined fluent
compileConditions1(happensAt(end(U),T), happensAtProcessedIE(Index,end(U),T)) :-
	sDFluent(U), internalEntity(U), indexOf(Index, U), !.

% special event: end of output entity/statically determined fluent
compileConditions1(happensAt(end(U),T), happensAtProcessedSDFluent(Index,end(U),T)) :-
	sDFluent(U), outputEntity(U), indexOf(Index, U), !.

% special event: end of statically determined fluent that is neither an input nor an output entity
compileConditions1(happensAt(end(U),T), happensAtSDFluent(end(U),T)) :-
	sDFluent(U), !.


% input entity/event
compileConditions1(happensAt(E,T), happensAtIE(E,T)) :-
	inputEntity(E), !.

% output entity/event
compileConditions1(happensAt(E,T), happensAtProcessed(Index,E,T)) :-
	outputEntity(E), indexOf(Index, E), !.


%%% holdsAt

% simple fluent
compileConditions1(holdsAt(U,T), holdsAtProcessedSimpleFluent(Index,U,T)) :-
	simpleFluent(U), indexOf(Index, U), !.

% input entity/statically determined fluent
compileConditions1(holdsAt(U,T), holdsAtProcessedIE(Index,U,T)) :-
	sDFluent(U), inputEntity(U), indexOf(Index, U), !.

% internal entity/statically determined fluent
compileConditions1(holdsAt(U,T), holdsAtProcessedIE(Index,U,T)) :-
	sDFluent(U), internalEntity(U), indexOf(Index, U), !.

% output entity/statically determined fluent
compileConditions1(holdsAt(U,T), holdsAtProcessedSDFluent(Index,U,T)) :-
	sDFluent(U), outputEntity(U), indexOf(Index, U), !.

% statically determined fluent that is neither input nor output entity
compileConditions1(holdsAt(U,T), holdsAtSDFluent(U,T)) :-
	sDFluent(U), !.


%%% holdsFor

% simple fluent
compileConditions1(holdsFor(U,I), holdsForProcessedSimpleFluent(Index,U,I)) :-
	simpleFluent(U), indexOf(Index, U), !.

% input entity/statically determined fluent
compileConditions1(holdsFor(U,I), holdsForProcessedIE(Index,U,I)) :-
	sDFluent(U), inputEntity(U), indexOf(Index, U), !.

% internal entity/statically determined fluent
compileConditions1(holdsFor(U,I), holdsForProcessedIE(Index,U,I)) :-
	sDFluent(U), internalEntity(U), indexOf(Index, U), !.

% output entity/statically determined fluent
compileConditions1(holdsFor(U,I), holdsForProcessedSDFluent(Index,U,I)) :-
	sDFluent(U), outputEntity(U), indexOf(Index, U), !.

% statically determined fluent that is neither input nor output entity
compileConditions1(holdsFor(U,I), holdsForSDFluent(U,I)) :-
	sDFluent(U), !.


%%% other body literals, eg interval manipulation constructs 
%%% or optimisation checks

compileConditions1(Something, Something).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I/O Utils
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


writeCompiledRule(initially, [U], (true)) :-
	!, write('initially('), write(U), write(').'), nl, nl. 

writeCompiledRule(initiatedAt, [U, T], (true)) :-
	!, write('initiatedAt('), write(U), write(', _, '), write(T), write(', _).'), nl, nl.

writeCompiledRule(terminatedAt, [U, T], (true)) :-
	!, write('terminatedAt('), write(U), write(', _, '), write(T), write(', _).'), nl, nl.

writeCompiledRule(holdsFor, [U, I], (true)) :-
	!, write('holdsForSDFluent('), write(U), write(','), write(I), write(').'), nl, nl. 

writeCompiledRule(happensAt, [E, T], (true)) :-
	!, write('happensAt('), write(E), write(','), write(T), write(').'), nl, nl.


writeCompiledRule(initially, [U], Body) :-
	write('initially('), write(U), write(') :-'), nl,  
	writeBodyLiterals(Body).

writeCompiledRule(initiatedAt, [U, T], Body) :-
	write('initiatedAt('), write(U), write(', _, '), write(T), write(', _) :-'), nl, 
	writeBodyLiterals(Body).

writeCompiledRule(terminatedAt, [U, T], Body) :-
	write('terminatedAt('), write(U), write(', _, '), write(T), write(', _) :-'), nl, 
	writeBodyLiterals(Body).

writeCompiledRule(initiates, [U, T], Body) :-
	write('initiatedAt('), write(U), write(', _, '), write(T), write(', _) :-'), nl, 
	writeBodyLiterals(Body).

writeCompiledRule(terminates, [U, T], Body) :-
	write('terminatedAt('), write(U), write(', _, '), write(T), write(', _) :-'), nl, 
	writeBodyLiterals(Body).

writeCompiledRule(holdsFor, [U, I], Body) :-
	write('holdsForSDFluent('), write(U), write(','), write(I), write(') :-'), nl,
	writeBodyLiterals(Body).

writeCompiledRule(happensAt, [E, T], Body) :-
	write('happensAtEv('), write(E), write(','), write(T), write(') :-'), nl, 
	writeBodyLiterals(Body).


writeBodyLiterals((Head,true)):-
	!, tab(5), write(Head), write('.'), nl, nl.

writeBodyLiterals((Head,Rest)):-
	!, tab(5), write(Head), write(','), nl,
	writeBodyLiterals(Rest).

writeBodyLiterals(Last) :- 
	tab(5), write(Last), write('.'), nl, nl.


