initiatedAt(person(_3156)=true, _, _3134, _) :-
     happensAtProcessedIE(_3156,start(walking(_3156)=true),_3134),
     \+happensAtIE(disappear(_3156),_3134).

initiatedAt(person(_3156)=true, _, _3134, _) :-
     happensAtProcessedIE(_3156,start(running(_3156)=true),_3134),
     \+happensAtIE(disappear(_3156),_3134).

initiatedAt(person(_3156)=true, _, _3134, _) :-
     happensAtProcessedIE(_3156,start(active(_3156)=true),_3134),
     \+happensAtIE(disappear(_3156),_3134).

initiatedAt(person(_3156)=true, _, _3134, _) :-
     happensAtProcessedIE(_3156,start(abrupt(_3156)=true),_3134),
     \+happensAtIE(disappear(_3156),_3134).

initiatedAt(person(_3156)=false, _, _3134, _) :-
     happensAtIE(disappear(_3156),_3134).

initiatedAt(leaving_object(_3156,_3158)=true, _, _3134, _) :-
     happensAtIE(appear(_3158),_3134),
     holdsAtProcessedIE(_3158,inactive(_3158)=true,_3134),
     holdsAtProcessedSimpleFluent(_3156,person(_3156)=true,_3134),
     holdsAtProcessedSDFluent(_3156,closeSymmetric(_3156,_3158,30)=true,_3134).

initiatedAt(leaving_object(_3156,_3158)=false, _, _3134, _) :-
     happensAtIE(disappear(_3158),_3134).

initiatedAt(meeting(_3156,_3158)=true, _, _3134, _) :-
     happensAtProcessedSDFluent(_3156,start(greeting1(_3156,_3158)=true),_3134),
     \+happensAtIE(disappear(_3156),_3134),
     \+happensAtIE(disappear(_3158),_3134).

initiatedAt(meeting(_3156,_3158)=true, _, _3134, _) :-
     happensAtProcessedSDFluent(_3156,start(greeting2(_3156,_3158)=true),_3134),
     \+happensAtIE(disappear(_3156),_3134),
     \+happensAtIE(disappear(_3158),_3134).

initiatedAt(meeting(_3156,_3158)=false, _, _3134, _) :-
     happensAtProcessedIE(_3156,start(running(_3156)=true),_3134).

initiatedAt(meeting(_3156,_3158)=false, _, _3134, _) :-
     happensAtProcessedIE(_3158,start(running(_3158)=true),_3134).

initiatedAt(meeting(_3156,_3158)=false, _, _3134, _) :-
     happensAtProcessedIE(_3156,start(abrupt(_3156)=true),_3134).

initiatedAt(meeting(_3156,_3158)=false, _, _3134, _) :-
     happensAtProcessedIE(_3158,start(abrupt(_3158)=true),_3134).

initiatedAt(meeting(_3156,_3158)=false, _, _3134, _) :-
     happensAtProcessedSDFluent(_3156,start(close(_3156,_3158,34)=false),_3134).

holdsForSDFluent(close(_3162,_3164,24)=true,_3134) :-
     holdsForProcessedIE(_3162,distance(_3162,_3164,24)=true,_3134).

holdsForSDFluent(close(_3162,_3164,25)=true,_3134) :-
     holdsForProcessedSDFluent(_3162,close(_3162,_3164,24)=true,_3186),
     holdsForSDFluent(distance(_3162,_3164,25)=true,_3206),
     union_all([_3186,_3206],_3134).

holdsForSDFluent(close(_3162,_3164,30)=true,_3134) :-
     holdsForSDFluent(close(_3162,_3164,25)=true,_3186),
     holdsForSDFluent(distance(_3162,_3164,30)=true,_3206),
     union_all([_3186,_3206],_3134).

holdsForSDFluent(close(_3162,_3164,34)=true,_3134) :-
     holdsForSDFluent(close(_3162,_3164,30)=true,_3186),
     holdsForSDFluent(distance(_3162,_3164,34)=true,_3206),
     union_all([_3186,_3206],_3134).

holdsForSDFluent(close(_3162,_3164,24)=false,_3134) :-
     holdsForProcessedSDFluent(_3162,close(_3162,_3164,24)=true,_3186),
     complement_all([_3186],_3134).

holdsForSDFluent(closeSymmetric(_3162,_3164,24)=true,_3134) :-
     holdsForProcessedSDFluent(_3162,close(_3162,_3164,24)=true,_3186),
     holdsForProcessedSDFluent(_3164,close(_3164,_3162,24)=true,_3206),
     union_all([_3186,_3206],_3134).

