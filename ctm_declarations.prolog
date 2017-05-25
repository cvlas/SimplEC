event(stop_enter(_,_,_,_)).	inputEntity(stop_enter(_,_,_,_)).	index(stop_enter(Id,_,_,_), Id).
event(stop_leave(_,_,_,_)).	inputEntity(stop_leave(_,_,_,_)).	index(stop_leave(Id,_,_,_), Id).



simpleFluent(punctuality(_,_)=non_punctual).	outputEntity(punctuality(_,_)=non_punctual).	index(punctuality(Id,_)=non_punctual, Id).
simpleFluent(punctuality(_,_)=punctual).	outputEntity(punctuality(_,_)=punctual).	index(punctuality(X,_)=punctual, X).


cachingOrder(punctuality(_,_)=punctual).	%1
cachingOrder(punctuality(_,_)=non_punctual).	%2
