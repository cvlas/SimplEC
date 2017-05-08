:- [library(dcg/basics)].

% -----------------------------------------------
% AUXILIARY TOOLS
% -----------------------------------------------

list_head([H|T], H, T).

% Add an element to the head or the tail of a list

addToHead(L, H, [H|L]).

addToTail([], E, [E]).
addToTail([H|T], E, [H|L]) :- addToTail(T, E, L).

% -----------------------------------------------
% SIMPL-EC
% -----------------------------------------------
	
simplEC(InputFile, OutputFile, DeclarationsFile) :-
	open(InputFile, read, Input),
	open(DeclarationsFile, append, DeclStream),
	tell(OutputFile),
	
	% Auxiliary global variables
	nb_setval(headFluents, []),
	nb_setval(declared, []),
	nb_setval(cached, []),
	nb_setval(intervalNo, 1),
	
	% Parse and translate the rules
	read_stream_to_codes(Input, Codes),
	phrase(goal(DeclStream), Codes),
	
	% Caching order only applies to output entities
	% Priority > 0 <=> Output Entity
	findall((OE,Pr), (cachingPriority(OE, Pr), Pr > 0), CachingUnordered),
	sort(2, @=<, CachingUnordered, CachingOrdered),
	findall(OE,
		(member((OE, Pr), CachingOrdered),
		nb_getval(cached, Cchd),
		\+member(OE, Cchd),
		addToTail(Cchd, OE, Cchdnew),
		nb_setval(cached, Cchdnew),
		write(DeclStream, "cachingOrder("), 
		write(DeclStream, OE),
		write(DeclStream, "). %"),
		write(DeclStream, Pr),
		nl(DeclStream)),
		_),
	told,
	close(Input), close(DeclStream), !.

% -----------------------------------------------
% DEFINITE CLAUSE GRAMMAR
% -----------------------------------------------

space 					--> 	"\t", space.
space 					--> 	"\n", space.
space 					--> 	"\r", space.
space 					--> 	" ", space.
space					-->	[].

goal(DeclStream)			--> 	space, ceDefinition(DeclStream), space, goal(DeclStream).
goal(_)					--> 	[].

ceDefinition(DeclStream)		-->	holdsFor(DeclStream).
ceDefinition(DeclStream)		-->	initTerm(DeclStream).
					
holdsFor(DeclStream)			--> 	head(Head, HeadT, DeclRepr, DeclStream), space, sep("iff"), space, hfBody(Body, BodyT, BodyPriority, DeclStream), ".",
						{
							atom_string(HeadTAtom, HeadT),
							
							split_string(Body, "\n", ",\t\n", BodySubs),
							findall((Term, VNames), (member(Sub, BodySubs), term_string(Term, Sub, [variable_names(VNames)])), Terms),
							last(Terms, (LastTerm, Vars)),
							last(Vars, Name=Var),
							delete(Terms, (LastTerm, Vars), TermsPending),
							delete(Vars, Name=Var, VarsPending),
							addToTail(VarsPending, HeadTAtom=Var, NewVars),
							addToTail(TermsPending, (LastTerm, NewVars), NewTerms),
							findall(S, (member((T, V), NewTerms), term_string(T, S, [variable_names(V)])), ExprStrSplit),
							atomics_to_string(ExprStrSplit, ",\n\t", BodyFinal),
							
							write(Head), write(" :-\n\t"), write(BodyFinal), write(".\n\n"),
							
							HeadPriority is BodyPriority + 1,
							cachingPriority(DeclRepr, OldPriority),
							% On multiple definitions, we keep the max priority.
							(OldPriority >= HeadPriority -> true
							;
							retract(cachingPriority(DeclRepr, OldPriority)),
							assertz(cachingPriority(DeclRepr, HeadPriority)))
						}.

