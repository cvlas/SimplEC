:- [library(dcg/basics)].

:- dynamic cachingPriority/2, declared/4, defines/3, head/1, noCaching/1.

% -----------------------------------------------
% AUXILIARY TOOLS
% -----------------------------------------------

% Split a list into its head and the rest

list_head([H|T], H, T).

% Add an element to the head or the tail of a list

addToHead(L, H, [H|L]).

addToTail([], E, [E]).
addToTail([H|T], E, [H|L]) :- addToTail(T, E, L).

% Update the caching priority of an element and propagate this update to all output entities that depend on it

propagatePriority(E, P) :-
	% The priority of E is P 
	assertz(finalCachingPriority(E, P)), 
	% Propagate this to all dependants...
	(\+ defines(E, _, _) -> true % There are no dependants. Exiting...
	;
	defines(E, E, _) -> true % Self-dependency. Exiting...
	;
	% Sort dependants
	findall(H, defines(E, H, _), Heads), Heads \= [], sort(Heads, HeadsSorted),
	findall((E, B, C), (defines(E, B, C), retract(defines(E, B, C))), _),
	% Assert new dependency for rule H
	forall(member(H, HeadsSorted), (assertz(defines(E, H, P)), 
	calculatePriority(H, Q),
	assertz(finalCachingPriority(H, Q)), 
	% Repeat procedure...
	propagatePriority(H, Q)))).

calculatePriority(H, Q) :-
	findall(P, defines(_, H, P), PS),
	sum_list(PS, TmpQ),
	Q is TmpQ + 1.

% -----------------------------------------------
% SIMPL-EC
% -----------------------------------------------
	
simplEC(InputFile, OutputFile, DeclarationsFile) :-
	split_string(InputFile, ".", "", InputFileTokens),
	list_head(InputFileTokens, InputName, _),
	atomics_to_string([InputName, ".log"], LogFile),
	open(InputFile, read, Input),
	open(DeclarationsFile, write, DeclStream),
	open(LogFile, write, LogStream),
	tell(OutputFile),
	
	% Auxiliary global variables
	nb_setval(intervalNo, 1),
	
	% Parse and translate the rules
	read_stream_to_codes(Input, Codes),
	phrase(goal, Codes),
	
	findall(looloody(DeclRepr, IndRepr, Type, EType), (declared(DeclRepr, IndRepr, Type, EType), retract(declared(DeclRepr, IndRepr, Type, EType))), Tuples),
	sort(4, @>=, Tuples, TuplesDistorted),
	sort(1, @<, TuplesDistorted, TuplesSorted),
	forall(member(looloody(DeclRepr, IndRepr, Type, EType), TuplesSorted), assertz(declared(DeclRepr, IndRepr, Type, EType))),
	
	findall((DeclRepr, IndRepr, "event", "input"),
		(declared(DeclRepr, IndRepr, "event", "input"),
		atomics_to_string(["event(", DeclRepr, ").\tinputEntity(", DeclRepr, ").\tindex(", IndRepr, ").\n"], "", OutStr),
		write(DeclStream, OutStr)),
		_), nl(DeclStream),
	
	findall((DeclRepr, IndRepr, "sD", "input"),
		(declared(DeclRepr, IndRepr, "sD", "input"),
		atomics_to_string(["sDFluent(", DeclRepr, ").\tinputEntity(", DeclRepr, ").\tindex(", IndRepr, ").\n"], "", OutStr),
		write(DeclStream, OutStr)),
		_), nl(DeclStream),
	
	findall((DeclRepr, IndRepr, "event", "output"),
		(declared(DeclRepr, IndRepr, "event", "output"),
		atomics_to_string(["event(", DeclRepr, ").\toutputEntity(", DeclRepr, ").\tindex(", IndRepr, ").\n"], "", OutStr),
		write(DeclStream, OutStr)),
		_), nl(DeclStream),
	
	findall((DeclRepr, IndRepr, "simple", "output"),
		(declared(DeclRepr, IndRepr, "simple", "output"),
		atomics_to_string(["simpleFluent(", DeclRepr, ").\toutputEntity(", DeclRepr, ").\tindex(", IndRepr, ").\n"], "", OutStr),
		write(DeclStream, OutStr)),
		_), nl(DeclStream),
	
	findall((DeclRepr, IndRepr, "sD", "output"),
		(declared(DeclRepr, IndRepr, "sD", "output"),
		atomics_to_string(["sDFluent(", DeclRepr, ").\toutputEntity(", DeclRepr, ").\tindex(", IndRepr, ").\n"], "", OutStr),
		write(DeclStream, OutStr)),
		_), nl(DeclStream),
	
	% Caching order only applies to output entities
	% Priority > 0 <=> Output Entity
	%findall(H, head(H), HP), write(HP),
	findall((H, Q), (head(H), \+ noCaching(H), findall(Pr, finalCachingPriority(H, Pr), Prs), max_list(Prs, Q)), CachingUnordered),
	sort(1, @<, CachingUnordered, CachingSorted),
	sort(2, @=<, CachingSorted, CachingOrdered),
	findall(H,
		(member((H, Q), CachingOrdered),
		atomics_to_string(["cachingOrder(", H, ").\t%", Q, "\n"], "", Out),
		write(DeclStream, Out)),
		_),
	told,
	close(Input), close(DeclStream), close(LogStream), !.

