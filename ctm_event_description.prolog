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
	holdsFor(punctuality(Id,VehicleType)=punctual,I23),
	complement_all([I23],I).

happensAt(punctuality_change(Id,VehicleType,punctual), T) :-
	happensAt(end(punctuality(Id,VehicleType)=non_punctual), T).

happensAt(punctuality_change(Id,VehicleType,non_punctual), T) :-
	happensAt(end(punctuality(Id,VehicleType)=punctual), T).

holdsFor(driving_style(Id,VehicleType)=unsafe, I) :-
	holdsFor(sharp_turn(Id,VehicleType)=very_sharp,I14),
	holdsFor(abrupt_acceleration(Id,VehicleType)=very_abrupt,I16),
	holdsFor(abrupt_deceleration(Id,VehicleType)=very_abrupt,I19),
	union_all([I16,I19,I14],I).

holdsFor(driving_style(Id,VehicleType)=uncomfortable, I) :-
	holdsFor(sharp_turn(Id,VehicleType)=sharp,I290),
	holdsFor(abrupt_acceleration(Id,VehicleType)=very_abrupt,I350),
	holdsFor(abrupt_deceleration(Id,VehicleType)=very_abrupt,I353),
	union_all([I350,I353],I354),
	relative_complement_all(I290,[I354],I356),
	holdsFor(abrupt_acceleration(Id,VehicleType)=abrupt,I358),
	holdsFor(abrupt_deceleration(Id,VehicleType)=abrupt,I361),
	union_all([I358,I361,I356],I).

holdsFor(driving_quality(Id,VehicleType)=high, I) :-
	holdsFor(punctuality(Id,VehicleType)=punctual,I71),
	holdsFor(driving_style(Id,VehicleType)=unsafe,I131),
	holdsFor(driving_style(Id,VehicleType)=uncomfortable,I134),
	union_all([I131,I134],I135),
	relative_complement_all(I71,[I135],I).

holdsFor(driving_quality(Id,VehicleType)=medium, I) :-
	holdsFor(punctuality(Id,VehicleType)=punctual,I8),
	holdsFor(driving_style(Id,VehicleType)=uncomfortable,I11),
	intersect_all([I8,I11],I).

holdsFor(driving_quality(Id,VehicleType)=low, I) :-
	holdsFor(punctuality(Id,VehicleType)=non_punctual,I9),
	holdsFor(driving_style(Id,VehicleType)=unsafe,I12),
	union_all([I9,I12],I).

holdsFor(passenger_comfort(Id,VehicleType)=reducing, I) :-
	holdsFor(driving_style(Id,VehicleType)=uncomfortable,I35),
	holdsFor(driving_style(Id,VehicleType)=unsafe,I37),
	holdsFor(passenger_density(Id,VehicleType)=high,I39),
	holdsFor(noise_level(Id,VehicleType)=high,I41),
	holdsFor(internal_temperature(Id,VehicleType)=very_warm,I43),
	holdsFor(internal_temperature(Id,VehicleType)=very_cold,I46),
	union_all([I43,I46,I41,I39,I37,I35],I).

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
	holdsFor(driving_style(Id,VehicleType)=uncomfortable,I27),
	holdsFor(driving_style(Id,VehicleType)=unsafe,I29),
	holdsFor(noise_level(Id,VehicleType)=high,I31),
	holdsFor(internal_temperature(Id,VehicleType)=very_warm,I33),
	holdsFor(internal_temperature(Id,VehicleType)=very_cold,I36),
	union_all([I33,I36,I31,I29,I27],I).

holdsFor(passenger_satisfaction(Id,VehicleType)=reducing, I) :-
	holdsFor(punctuality(Id,VehicleType)=non_punctual,I9),
	holdsFor(passenger_comfort(Id,VehicleType)=reducing,I12),
	union_all([I9,I12],I).

