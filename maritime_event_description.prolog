holdsFor(loitering(Vessel)=true, I) :-
	holdsFor(lowSpeed(Vessel)=true,I1),
	holdsFor(stopped(Vessel)=true,I2),
	union_all([I1,I2],I3),
	holdsFor(withinArea(Vessel,AreaName)=true,I4),
	findall((S,E),(member((S,E),I4),Diff is E-S,Diff>600),I5),
	intersect_all([I3,I4,I5],I).

holdsFor(rendezVouz(Vessel1,Vessel2)=true, I) :-
	holdsFor(proximity(Vessel1,Vessel2)=true,I1),
	holdsFor(lowSpeed(Vessel1)=true,I2),
	holdsFor(stopped(Vessel1)=true,I3),
	union_all([I2,I3],I4),
	holdsFor(lowSpeed(Vessel2)=true,I5),
	holdsFor(stopped(Vessel2)=true,I6),
	union_all([I5,I6],I7),
	findall((S,E),(member((S,E),I7),Diff is E-S,Diff>600),I8),
	intersect_all([I1,I4,I7,I8],I).