dependencyGraph(GraphFile) :-
	tell(GraphFile),
	write("digraph {\n"),
	findall(edge(I, J), (defines(I, J, _)), Edges),
	sort(Edges, EdgesSorted),
	forall(member(edge(K, L), EdgesSorted), (write("\""), write(K), write("\" -> \""), write(L), write("\"\n"))),
	write("}\n"),
	told.

% -----------------------------------------------
% DEFINITE CLAUSE GRAMMAR
% -----------------------------------------------

space 			--> 	"\t", space.
space 			--> 	"\n", space.
space 			--> 	"\r", space.
space 			--> 	" ", space.
space			-->	[].

goal			--> 	space, ceDefinition, space, goal.
goal			--> 	[].

ceDefinition		-->	initially.
ceDefinition		-->	holdsFor.
ceDefinition		-->	starAt.

initially		-->	"initially", space, fluent("simple", "output", CTStr, DeclRepr, _, _, null), ".",
				{
					atomics_to_string(["initially(", CTStr, ").\n\n"], "", InitiallyStr),
					write(InitiallyStr),
					assertz(cachingPriority(DeclRepr, 1)),
					propagatePriority(DeclRepr, 1)
				}.
					
holdsFor		--> 	head(Head, HeadDeclRepr), space, sep("iff"), space, {nb_setval(intervalNo, 1)}, forBody(Body, BodyPriority, HeadDeclRepr), ".",
				{
					split_string(Body, "\n", ",\t\n", BodySubs),
					findall((Term, VNames), (member(Sub, BodySubs), term_string(Term, Sub, [variable_names(VNames)])), Terms),
					last(Terms, (LastTerm, Vars)),
					last(Vars, Name=Var),
					delete(Terms, (LastTerm, Vars), TermsPending),
					delete(Vars, Name=Var, VarsPending),
					addToTail(VarsPending, 'I'=Var, NewVars),
					addToTail(TermsPending, (LastTerm, NewVars), NewTerms),
					findall(S, (member((T, V), NewTerms), term_string(T, S, [variable_names(V)])), ExprStrSplit),
					atomics_to_string(ExprStrSplit, ",\n\t", BodyFinal),
					
					write(Head), write(" :-\n\t"), write(BodyFinal), write(".\n\n"),
					
					HeadPriority is BodyPriority + 1,
					
					% Duplicate handling
					findall(P, cachingPriority(HeadDeclRepr, P), PS), max_list(PS, OldPriority),
					findall((HeadDeclRepr, P), (cachingPriority(HeadDeclRepr, P), retract(cachingPriority(HeadDeclRepr, P))), _),
					assertz(cachingPriority(HeadDeclRepr, OldPriority)),
					
					% On multiple definitions, we keep the max priority.
					(OldPriority >= HeadPriority -> true
					;
					retract(cachingPriority(HeadDeclRepr, OldPriority)),
					assertz(cachingPriority(HeadDeclRepr, HeadPriority)),
					propagatePriority(HeadDeclRepr, HeadPriority)),
					
					split_string(HeadDeclRepr, "=", "", Parts),
					list_head(Parts, Prefix, [Value]),
					string_codes(Value, ValueCodes),
					list_head(ValueCodes, First, _),
					(char_type(First, lower) -> true
					;
					assertz(noCaching(HeadDeclRepr)),
					findall((D, P), (cachingPriority(D, P), sub_string(D, 0, _, _, Prefix), assertz(head(D)), HeadPriority > P, assertz(cachingPriority(D, HeadPriority)), propagatePriority(D, HeadPriority)), _))
				}.

