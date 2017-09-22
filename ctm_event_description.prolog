initially(punctuality(_,_)=punctual).

initiatedAt(punctuality(Id,VehicleType)=punctual, T) :-
	happensAt(stop_enter(Id,VehicleType,_,scheduled), T).

initiatedAt(punctuality(Id,VehicleType)=punctual, T) :-
	happensAt(stop_enter(Id,VehicleType,_,early), T).

terminatedAt(punctuality(Id,VehicleType)=punctual, T) :-
	happensAt(stop_enter(Id,VehicleType,_,late), T).

terminatedAt(punctuality(Id,VehicleType)=punctual, T) :-
	happensAt(stop_leave(Id,VehicleType,_,early), T).

happensAt(punctuality_change(Id,VehicleType,punctual), T) :-
	happensAt(end(punctuality(Id,VehicleType)=non_punctual), T).

happensAt(punctuality_change(Id,VehicleType,non_punctual), T) :-
	happensAt(end(punctuality(Id,VehicleType)=punctual), T).

holdsFor(driving_quality(Id,VehicleType)=high, I) :-
	holdsFor(punctuality(Id,VehicleType)=punctual,I1),
	holdsFor(driving_style(Id,VehicleType)=unsafe,I3),
	holdsFor(driving_style(Id,VehicleType)=uncomfortable,I4),
	union_all([I3,I4],I5),
	intersect_all([I1],I7),
	relative_complement_all(I7,[I5],I).

holdsFor(driving_quality(Id,VehicleType)=medium, I) :-
	holdsFor(punctuality(Id,VehicleType)=punctual,I1),
	holdsFor(driving_style(Id,VehicleType)=uncomfortable,I2),
	intersect_all([I1,I2],I).

initially(passenger_density(_,_)=low).

initiatedAt(passenger_density(Id,VehicleType)=Value, T) :-
	happensAt(passenger_density_change(Id,VehicleType,Value), T).

initially(noise_level(_,_)=low).

initiatedAt(noise_level(Id,VehicleType)=Value, T) :-
	happensAt(noise_level_change(Id,VehicleType,Value), T).

initially(internal_temperature(_,_)=normal).

initiatedAt(internal_temperature(Id,VehicleType)=Value, T) :-
	happensAt(internal_temperature_change(Id,VehicleType,Value), T).

