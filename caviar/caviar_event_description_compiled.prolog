:-, ['../src/RTEC.prolog'].
:-, ['caviar_declarations.prolog'].

rocessedIE(_31814,start(walking(_31814)=true),_31792),
     \+happensAtIE(disappear(_31814),_31792).

initiatedAt(person(_31814)=true, _, _31792, _) :-
     happensAtProcessedIE(_31814,start(running(_31814)=true),_31792),
     \+happensAtIE(disappear(_31814),_31792).

initiatedAt(person(_31814)=true, _, _31792, _) :-
     happensAtProcessedIE(_31814,start(active(_31814)=true),_31792),
     \+happensAtIE(disappear(_31814),_31792).

initiatedAt(person(_31814)=true, _, _31792, _) :-
     happensAtProcessedIE(_31814,start(abrupt(_31814)=true),_31792),
     \+happensAtIE(disappear(_31814),_31792).

initiatedAt(person(_31814)=false, _, _31792, _) :-
     happensAtIE(disappear(_31814),_31792).

initiatedAt(leaving_object(_31814,_31816)=true, _, _31792, _) :-
     happensAtIE(appear(_31816),_31792),
     holdsAtProcessedIE(_31816,inactive(_31816)=true,_31792),
     holdsAtProcessedSimpleFluent(_31814,person(_31814)=true,_31792),
     holdsAtProcessedSDFluent(_31814,closeSymmetric(_31814,_31816,30)=true,_31792).

initiatedAt(leaving_object(_31814,_31816)=false, _, _31792, _) :-
     happensAtIE(disappear(_31816),_31792).

initiatedAt(meeting(_31814,_31816)=true, _, _31792, _) :-
     happensAtProcessedSDFluent(_31814,start(greeting1(_31814,_31816)=true),_31792),
     \+happensAtIE(disappear(_31814),_31792),
     \+happensAtIE(disappear(_31816),_31792).

initiatedAt(meeting(_31814,_31816)=true, _, _31792, _) :-
     happensAtProcessedSDFluent(_31814,start(greeting2(_31814,_31816)=true),_31792),
     \+happensAtIE(disappear(_31814),_31792),
     \+happensAtIE(disappear(_31816),_31792).

initiatedAt(meeting(_31814,_31816)=false, _, _31792, _) :-
     happensAtProcessedIE(_31814,start(running(_31814)=true),_31792).

initiatedAt(meeting(_31814,_31816)=false, _, _31792, _) :-
     happensAtProcessedIE(_31816,start(running(_31816)=true),_31792).

initiatedAt(meeting(_31814,_31816)=false, _, _31792, _) :-
     happensAtProcessedIE(_31814,start(abrupt(_31814)=true),_31792).

initiatedAt(meeting(_31814,_31816)=false, _, _31792, _) :-
     happensAtProcessedIE(_31816,start(abrupt(_31816)=true),_31792).

initiatedAt(meeting(_31814,_31816)=false, _, _31792, _) :-
     happensAtProcessedSDFluent(_31814,start(close(_31814,_31816,34)=false),_31792).

holdsForSDFluent(close(_31820,_31822,24)=true,_31792) :-
     holdsForProcessedIE(_31820,distance(_31820,_31822,24)=true,_31792).

holdsForSDFluent(close(_31820,_31822,25)=true,_31792) :-
     holdsForProcessedSDFluent(_31820,close(_31820,_31822,24)=true,_31844),
     holdsForSDFluent(distance(_31820,_31822,25)=true,_31864),
     union_all([_31844,_31864],_31792).

holdsForSDFluent(close(_31820,_31822,30)=true,_31792) :-
     holdsForSDFluent(close(_31820,_31822,25)=true,_31844),
     holdsForSDFluent(distance(_31820,_31822,30)=true,_31864),
     union_all([_31844,_31864],_31792).

holdsForSDFluent(close(_31820,_31822,34)=true,_31792) :-
     holdsForSDFluent(close(_31820,_31822,30)=true,_31844),
     holdsForSDFluent(distance(_31820,_31822,34)=true,_31864),
     union_all([_31844,_31864],_31792).

holdsForSDFluent(close(_31820,_31822,24)=false,_31792) :-
     holdsForProcessedSDFluent(_31820,close(_31820,_31822,24)=true,_31844),
     complement_all([_31844],_31792).

holdsForSDFluent(closeSymmetric(_31820,_31822,24)=true,_31792) :-
     holdsForProcessedSDFluent(_31820,close(_31820,_31822,24)=true,_31844),
     holdsForProcessedSDFluent(_31822,close(_31822,_31820,24)=true,_31864),
     union_all([_31844,_31864],_31792).