starAt			-->	head(Head, HeadDeclRepr), space, sep("if"), space, atBody(Body, BodyPriority, HeadDeclRepr), ".",
				{
					string_codes(Body, BodyCodes),
					list_head(BodyCodes, _, CommaFreeBodyCodes),
					string_codes(CommaFreeBody, CommaFreeBodyCodes),
					
					write(Head), write(" :-"), write(CommaFreeBody), write(".\n\n"),
					
					HeadPriority is BodyPriority + 1,
					
					% Duplicate handling???
					cachingPriority(HeadDeclRepr, OldPriority),
					
					% On multiple definitions, we keep the max priority.
					(OldPriority >= HeadPriority -> true
					;
					retract(cachingPriority(HeadDeclRepr, OldPriority)),
					assertz(cachingPriority(HeadDeclRepr, HeadPriority)),
					propagatePriority(HeadDeclRepr, HeadPriority)),
					
					split_string(HeadDeclRepr, "=", "", Parts),
					length(Parts, Length),
					(Length = 2 ->
					(list_head(Parts, Prefix, [Value]),
					string_codes(Value, ValueCodes),
					list_head(ValueCodes, First, _),
					(char_type(First, lower) -> true
					;
					assertz(noCaching(HeadDeclRepr)),
					findall((D, P), (cachingPriority(D, P), sub_string(D, 0, _, _, Prefix), assertz(head(D)), HeadPriority > P, assertz(cachingPriority(D, HeadPriority)), propagatePriority(D, HeadPriority)), _)))
					;
					true)
				}.
	
sep("iff")		--> 	"iff".
sep("if")		--> 	"if".

head(HeadStr, DeclRepr)		--> 	fluent("sD", "output", CTStr, DeclRepr, _, _, null),
					{
						atomics_to_string(["holdsFor(", CTStr, ", I)"], "", HeadStr),
						(\+ head(DeclRepr) -> assertz(head(DeclRepr))
						;
						true)
					}.
head(HeadStr, DeclRepr)		--> 	"initiate", space, fluent("simple", "output", CTStr, DeclRepr, _, _, null),
					{
						atomics_to_string(["initiatedAt(", CTStr, ", T)"], "", HeadStr),
						(\+ head(DeclRepr) -> assertz(head(DeclRepr))
						;
						true)
					}.
head(HeadStr, DeclRepr)		--> 	"terminate", space, fluent("simple", "output", CTStr, DeclRepr, _, _, null),
					{
						atomics_to_string(["terminatedAt(", CTStr, ", T)"], "", HeadStr)
					}.
head(HeadStr, DeclRepr)		--> 	"happens", space, event("output", EvStr, DeclRepr, _, null),
					{
						atomics_to_string(["happensAt(", EvStr, ", T)"], "", HeadStr)
					}.

