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
	%sleep(1),
	%write("\n\nLook, as far as I know, the priority of "), write(E), write(" is "), write(P),
	%write(". I am going to propagate this to all dependants...\n"),
	(\+ defines(E, _, _) -> true %write("There are no dependants. Exiting...\n\n")
	;
	defines(E, E, _) -> true %write("Self-dependency. Exiting...\n\n")
	;
	findall(H, defines(E, H, _), Heads), Heads \= [], sort(Heads, HeadsSorted),
	%write("Dependants Unsorted: "), write(Heads), write("\tDependants Sorted: "), write(HeadsSorted), nl,
	findall((E, B, C), (defines(E, B, C), retract(defines(E, B, C))), _),
	forall(member(H, HeadsSorted), (assertz(defines(E, H, P)), 
	%write("Asserted new dependency for rule "), write(H), write(". Now the new priority of "), write(H), 
	calculatePriority(H, Q), 
	%write(" is "), write(Q),
	assertz(cachingPriority(H, Q)),
	%write("! Repeating procedure...\n\n"), 
	propagatePriority(H, Q)))).

calculatePriority(H, Q) :-
	findall(dddt(O,P), defines(O, H, P), OPS),
	sort(2, @>=, OPS, OOPS),
	sort(1, @<, OOPS, OOPSS),
	findall(P, member(dddt(_, P), OOPSS), PS),
	%write("\n"),write(OOPSS),nl,
	sum_list(PS, TmpQ),
	Q is TmpQ + 1.

% -----------------------------------------------
% SIMPL-EC
% -----------------------------------------------
	
simplEC(InputFile, OutputFile, DeclarationsFile, GraphFile) :-
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
	findall((H, Q), (head(H), \+ noCaching(H), findall(Pr, cachingPriority(H, Pr), Prs), max_list(Prs, Q)), CachingUnordered),
	sort(1, @<, CachingUnordered, CachingSorted),
	sort(2, @=<, CachingSorted, CachingOrdered),
	findall(H,
		(member((H, Q), CachingOrdered),
		atomics_to_string(["cachingOrder(", H, ").\t%", Q, "\n"], "", Out),
		write(DeclStream, Out)),
		_),
	told,
	close(Input), close(DeclStream), close(LogStream),
	
	% Dependency graph preparation
	findall(Q, member((_, Q), CachingOrdered), QS),
	findall(H, member((H, _), CachingOrdered), HS),
	findall(H0, (declared(H0, _, _, _), \+ member((H0, _), CachingOrdered)), H0S),
	pairs_keys_values(QHS, QS, HS),
	group_pairs_by_key(QHS, QLS),
	pairs_keys_values(QLS, List1, List2),
	findall((L1, L2), (member(L1, List1), nth1(Index, List1, L1), nth1(Index, List2, L2)), AlmostFinalList),
	addToHead(AlmostFinalList, (0, H0S), FinalList),
	%writeln(FinalList),
	
	% Dependency graph generation
	tell(GraphFile),
	write("digraph\n{\n\tnode [shape=Mrecord];\n\trankdir=LR\n\n"),
	
	forall(member((Q, L), FinalList), (findall(LabelPart, (member(Part, L), atomics_to_string(["<", Part, "> ", Part], LabelPart)), LabelParts), atomics_to_string(LabelParts, "|", Label), atomics_to_string(["\t", Q, " [label=\"", Label, "\"];\n"], Line), write(Line))),nl,
	
	%findall(edge(CI, I, CJ, J), (defines(I, J, _), member(I, SomeH), member((CI, SomeH), FinalList), member(J, SomeOtherH), member((CJ, SomeOtherH), FinalList)), Edges),
	findall(edge(CI, I, CJ, J), (defines(I, J, _), member((J, CJ), CachingOrdered), (member((I, CI), CachingOrdered) -> true ; CI is 0)), Edges),
	sort(Edges, EdgesSorted),
	forall(member(edge(CK, K, CL, L), EdgesSorted), (write("\t"), write(CK), write(":\""), write(K), write("\" -> "), write(CL), write(":\""), write(L), writeln("\""))),
	write("}\n"),
	told, !.

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

head(HeadStr, DeclRepr)						--> 	"holds", space, fluent("sD", "output", CTStr, DeclRepr, _, _, null),
									{
										atomics_to_string(["holdsFor(", CTStr, ", I)"], "", HeadStr),
										(\+ head(DeclRepr) -> assertz(head(DeclRepr))
										;
										true)
									}.
