headFluent2(X)=value iff (condition6(X)=value or condition7(X)=value or not(condition8(X)=value, condition9(X)=value)), condition10(X)=value.
	
headFluent1(X)=value iff condition1(X)=value, condition2(X)=value, (condition3(X)=value or condition4(X)=value), not(condition5(X)=value).

working(X)=value iff location(X)=work, not(takingBreak(X)=value).

resting(X) iff location(X)=pub or onHoliday(X) or (location(X)=work, takingBreak(X)).

happy(X) iff rich(X) or resting(X).

sad(X) iff poor(X), (working(X) or (atHome(X), changingDiapers(X))).

friends(X,Y) iff atThePub(X), atThePub(Y), not(rich(X) or rich(Y)).