fluent(Type, Etype, CTStr, DeclRepr, Priority, I, HeadDeclRepr)	--> 	functawr(FncStr), "(", argumentsList(ArgLStr, UArgLStr, IndArgLStr, Index), ")", value(ValStr, VType), !,
								{
									atomics_to_string([FncStr, "(", ArgLStr, ")", ValStr], "", CTStr),
									atomics_to_string([FncStr, "(", UArgLStr, ")"], "", DeclRePrefix),
									atomics_to_string([DeclRePrefix, ValStr], "", DeclRepr),
									atomics_to_string([FncStr, "(", IndArgLStr, ")", ValStr, ", ", Index], "", IndRepr),
									
									(VType = val -> true
									;
									findall((D, I, T, E), (declared(D, I, T, E), sub_string(D, 0, _, _, DeclRePrefix), assertz(declared(D, I, Type, Etype))), _)),
									
									nb_getval(intervalNo, Int),
									string_concat("I", Int, I),
									NewInt is Int + 1,
									nb_setval(intervalNo, NewInt),
									
									(declared(DeclRepr, IndRepr, Type, Etype) -> true
									;
									(declared(DeclRepr, IndRepr, "sD", "input"), Etype = "output") ->
									assertz(declared(DeclRepr, IndRepr, Type, Etype))
									;
									(VType = var -> true
									;
									assertz(declared(DeclRepr, IndRepr, Type, Etype))),
									assertz(cachingPriority(DeclRepr, 0))),
									
									cachingPriority(DeclRepr, Priority),
									
									(HeadDeclRepr = null -> assertz(head(DeclRepr))
									;
									assertz(defines(DeclRepr, HeadDeclRepr, Priority)))
								}.

event(Etype, EvStr, DeclRepr, Priority, HeadDeclRepr)		-->	functawr(FncStr), "(", argumentsList(ArgLStr, UArgLStr, IndArgLStr, Index), ")",
								{
									atomics_to_string([FncStr, "(", ArgLStr, ")"], "", EvStr),
									atomics_to_string([FncStr, "(", UArgLStr, ")"], "", DeclRepr),
									atomics_to_string([FncStr, "(", IndArgLStr, "), ", Index], "", IndRepr),
									
									(declared(DeclRepr, IndRepr, "event", Etype) -> true
									;
									(declared(DeclRepr, IndRepr, "event", "input"), Etype = "output") ->
									assertz(declared(DeclRepr, IndRepr, "event", Etype))
									;
									assertz(declared(DeclRepr, IndRepr, "event", Etype)),
									assertz(cachingPriority(DeclRepr, 0))),
									
									cachingPriority(DeclRepr, Priority),
									
									(HeadDeclRepr = null -> assertz(head(DeclRepr))
									;
									assertz(defines(DeclRepr, HeadDeclRepr, Priority)))
								}.

functawr(FncStr) 					--> 	[Lower], { char_type(Lower, lower) }, restChars(RCList),
								{
									string_codes(FncStr, [Lower|RCList])
								}.

value(ValStr, val)						-->	"=", [Lower], { char_type(Lower, lower) }, restChars(RCList),
								{
									string_codes(Str, [Lower|RCList]),
									string_concat("=", Str, ValStr)
								}.
value(ValStr, var)						-->	"=", [Upper], { char_type(Upper, upper) }, restChars(RCList),
								{
									string_codes(Str, [Upper|RCList]),
									string_concat("=", Str, ValStr)
								}.
value("=true", val)						-->	[].

restChars(Chars)					--> 	string_without([9, 10, 13, 32, 40, 41, 44, 46], Chars).

argumentsList(ArgLStr, UArgLStr, IndArgLStr, ArgStr)	--> 	argument(ArgStr), moreArguments(MArgStr, UMArgStr),
								{
									string_concat(ArgStr, MArgStr, ArgLStr),
									string_concat("_", UMArgStr, UArgLStr),
									string_concat(ArgStr, UMArgStr, IndArgLStr)
								}.
argumentsList(ArgLStr, UArgLStr, IndArgLStr, "X")	--> 	"_", moreArguments(MArgStr, UMArgStr),
								{
									string_concat("_", MArgStr, ArgLStr),
									string_concat("_", UMArgStr, UArgLStr),
									string_concat("X", UMArgStr, IndArgLStr)
								}.

argument(ArgStr) 					--> 	[Alpha], { char_type(Alpha, alnum) }, restChars(RCList),
								{
									string_codes(ArgStr, [Alpha|RCList])
								}.

moreArguments(MArgStr, MArgStr)				--> 	[],
								{
									string_codes(MArgStr, [])
								}.
