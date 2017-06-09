initiatedAt(stopped(_38)=true, _86, _10, _92) :-
     happensAtIE(stop_start(_38),_10),_86=<_10,_10<_92,
     happensAtIE(coord(_38,_54,_56),_10),_86=<_10,_10<_92,
     nearPorts(_54,_56,[]).

initiatedAt(lowSpeed(_38)=true, _86, _10, _92) :-
     happensAtIE(slow_motion_start(_38),_10),_86=<_10,_10<_92,
     happensAtIE(coord(_38,_54,_56),_10),_86=<_10,_10<_92,
     nearPorts(_54,_56,[]).

initiatedAt(withinArea(_38,_40)=true, _56, _10, _62) :-
     happensAtIE(isInArea(_38,_40),_10),
     _56=<_10,
     _10<_62.

initiatedAt(sailing(_38)=true, _74, _10, _80) :-
     happensAtIE(velocity(_38,_44,_46),_10),_74=<_10,_10<_80,
     _44>2.0.

initiatedAt(highSpeedIn(_38,_40)=true, _100, _10, _106) :-
     happensAtIE(isInArea(_38,_40),_10),_100=<_10,_10<_106,
     happensAtIE(velocity(_38,_58,_60),_10),_100=<_10,_10<_106,
     speedArea(_40,_72),
     _58>_72.

terminatedAt(stopped(_38)=true, _52, _10, _58) :-
     happensAtIE(stop_end(_38),_10),
     _52=<_10,
     _10<_58.

terminatedAt(lowSpeed(_38)=true, _52, _10, _58) :-
     happensAtIE(slow_motion_end(_38),_10),
     _52=<_10,
     _10<_58.

terminatedAt(lowSpeed(_38)=true, _62, _10, _68) :-
     happensAtProcessedSimpleFluent(_38,start(stopped(_38)=true),_10),
     _62=<_10,
     _10<_68.

terminatedAt(withinArea(_38,_40)=true, _56, _10, _62) :-
     happensAtIE(leavesArea(_38,_40),_10),
     _56=<_10,
     _10<_62.

terminatedAt(sailing(_38)=true, _74, _10, _80) :-
     happensAtIE(velocity(_38,_44,_46),_10),_74=<_10,_10<_80,
     _44<2.0.

terminatedAt(sailing(_38)=true, _52, _10, _58) :-
     happensAtIE(gap_start(_38),_10),
     _52=<_10,
     _10<_58.

terminatedAt(highSpeedIn(_38,_40)=true, _100, _10, _106) :-
     happensAtIE(isInArea(_38,_40),_10),_100=<_10,_10<_106,
     happensAtIE(velocity(_38,_58,_60),_10),_100=<_10,_10<_106,
     speedArea(_40,_72),
     _58<_72.

terminatedAt(highSpeedIn(_38,_40)=true, _56, _10, _62) :-
     happensAtIE(leavesArea(_38,_40),_10),
     _56=<_10,
     _10<_62.

terminatedAt(highSpeedIn(_38,_40)=true, _54, _10, _60) :-
     happensAtIE(gap_start(_38),_10),
     _54=<_10,
     _10<_60.

holdsForSDFluent(loitering(_38)=true,_10) :-
     holdsForProcessedSimpleFluent(_38,lowSpeed(_38)=true,_54),
     holdsForProcessedSimpleFluent(_38,stopped(_38)=true,_70),
     holdsFor(withinArea(_38,_82)=true,_88),
     intersect_all([_54,_88],_106),
     intersect_all([_70,_88],_124),
     union_all([_106,_124],_142),
     findall((_146,_148),(member((_146,_148),_142),_176 is _148-_146,_176>600),_10).

holdsForSDFluent(rendezVouz(_38,_40)=true,_10) :-
     holdsForProcessedIE(_38,proximity(_38,_40)=true,_58),
     holdsForProcessedSimpleFluent(_38,lowSpeed(_38)=true,_74),
     holdsForProcessedSimpleFluent(_40,lowSpeed(_40)=true,_90),
     holdsForProcessedSimpleFluent(_38,stopped(_38)=true,_106),
     holdsForProcessedSimpleFluent(_40,stopped(_40)=true,_122),
     union_all([_74,_106],_140),
     union_all([_90,_122],_158),
     intersect_all([_140,_158,_58],_182),
     findall((_186,_188),(member((_186,_188),_182),_216 is _188-_186,_216>600),_10).

cachingOrder2(_14, stopped(_14)=true) :-
     vessel(_14).

cachingOrder2(_14, lowSpeed(_14)=true) :-
     vessel(_14).

cachingOrder2(_14, sailing(_14)=true) :-
     vessel(_14).

cachingOrder2(_14, loitering(_14)=true) :-
     vessel(_14).

cachingOrder2(_14, rendezVouz(_14,_16)=true) :-
     vessel(_14),vessel(_16),_14=\=_16.