head(HeadStr, DeclRepr)						--> 	"initiate", space, fluent("simple", "output", CTStr, DeclRepr, _, _, null),
									{
										atomics_to_string(["initiatedAt(", CTStr, ", T)"], "", HeadStr),
										(\+ head(DeclRepr) -> assertz(head(DeclRepr))
										;
										true)
									}.
head(HeadStr, DeclRepr)						--> 	"terminate", space, fluent("simple", "output", CTStr, DeclRepr, _, _, null),
									{
										atomics_to_string(["terminatedAt(", CTStr, ", T)"], "", HeadStr)
									}.
head(HeadStr, DeclRepr)						--> 	"happens", space, event("output", EvStr, DeclRepr, _, null),
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
										(VType = var -> true
										;
										assertz(declared(DeclRepr, IndRepr, Type, Etype)))),
										
										(cachingPriority(DeclRepr, _) -> (findall(P, cachingPriority(DeclRepr, P), PS), max_list(PS, Priority))
										;
										assertz(cachingPriority(DeclRepr, 0)), Priority = 0),
										
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
										assertz(declared(DeclRepr, IndRepr, "event", Etype))),
										
										(cachingPriority(DeclRepr, _) -> (findall(P, cachingPriority(DeclRepr, P), PS), max_list(PS, Priority))
										;
										assertz(cachingPriority(DeclRepr, 0)), Priority = 0),
										
										(HeadDeclRepr = null -> assertz(head(DeclRepr))
										;
										assertz(defines(DeclRepr, HeadDeclRepr, Priority)))
									}.

functawr(FncStr)	 					--> 	[Lower], { char_type(Lower, lower) }, restChars(RCList),
									{
										string_codes(FncStr, [Lower|RCList])
									}.
	
variable(VarStr)						-->	[Upper], { char_type(Upper, upper) }, restChars(RCList),
									{
										string_codes(VarStr, [Upper|RCList])
									}.
variable(VarStr)						-->	"_", restChars(RCList),
									{
										string_codes(RCStr, RCList),
										string_concat("_", RCStr, VarStr)
									}.

value(ValStr, var)						-->	"=", variable(ArgStr),
									{
										string_concat("=", ArgStr, ValStr)
									}.
value(ValStr, val)						-->	"=", functawr(ArgStr),
									{
										string_concat("=", ArgStr, ValStr)
									}.
value(ValStr, val)						-->	"=", number(ArgStr),
									{
										string_concat("=", ArgStr, ValStr)
									}.
value("=true", val)						-->	[].

restChars(Chars)						--> 	string_without([9, 10, 13, 32, 40, 41, 44, 46], Chars).

argumentsList(ArgLStr, UArgLStr, IndArgLStr, ArgStr)		--> 	argument(ArgStr), moreArguments(MArgStr, UMArgStr),
									{
										string_concat(ArgStr, MArgStr, ArgLStr),
										string_concat("_", UMArgStr, UArgLStr),
										string_concat(ArgStr, UMArgStr, IndArgLStr)
									}.
argumentsList(ArgLStr, UArgLStr, IndArgLStr, "X")		--> 	"_", moreArguments(MArgStr, UMArgStr),
									{
										string_concat("_", MArgStr, ArgLStr),
										string_concat("_", UMArgStr, UArgLStr),
										string_concat("X", UMArgStr, IndArgLStr)
									}.

argument(ArgStr) 						--> 	functawr(ArgStr).
argument(ArgStr) 						--> 	variable(ArgStr).
argument(ArgStr) 						--> 	number(ArgStr).
argument(ArgStr) 						--> 	list(ArgStr).

moreArguments(MArgStr, MArgStr)					--> 	[],
									{
										string_codes(MArgStr, [])
									}.
moreArguments(MArgStr, UMArgStr)				-->	",", space, argument(ArgStr), moreArguments(MMArgStr, UMMArgStr),
									{
										atomics_to_string([",", ArgStr, MMArgStr], "", MArgStr),
										string_concat(",_", UMMArgStr, UMArgStr)
									}.
moreArguments(MArgStr, UMArgStr)				-->	",", space, "_", moreArguments(MMArgStr, UMMArgStr),
									{
										string_concat(",_", MMArgStr, MArgStr),
										string_concat(",_", UMMArgStr, UMArgStr)
									}.

