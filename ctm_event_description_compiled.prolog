initially(punctuality(_4656,_4658)=punctual).

initially(passenger_density(_4656,_4658)=low).

initially(noise_level(_4656,_4658)=low).

initially(internal_temperature(_4656,_4658)=normal).

initiatedAt(punctuality(_3156,_3158)=punctual, _, _3134, _) :-
     happensAtIE(stop_enter(_3156,_3158,_3166,scheduled),_3134).

initiatedAt(punctuality(_3156,_3158)=punctual, _, _3134, _) :-
     happensAtIE(stop_enter(_3156,_3158,_3166,early),_3134).

initiatedAt(passenger_density(_3156,_3158)=_3152, _, _3134, _) :-
     happensAtIE(passenger_density_change(_3156,_3158,_3152),_3134).

initiatedAt(noise_level(_3156,_3158)=_3152, _, _3134, _) :-
     happensAtIE(noise_level_change(_3156,_3158,_3152),_3134).

initiatedAt(internal_temperature(_3156,_3158)=_3152, _, _3134, _) :-
     happensAtIE(internal_temperature_change(_3156,_3158,_3152),_3134).

terminatedAt(punctuality(_3156,_3158)=punctual, _, _3134, _) :-
     happensAtIE(stop_enter(_3156,_3158,_3166,late),_3134).

terminatedAt(punctuality(_3156,_3158)=punctual, _, _3134, _) :-
     happensAtIE(stop_leave(_3156,_3158,_3166,early),_3134).

holdsForSDFluent(punctuality(_3162,_3164)=non_punctual,_3134) :-
     holdsForProcessedSimpleFluent(_3162,punctuality(_3162,_3164)=punctual,_3182),
     complement_all([_3182],_3134).

holdsForSDFluent(driving_style(_3162,_3164)=unsafe,_3134) :-
     holdsForProcessedIE(_3162,sharp_turn(_3162,_3164)=very_sharp,_3182),
     holdsForProcessedIE(_3162,abrupt_acceleration(_3162,_3164)=very_abrupt,_3200),
     holdsForProcessedIE(_3162,abrupt_deceleration(_3162,_3164)=very_abrupt,_3218),
     union_all([_3182,_3200,_3218],_3134).

holdsForSDFluent(driving_style(_3162,_3164)=uncomfortable,_3134) :-
     holdsForProcessedIE(_3162,sharp_turn(_3162,_3164)=sharp,_3182),
     holdsForProcessedIE(_3162,abrupt_acceleration(_3162,_3164)=very_abrupt,_3200),
     holdsForProcessedIE(_3162,abrupt_deceleration(_3162,_3164)=very_abrupt,_3218),
     union_all([_3200,_3218],_3236),
     relative_complement_all(_3182,[_3236],_3250),
     holdsForProcessedIE(_3162,abrupt_acceleration(_3162,_3164)=abrupt,_3268),
     holdsForProcessedIE(_3162,abrupt_deceleration(_3162,_3164)=abrupt,_3286),
     union_all([_3250,_3268,_3286],_3134).

holdsForSDFluent(driving_quality(_3162,_3164)=high,_3134) :-
     holdsForProcessedSimpleFluent(_3162,punctuality(_3162,_3164)=punctual,_3182),
     holdsForProcessedSDFluent(_3162,driving_style(_3162,_3164)=unsafe,_3200),
     holdsForProcessedSDFluent(_3162,driving_style(_3162,_3164)=uncomfortable,_3218),
     union_all([_3200,_3218],_3236),
     relative_complement_all(_3182,[_3236],_3134).

holdsForSDFluent(driving_quality(_3162,_3164)=medium,_3134) :-
     holdsForProcessedSimpleFluent(_3162,punctuality(_3162,_3164)=punctual,_3182),
     holdsForProcessedSDFluent(_3162,driving_style(_3162,_3164)=uncomfortable,_3200),
     intersect_all([_3182,_3200],_3134).

holdsForSDFluent(driving_quality(_3162,_3164)=low,_3134) :-
     holdsForProcessedSDFluent(_3162,punctuality(_3162,_3164)=non_punctual,_3182),
     holdsForProcessedSDFluent(_3162,driving_style(_3162,_3164)=unsafe,_3200),
     union_all([_3182,_3200],_3134).

