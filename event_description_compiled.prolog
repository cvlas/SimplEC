:- ['RTEC.prolog'].
:- ['declarations.prolog'].

initially(punctuality(_4750,_4752)=punctual).

initially(passenger_density(_4750,_4752)=low).

initially(noise_level(_4750,_4752)=low).

initially(internal_temperature(_4750,_4752)=normal).

initiatedAt(punctuality(_3214,_3216)=punctual, _, _3192, _) :-
     happensAtIE(stop_enter(_3214,_3216,_3224,scheduled),_3192).

initiatedAt(punctuality(_3214,_3216)=punctual, _, _3192, _) :-
     happensAtIE(stop_enter(_3214,_3216,_3224,early),_3192).

initiatedAt(passenger_density(_3214,_3216)=_3210, _, _3192, _) :-
     happensAtIE(passenger_density_change(_3214,_3216,_3210),_3192).

initiatedAt(noise_level(_3214,_3216)=_3210, _, _3192, _) :-
     happensAtIE(noise_level_change(_3214,_3216,_3210),_3192).

initiatedAt(internal_temperature(_3214,_3216)=_3210, _, _3192, _) :-
     happensAtIE(internal_temperature_change(_3214,_3216,_3210),_3192).

terminatedAt(punctuality(_3214,_3216)=punctual, _, _3192, _) :-
     happensAtIE(stop_enter(_3214,_3216,_3224,late),_3192).

terminatedAt(punctuality(_3214,_3216)=punctual, _, _3192, _) :-
     happensAtIE(stop_leave(_3214,_3216,_3224,early),_3192).

holdsForSDFluent(punctuality(_3220,_3222)=non_punctual,_3192) :-
     holdsForProcessedSimpleFluent(_3220,punctuality(_3220,_3222)=punctual,_3240),
     complement_all([_3240],_3192).

holdsForSDFluent(driving_style(_3220,_3222)=unsafe,_3192) :-
     holdsForProcessedIE(_3220,sharp_turn(_3220,_3222)=very_sharp,_3240),
     holdsForProcessedIE(_3220,abrupt_acceleration(_3220,_3222)=very_abrupt,_3258),
     holdsForProcessedIE(_3220,abrupt_deceleration(_3220,_3222)=very_abrupt,_3276),
     union_all([_3240,_3258,_3276],_3192).

holdsForSDFluent(driving_style(_3220,_3222)=uncomfortable,_3192) :-
     holdsForProcessedIE(_3220,sharp_turn(_3220,_3222)=sharp,_3240),
     holdsForProcessedIE(_3220,abrupt_acceleration(_3220,_3222)=very_abrupt,_3258),
     holdsForProcessedIE(_3220,abrupt_deceleration(_3220,_3222)=very_abrupt,_3276),
     union_all([_3258,_3276],_3294),
     relative_complement_all(_3240,[_3294],_3308),
     holdsForProcessedIE(_3220,abrupt_acceleration(_3220,_3222)=abrupt,_3326),
     holdsForProcessedIE(_3220,abrupt_deceleration(_3220,_3222)=abrupt,_3344),
     union_all([_3308,_3326,_3344],_3192).

