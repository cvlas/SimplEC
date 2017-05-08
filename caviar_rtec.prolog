holdsFor(close(Id1,Id2,24)=true, I) :-
	holdsFor(distance(Id1,Id2,24)=true, I).

holdsFor(close(Id1,Id2,25)=true, I) :-
	holdsFor(close(Id1,Id2,24)=true, I1),
	holdsFor(distance(Id1,Id2,25)=true, I2),
	union_all([I1,I2], I).

holdsFor(close(Id1,Id2,30)=true, I) :-
	holdsFor(close(Id1,Id2,25)=true, I1),
	holdsFor(distance(Id1,Id2,30)=true, I2),
	union_all([I1,I2], I).

holdsFor(close(Id1,Id2,34)=true, I) :-
	holdsFor(close(Id1,Id2,30)=true, I1),
	holdsFor(distance(Id1,Id2,34)=true, I2),
	union_all([I1,I2], I).

holdsFor(close(Id1,Id2,Threshold)=false, I) :-
	holdsFor(close(Id1,Id2,Threshold)=true, I1),
	complement_all([I1], I).

holdsFor(closeSymmetric(Id1,Id2,Threshold)=true, I) :-
	holdsFor(close(Id1,Id2,Threshold)=true, I1),
	holdsFor(close(Id2,Id1,Threshold)=true, I2),
	union_all([I1,I2], I).





initiatedAt(person(Id)=true, T) :-
	happensAt(start(walking(Id)=true), T),
	\+ happensAt(disappear(Id), T).

initiatedAt(person(Id)=true, T) :-
	happensAt(start(running(Id)=true), T),
	\+ happensAt(disappear(Id), T).

initiatedAt(person(Id)=true, T) :-
	happensAt(start(active(Id)=true), T),
	\+ happensAt(disappear(Id), T).

initiatedAt(person(Id)=true, T) :-
	happensAt(start(abrupt(Id)=true), T),
	\+ happensAt(disappear(Id), T).

initiatedAt(person(Id)=false, T) :-
	happensAt(disappear(Id), T).


/****************************************************************
 *		     LEAVING OBJECT				*
 ****************************************************************/

% ----- initiate leaving_object

initiatedAt(leaving_object(Person,Object)=true, T) :-
	happensAt(appear(Object), T), 
	holdsAt(inactive(Object)=true, T),
	holdsAt(person(Person)=true, T),
	% leaving_object is not symmetric in the pair of ids
	% and thus we need closeSymmetric here as opposed to close 
	holdsAt(closeSymmetric(Person,Object,30)=true, T).

% ----- terminate leaving_object: pick up object

initiatedAt(leaving_object(_Person,Object)=false, T) :-
	happensAt(disappear(Object), T).


/****************************************************************
 *		     MEETING					*
 ****************************************************************/

% ----- initiate meeting

initiatedAt(meeting(P1,P2)=true, T) :-
	happensAt(start(greeting1(P1,P2)=true), T),	
	\+ happensAt(disappear(P1), T),
	\+ happensAt(disappear(P2), T).

initiatedAt(meeting(P1,P2)=true, T) :-
	happensAt(start(greeting2(P1,P2)=true), T),	
	\+ happensAt(disappear(P1), T),
	\+ happensAt(disappear(P2), T).

% greeting1 

holdsFor(greeting1(P1,P2)=true, I) :-
	holdsFor(activeOrInactivePerson(P1)=true, IAI),
	holdsFor(person(P2)=true, IP2),
	holdsFor(close(P1,P2,25)=true, IC),
	intersect_all([IAI, IC, IP2], ITemp),
	holdsFor(running(P2)=true, IR2),
	holdsFor(abrupt(P2)=true, IA2),
	relative_complement_all(ITemp, [IR2,IA2], I).

% greeting2

holdsFor(greeting2(P1,P2)=true, I) :-
	% if P1 were active or inactive 
	% then meeting would have been initiated by greeting1	
	holdsFor(walking(P1)=true, IW1),
	holdsFor(activeOrInactivePerson(P2)=true, IAI2),
	holdsFor(close(P2,P1,25)=true, IC),
	intersect_all([IW1, IAI2, IC], I).

% activeOrInactivePersion 

holdsFor(activeOrInactivePerson(P)=true, I) :-
	holdsFor(active(P)=true, IA),
	holdsFor(inactive(P)=true, In),
	holdsFor(person(P)=true, IP),
	intersect_all([In,IP], InP),
	union_all([IA,InP], I).


% ----- terminate meeting

% run
initiatedAt(meeting(P1,_P2)=false, T) :-
	happensAt(start(running(P1)=true), T).

initiatedAt(meeting(_P1,P2)=false, T) :-
	happensAt(start(running(P2)=true), T).

% move abruptly
initiatedAt(meeting(P1,_P2)=false, T) :-
	happensAt(start(abrupt(P1)=true), T).

initiatedAt(meeting(_P1,P2)=false, T) :-
	happensAt(start(abrupt(P2)=true), T).

% move away from each other
initiatedAt(meeting(P1,P2)=false, T) :-
	happensAt(start(close(P1,P2,34)=false), T).


/****************************************************************
 *		     MOVING					*
 ****************************************************************/

holdsFor(moving(P1,P2)=true, MI) :-
	holdsFor(walking(P1)=true, WP1),
	holdsFor(walking(P2)=true, WP2),
	intersect_all([WP1,WP2], WI),
	holdsFor(close(P1,P2,34)=true, CI),
	intersect_all([WI,CI], MI).


/****************************************************************
 *		     FIGHTING					*
 ****************************************************************/

holdsFor(fighting(P1,P2)=true, FightingI) :-
	holdsFor(abrupt(P1)=true, AbruptP1I),
	holdsFor(abrupt(P2)=true, AbruptP2I),
	union_all([AbruptP1I,AbruptP2I], AbruptI),
	holdsFor(close(P1,P2,24)=true, CloseI),
	intersect_all([AbruptI,CloseI], AbruptCloseI),
	holdsFor(inactive(P1)=true, InactiveP1I),
	holdsFor(inactive(P2)=true, InactiveP2I),
	union_all([InactiveP1I,InactiveP2I], InactiveI),
	relative_complement_all(AbruptCloseI, [InactiveI], FightingI).