holdsForSDFluent(passenger_comfort(_3162,_3164)=reducing,_3134) :-
     holdsForProcessedSDFluent(_3162,driving_style(_3162,_3164)=uncomfortable,_3182),
     holdsForProcessedSDFluent(_3162,driving_style(_3162,_3164)=unsafe,_3200),
     holdsForProcessedSimpleFluent(_3162,passenger_density(_3162,_3164)=high,_3218),
     holdsForProcessedSimpleFluent(_3162,noise_level(_3162,_3164)=high,_3236),
     holdsForProcessedSimpleFluent(_3162,internal_temperature(_3162,_3164)=very_warm,_3254),
     holdsForProcessedSimpleFluent(_3162,internal_temperature(_3162,_3164)=very_cold,_3272),
     union_all([_3182,_3200,_3218,_3236,_3254,_3272],_3134).

holdsForSDFluent(driver_comfort(_3162,_3164)=reducing,_3134) :-
     holdsForProcessedSDFluent(_3162,driving_style(_3162,_3164)=uncomfortable,_3182),
     holdsForProcessedSDFluent(_3162,driving_style(_3162,_3164)=unsafe,_3200),
     holdsForProcessedSimpleFluent(_3162,noise_level(_3162,_3164)=high,_3218),
     holdsForProcessedSimpleFluent(_3162,internal_temperature(_3162,_3164)=very_warm,_3236),
     holdsForProcessedSimpleFluent(_3162,internal_temperature(_3162,_3164)=very_cold,_3254),
     union_all([_3182,_3200,_3218,_3236,_3254],_3134).

holdsForSDFluent(passenger_satisfaction(_3162,_3164)=reducing,_3134) :-
     holdsForProcessedSDFluent(_3162,punctuality(_3162,_3164)=non_punctual,_3182),
     holdsForProcessedSDFluent(_3162,passenger_comfort(_3162,_3164)=reducing,_3200),
     union_all([_3182,_3200],_3134).

happensAtEv(punctuality_change(_3150,_3152,punctual),_3134) :-
     happensAtProcessedSDFluent(_3150,end(punctuality(_3150,_3152)=non_punctual),_3134).

happensAtEv(punctuality_change(_3150,_3152,non_punctual),_3134) :-
     happensAtProcessedSimpleFluent(_3150,end(punctuality(_3150,_3152)=punctual),_3134).

cachingOrder2(_3138, driving_style(_3138,_3140)=uncomfortable) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, driving_style(_3138,_3140)=unsafe) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, internal_temperature(_3138,_3140)=very_cold) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, internal_temperature(_3138,_3140)=very_warm) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, noise_level(_3138,_3140)=high) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, passenger_density(_3138,_3140)=high) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, punctuality(_3138,_3140)=punctual) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, driver_comfort(_3138,_3140)=reducing) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, driving_quality(_3138,_3140)=high) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, driving_quality(_3138,_3140)=medium) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, passenger_comfort(_3138,_3140)=reducing) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, punctuality(_3138,_3140)=non_punctual) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, driving_quality(_3138,_3140)=low) :-
     vehicle(_3138,_3140).

cachingOrder2(_3138, passenger_satisfaction(_3138,_3140)=reducing) :-
     vehicle(_3138,_3140).

cachingOrder2(_3132, punctuality_change(_3132,_3134,punctual)) :-
     vehicle(_3132,_3134).

collectIntervals2(_3138, abrupt_acceleration(_3138,_3140)=abrupt) :-
     vehicle(_3138,_3140).

collectIntervals2(_3138, abrupt_acceleration(_3138,_3140)=very_abrupt) :-
     vehicle(_3138,_3140).

collectIntervals2(_3138, abrupt_deceleration(_3138,_3140)=abrupt) :-
     vehicle(_3138,_3140).

collectIntervals2(_3138, abrupt_deceleration(_3138,_3140)=very_abrupt) :-
     vehicle(_3138,_3140).

collectIntervals2(_3138, sharp_turn(_3138,_3140)=sharp) :-
     vehicle(_3138,_3140).

collectIntervals2(_3138, sharp_turn(_3138,_3140)=very_sharp) :-
     vehicle(_3138,_3140).

