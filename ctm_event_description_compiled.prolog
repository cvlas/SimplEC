initially(punctuality(_60516,_60518)=punctual).

initially(passenger_density(_60516,_60518)=low).

initially(noise_level(_60516,_60518)=low).

initially(internal_temperature(_60516,_60518)=normal).

initiatedAt(punctuality(_59016,_59018)=punctual, _, _58994, _) :-
     happensAtIE(stop_enter(_59016,_59018,_59026,scheduled),_58994).

initiatedAt(punctuality(_59016,_59018)=punctual, _, _58994, _) :-
     happensAtIE(stop_enter(_59016,_59018,_59026,early),_58994).

initiatedAt(passenger_density(_59016,_59018)=_59012, _, _58994, _) :-
     happensAtIE(passenger_density_change(_59016,_59018,_59012),_58994).

initiatedAt(noise_level(_59016,_59018)=_59012, _, _58994, _) :-
     happensAtIE(noise_level_change(_59016,_59018,_59012),_58994).

initiatedAt(internal_temperature(_59016,_59018)=_59012, _, _58994, _) :-
     happensAtIE(internal_temperature_change(_59016,_59018,_59012),_58994).

terminatedAt(punctuality(_59016,_59018)=punctual, _, _58994, _) :-
     happensAtIE(stop_enter(_59016,_59018,_59026,late),_58994).

terminatedAt(punctuality(_59016,_59018)=punctual, _, _58994, _) :-
     happensAtIE(stop_leave(_59016,_59018,_59026,early),_58994).

holdsForSDFluent(punctuality(_59022,_59024)=non_punctual,_58994) :-
     holdsForProcessedSimpleFluent(_59022,punctuality(_59022,_59024)=punctual,_59042),
     complement_all([_59042],_58994).

holdsForSDFluent(driving_style(_59022,_59024)=unsafe,_58994) :-
     holdsForProcessedIE(_59022,sharp_turn(_59022,_59024)=very_sharp,_59042),
     holdsForProcessedIE(_59022,abrupt_acceleration(_59022,_59024)=very_abrupt,_59060),
     holdsForProcessedIE(_59022,abrupt_deceleration(_59022,_59024)=very_abrupt,_59078),
     union_all([_59042,_59060,_59078],_58994).

holdsForSDFluent(driving_style(_59022,_59024)=uncomfortable,_58994) :-
     holdsForProcessedIE(_59022,sharp_turn(_59022,_59024)=sharp,_59042),
     holdsForProcessedIE(_59022,abrupt_acceleration(_59022,_59024)=very_abrupt,_59060),
     holdsForProcessedIE(_59022,abrupt_deceleration(_59022,_59024)=very_abrupt,_59078),
     union_all([_59060,_59078],_59096),
     relative_complement_all(_59042,[_59096],_59110),
     holdsForProcessedIE(_59022,abrupt_acceleration(_59022,_59024)=abrupt,_59128),
     holdsForProcessedIE(_59022,abrupt_deceleration(_59022,_59024)=abrupt,_59146),
     union_all([_59110,_59128,_59146],_58994).