initTerm(DeclStream)			-->	head(Head, _, DeclRepr, DeclStream), space, sep("if"), space, itBody(Body, BodyPriority, DeclStream), ".",
						{
							string_codes(Body, BodyCodes),
							list_head(BodyCodes, _, CommaFreeBodyCodes),
							string_codes(CommaFreeBody, CommaFreeBodyCodes),
							write(Head), write(" :-"), write(CommaFreeBody), write(".\n\n"),
							HeadPriority is BodyPriority + 1,
							cachingPriority(DeclRepr, OldPriority),
							% On multiple definitions, we keep the max priority.
							(OldPriority >= HeadPriority -> true
							;
							retract(cachingPriority(DeclRepr, OldPriority)),
							assertz(cachingPriority(DeclRepr, HeadPriority)))
						}.
	
sep("iff")				--> 	"iff".
sep("if")				--> 	"if".

head(HeadStr, CTT, DeclRepr, DeclStream)			--> 	fluent("sD", "output", CTStr, DeclRepr, _, CTT, DeclStream),
							{
								string_concat("holdsFor(", CTStr, HeadStrPending1),
								string_concat(HeadStrPending1, ", ", HeadStrPending2),
								string_concat(HeadStrPending2, CTT, HeadStrPending3),
								string_concat(HeadStrPending3, ")", HeadStr),
								nb_getval(headFluents, HF),
								addToTail(HF, DeclRepr, HF_new),
								nb_setval(headFluents, HF_new)
							}.
head(HeadStr, CTT, DeclRepr, DeclStream) 			--> 	"initiate", space, fluent("simple", "output", CTStr, DeclRepr, _, CTT, DeclStream),
							{
								string_concat("initiatedAt(", CTStr, HeadStrPending1),
								string_concat(HeadStrPending1, ", T)", HeadStr),
								nb_getval(headFluents, HF),
								addToTail(HF, DeclRepr, HF_new),
								nb_setval(headFluents, HF_new)
							}.
head(HeadStr, CTT, DeclRepr, DeclStream)	 		--> 	"terminate", space, fluent("simple", "output", CTStr, DeclRepr, _, CTT, DeclStream),
							{
								string_concat("terminatedAt(", CTStr, HeadStrPending1),
								string_concat(HeadStrPending1, ", T)", HeadStr)
							}.

fluent(Type, Etype, CTStr, DeclRepr, Priority, T, DeclStream)	--> 	functawr(FncStr), "(", argumentsList(ArgLStr, IArgLStr, UArgLStr, IndArgLStr, Index), ")", value(ValStr, Str), !,
							{
								string_concat(FncStr, "(", FncPending1),
								string_concat(FncPending1, ArgLStr, FncPending2),
								string_concat(FncPending2, ")", FncPending3),
								string_concat(FncPending3, ValStr, CTStr),
								%string_concat("I_", FncStr, TPending1),
								%string_concat(TPending1, "_", TPending2),
								%string_concat(TPending2, IArgLStr, TPending3),
								%string_concat(TPending3, "_", TPending4),
								%string_concat(TPending4, Str, T),
								nb_getval(intervalNo, Int),
								string_concat("I", Int, T),
								NewInt is Int + 1,
								nb_setval(intervalNo, NewInt),
								string_concat(FncStr, ValStr, DeclStr),
								string_concat(FncPending1, UArgLStr, DeclReprPending1),
								string_concat(DeclReprPending1, ")", DeclReprPending2),
								string_concat(DeclReprPending2, ValStr, DeclRepr),
								nb_getval(headFluents, HF),
								nb_getval(declared, Decl),
								(member(DeclRepr, HF) -> true
								%cachingPriority(DeclRepr, Priority),
								%NewPriority is Priority+1, 
								%retract(cachingPriority(DeclRepr, Priority)), 
								%assertz(cachingPriority(DeclRepr, NewPriority))
								;
								member(DeclStr, Decl) -> true
								;
								write(DeclStream, Type), write(DeclStream, "Fluent("), write(DeclStream, DeclRepr), write(DeclStream, ").\n"),
								write(DeclStream, Etype), write(DeclStream, "Entity("), write(DeclStream, DeclRepr), write(DeclStream, ").\n"),
								write(DeclStream, "index("), write(DeclStream, FncPending1), write(DeclStream, IndArgLStr), write(DeclStream, ")"), write(DeclStream, ValStr), write(DeclStream, ", "), write(DeclStream, Index), write(DeclStream, ").\n\n"),
								addToTail(Decl, DeclStr, Decll),
								nb_setval(declared, Decll),
								assertz(cachingPriority(DeclRepr, 0))),
								cachingPriority(DeclRepr, Priority)
							}.

