:- dynamic grounding/1.

/*showWhatLoadedDeclsSpPrep:-
    getcwd(Dir),
    write('Loaded '),write(Dir),writeln('/amin_declarations.prolog').

:- showWhatLoadedDeclsSpPrep.*/


/********************************************************************** DECLARATIONS *******************************************************************************
 -Declare the entities of the event description: events, simple and statically determined fluents.
 -For each entity state if it is input or output (simple fluents are by definition output entities).
 -For each input/output entity state its index.
 -For input entities/statically determined fluents state whether the intervals will be collected into a list or built from time-points.
 -Declare the groundings of the fluents and output entities/events.
 -Declare the order of caching of output entities.
 *******************************************************************************************************************************************************************/
 
%event(dummy(_)).			
%inputEntity(dummy(_)).			
%index(dummy(Vessel),	Vessel).

%event(nonCritical(_)).			
%inputEntity(nonCritical(_)).			
%index(nonCritical(Vessel),	Vessel).

%event(turn(_)).			
%inputEntity(turn(_)).			
%index(turn(Vessel),	Vessel).

event(change_in_speed_start(_)).		
inputEntity(change_in_speed_start(_)).		
index(change_in_speed_start(Vessel),	Vessel).

event(change_in_speed_end(_)).		
inputEntity(change_in_speed_end(_)).		
index(change_in_speed_end(Vessel),	Vessel).

event(change_in_heading(_)).		
inputEntity(change_in_heading(_)).		
index(change_in_heading(Vessel),	Vessel).

event(stop_start(_)).		
inputEntity(stop_start(_)).		
index(stop_start(Vessel),	Vessel).

event(stop_end(_)).		
inputEntity(stop_end(_)).		
index(stop_end(Vessel),	Vessel).

event(slow_motion_start(_)).		
inputEntity(slow_motion_start(_)).		
index(slow_motion_start(Vessel),	Vessel).

event(slow_motion_end(_)).		
inputEntity(slow_motion_end(_)).		
index(slow_motion_end(Vessel),	Vessel).

event(gap_start(_)).		
inputEntity(gap_start(_)).		
index(gap_start(Vessel), Vessel).

event(gap_end(_)).		
inputEntity(gap_end(_)).		
index(gap_end(Vessel), Vessel).

event(isInArea(_,_)).		
inputEntity(isInArea(_,_)).		
index(isInArea(Vessel,_), 	Vessel).

event(leavesArea(_,_)).		
inputEntity(leavesArea(_,_)).		
index(leavesArea(Vessel,_), 	Vessel).

event(coord(_,_,_)).		
inputEntity(coord(_,_,_)).		
index(coord(Vessel,_,_), 	Vessel).

event(velocity(_,_,_)).		
inputEntity(velocity(_,_,_)).		
index(velocity(Vessel,_,_), 	Vessel).

event(coord_nc(_,_,_)).		
inputEntity(coord_nc(_,_,_)).		
index(coord_nc(Vessel,_,_), 	Vessel).

event(velocity_nc(_,_,_)).		
inputEntity(velocity_nc(_,_,_)).		
index(velocity_nc(Vessel,_,_), 	Vessel).

sDFluent(proximity(_,_)=true).	
inputEntity(proximity(_,_)=true).		
index(proximity(Vessel,_)=true, 	Vessel).

sDFluent(inCell(_)=_).
inputEntity(inCell(_)=_).
index(inCell(Vessel)=_, Vessel).

simpleFluent(lowSpeed(_)=true).    
outputEntity(lowSpeed(_)=true).	
index(lowSpeed(Vessel)=true, Vessel).

simpleFluent(stopped(_)=true).    
outputEntity(stopped(_)=true).	
index(stopped(Vessel)=true, Vessel).

simpleFluent(sailing(_)=true).    
outputEntity(sailing(_)=true).	
index(sailing(Vessel)=true, Vessel).

simpleFluent(highSpeedIn(_,_)=true).    
outputEntity(highSpeedIn(_,_)=true).	
index(highSpeedIn(Vessel,_)=true, Vessel).

simpleFluent(withinArea(_,_)=true).    
outputEntity(withinArea(_,_)=true).	
index(withinArea(Vessel)=true, Vessel).

sDFluent(loitering(_)=true). 			
outputEntity(loitering(_)=true).
index(loitering(Vessel)=true, Vessel).

sDFluent(rendezVouz(_,_)=true). 			
outputEntity(rendezVouz(_,_)=true).
index(rendezVouz(Vessel,_)=true, Vessel).

% for input entities/statically determined fluents state whether 
% the intervals will be collected into a list or built from given time-points

%collectIntervals(stopped(_)=true).
%collectIntervals(inCell(_)=_).
collectIntervals(proximity(_,_)=true).

% define the groundings of the fluents and output entities/events

grounding(lowSpeed(Vessel)=true) 					:- vessel(Vessel).
grounding(sailing(Vessel)=true) 					:- vessel(Vessel).
grounding(stopped(Vessel)=true) 					:- vessel(Vessel).
grounding(withinArea(Vessel,_AreaName)=true) 					:- vessel(Vessel).
grounding(highSpeedIn(Vessel,_AreaName)=true) 					:- vessel(Vessel).
%grounding(inCell(Vessel)=CellId)					:- rememberToRetractMe(CellId,Vessel).
grounding(loitering(Vessel)=true)					:- vessel(Vessel).
grounding(rendezVouz(Vessel,Vessel2)=true)	:- vessel(Vessel), vessel(Vessel2), Vessel =\= Vessel2.
%grounding(illegalShipping(Vessel)) 					:- vessel(Vessel). 
%grounding(suspiciousArea(CellId)) 					:- gridCell(CellId,_X,_Y).
%grounding(erraticMovement(Vessel)=true) 			:- vessel(Vessel).
%grounding(fastApproach(Vessel)) 					:- vessel(Vessel).
%grounding(suspiciousDelay(Vessel)=true) 			:- vessel(Vessel).
%grounding(possibleRendevouz(Vessel1,Vessel2)=true) 	:- rememberToRetractMe(CellId,Vessel1),
%													   rememberToRetractMe(CellId,Vessel2),
%													   Vessel1 \= Vessel2.
%grounding(packagePicking(Vessel1,Vessel2))	:- rememberToRetractMe(CellId,Vessel1),
%													   rememberToRetractMe(CellId,Vessel2),
%													   Vessel1 \= Vessel2.
% cachingOrder should be defined for all output entities

cachingOrder(stopped(_)=true).
cachingOrder(lowSpeed(_)=true).
cachingOrder(withinArea(_,_)=true).
cachingOrder(sailing(_)=true).
cachingOrder(highSpeed(_,_)=true).
cachingOrder(loitering(_)=true).
cachingOrder(rendezVouz(_,_)=true).

needsGrounding(_, _, _) :- fail. 
buildFromPoints(_) :- fail.
