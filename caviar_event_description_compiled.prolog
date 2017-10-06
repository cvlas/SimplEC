:- ['../src/RTEC.prolog'].
:- ['caviar_declarations.prolog'].

tProcessedIE(_31716,start(walking(_31716)=true),_31694),
     \+happensAtIE(disappear(_31716),_31694).

initiatedAt(person(_31716)=true, _, _31694, _) :-
     happensAtProcessedIE(_31716,start(running(_31716)=true),_31694),
     \+happensAtIE(disappear(_31716),_31694).

initiatedAt(person(_31716)=true, _, _31694, _) :-
     happensAtProcessedIE(_31716,start(active(_31716)=true),_31694),
     \+happensAtIE(disappear(_31716),_31694).

initiatedAt(person(_31716)=true, _, _31694, _) :-
     happensAtProcessedIE(_31716,start(abrupt(_31716)=true),_31694),
     \+happensAtIE(disappear(_31716),_31694).

initiatedAt(person(_31716)=false, _, _31694, _) :-
     happensAtIE(disappear(_31716),_31694).

initiatedAt(leaving_object(_31716,_31718)=true, _, _31694, _) :-
     happensAtIE(appear(_31718),_31694),
     holdsAtProcessedIE(_31718,inactive(_31718)=true,_31694),
     holdsAtProcessedSimpleFluent(_31716,person(_31716)=true,_31694),
     holdsAtProcessedSDFluent(_31716,closeSymmetric(_31716,_31718,30)=true,_31694).

initiatedAt(leaving_object(_31716,_31718)=false, _, _31694, _) :-
     happensAtIE(disappear(_31718),_31694).

initiatedAt(meeting(_31716,_31718)=true, _, _31694, _) :-
     happensAtProcessedSDFluent(_31716,start(greeting1(_31716,_31718)=true),_31694),
     \+happensAtIE(disappear(_31716),_31694),
     \+happensAtIE(disappear(_31718),_31694).

initiatedAt(meeting(_31716,_31718)=true, _, _31694, _) :-
     happensAtProcessedSDFluent(_31716,start(greeting2(_31716,_31718)=true),_31694),
     \+happensAtIE(disappear(_31716),_31694),
     \+happensAtIE(disappear(_31718),_31694).

initiatedAt(meeting(_31716,_31718)=false, _, _31694, _) :-
     happensAtProcessedIE(_31716,start(running(_31716)=true),_31694).

initiatedAt(meeting(_31716,_31718)=false, _, _31694, _) :-
     happensAtProcessedIE(_31718,start(running(_31718)=true),_31694).

initiatedAt(meeting(_31716,_31718)=false, _, _31694, _) :-
     happensAtProcessedIE(_31716,start(abrupt(_31716)=true),_31694).

initiatedAt(meeting(_31716,_31718)=false, _, _31694, _) :-
     happensAtProcessedIE(_31718,start(abrupt(_31718)=true),_31694).

initiatedAt(meeting(_31716,_31718)=false, _, _31694, _) :-
     happensAtProcessedSDFluent(_31716,start(close(_31716,_31718,34)=false),_31694).

cachingOrder2(_31698, close(_31698,_31700,24)=true) :-
     id_pair(_31698,_31700).

cachingOrder2(_31698, person(_31698)=true) :-
     list_of_ids(_31698).

cachingOrder2(_31698, activeOrInactivePerson(_31698)=true) :-
     list_of_ids(_31698).

cachingOrder2(_31698, close(_31698,_31700,34)=false) :-
     id_pair(_31698,_31700).

cachingOrder2(_31698, closeSymmetric(_31698,_31700,30)=true) :-
     id_pair(_31698,_31700).

cachingOrder2(_31698, fighting(_31698,_31700)=true) :-
     id_pair(_31698,_31700).

cachingOrder2(_31698, moving(_31698,_31700)=true) :-
     id_pair(_31698,_31700).

cachingOrder2(_31698, greeting1(_31698,_31700)=true) :-
     id_pair(_31698,_31700).

cachingOrder2(_31698, greeting2(_31698,_31700)=true) :-
     id_pair(_31698,_31700).

cachingOrder2(_31698, leaving_object(_31698,_31700)=true) :-
     id_pair(_31698,_31700).

cachingOrder2(_31698, leaving_object(_31698,_31700)=true) :-
     symmetric_id_pair(_31698,_31700).

cachingOrder2(_31698, meeting(_31698,_31700)=true) :-
     id_pair(_31698,_31700).

buildFromPoints2(_31698, walking(_31698)=true) :-
     list_of_ids(_31698).

buildFromPoints2(_31698, active(_31698)=true) :-
     list_of_ids(_31698).

buildFromPoints2(_31698, inactive(_31698)=true) :-
     list_of_ids(_31698).

buildFromPoints2(_31698, running(_31698)=true) :-
     list_of_ids(_31698).

buildFromPoints2(_31698, abrupt(_31698)=true) :-
     list_of_ids(_31698).