moreArguments(MArgStr, UMArgStr)			-->	",", space, argument(ArgStr), moreArguments(MMArgStr, UMMArgStr),
								{
									string_concat(",", ArgStr, MArgPending),
									string_concat(MArgPending, MMArgStr, MArgStr),
									string_concat(",_", UMMArgStr, UMArgStr)
								}.
moreArguments(MArgStr, UMArgStr)			-->	",", space, "_", moreArguments(MMArgStr, UMMArgStr),
								{
									string_concat(",_", MMArgStr, MArgStr),
									string_concat(",_", UMMArgStr, UMArgStr)
								}.

forBody(BodyStr, Priority, HeadDeclRepr)			-->	expression(BodyStr, _, Priority, HeadDeclRepr).

expression(ExprStr, I, Priority, HeadDeclRepr)		-->	component(CompStr, T1, Priority1, HeadDeclRepr), moreComponents(MCompStr, T2, and, Priority2, HeadDeclRepr),
								{
									nb_getval(intervalNo, Int),
									string_concat("I", Int, I),
									NewInt is Int + 1,
									nb_setval(intervalNo, NewInt),
									
									atom_string(T1Atom, T1),
									atom_string(T2Atom, T2),
									atom_string(IAtom, I),
									
									atomics_to_string([CompStr, MCompStr], ",\n\t", ExprStrPending),
									split_string(ExprStrPending, "\n", ",\t\n", SubStrings),
									findall((Term, VNames), (member(Sub, SubStrings), term_string(Term, Sub, [variable_names(VNames)])), Terms),
									(
										(member((complement_all(List, SomeI), Vars), Terms), last(Vars, T2Atom=SomeI)) ->
										delete(Terms, (complement_all(List, SomeI), Vars), TermsPending1),
										delete(Vars, T2Atom=SomeI, VarsPending1),
										addToHead(VarsPending1, T1Atom=Anon1, VarsPending2),
										addToTail(VarsPending2, IAtom=AnonI, NewVars),
										addToTail(TermsPending1, (relative_complement_all(Anon1, List, AnonI), NewVars), NewTerms)
										;
										(member((intersect_all(List, SomeI), Vars), Terms), last(Vars, T1Atom=SomeI)) ->
										delete(Terms, (intersect_all(List, SomeI), Vars), TermsPending1),
										delete(Vars, T1Atom=SomeI, VarsPending1),
										addToHead(VarsPending1, T2Atom=Anon2, VarsPending2),
										addToTail(VarsPending2, IAtom=AnonI, NewVars),
										addToHead(List, Anon2, NewList),
										addToTail(TermsPending1, (intersect_all(NewList, AnonI), NewVars), NewTerms)
										;
										(member((intersect_all(List, SomeI), Vars), Terms), last(Vars, T2Atom=SomeI)) ->
										delete(Terms, (intersect_all(List, SomeI), Vars), TermsPending1),
										delete(Vars, T2Atom=SomeI, VarsPending1),
										addToHead(VarsPending1, T1Atom=Anon1, VarsPending2),
										addToTail(VarsPending2, IAtom=AnonI, NewVars),
										addToHead(List, Anon1, NewList),
										addToTail(TermsPending1, (intersect_all(NewList, AnonI), NewVars), NewTerms)
										;
										addToTail(Terms, (intersect_all([Anon1, Anon2], AnonI), [T1Atom=Anon1, T2Atom=Anon2, IAtom=AnonI]), NewTerms)
									),
									findall(S, (member((T, V), NewTerms), term_string(T, S, [variable_names(V)])), ExprStrSplit),
									atomics_to_string(ExprStrSplit, ",\n\t", ExprStr),
	
									Priority is Priority1 + Priority2
								}.