event(Etype, EvStr, 0, EvT, DeclStream)		-->	functawr(FncStr), "(", argumentsList(ArgLStr, IArgLStr, UArgLStr, IndArgLStr, Index), ")",
							{
								string_concat(FncStr, "(", EvStrPending1),
								string_concat(EvStrPending1, ArgLStr, EvStrPending2),
								string_concat(EvStrPending2, ")", EvStr),
								string_concat("T_", FncStr, EvTPending1),
								string_concat(EvTPending1, "_", EvTPending2),
								string_concat(EvTPending2, IArgLStr, EvT),
								string_concat(EvStrPending1, UArgLStr, DeclReprPending1),
								string_concat(DeclReprPending1, ")", DeclRepr),
								write(DeclStream, "event("), write(DeclStream, DeclRepr), write(DeclStream, ").\n"),
								write(DeclStream, Etype), write(DeclStream, "Entity("), write(DeclStream, DeclRepr), write(DeclStream, ").\n"),
								write(DeclStream, "index("), write(DeclStream, EvStrPending1), write(DeclStream, IndArgLStr), write(DeclStream, "), "), write(DeclStream, Index), write(DeclStream, ").\n\n")
							}.

functawr(FncStr) 						--> 	[Lower], { char_type(Lower, lower) }, restChars(RCList),
									{
										string_codes(FncStr, [Lower|RCList])
									}.

value(ValStr, Str)						-->	"=", functawr(Str),
									{
										string_concat("=", Str, ValStr)
									}.
value("=true", "true")						-->	[].

restChars(Chars)						--> 	string_without([9, 10, 13, 32, 40, 41, 44, 46], Chars).

argumentsList(ArgLStr, IArgLStr, UArgLStr, IndArgLStr, ArgStr)	--> 	argument(ArgStr), moreArguments(MArgStr, IMArgStr, UMArgStr),
									{
										string_concat(ArgStr, MArgStr, ArgLStr),
										string_concat(ArgStr, IMArgStr, IArgLStr),
										string_concat("_", UMArgStr, UArgLStr),
										string_concat(ArgStr, UMArgStr, IndArgLStr)
									}.

argument(ArgStr) 						--> 	[Alpha], { char_type(Alpha, alpha) }, restChars(RCList),
									{
										string_codes(ArgStr, [Alpha|RCList])
									}.

moreArguments(MArgStr, MArgStr, MArgStr)			--> 	[],
									{
										string_codes(MArgStr, [])
									}.
moreArguments(MArgStr, IMArgStr, UMArgStr)			-->	",", argument(ArgStr), moreArguments(MMArgStr, IMMArgStr, UMMArgStr),
									{
										string_concat(",", ArgStr, MArgPending),
										string_concat(MArgPending, MMArgStr, MArgStr),
										string_concat(",_", UMMArgStr, UMArgStr),
										string_concat("_", ArgStr, IMArgPending),
										string_concat(IMArgPending, IMMArgStr, IMArgStr)
									}.

hfBody(BodyStr, I, Priority, DeclStream)			-->	expression(BodyStr, I, Priority, DeclStream).

expression(ExprStr, I, Priority, DeclStream)		-->	component(CompStr, T1, Priority1, DeclStream), moreComponents(MCompStr, T2, and, Priority2, DeclStream),
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
									%addToTail(List, Anon1, NewList),
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
expression(ExprStr, I, Priority, DeclStream)		-->	component(CompStr, T1, Priority1, DeclStream), moreComponents(MCompStr, T2, or, Priority2, DeclStream),
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
expression(ExprStr, I, Priority, DeclStream)		-->	component(ExprStr, I, Priority, DeclStream), moreComponents(null).

moreComponents(MCompStr, I, and, Priority, DeclStream)	-->	",", space, expression(MCompStr, I, Priority, DeclStream).
moreComponents(MCompStr, I, or, Priority, DeclStream)	-->	space, "or", space, expression(MCompStr, I, Priority, DeclStream).
moreComponents(null)				-->	[].

