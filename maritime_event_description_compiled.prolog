:- ['RTEC.prolog'].
:-['maritime_declarations.prolog'].

initiatedAt(stopped(_3156)=true, _, _3134, _) :-
     happensAtIE(stop_start(_3156),_3134),
     happensAtIE(coord(_3156,_3172,_3174),_3134),
     nearPorts(_3172,_3174,[]).

initiatedAt(lowSpeed(_3156)=true, _, _3134, _) :-
     happensAtIE(slow_motion_start(_3156),_3134),
     happensAtIE(coord(_3156,_3172,_3174),_3134),
     nearPorts(_3172,_3174,[]).

initiatedAt(withinArea(_3156,_3158)=true, _, _3134, _) :-
     happensAtIE(isInArea(_3156,_3158),_3134).

initiatedAt(sailing(_3156)=true, _, _3134, _) :-
     happensAtIE(velocity(_3156,_3162,_3164),_3134),
     _3162>20.

initiatedAt(highSpeedIn(_3156,_3158)=true, _, _3134, _) :-
     happensAtIE(isInArea(_3156,_3158),_3134),
     happensAtIE(velocity(_3156,_3176,_3178),_3134),
     speedArea(_3158,_3190),
     _3176>_3190.

terminatedAt(stopped(_3156)=true, _, _3134, _) :-
     happensAtIE(stop_end(_3156),_3134).

terminatedAt(lowSpeed(_3156)=true, _, _3134, _) :-
     happensAtIE(slow_motion_end(_3156),_3134).

terminatedAt(lowSpeed(_3156)=true, _, _3134, _) :-
     happensAtProcessedSimpleFluent(_3156,start(stopped(_3156)=true),_3134).

terminatedAt(withinArea(_3156,_3158)=true, _, _3134, _) :-
     happensAtIE(leavesArea(_3156,_3158),_3134).

terminatedAt(sailing(_3156)=true, _, _3134, _) :-
     happensAtIE(velocity(_3156,_3162,_3164),_3134),
     _3162<20.

terminatedAt(sailing(_3156)=true, _, _3134, _) :-
     happensAtIE(gap_start(_3156),_3134).

terminatedAt(highSpeedIn(_3156,_3158)=true, _, _3134, _) :-
     happensAtIE(isInArea(_3156,_3158),_3134),
     happensAtIE(velocity(_3156,_3176,_3178),_3134),
     speedArea(_3158,_3190),
     _3176<_3190.

terminatedAt(highSpeedIn(_3156,_3158)=true, _, _3134, _) :-
     happensAtIE(leavesArea(_3156,_3158),_3134).

terminatedAt(highSpeedIn(_3156,_3158)=true, _, _3134, _) :-
     happensAtIE(gap_start(_3156),_3134).

holdsForSDFluent(loitering(_3162)=true,_3134) :-
     holdsForProcessedSimpleFluent(_3162,lowSpeed(_3162)=true,_3178),
     holdsForProcessedSimpleFluent(_3162,stopped(_3162)=true,_3194),
     union_all([_3178,_3194],_3212),
     holdsForProcessedSimpleFluent(_3162,withinArea(_3162,_3224)=true,_3230),
     findall((_3234,_3236),(member((_3234,_3236),_3230),_3264 is _3236-_3234,_3264>600),_3286),
     intersect_all([_3212,_3230,_3286],_3134).

holdsForSDFluent(rendezVouz(_3162,_3164)=true,_3134) :-
     holdsForProcessedIE(_3162,proximity(_3162,_3164)=true,_3182),
     holdsForProcessedSimpleFluent(_3162,lowSpeed(_3162)=true,_3198),
     holdsForProcessedSimpleFluent(_3162,stopped(_3162)=true,_3214),
     union_all([_3198,_3214],_3232),
     holdsForProcessedSimpleFluent(_3164,lowSpeed(_3164)=true,_3248),
     holdsForProcessedSimpleFluent(_3164,stopped(_3164)=true,_3264),
     union_all([_3248,_3264],_3282),
     findall((_3286,_3288),(member((_3286,_3288),_3282),_3316 is _3288-_3286,_3316>600),_3338),
     intersect_all([_3182,_3232,_3282,_3338],_3134).

happensAtEv(fastApproach(_3150),_3134) :-
     happensAtIE(speedChange(_3150),_3134),
     holdsAtProcessedIE(_3150,velocity(_3150)=true,_3134),
     true>20,
     holdsAt(coord(_3150)=(_3196,_3198),_3134),
     \+nearPorts(_3196,_3198),
     holdsAtProcessedIE(_3150,headingToVessels(_3150)=true,_3134).

cachingOrder2(_3138, highSpeedIn(_3138,_3140)=true) :-
     vessel(_3138).

cachingOrder2(_3138, sailing(_3138)=true) :-
     vessel(_3138).

cachingOrder2(_3138, stopped(_3138)=true) :-
     vessel(_3138).

cachingOrder2(_3138, withinArea(_3138,_3140)=true) :-
     vessel(_3138).

cachingOrder2(_3138, lowSpeed(_3138)=true) :-
     vessel(_3138).

cachingOrder2(_3138, loitering(_3138)=true) :-
     vessel(_3138).

cachingOrder2(_3138, rendezVouz(_3138,_3140)=true) :-
     vessel(_3138),vessel(_3140),_3138=\=_3140.

