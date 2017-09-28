event(internal_temperature_change(_,_,_)).	inputEntity(internal_temperature_change(_,_,_)).	index(internal_temperature_change(Id,_,_), Id).
event(noise_level_change(_,_,_)).	inputEntity(noise_level_change(_,_,_)).	index(noise_level_change(Id,_,_), Id).
event(passenger_density_change(_,_,_)).	inputEntity(passenger_density_change(_,_,_)).	index(passenger_density_change(Id,_,_), Id).
event(stop_enter(_,_,_,early)).	inputEntity(stop_enter(_,_,_,early)).	index(stop_enter(Id,_,_,early), Id).
event(stop_enter(_,_,_,late)).	inputEntity(stop_enter(_,_,_,late)).	index(stop_enter(Id,_,_,late), Id).
event(stop_enter(_,_,_,scheduled)).	inputEntity(stop_enter(_,_,_,scheduled)).	index(stop_enter(Id,_,_,scheduled), Id).
event(stop_leave(_,_,_,early)).	inputEntity(stop_leave(_,_,_,early)).	index(stop_leave(Id,_,_,early), Id).

sDFluent(abrupt_acceleration(_,_)=abrupt).	inputEntity(abrupt_acceleration(_,_)=abrupt).	index(abrupt_acceleration(Id,_)=abrupt, Id).
sDFluent(abrupt_acceleration(_,_)=very_abrupt).	inputEntity(abrupt_acceleration(_,_)=very_abrupt).	index(abrupt_acceleration(Id,_)=very_abrupt, Id).
sDFluent(abrupt_deceleration(_,_)=abrupt).	inputEntity(abrupt_deceleration(_,_)=abrupt).	index(abrupt_deceleration(Id,_)=abrupt, Id).
sDFluent(abrupt_deceleration(_,_)=very_abrupt).	inputEntity(abrupt_deceleration(_,_)=very_abrupt).	index(abrupt_deceleration(Id,_)=very_abrupt, Id).
sDFluent(sharp_turn(_,_)=sharp).	inputEntity(sharp_turn(_,_)=sharp).	index(sharp_turn(Id,_)=sharp, Id).
sDFluent(sharp_turn(_,_)=very_sharp).	inputEntity(sharp_turn(_,_)=very_sharp).	index(sharp_turn(Id,_)=very_sharp, Id).

event(punctuality_change(_,_,non_punctual)).	outputEntity(punctuality_change(_,_,non_punctual)).	index(punctuality_change(Id,_,non_punctual), Id).
event(punctuality_change(_,_,punctual)).	outputEntity(punctuality_change(_,_,punctual)).	index(punctuality_change(Id,_,punctual), Id).

simpleFluent(internal_temperature(_,_)=normal).	outputEntity(internal_temperature(_,_)=normal).	index(internal_temperature(X,_)=normal, X).
simpleFluent(internal_temperature(_,_)=very_cold).	outputEntity(internal_temperature(_,_)=very_cold).	index(internal_temperature(Id,_)=very_cold, Id).
simpleFluent(internal_temperature(_,_)=very_warm).	outputEntity(internal_temperature(_,_)=very_warm).	index(internal_temperature(Id,_)=very_warm, Id).
simpleFluent(noise_level(_,_)=high).	outputEntity(noise_level(_,_)=high).	index(noise_level(Id,_)=high, Id).
simpleFluent(noise_level(_,_)=low).	outputEntity(noise_level(_,_)=low).	index(noise_level(X,_)=low, X).
simpleFluent(passenger_density(_,_)=high).	outputEntity(passenger_density(_,_)=high).	index(passenger_density(Id,_)=high, Id).
simpleFluent(passenger_density(_,_)=low).	outputEntity(passenger_density(_,_)=low).	index(passenger_density(X,_)=low, X).
simpleFluent(punctuality(_,_)=punctual).	outputEntity(punctuality(_,_)=punctual).	index(punctuality(X,_)=punctual, X).

sDFluent(driver_comfort(_,_)=reducing).	outputEntity(driver_comfort(_,_)=reducing).	index(driver_comfort(Id,_)=reducing, Id).
sDFluent(driving_quality(_,_)=high).	outputEntity(driving_quality(_,_)=high).	index(driving_quality(Id,_)=high, Id).
sDFluent(driving_quality(_,_)=low).	outputEntity(driving_quality(_,_)=low).	index(driving_quality(Id,_)=low, Id).
sDFluent(driving_quality(_,_)=medium).	outputEntity(driving_quality(_,_)=medium).	index(driving_quality(Id,_)=medium, Id).
sDFluent(driving_style(_,_)=uncomfortable).	outputEntity(driving_style(_,_)=uncomfortable).	index(driving_style(Id,_)=uncomfortable, Id).
sDFluent(driving_style(_,_)=unsafe).	outputEntity(driving_style(_,_)=unsafe).	index(driving_style(Id,_)=unsafe, Id).
sDFluent(passenger_comfort(_,_)=reducing).	outputEntity(passenger_comfort(_,_)=reducing).	index(passenger_comfort(Id,_)=reducing, Id).
sDFluent(passenger_satisfaction(_,_)=reducing).	outputEntity(passenger_satisfaction(_,_)=reducing).	index(passenger_satisfaction(Id,_)=reducing, Id).
sDFluent(punctuality(_,_)=non_punctual).	outputEntity(punctuality(_,_)=non_punctual).	index(punctuality(Id,_)=non_punctual, Id).

cachingOrder(driving_style(_,_)=uncomfortable).	%1
cachingOrder(driving_style(_,_)=unsafe).	%1
cachingOrder(internal_temperature(_,_)=normal).	%1
cachingOrder(noise_level(_,_)=low).	%1
cachingOrder(passenger_density(_,_)=low).	%1
cachingOrder(punctuality(_,_)=punctual).	%1
cachingOrder(driver_comfort(_,_)=reducing).	%2
cachingOrder(driving_quality(_,_)=high).	%2
cachingOrder(driving_quality(_,_)=medium).	%2
cachingOrder(passenger_comfort(_,_)=reducing).	%2
cachingOrder(punctuality(_,_)=non_punctual).	%2
cachingOrder(punctuality_change(_,_,non_punctual)).	%2
cachingOrder(driving_quality(_,_)=low).	%3
cachingOrder(passenger_satisfaction(_,_)=reducing).	%3
cachingOrder(punctuality_change(_,_,punctual)).	%3