component(CompStr, T, Priority, DeclStream)		-->	fluent("sD", "input", Str, _, Priority, T, DeclStream),
							{
								string_concat(",\n\tholdsFor(", Str, CompStrPending1),
								string_concat(CompStrPending1, ", ", CompStrPending2),
								string_concat(CompStrPending2, T, CompStrPending3),
								string_concat(CompStrPending3, ")", CompStr)
							}.
component(CompStr, T, Priority, DeclStream)		-->	"(", space, expression(CompStr, T, Priority, DeclStream), space, ")".
component(CompStr, T, Priority, DeclStream)		-->	"not", space, expression(Str, ExpT, Priority, DeclStream),
							{
								string_concat(Str, ",\n\tcomplement_all([", CompStrPending3),
								string_concat(CompStrPending3, ExpT, CompStrPending4),
								string_concat(CompStrPending4, "], ", CompStrPending5),
								%string_concat(ExpT, "_COMPL", T),
								nb_getval(intervalNo, Int),
								string_concat("I", Int, T),
								NewInt is Int + 1,
								nb_setval(intervalNo, NewInt),
								string_concat(CompStrPending5, T, CompStrPending6),
								string_concat(CompStrPending6, ")", CompStr)
							}.

itBody(ITBodyStr, Priority, DeclStream)			-->	"happens", space, event("input", CTStr, Priority1, _, DeclStream), moreConditions(MCondStr, Priority2, DeclStream),
							{
								string_concat(",\n\thappensAt(", CTStr, CondStrPending1),
								string_concat(CondStrPending1, ", T)", CondStr),
								string_concat(CondStr, MCondStr, ITBodyStr),
								Priority is Priority1 + Priority2
							}.
itBody(ITBodyStr, Priority, DeclStream)			-->	"start", space, fluent("sD", "input", CTStr, _, Priority1, _, DeclStream), moreConditions(MCondStr, Priority2, DeclStream),
							{
								string_concat(",\n\thappensAt(start(", CTStr, CondStrPending1),
								string_concat(CondStrPending1, "), T)", CondStr),
								string_concat(CondStr, MCondStr, ITBodyStr),
								Priority is Priority1 + Priority2
							}.
itBody(ITBodyStr, Priority, DeclStream)			-->	"end", space, fluent("sD", "input", CTStr, _, Priority1, _, DeclStream), moreConditions(MCondStr, Priority2, DeclStream),
							{
								string_concat(",\n\thappensAt(end(", CTStr, CondStrPending1),
								string_concat(CondStrPending1, "), T)", CondStr),
								string_concat(CondStr, MCondStr, ITBodyStr),
								Priority is Priority1 + Priority2
							}.

condition(CondStr, Priority, DeclStream)			-->	"start", space, fluent("sD", "input", CTStr, _, Priority, _, DeclStream),
							{
								string_concat(",\n\thappensAt(start(", CTStr, CondStrPending1),
								string_concat(CondStrPending1, "), T)", CondStr)
							}.
condition(CondStr, Priority, DeclStream)			-->	"end", space, fluent("sD", "input", CTStr, _, Priority, _, DeclStream),
							{
								string_concat(",\n\thappensAt(end(", CTStr, CondStrPending1),
								string_concat(CondStrPending1, "), T)", CondStr)
							}.
condition(CondStr, Priority, DeclStream)			-->	"happens", space, event("input", CTStr, Priority, _, DeclStream),
							{
								string_concat(",\n\thappensAt(", CTStr, CondStrPending1),
								string_concat(CondStrPending1, ", T)", CondStr)
							}.
condition(CondStr, Priority, DeclStream)			-->	fluent("sD", "input", CTStr, _, Priority, _, DeclStream),
							{
								string_concat(",\n\tholdsAt(", CTStr, CondStrPending1),
								string_concat(CondStrPending1, ", T)", CondStr)
							}.

moreConditions(MCondStr, Priority, DeclStream)		-->	",", space, condition(CondStr, Priority1, DeclStream), moreConditions(MMCondStr, Priority2, DeclStream),
							{
								string_concat(CondStr, MMCondStr, MCondStr),
								Priority is Priority1 + Priority2
							}.
moreConditions("", 0, _)				-->	[].

