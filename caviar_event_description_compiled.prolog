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

