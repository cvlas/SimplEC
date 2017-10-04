:- ['src/RTEC.prolog'].
:- ['simplEC.prolog'].

compile(SimplECStatements, EventDescription, Declarations, DependencyGraph, CompiledEventDescription) :-
	simplEC(SimplECStatements, EventDescription, Declarations, DependencyGraph),
	open(CompiledEventDescription, write, CEDStream),
	atomics_to_string([":-, ['src/RTEC.prolog'].\n"], Result1),
	atomics_to_string([":-, ['", Declarations, "'].\n\n"], Result2),
	write(CEDStream, Result1),
	write(CEDStream, Result2),
	compileEventDescription(Declarations, EventDescription, CompiledEventDescription).
