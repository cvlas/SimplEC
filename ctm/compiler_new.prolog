:- ['RTEC.prolog'].
:- ['SimplEC.prolog'].

compile(SimplECStatements, EventDescription, Declarations, DependencyGraph, CompiledEventDescription) :-
	simplEC(SimplECStatements, EventDescription, Declarations, DependencyGraph),
	compileEventDescription(Declarations, EventDescription, CompiledEventDescription).