forBody(BodyStr, Priority, HeadDeclRepr)			-->	expression(BodyStr, _, Priority, HeadDeclRepr).
forBody(BodyStr, Priority, HeadDeclRepr)			-->	expression(ExprStr, _, Priority, HeadDeclRepr), ",", space, constraints(ConStr),
									{
										atomics_to_string([ExprStr, ConStr], ",\n\t", BodyStr)
									}.

expression(ExprStr, I, Priority, HeadDeclRepr)			-->	component(CompStr, T1, Priority1, HeadDeclRepr), moreComponents(MCompStr, T2, and, Priority2, HeadDeclRepr),
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
expression(ExprStr, I, Priority, HeadDeclRepr)			-->	component(CompStr, T1, Priority1, HeadDeclRepr), moreComponents(MCompStr, T2, or, Priority2, HeadDeclRepr),
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
expression(ExprStr, I, Priority, HeadDeclRepr)			-->	component(ExprStr, I, Priority, HeadDeclRepr), moreComponents(null).

moreComponents(MCompStr, I, and, Priority, HeadDeclRepr)	-->	",", space, expression(MCompStr, I, Priority, HeadDeclRepr).
moreComponents(MCompStr, I, or, Priority, HeadDeclRepr)		-->	space, "or", space, expression(MCompStr, I, Priority, HeadDeclRepr).
moreComponents(null)						-->	[].

component(CompStr, T, Priority, HeadDeclRepr)			-->	fluent("sD", "input", Str, _, Priority, T, HeadDeclRepr),
									{
										atomics_to_string([",\n\tholdsFor(", Str, ", ", T, ")"], "", CompStr)
									}.
component(CompStr, T, Priority, HeadDeclRepr)			-->	"(", space, expression(CompStr, T, Priority, HeadDeclRepr), space, ")".
component(CompStr, T, Priority, HeadDeclRepr)			-->	"not", space, expression(Str, ExpT, Priority, HeadDeclRepr),
									{
										nb_getval(intervalNo, Int),
										NewInt is Int + 1,
										nb_setval(intervalNo, NewInt),
										string_concat("I", Int, T),
										atomics_to_string([Str, ",\n\tcomplement_all([", ExpT, "], ", T, ")"], "", CompStr)
									}.

constraints(ConStr)						-->	durationConstraint(DCStr), moreConstraints(MConStr),
									{
										atomics_to_string([DCStr, MConStr], ",\n\t", ConStr)
									}.
constraints(ConStr)						-->	atemporalConstraint(ACStr), moreConstraints(MConStr),
									{
										atomics_to_string([ACStr, MConStr], ",\n\t", ConStr)
									}.
constraints("")							-->	[].

moreConstraints(MConStr)					-->	",", space, constraints(MConStr).
moreConstraints("")						-->	[].

durationConstraint(DCStr)					-->	"duration", space, operator(OpStr), space, variable(VarStr),
									{
										nb_getval(intervalNo, Int),
										PrevInt is Int - 1,
										NewInt is Int + 1,
										nb_setval(intervalNo, NewInt),
										atomics_to_string([",\n\tfindall((S,E), (member((S,E), I", PrevInt, "), Diff is E-S, Diff ", OpStr, " ", VarStr, "), I", Int, ")"], "", DCStr)
									}.
durationConstraint(DCStr)					-->	"duration", space, operator(OpStr), space, number(NumStr),
									{
										nb_getval(intervalNo, Int),
										PrevInt is Int - 1,
										NewInt is Int + 1,
										nb_setval(intervalNo, NewInt),
										atomics_to_string([",\n\tfindall((S,E), (member((S,E), I", PrevInt, "), Diff is E-S, Diff ", OpStr, " ", NumStr, "), I", Int, ")"], "", DCStr)
									}.

atBody(AtBodyStr, Priority, HeadDeclRepr)			-->	"happens", space, event("input", CTStr, _, Priority1, HeadDeclRepr), moreConditions(MCondStr, Priority2, HeadDeclRepr),
									{
										atomics_to_string([",\n\thappensAt(", CTStr, ", T)", MCondStr], "", AtBodyStr),
										Priority is Priority1 + Priority2
									}.
atBody(AtBodyStr, Priority, HeadDeclRepr)			-->	"not happens", space, event("input", CTStr, _, Priority1, HeadDeclRepr), moreConditions(MCondStr, Priority2, HeadDeclRepr),
									{
										atomics_to_string([",\n\t\\+ happensAt(", CTStr, ", T)", MCondStr], "", AtBodyStr),
										Priority is Priority1 + Priority2
									}.