holdsForSDFluent(greeting1(_3162,_3164)=true,_3134) :-
     holdsForProcessedSDFluent(_3162,activeOrInactivePerson(_3162)=true,_3180),
     holdsForProcessedSimpleFluent(_3164,person(_3164)=true,_3196),
     holdsForSDFluent(close(_3162,_3164,25)=true,_3216),
     holdsForProcessedIE(_3164,running(_3164)=true,_3232),
     holdsForProcessedIE(_3164,abrupt(_3164)=true,_3248),
     union_all([_3232,_3248],_3266),
     intersect_all([_3180,_3196,_3216],_3290),
     relative_complement_all(_3290,[_3266],_3134).

holdsForSDFluent(greeting2(_3162,_3164)=true,_3134) :-
     holdsForProcessedIE(_3162,walking(_3162)=true,_3180),
     holdsForProcessedSDFluent(_3164,activeOrInactivePerson(_3164)=true,_3196),
     holdsForSDFluent(close(_3164,_3162,25)=true,_3216),
     intersect_all([_3180,_3196,_3216],_3134).

holdsForSDFluent(activeOrInactivePerson(_3162)=true,_3134) :-
     holdsForProcessedIE(_3162,active(_3162)=true,_3178),
     holdsForProcessedIE(_3162,inactive(_3162)=true,_3194),
     holdsForProcessedSimpleFluent(_3162,person(_3162)=true,_3210),
     intersect_all([_3194,_3210],_3228),
     union_all([_3178,_3228],_3134).

holdsForSDFluent(moving(_3162,_3164)=true,_3134) :-
     holdsForProcessedIE(_3162,walking(_3162)=true,_3180),
     holdsForProcessedIE(_3164,walking(_3164)=true,_3196),
     holdsForSDFluent(close(_3162,_3164,34)=true,_3216),
     intersect_all([_3180,_3196,_3216],_3134).

holdsForSDFluent(fighting(_3162,_3164)=true,_3134) :-
     holdsForProcessedIE(_3162,abrupt(_3162)=true,_3180),
     holdsForProcessedIE(_3164,abrupt(_3164)=true,_3196),
     union_all([_3180,_3196],_3214),
     holdsForProcessedSDFluent(_3162,close(_3162,_3164,24)=true,_3234),
     holdsForProcessedIE(_3162,inactive(_3162)=true,_3250),
     holdsForProcessedIE(_3164,inactive(_3164)=true,_3266),
     union_all([_3250,_3266],_3284),
     intersect_all([_3214,_3234],_3302),
     relative_complement_all(_3302,[_3284],_3134).

cachingOrder2(_3138, close(_3138,_3140,24)=true) :-
     id_pair(_3138,_3140).

cachingOrder2(_3138, person(_3138)=true) :-
     list_of_ids(_3138).

cachingOrder2(_3138, activeOrInactivePerson(_3138)=true) :-
     list_of_ids(_3138).

cachingOrder2(_3138, close(_3138,_3140,34)=false) :-
     id_pair(_3138,_3140).

cachingOrder2(_3138, closeSymmetric(_3138,_3140,30)=true) :-
     id_pair(_3138,_3140).

cachingOrder2(_3138, fighting(_3138,_3140)=true) :-
     id_pair(_3138,_3140).

cachingOrder2(_3138, moving(_3138,_3140)=true) :-
     id_pair(_3138,_3140).

cachingOrder2(_3138, greeting1(_3138,_3140)=true) :-
     id_pair(_3138,_3140).

cachingOrder2(_3138, greeting2(_3138,_3140)=true) :-
     id_pair(_3138,_3140).

cachingOrder2(_3138, leaving_object(_3138,_3140)=true) :-
     id_pair(_3138,_3140).

cachingOrder2(_3138, leaving_object(_3138,_3140)=true) :-
     symmetric_id_pair(_3138,_3140).

cachingOrder2(_3138, meeting(_3138,_3140)=true) :-
     id_pair(_3138,_3140).

buildFromPoints2(_3138, walking(_3138)=true) :-
     list_of_ids(_3138).

buildFromPoints2(_3138, active(_3138)=true) :-
     list_of_ids(_3138).

buildFromPoints2(_3138, inactive(_3138)=true) :-
     list_of_ids(_3138).

buildFromPoints2(_3138, running(_3138)=true) :-
     list_of_ids(_3138).

buildFromPoints2(_3138, abrupt(_3138)=true) :-
     list_of_ids(_3138).