holdsForSDFluent(greeting1(_31820,_31822)=true,_31792) :-
     holdsForProcessedSDFluent(_31820,activeOrInactivePerson(_31820)=true,_31838),
     holdsForProcessedSimpleFluent(_31822,person(_31822)=true,_31854),
     holdsForSDFluent(close(_31820,_31822,25)=true,_31874),
     holdsForProcessedIE(_31822,running(_31822)=true,_31890),
     holdsForProcessedIE(_31822,abrupt(_31822)=true,_31906),
     union_all([_31890,_31906],_31924),
     intersect_all([_31838,_31854,_31874],_31948),
     relative_complement_all(_31948,[_31924],_31792).

holdsForSDFluent(greeting2(_31820,_31822)=true,_31792) :-
     holdsForProcessedIE(_31820,walking(_31820)=true,_31838),
     holdsForProcessedSDFluent(_31822,activeOrInactivePerson(_31822)=true,_31854),
     holdsForSDFluent(close(_31822,_31820,25)=true,_31874),
     intersect_all([_31838,_31854,_31874],_31792).

holdsForSDFluent(activeOrInactivePerson(_31820)=true,_31792) :-
     holdsForProcessedIE(_31820,active(_31820)=true,_31836),
     holdsForProcessedIE(_31820,inactive(_31820)=true,_31852),
     holdsForProcessedSimpleFluent(_31820,person(_31820)=true,_31868),
     intersect_all([_31852,_31868],_31886),
     union_all([_31836,_31886],_31792).

holdsForSDFluent(moving(_31820,_31822)=true,_31792) :-
     holdsForProcessedIE(_31820,walking(_31820)=true,_31838),
     holdsForProcessedIE(_31822,walking(_31822)=true,_31854),
     holdsForSDFluent(close(_31820,_31822,34)=true,_31874),
     intersect_all([_31838,_31854,_31874],_31792).

holdsForSDFluent(fighting(_31820,_31822)=true,_31792) :-
     holdsForProcessedIE(_31820,abrupt(_31820)=true,_31838),
     holdsForProcessedIE(_31822,abrupt(_31822)=true,_31854),
     union_all([_31838,_31854],_31872),
     holdsForProcessedSDFluent(_31820,close(_31820,_31822,24)=true,_31892),
     holdsForProcessedIE(_31820,inactive(_31820)=true,_31908),
     holdsForProcessedIE(_31822,inactive(_31822)=true,_31924),
     union_all([_31908,_31924],_31942),
     intersect_all([_31872,_31892],_31960),
     relative_complement_all(_31960,[_31942],_31792).

cachingOrder2(_31796, close(_31796,_31798,24)=true) :-
     id_pair(_31796,_31798).

cachingOrder2(_31796, person(_31796)=true) :-
     list_of_ids(_31796).

cachingOrder2(_31796, activeOrInactivePerson(_31796)=true) :-
     list_of_ids(_31796).

cachingOrder2(_31796, close(_31796,_31798,34)=false) :-
     id_pair(_31796,_31798).

cachingOrder2(_31796, closeSymmetric(_31796,_31798,30)=true) :-
     id_pair(_31796,_31798).

cachingOrder2(_31796, fighting(_31796,_31798)=true) :-
     id_pair(_31796,_31798).

cachingOrder2(_31796, moving(_31796,_31798)=true) :-
     id_pair(_31796,_31798).

cachingOrder2(_31796, greeting1(_31796,_31798)=true) :-
     id_pair(_31796,_31798).

cachingOrder2(_31796, greeting2(_31796,_31798)=true) :-
     id_pair(_31796,_31798).

cachingOrder2(_31796, leaving_object(_31796,_31798)=true) :-
     id_pair(_31796,_31798).

cachingOrder2(_31796, leaving_object(_31796,_31798)=true) :-
     symmetric_id_pair(_31796,_31798).

cachingOrder2(_31796, meeting(_31796,_31798)=true) :-
     id_pair(_31796,_31798).

buildFromPoints2(_31796, walking(_31796)=true) :-
     list_of_ids(_31796).

buildFromPoints2(_31796, active(_31796)=true) :-
     list_of_ids(_31796).

buildFromPoints2(_31796, inactive(_31796)=true) :-
     list_of_ids(_31796).

buildFromPoints2(_31796, running(_31796)=true) :-
     list_of_ids(_31796).

buildFromPoints2(_31796, abrupt(_31796)=true) :-
     list_of_ids(_31796).