atBody(AtBodyStr, Priority, HeadDeclRepr)			-->	"start", space, fluent("sD", "input", CTStr, _, Priority1, _, HeadDeclRepr), moreConditions(MCondStr, Priority2, HeadDeclRepr),
									{
										atomics_to_string([",\n\thappensAt(start(", CTStr, "), T)", MCondStr], "", AtBodyStr),
										Priority is Priority1 + Priority2
									}.
atBody(AtBodyStr, Priority, HeadDeclRepr)			-->	"end", space, fluent("sD", "input", CTStr, _, Priority1, _, HeadDeclRepr), moreConditions(MCondStr, Priority2, HeadDeclRepr),
									{
										atomics_to_string([",\n\thappensAt(end(", CTStr, "), T)", MCondStr], "", AtBodyStr),
										Priority is Priority1 + Priority2
									}.

condition(CondStr, Priority, HeadDeclRepr)			-->	"start", space, fluent("sD", "input", CTStr, _, Priority, _, HeadDeclRepr),
									{
										atomics_to_string([",\n\thappensAt(start(", CTStr, "), T)"], "", CondStr)
									}.
condition(CondStr, Priority, HeadDeclRepr)			-->	"end", space, fluent("sD", "input", CTStr, _, Priority, _, HeadDeclRepr),
									{
										atomics_to_string([",\n\thappensAt(end(", CTStr, "), T)"], "", CondStr)
									}.
condition(CondStr, Priority, HeadDeclRepr)			-->	"happens", space, event("input", CTStr, _, Priority, HeadDeclRepr),
									{
										atomics_to_string([",\n\thappensAt(", CTStr, ", T)"], "", CondStr)
									}.
condition(CondStr, Priority, HeadDeclRepr)			-->	"not happens", space, event("input", CTStr, _, Priority, HeadDeclRepr),
									{
										atomics_to_string([",\n\t\\+ happensAt(", CTStr, ", T)"], "", CondStr)
									}.
condition(CondStr, Priority, HeadDeclRepr)			-->	"holds", space, fluent("sD", "input", CTStr, _, Priority, _, HeadDeclRepr),
									{
										atomics_to_string([",\n\tholdsAt(", CTStr, ", T)"], "", CondStr)
									}.
condition(CondStr, Priority, HeadDeclRepr)			-->	"not holds", space, fluent("sD", "input", CTStr, _, Priority, _, HeadDeclRepr),
									{
										atomics_to_string([",\n\t\\+ holdsAt(", CTStr, ", T)"], "", CondStr)
									}.
condition(ACStr, 0, _)						-->	atemporalConstraint(ACStr).
	
moreConditions(MCondStr, Priority, HeadDeclRepr)		-->	",", space, condition(CondStr, Priority1, HeadDeclRepr), moreConditions(MMCondStr, Priority2, HeadDeclRepr),
									{
										string_concat(CondStr, MMCondStr, MCondStr),
										Priority is Priority1 + Priority2
									}.
moreConditions("", 0, _)					-->	[].

atemporalConstraint(ACStr)					-->	fact(ACStr).
atemporalConstraint(ACStr)					-->	math(ACStr).

fact(FStr)							-->	functawr(FncStr), "(", argumentsList(ArgLStr, _, _, _), ")",
									{
										atomics_to_string([",\n\t", FncStr, "(", ArgLStr, ")"], "", FStr)
									}.

math(MStr)							-->	variable(Var1Str), space, operator(OpStr), space, variable(Var2Str),
									{
										atomics_to_string([",\n\t", Var1Str, " ", OpStr, " ", Var2Str], "", MStr)
									}.
math(MStr)							-->	variable(Var1Str), space, operator(OpStr), space, number(NumStr),
									{
										atomics_to_string([",\n\t", Var1Str, " ", OpStr, " ", NumStr], "", MStr)
									}.

operator(">")							-->	">".
operator(">=")							-->	">=".
operator("<")							-->	"<".
operator("=<")							-->	"=<".
operator("=")							-->	"=".

list(LStr)							-->	"[", space, argumentsList(ArgLStr, _, _, _), space, "]",
									{
										atomics_to_string(["[", ArgLStr, "]"], "", LStr)
									}.
list("[]")							-->	"[]".