expression(ExprStr, I, Priority, HeadDeclRepr)		-->	component(CompStr, T1, Priority1, HeadDeclRepr), moreComponents(MCompStr, T2, or, Priority2, HeadDeclRepr),
								{
									nb_getval(intervalNo, Int),
									string_concat("I", Int, I),
									NewInt is Int + 1,
									nb_setval(intervalNo, NewInt),
									
									atom_string(T1Atom, T1),
									atom_string(T2Atom, T2),
									atom_string(IAtom, I),
									
									atomics_to_string([CompStr, MCompStr], ",\n\t", ExprStrPending),
									split_string(ExprStrPending, "\n", ",\t\n", SubStrings),
									findall((Term, VNames), (member(Sub, SubStrings), term_string(Term, Sub, [variable_names(VNames)])), Terms),
									(
										(member((union_all(List, SomeI), Vars), Terms), last(Vars, T1Atom=SomeI)) ->
										delete(Terms, (union_all(List, SomeI), Vars), TermsPending1),
										delete(Vars, T1Atom=SomeI, VarsPending1),
										addToHead(VarsPending1, T2Atom=Anon2, VarsPending2),
										addToTail(VarsPending2, IAtom=AnonI, NewVars),
										addToTail(List, Anon2, NewList),
										addToTail(TermsPending1, (union_all(NewList, AnonI), NewVars), NewTerms)
										;
										(member((union_all(List, SomeI), Vars), Terms), last(Vars, T2Atom=SomeI)) ->
										delete(Terms, (union_all(List, SomeI), Vars), TermsPending1),
										delete(Vars, T2Atom=SomeI, VarsPending1),
										addToHead(VarsPending1, T1Atom=Anon1, VarsPending2),
										addToTail(VarsPending2, IAtom=AnonI, NewVars),
										addToTail(List, Anon1, NewList),
										addToTail(TermsPending1, (union_all(NewList, AnonI), NewVars), NewTerms)
										;
										addToTail(Terms, (union_all([Anon1, Anon2], AnonI), [T1Atom=Anon1, T2Atom=Anon2, IAtom=AnonI]), NewTerms)
									),
									findall(S, (member((T, V), NewTerms), term_string(T, S, [variable_names(V)])), ExprStrSplit),
									atomics_to_string(ExprStrSplit, ",\n\t", ExprStr),
	
									Priority is Priority1 + Priority2
								}.
expression(ExprStr, I, Priority, HeadDeclRepr)		-->	component(ExprStr, I, Priority, HeadDeclRepr), moreComponents(null).

moreComponents(MCompStr, I, and, Priority, HeadDeclRepr)	-->	",", space, expression(MCompStr, I, Priority, HeadDeclRepr).
moreComponents(MCompStr, I, or, Priority, HeadDeclRepr)	-->	space, "or", space, expression(MCompStr, I, Priority, HeadDeclRepr).
moreComponents(null)					-->	[].

component(CompStr, T, Priority, HeadDeclRepr)		-->	fluent("sD", "input", Str, _, Priority, T, HeadDeclRepr),
								{
									string_concat(",\n\tholdsFor(", Str, CompStrPending1),
									string_concat(CompStrPending1, ", ", CompStrPending2),
									string_concat(CompStrPending2, T, CompStrPending3),
									string_concat(CompStrPending3, ")", CompStr)
								}.
component(CompStr, T, Priority, HeadDeclRepr)		-->	"(", space, expression(CompStr, T, Priority, HeadDeclRepr), space, ")".
component(CompStr, T, Priority, HeadDeclRepr)		-->	"not", space, expression(Str, ExpT, Priority, HeadDeclRepr),
								{
									string_concat(Str, ",\n\tcomplement_all([", CompStrPending3),
									string_concat(CompStrPending3, ExpT, CompStrPending4),
									string_concat(CompStrPending4, "], ", CompStrPending5),
									nb_getval(intervalNo, Int),
									string_concat("I", Int, T),
									NewInt is Int + 1,
									nb_setval(intervalNo, NewInt),
									string_concat(CompStrPending5, T, CompStrPending6),
									string_concat(CompStrPending6, ")", CompStr)
								}.

atBody(AtBodyStr, Priority, HeadDeclRepr)			-->	"happens", space, event("input", CTStr, _, Priority1, HeadDeclRepr), moreConditions(MCondStr, Priority2, HeadDeclRepr),
								{
									string_concat(",\n\thappensAt(", CTStr, CondStrPending1),
									string_concat(CondStrPending1, ", T)", CondStr),
									string_concat(CondStr, MCondStr, AtBodyStr),
									Priority is Priority1 + Priority2
								}.
