headFluent2(X)=value iff (condition6(X)=value or condition7(X)=value or not(condition8(X)=value, condition9(X)=value)), condition10(X)=value.
	
headFluent1(X)=value iff condition1(X)=value, condition2(X)=value, (condition3(X)=value or condition4(X)=value), not(condition5(X)=value).

working(X)=value iff location(X)=work, not(takingBreak(X)=value).

resting(X)=true iff location(X)=pub or onHoliday(X)=true or (location(X)=work=true, takingBreak(X)=true).

happy(X)=true iff rich(X)=true or resting(X)=true.

sad(X)=true iff poor(X)=true, (working(X)=true or (atHome(X)=true, changingDiapers(X)=true)).

friends(X,Y)=true iff atThePub(X)=true, atThePub(Y)=true, not(rich(X)=true or rich(Y)=true).
