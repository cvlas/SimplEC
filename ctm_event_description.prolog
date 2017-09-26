initially(punctuality(_,_)=punctual).

initiatedAt(punctuality(Id,VehicleType)=punctual, T) :-
	happensAt(stop_enter(Id,VehicleType,_,scheduled), T).

initiatedAt(punctuality(Id,VehicleType)=punctual, T) :-
	happensAt(stop_enter(Id,VehicleType,_,early), T).

terminatedAt(punctuality(Id,VehicleType)=punctual, T) :-
	happensAt(stop_enter(Id,VehicleType,_,late), T).

terminatedAt(punctuality(Id,VehicleType)=punctual, T) :-
	happensAt(stop_leave(Id,VehicleType,_,early), T).

holdsFor(punctuality(Id,VehicleType)=non_punctual, I) :-
	holdsFor(punctuality(Id,VehicleType)=punctual,I1),
	complement_all([I1],I).

happensAt(punctuality_change(Id,VehicleType,punctual), T) :-
	happensAt(end(punctuality(Id,VehicleType)=non_punctual), T).

happensAt(punctuality_change(Id,VehicleType,non_punctual), T) :-
	happensAt(end(punctuality(Id,VehicleType)=punctual), T).

holdsFor(driving_style(Id,VehicleType)=unsafe, I) :-
	holdsFor(sharp_turn(Id,VehicleType)=very_sharp,I2),
	holdsFor(abrupt_acceleration(Id,VehicleType)=very_abrupt,I3),
	holdsFor(abrupt_deceleration(Id,VehicleType)=very_abrupt,I4),
	union_all([I2,I3,I4],I).

holdsFor(driving_style(Id,VehicleType)=uncomfortable, I) :-
	holdsFor(sharp_turn(Id,VehicleType)=sharp,I2),
	holdsFor(abrupt_acceleration(Id,VehicleType)=very_abrupt,I4),
	holdsFor(abrupt_deceleration(Id,VehicleType)=very_abrupt,I5),
	union_all([I4,I5],I6),
	relative_complement_all(I2,[I6],I8),
	holdsFor(abrupt_acceleration(Id,VehicleType)=abrupt,I9),
	holdsFor(abrupt_deceleration(Id,VehicleType)=abrupt,I10),
	union_all([I8,I9,I10],I).

holdsFor(driving_quality(Id,VehicleType)=high, I) :-
	holdsFor(punctuality(Id,VehicleType)=punctual,I1),
	holdsFor(driving_style(Id,VehicleType)=unsafe,I3),
	holdsFor(driving_style(Id,VehicleType)=uncomfortable,I4),
	union_all([I3,I4],I5),
	relative_complement_all(I1,[I5],I).

holdsFor(driving_quality(Id,VehicleType)=medium, I) :-
	holdsFor(punctuality(Id,VehicleType)=punctual,I1),
	holdsFor(driving_style(Id,VehicleType)=uncomfortable,I2),
	intersect_all([I1,I2],I).

holdsFor(driving_quality(Id,VehicleType)=low, I) :-
	holdsFor(punctuality(Id,VehicleType)=non_punctual,I2),
	holdsFor(driving_style(Id,VehicleType)=unsafe,I3),
	union_all([I2,I3],I).

holdsFor(passenger_comfort(Id,VehicleType)=reducing, I) :-
	holdsFor(driving_style(Id,VehicleType)=uncomfortable,I2),
	holdsFor(driving_style(Id,VehicleType)=unsafe,I3),
	holdsFor(passenger_density(Id,VehicleType)=high,I4),
	holdsFor(noise_level(Id,VehicleType)=high,I5),
	holdsFor(internal_temperature(Id,VehicleType)=very_warm,I6),
	holdsFor(internal_temperature(Id,VehicleType)=very_cold,I7),
	union_all([I2,I3,I4,I5,I6,I7],I).

initially(passenger_density(_,_)=low).

initiatedAt(passenger_density(Id,VehicleType)=Value, T) :-
	happensAt(passenger_density_change(Id,VehicleType,Value), T).

initially(noise_level(_,_)=low).

initiatedAt(noise_level(Id,VehicleType)=Value, T) :-
	happensAt(noise_level_change(Id,VehicleType,Value), T).

initially(internal_temperature(_,_)=normal).

initiatedAt(internal_temperature(Id,VehicleType)=Value, T) :-
	happensAt(internal_temperature_change(Id,VehicleType,Value), T).

holdsFor(driver_comfort(Id,VehicleType)=reducing, I) :-
	holdsFor(driving_style(Id,VehicleType)=uncomfortable,I2),
	holdsFor(driving_style(Id,VehicleType)=unsafe,I3),
	holdsFor(noise_level(Id,VehicleType)=high,I4),
	holdsFor(internal_temperature(Id,VehicleType)=very_warm,I5),
	holdsFor(internal_temperature(Id,VehicleType)=very_cold,I6),
	union_all([I2,I3,I4,I5,I6],I).

holdsFor(passenger_satisfaction(Id,VehicleType)=reducing, I) :-
	holdsFor(punctuality(Id,VehicleType)=non_punctual,I2),
	holdsFor(passenger_comfort(Id,VehicleType)=reducing,I3),
	union_all([I2,I3],I).

