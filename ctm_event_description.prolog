initially(punctuality(_,_)=punctual).

initiatedAt(punctuality(Id,VehicleType)=punctual, T) :-
	happensAt(stop_enter(Id,VehicleType,_,scheduled), T).

initiatedAt(punctuality(Id,VehicleType)=punctual, T) :-
	happensAt(stop_enter(Id,VehicleType,_,early), T).

initiatedAt(punctuality(Id,VehicleType)=non_punctual, T) :-
	happensAt(stop_enter(Id,VehicleType,_,late), T).

initiatedAt(punctuality(Id,VehicleType)=non_punctual, T) :-
	happensAt(stop_leave(Id,VehicleType,_,early), T).

holdsFor(punctuality(Id,VehicleType)=non_punctual, I) :-
	holdsFor(punctuality(Id,VehicleType)=punctual,I23),
	complement_all([I23],I).