atBody(AtBodyStr, Priority, HeadDeclRepr)			-->	"not happens", space, event("input", CTStr, _, Priority1, HeadDeclRepr), moreConditions(MCondStr, Priority2, HeadDeclRepr),
								{
									string_concat(",\n\t\\+ happensAt(", CTStr, CondStrPending1),
									string_concat(CondStrPending1, ", T)", CondStr),
									string_concat(CondStr, MCondStr, AtBodyStr),
									Priority is Priority1 + Priority2
								}.
atBody(AtBodyStr, Priority, HeadDeclRepr)			-->	"start", space, fluent("sD", "input", CTStr, _, Priority1, _, HeadDeclRepr), moreConditions(MCondStr, Priority2, HeadDeclRepr),
								{
									string_concat(",\n\thappensAt(start(", CTStr, CondStrPending1),
									string_concat(CondStrPending1, "), T)", CondStr),
									string_concat(CondStr, MCondStr, AtBodyStr),
									Priority is Priority1 + Priority2
								}.
atBody(AtBodyStr, Priority, HeadDeclRepr)			-->	"end", space, fluent("sD", "input", CTStr, _, Priority1, _, HeadDeclRepr), moreConditions(MCondStr, Priority2, HeadDeclRepr),
								{
									string_concat(",\n\thappensAt(end(", CTStr, CondStrPending1),
									string_concat(CondStrPending1, "), T)", CondStr),
									string_concat(CondStr, MCondStr, AtBodyStr),
									Priority is Priority1 + Priority2
								}.

condition(CondStr, Priority, HeadDeclRepr)		-->	"start", space, fluent("sD", "input", CTStr, _, Priority, _, HeadDeclRepr),
								{
									string_concat(",\n\thappensAt(start(", CTStr, CondStrPending1),
									string_concat(CondStrPending1, "), T)", CondStr)
								}.
condition(CondStr, Priority, HeadDeclRepr)		-->	"end", space, fluent("sD", "input", CTStr, _, Priority, _, HeadDeclRepr),
								{
									string_concat(",\n\thappensAt(end(", CTStr, CondStrPending1),
									string_concat(CondStrPending1, "), T)", CondStr)
								}.
condition(CondStr, Priority, HeadDeclRepr)		-->	"happens", space, event("input", CTStr, _, Priority, HeadDeclRepr),
								{
									string_concat(",\n\thappensAt(", CTStr, CondStrPending1),
									string_concat(CondStrPending1, ", T)", CondStr)
								}.
condition(CondStr, Priority, HeadDeclRepr)		-->	"not happens", space, event("input", CTStr, _, Priority, HeadDeclRepr),
								{
									string_concat(",\n\t\\+ happensAt(", CTStr, CondStrPending1),
									string_concat(CondStrPending1, ", T)", CondStr)
								}.
condition(CondStr, Priority, HeadDeclRepr)		-->	fluent("sD", "input", CTStr, _, Priority, _, HeadDeclRepr),
								{
									string_concat(",\n\tholdsAt(", CTStr, CondStrPending1),
									string_concat(CondStrPending1, ", T)", CondStr)
								}.
condition(CondStr, Priority, HeadDeclRepr)		-->	"not", space, fluent("sD", "input", CTStr, _, Priority, _, HeadDeclRepr),
								{
									string_concat(",\n\t\\+ holdsAt(", CTStr, CondStrPending1),
									string_concat(CondStrPending1, ", T)", CondStr)
								}.

moreConditions(MCondStr, Priority, HeadDeclRepr)		-->	",", space, condition(CondStr, Priority1, HeadDeclRepr), moreConditions(MMCondStr, Priority2, HeadDeclRepr),
								{
									string_concat(CondStr, MMCondStr, MCondStr),
									Priority is Priority1 + Priority2
								}.
moreConditions("", 0, _)				-->	[].

