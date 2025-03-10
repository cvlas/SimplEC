% @author 	Christos Vlassopoulos
% 		cvlas@iit.demokritos.gr
%

:- [library(dcg/basics)].

:- dynamic atem/1, cachingPriority/2, declared/5, defines/3, graphines/2, head/1, noCaching/1, matchRepr/2, one/1, two/1, three/1.

%:- ['RTEC.prolog'].

% -----------------------------------------------
% AUXILIARY TOOLS
% -----------------------------------------------

% Split a list into its head and the rest.
list_head([H|T], H, T).

% Add an element to the head or the tail of a list.
addToHead(L, H, [H|L]).

addToTail([], E, [E]).
addToTail([H|T], E, [H|L]) :- addToTail(T, E, L).

% Find the Cartesian product of the elements within a list of lists.
prod([],[[]]).
prod([L|Ls],Out) :-
	bagof([X|R],(prod(Ls,O), member(X,L), member(R,O)),Out).

% 
cachingLevel(Node, Level, Path) :-
	addToHead(Path, Node, NewPath),
	findall(Parent, defines(Parent, Node, _), Parents),
	subtract(Parents, NewPath, NewParents),
	(length(NewParents, 0) -> Level is 0
	;
	(findall(L, (member(P, NewParents), cachingLevel(P, L, NewPath)), Levels),
	max_list(Levels, MaxLevel),
	Level is MaxLevel + 1)
	).

% -----------------------------------------------
% FULL COMPILER
% -----------------------------------------------

%compile(SimplECStatements, EventDescription, Declarations, DependencyGraph, CompiledEventDescription) :-
%	simplEC(SimplECStatements, EventDescription, Declarations, DependencyGraph),
%	open(CompiledEventDescription, write, CEDStream),
%	atomics_to_string([":- ['RTEC.prolog'].\n"], Result1),
%	atomics_to_string([":- ['", Declarations, "'].\n\n"], Result2),
%	write(CEDStream, Result1),
%	write(CEDStream, Result2),
%	compileEventDescription(Declarations, EventDescription, CompiledEventDescription).

% -----------------------------------------------
% SIMPL-EC
% -----------------------------------------------

simplEC(InputFile, GraphFontSize, FourArgAtRules) :-
	
	% Prepare files for reading and writing
	split_string(InputFile, ".", "", InputFileTokens),
	list_head(InputFileTokens, InputName, _),
	atomics_to_string([InputName, ".log"], LogFile),
	open(InputFile, read, Input),
	open('declarations.prolog', write, DeclStream),
	open(LogFile, write, LogStream), close(LogStream),
	tell('event_description.prolog'),
	
	% Set auxiliary global variables for interval numbering and logfile production
	nb_setval(intervalNo, 1),
	nb_setval(logFile, LogFile),
	nb_setval(fourArgs, FourArgAtRules),
	
	% Parse and translate the rules into RTEC format
	read_stream_to_codes(Input, Codes),
	phrase(goal, Codes),
	
	% Finalize dependencies
	findall((A, BPrefix, C), (defines(A, B, C), noCaching(B), retract(defines(A, B, C)), split_string(B, "=", "", BParts), list_head(BParts, BPrefix, _)), DefinesPending),
	findall(D, (declared(D, _, _, _, _), split_string(D, "=", "", DParts), list_head(DParts, DPrefix, _), member((A, DPrefix, C), DefinesPending), assertz(defines(A, D, C))), _),
	findall((AG, BGPrefix), (graphines(AG, BG), matchRepr(B, BG), noCaching(B), retract(graphines(AG, BG)), split_string(BG, "=", "", BGParts), list_head(BGParts, BGPrefix, _)), GraphinesPending),
	findall(DG, (declared(D, DG, _, _, _), split_string(DG, "=", "", DGParts), list_head(DGParts, DGPrefix, _), member((AG, DGPrefix), GraphinesPending), assertz(graphines(AG, DG))), _),
	
	% Build declarations:
	% Find all declared entities. Store them in a list and forget everything else about them.
	% Sort declared entities and remove duplicates.
	% If an entity appears in the rules both as an input and an output entity, we consider it an output entity.
	% After having the declared entities filtered, we assert them anew.
	findall(declFact(DeclRepr, GraphRepr, IndRepr, Type, EType), (declared(DeclRepr, GraphRepr, IndRepr, Type, EType), retract(declared(DeclRepr, GraphRepr, IndRepr, Type, EType))), Tuples),
	%forall(member(Tuple, Tuples), (writeln(Tuple))), nl, nl, 
	sort(5, @>=, Tuples, TuplesDistorted),
	%forall(member(TupleD, TuplesDistorted), (writeln(TupleD))), nl, nl,
	sort(1, @<, TuplesDistorted, TuplesSorted),
	%forall(member(TupleS, TuplesSorted), (writeln(TupleS))), nl, nl,
	forall(member(declFact(DeclRepr, GraphRepr, IndRepr, Type, EType), TuplesSorted), assertz(declared(DeclRepr, GraphRepr, IndRepr, Type, EType))),
	
	% Find and print all input events.
	findall((DeclRepr, GraphRepr, IndRepr, "event", "input"),
		(declared(DeclRepr, GraphRepr, IndRepr, "event", "input"),
		atomics_to_string(["event(", DeclRepr, ").\tinputEntity(", DeclRepr, ").\tindex(", IndRepr, ").\n"], "", OutStr),
		write(DeclStream, OutStr)),
		_), nl(DeclStream),
	
	% Find and print all input SDF's.
	findall((DeclRepr, GraphRepr, IndRepr, "sD", "input"),
		(declared(DeclRepr, GraphRepr, IndRepr, "sD", "input"),
		atomics_to_string(["sDFluent(", DeclRepr, ").\tinputEntity(", DeclRepr, ").\tindex(", IndRepr, ").\n"], "", OutStr),
		write(DeclStream, OutStr)),
		_), nl(DeclStream),
	
	% Find and print all output events.
	findall((DeclRepr, GraphRepr, IndRepr, "event", "output"),
		(declared(DeclRepr, GraphRepr, IndRepr, "event", "output"),
		atomics_to_string(["event(", DeclRepr, ").\toutputEntity(", DeclRepr, ").\tindex(", IndRepr, ").\n"], "", OutStr),
		write(DeclStream, OutStr)),
		_), nl(DeclStream),
	
	% Find and print all Simple Fluents.
	findall((DeclRepr, GraphRepr, IndRepr, "simple", "output"),
		(declared(DeclRepr, GraphRepr, IndRepr, "simple", "output"),
		atomics_to_string(["simpleFluent(", DeclRepr, ").\toutputEntity(", DeclRepr, ").\tindex(", IndRepr, ").\n"], "", OutStr),
		write(DeclStream, OutStr)),
		_), nl(DeclStream),
	
	% Find and print all output SDF's.
	findall((DeclRepr, GraphRepr, IndRepr, "sD", "output"),
		(declared(DeclRepr, GraphRepr, IndRepr, "sD", "output"),
		atomics_to_string(["sDFluent(", DeclRepr, ").\toutputEntity(", DeclRepr, ").\tindex(", IndRepr, ").\n"], "", OutStr),
		write(DeclStream, OutStr)),
		_), nl(DeclStream),
	
	% CollectIntervals...
	findall(Result, (one(Result), write(DeclStream, Result)), _),nl(DeclStream),
	
	% BuildFromPoints...
	findall(Result, (two(Result), write(DeclStream, Result)), _),nl(DeclStream),
	
	% Grounding...
	findall(Result, (three(Result), write(DeclStream, Result)), _),nl(DeclStream),
	
	% For each output entity (among those that have not been flagged as "noCaching") find its level in the caching hierarchy
	% Sort by caching priority value, in ascending order and print in the declarations file
	findall(cachingHierarchy(Node, Level), (declared(Node, _, _, _, "output"), \+ noCaching(Node), cachingLevel(Node, Level, [])), CachingUnordered),
	%forall(member(Tuple, CachingUnordered), (writeln(Tuple))), nl, nl, 
	sort(1, @<, CachingUnordered, CachingSorted),
	%forall(member(Tuple, CachingSorted), (writeln(Tuple))), nl, nl, 
	sort(2, @=<, CachingSorted, CachingOrdered),
	%forall(member(Tuple, CachingOrdered), (writeln(Tuple))), nl, nl, 
	findall(H,
		(member(cachingHierarchy(H, Q), CachingOrdered),
		atomics_to_string(["cachingOrder(", H, ").\t%", Q, "\n"], "", Out),
		write(DeclStream, Out)),
		_),
	told,
	close(Input), close(DeclStream),
	
	% Dependency graph preparation:
	% Create a mapping of the form Q -> {H1, H2, ..., Hn}
	% where Q is a caching priority value and {H1, H2, ..., Hn} are the entities
	% that have Q as their caching priority value
	% (input entities are considered to have Q = 0)
	findall((AG, B), (matchRepr(A, AG), \+ noCaching(A), cachingLevel(A, B, [])), AllCachingLevels),
	%forall(member(ACL, AllCachingLevels), writeln(ACL)), nl,
	findall(Q, member((_, Q), AllCachingLevels), QS),
	findall(H, member((H, _), AllCachingLevels), HS),
	%findall(H0, (declared(H0, _, _, _), \+ member(cachingHierarchy(H0, _), CachingOrdered)), H0S),
	pairs_keys_values(QHS, QS, HS),
	%forall(member(Pair, QHS), writeln(Pair)), nl,
	sort(QHS, QHSS),
	%forall(member(PairS, QHSS), writeln(PairS)), nl,
	group_pairs_by_key(QHSS, QLSS),
	%forall(member(PairL, QLSS), writeln(PairL)), nl,
	pairs_keys_values(QLSS, List1, List2),
	findall((L1, L2), (member(L1, List1), nth1(Index, List1, L1), nth1(Index, List2, L2)), FinalList),
	%forall(member(PairF, FinalList), writeln(PairF)), nl,
	%addToHead(AlmostFinalList, (0, H0S), FinalList),
	
	% Dependency graph generation:
	% Use the mapping above to group entities of the same caching level together in the graph.
	% Use the existing dependencies to add directed edges to the graph.
	tell('dependency_graph.txt'),
	write("digraph\n{\n\tnode [shape=Mrecord, fontsize="), write(GraphFontSize), write("];\n\trankdir=LR;\n\tranksep=\"1.2 equally\"\n\n"),
	forall(member((Q, L), FinalList), (findall(LabelPart, (member(Part, L), atomics_to_string(["<", Part, "> ", Part], LabelPart)), LabelParts), atomics_to_string(LabelParts, "|", Label), atomics_to_string(["\t", Q, " [label=\"", Label, "\"];\n"], Line), write(Line))),nl,
	%findall(edge(CI, I, CJ, J), (defines(I, J, _), member((J, CJ), CachingOrdered), (member((I, CI), CachingOrdered) -> true ; CI is 0)), Edges),
	findall(edge(CI, IG, CJ, JG), (graphines(IG, JG), matchRepr(I, IG), matchRepr(J, JG), cachingLevel(I, CI, []), cachingLevel(J, CJ, [])), Edges),
	sort(Edges, EdgesSorted),
	forall(member(edge(CK, K, CL, L), EdgesSorted), (write("\t"), write(CK), write(":\""), write(K), write("\" -> "), write(CL), write(":\""), write(L), writeln("\""))),
	write("}\n"),
	told, !.

% -----------------------------------------------
% DEFINITE CLAUSE GRAMMAR
% -----------------------------------------------

space(NPP)		--> 	spaceChar, space(N),
				{
					NPP is N + 1
				}.
space(0)		-->	[].

spaceChar		-->	" ".
spaceChar		-->	"\t".
spaceChar		-->	"\n".
spaceChar		-->	"\r".

goal			--> 	space(_), ceDefinition, space(_), goal.
goal			--> 	[].

% All possible statements in our dialect.
ceDefinition		-->	atemporalPredicates.
ceDefinition		-->	multivaluedFluents.
ceDefinition		-->	initially.
ceDefinition		-->	atRule.
ceDefinition		-->	forRule.
ceDefinition		-->	collectIntervals.
ceDefinition		-->	buildFromPoints.
ceDefinition		-->	grounding.
ceDefinition		-->	string_without([46], ErrRule), ".",
				{
					% Write error message in log file
					string_codes(ErrRuleStr, ErrRule),
					nb_getval(logFile, LogFile),
					open(LogFile, append, LogStream),
					write(LogStream, "IN RULE:\n"),
					write(LogStream, ErrRuleStr),
					write(LogStream, "\nERROR: Unknown event pattern detected.\nPlease check your syntax.\n\n"),
					close(LogStream)
				}.

% Statements that declare atemporal predicates.			
atemporalPredicates	-->	"atemporal:", space(_), functawr(FncStr), moreFacts, ".",
				{
					assertz(atem(FncStr))
				}.
				
moreFacts		-->	space(_), ",", space(_), functawr(FncStr), moreFacts,
				{
					assertz(atem(FncStr))
				}.
moreFacts		-->	"".

% Statements that declare fluents that have values other than "true" and "false".	
multivaluedFluents	-->	"multivalued:", space(_), multivaluedFluent, moremultivaluedFluents, ".".

moremultivaluedFluents	-->	space(_), ",", space(_), multivaluedFluent, moremultivaluedFluents.
moremultivaluedFluents	-->	"".

multivaluedFluent	-->	functawr(FncStr), "(", argumentsList(_, _, GArgLStr, IndArgLStr, Index, _), ")", space(_), "=", space(_), list(_, List),
				{
					atomics_to_string([FncStr, "(", GArgLStr, ")"], "", DeclRePrefix),
					
					forall(member(ValStr, List), 
					
					(atomics_to_string([DeclRePrefix, "=", ValStr], "", DeclRepr),
					atomics_to_string([FncStr, "(", GArgLStr, ")=", ValStr], "", GraphRepr),
					atomics_to_string([FncStr, "(", IndArgLStr, ")=", ValStr, ", ", Index], "", IndRepr),
					
					assertz(declared(DeclRepr, GraphRepr, IndRepr, "sD", "input"))))
				}.

% Statements that declare which fluents should have their intervals collected.	
collectIntervals	-->	"collectIntervals:", space(_), fluent("sD", "input", CTStr, _, _, _, _, _, _), moreCIFluents(MFStr), ".",
				{
					atomics_to_string(["collectIntervals(", CTStr, ").\n", MFStr], Result),
					assertz(one(Result))
				}.

moreCIFluents(MFStr)	-->	space(_), ",", space(_), fluent("sD", "input", CTStr, _, _, _, _, _, _), moreCIFluents(MMFStr),
				{
					atomics_to_string(["collectIntervals(", CTStr, ").\n", MMFStr], MFStr)
				}.
moreCIFluents("")	-->	[].

% Statements that declare which fluents should have their intervals built from timepoints.	
buildFromPoints		-->	"buildFromPoints:", space(_), fluent("sD", "input", CTStr, _, _, _, _, _, _), moreBPFluents(MFStr), ".",
				{
					atomics_to_string(["buildFromPoints(", CTStr, ").\n", MFStr], Result),
					assertz(two(Result))
				}.

moreBPFluents(MFStr)	-->	space(_), ",", space(_), fluent("sD", "input", CTStr, _, _, _, _, _, _), moreBPFluents(MMFStr),
				{
					atomics_to_string(["buildFromPoints(", CTStr, ").\n", MMFStr], MFStr)
				}.
moreBPFluents("")	-->	[].

% Statements that declare the groundings.
grounding		--> 	"grounding:", space(_), string_without([45], Thingy), "-->", space(_), string_without([46], Fact), ".",
				{
					string_codes(ThingyStr, Thingy),
					split_string(ThingyStr, "", " \t\n", [ClearThingyStr]),
					string_codes(FactStr, Fact),
					atomics_to_string(["grounding(", ClearThingyStr, ")\t:-\t", FactStr, ".\n"], Result),
					assertz(three(Result))
				}.

% The "initially" statement.
initially		-->	"initially", space(N), {N > 0}, fluent("simple", "output", CTStr, _, _, _, _, null, null), ".",
				{
					atomics_to_string(["initially(", CTStr, ").\n\n"], "", InitiallyStr),
					write(InitiallyStr)
				}.

% The "holdsFor" statement.	
forRule			--> 	forHead(Head, HeadDeclRepr, HeadGraphRepr), space(_), sep, space(_), {nb_setval(intervalNo, 1)}, forBody(Body, HeadDeclRepr, HeadGraphRepr), ".",
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
					
					split_string(HeadDeclRepr, "=", "", Parts),
					list_head(Parts, _, [Value]),
					string_codes(Value, ValueCodes),
					list_head(ValueCodes, First, _),
					(char_type(First, lower) -> true
					;
					assertz(noCaching(HeadDeclRepr)))
				}.

% "initiatedAt", "terminatedAt", and "happensAt" statements.
atRule			-->	atHead(Head, HeadDeclRepr, HeadGraphRepr), space(_), sep, space(_), atBody(EntireBody, _, HeadDeclRepr, HeadGraphRepr), ".",
				{
					split_string(EntireBody, "^", "", BodyParts),
					findall(Body,
					(member(Body, BodyParts),
					string_codes(Body, BodyCodes),
					list_head(BodyCodes, _, CommaFreeBodyCodes),
					string_codes(CommaFreeBody, CommaFreeBodyCodes),
					write(Head), write(" :-"), write(CommaFreeBody), write(".\n\n")),
					_),
					
					split_string(HeadDeclRepr, "=", "", Parts),
					length(Parts, Length),
					(Length = 2 ->
					(list_head(Parts, _, [Value]),
					string_codes(Value, ValueCodes),
					list_head(ValueCodes, First, _),
					(char_type(First, lower) -> true
					;
					assertz(noCaching(HeadDeclRepr))))
					;
					true)
				}.
	
sep			--> 	"iff".
sep			--> 	"if".

% The head of a "holdsFor" statement.
forHead(HeadStr, DeclRepr, GraphRepr)	--> 	fluent("sD", "output", CTStr, DeclRepr, GraphRepr, _, _, null, null),
						{
							atomics_to_string(["holdsFor(", CTStr, ", I)"], "", HeadStr)
						}.

% The head of an "initiatedAt", "terminatedAt", or "happensAt" statement.
atHead(HeadStr, DeclRepr, GraphRepr)	--> 	"initiate", space(N), {N > 0}, fluent("simple", "output", CTStr, DeclRepr, GraphRepr, _, _, null, null),
						{
							nb_getval(fourArgs, FA),
							(FA -> atomics_to_string(["initiatedAt(", CTStr, ", T1, T, T2)"], "", HeadStr)
							;
							atomics_to_string(["initiatedAt(", CTStr, ", T)"], "", HeadStr))
						}.
atHead(HeadStr, DeclRepr, GraphRepr)	--> 	"terminate", space(N), {N > 0}, fluent("simple", "output", CTStr, DeclRepr, GraphRepr, _, _, null, null),
						{
							nb_getval(fourArgs, FA),
							(FA -> atomics_to_string(["terminatedAt(", CTStr, ", T1, T, T2)"], "", HeadStr)
							;
							atomics_to_string(["terminatedAt(", CTStr, ", T)"], "", HeadStr))
						}.
atHead(HeadStr, DeclRepr, GraphRepr)	--> 	"happens", space(N), {N > 0}, event("output", EvStr, DeclRepr, GraphRepr, _, null, null),
						{
							atomics_to_string(["happensAt(", EvStr, ", T)"], "", HeadStr)
						}.

% A fluent
fluent(Type, Etype, CTStr, DeclRepr, GraphRepr, _, I, HeadDeclRepr, HeadGraphRepr)	--> 	functawr(FncStr), "(", argumentsList(ArgLStr, UArgLStr, GArgLStr, IndArgLStr, Index, _), ")", space(_), value(ValStr, VType), !,
												{
													\+ atem(FncStr),
													atomics_to_string([FncStr, "(", ArgLStr, ")", ValStr], "", CTStr),
													atomics_to_string([FncStr, "(", UArgLStr, ")"], "", DeclRePrefix),
													atomics_to_string([DeclRePrefix, ValStr], "", DeclRepr),
													atomics_to_string([FncStr, "(", GArgLStr, ")", ValStr], "", GraphRepr),
													atomics_to_string([FncStr, "(", IndArgLStr, ")", ValStr, ", ", Index], "", IndRepr),
	
													nb_getval(intervalNo, Int),
													string_concat("I", Int, I),
													NewInt is Int + 1,
													nb_setval(intervalNo, NewInt),
	
													(
														declared(DeclRepr, GraphRepr, IndRepr, Type, Etype) -> true
														;
														(
															VType = var -> findall((D, G, Ind), (declared(D, G, Ind, _, _), split_string(D, "=", " ", [DeclRePrefix|_]), assertz(declared(D, G, Ind, Type, Etype))), _)
															;
															(
																HeadDeclRepr = null -> assertz(declared(DeclRepr, GraphRepr, IndRepr, Type, Etype))
																;
																(
																	% Ψάξε και βρες αν υπάρχει κάποιο output entity με το ίδιο όνομα, την ίδια τιμή και το ίδιο πλήθος ορισμάτων.
																	% Aν υπάρχει, τότε κάνε assertz το τρέχον fluent σαν output entity.
					
																	split_string(DeclRepr, "()=,", ")= ", DeclReprParts),
																	list_head(DeclReprParts, DeclReprFunctor, DeclReprRest),
																	last(DeclReprRest, DeclReprValue),
					
																	((declared(HD, _, _, HT, "output"),
																	split_string(HD, "()=,", ")= ", HDParts),
																	same_length(HDParts, DeclReprParts),
																	list_head(HDParts, DeclReprFunctor, HDRest),
																	last(HDRest, DeclReprValue)) -> assertz(declared(DeclRepr, GraphRepr, IndRepr, HT, "output"))
																	;
																	assertz(declared(DeclRepr, GraphRepr, IndRepr, Type, Etype)))
																)
															)
														)
													),
	
													(
														(HeadDeclRepr = null, HeadGraphRepr = null) -> assertz(head(DeclRepr))
														;
														(
															split_string(HeadDeclRepr, "=", "", Parts),
															length(Parts, Length),
															(
																Length = 2 ->
																(
																	list_head(Parts, HeadDeclRePrefix, [Value]),
																	string_codes(Value, ValueCodes),
																	list_head(ValueCodes, First, _),
																	(
																		%atomics_to_string(["\nCurrently examining char: ", First, ", from head fluent ", HeadDeclRepr], "", Message1),
																		%write(Message1),
																		char_type(First, upper) ->
																		(
																			findall((Hi, Gi, In, Ti, Ei), (declared(Hi, Gi, In, Ti, Ei), sub_string(Hi, 0, _, _, HeadDeclRePrefix), assertz(defines(DeclRepr, Hi, _)), assertz(graphines(GraphRepr, Hi))), _)
																		)
																		;
																		(
																			%atomics_to_string(["\nFluent ", HeadDeclRepr, " has a normal value. Creating regular dependencies...\n"], "", Message3),
																			%write(Message3),
																			assertz(defines(DeclRepr, HeadDeclRepr, _)),
																			assertz(graphines(DeclRepr, HeadDeclRepr))
																		)
																	)
																)
																;
																(
																	%atomics_to_string(["\nObject ", HeadDeclRepr, " does not have a value. Must be an event.\n"], "", Message4),
																	%write(Message4),
																	assertz(defines(DeclRepr, HeadDeclRepr, _)),
																	assertz(graphines(DeclRepr, HeadDeclRepr))
																)
															)
														)
													),
	
													(matchRepr(DeclRepr, GraphRepr) -> true
													;
													assertz(matchRepr(DeclRepr, GraphRepr)))
												}.

% An event
event(Etype, EvStr, DeclRepr, GraphRepr, _, HeadDeclRepr, HeadGraphRepr)		-->	functawr(FncStr), "(", argumentsList(ArgLStr, UArgLStr, GArgLStr, IndArgLStr, Index, _), ")",
												{
													atomics_to_string([FncStr, "(", ArgLStr, ")"], "", EvStr),
													atomics_to_string([FncStr, "(", UArgLStr, ")"], "", DeclRepr),
													atomics_to_string([FncStr, "(", GArgLStr, ")"], "", GraphRepr),
													atomics_to_string([FncStr, "(", IndArgLStr, "), ", Index], "", IndRepr),

													(
														declared(DeclRepr, GraphRepr, IndRepr, "event", Etype) -> true
														;
														(
															HeadDeclRepr = null -> assertz(declared(DeclRepr, GraphRepr, IndRepr, "event", Etype))
															;
															(
																% Ψάξε και βρες αν υπάρχει κάποιο output event με το ίδιο όνομα και το ίδιο πλήθος ορισμάτων.
																% Aν υπάρχει, τότε κάνε assertz το τρέχον event σαν output entity.
				
																split_string(DeclRepr, "()=,", ")= ", DeclReprParts),
																list_head(DeclReprParts, DeclReprFunctor, _),
				
																((declared(HD, _, _, "event", "output"),
																split_string(HD, "()=,", ")= ", HDParts),
																same_length(HDParts, DeclReprParts),
																list_head(HDParts, DeclReprFunctor, _)) -> assertz(declared(DeclRepr, GraphRepr, IndRepr, "event", "output"))
																;
																assertz(declared(DeclRepr, GraphRepr, IndRepr, "event", Etype)))
															)
														)
													),
	
													(
														(HeadDeclRepr = null, HeadGraphRepr = null) -> assertz(head(DeclRepr))
														;
														(
															%atomics_to_string(["Currently examining event: ", HeadDeclRepr, ""], "", Message5),
															%write(Message5),
															split_string(HeadDeclRepr, "=", "", Parts),
															length(Parts, Length),
															(
																Length = 2 ->
																(
																	list_head(Parts, HeadDeclRePrefix, [Value]),
																	string_codes(Value, ValueCodes),
																	list_head(ValueCodes, First, _),
																	(
																		%atomics_to_string(["\nCurrently examining char: ", First, ", from head event ", HeadDeclRepr], "", Message1),
																		%write(Message1),
																		char_type(First, upper) ->
																		(
																			findall((Hi, Gi, In, Ti, Ei), (declared(Hi, Gi, In, Ti, Ei), sub_string(Hi, 0, _, _, HeadDeclRePrefix), assertz(defines(DeclRepr, Hi, _)), assertz(graphines(GraphRepr, Hi))), _)
																		)
																		;
																		(
																			%atomics_to_string(["\nFluent ", HeadDeclRepr, " has a normal value. Creating regular dependencies...\n"], "", Message3),
																			%write(Message3),
																			assertz(defines(DeclRepr, HeadDeclRepr, _)),
																			assertz(graphines(DeclRepr, HeadDeclRepr))
																		)
																	)
																)
																;
																(
																	%atomics_to_string(["\nObject ", HeadDeclRepr, " does not have a value. Must be an event.\n"], "", Message4),
																	%write(Message4),
																	assertz(defines(DeclRepr, HeadDeclRepr, _)),
																	assertz(graphines(DeclRepr, HeadDeclRepr))
																)
															)
														)
													),
	
													(matchRepr(DeclRepr, GraphRepr) -> true
													;
													assertz(matchRepr(DeclRepr, GraphRepr)))
												}.

functawr(FncStr)	--> 	[Lower], { char_type(Lower, lower) }, restChars(RCList),
				{
					string_codes(FncStr, [Lower|RCList])
				}.
	
variable(VarStr)	-->	[Upper], { char_type(Upper, upper) }, restChars(RCList),
				{
					string_codes(VarStr, [Upper|RCList])
				}.
variable(VarStr)	-->	"_", restChars(RCList),
				{
					string_codes(RCStr, RCList),
					string_concat("_", RCStr, VarStr)
				}.

value(ValStr, var)	-->	"=", space(_), variable(ArgStr),
				{
					string_concat("=", ArgStr, ValStr)
				}.
value(ValStr, var)	-->	"=", space(_), tuple(ArgStr, List),
				{
					list_head(List, First, _),
					string_codes(First, FirCd),
					list_head(FirCd, F, _),
					char_type(F, upper),
					string_concat("=", ArgStr, ValStr)
				}.
value(ValStr, val)	-->	"=", space(_), functawr(ArgStr),
				{
					string_concat("=", ArgStr, ValStr)
				}.
value(ValStr, val)	-->	"=", space(_), number(ArgStr),
				{
					string_concat("=", ArgStr, ValStr)
				}.
value(ValStr, val)	-->	"=", space(_), numUnit(ArgStr),
				{
					string_concat("=", ArgStr, ValStr)
				}.
value(ValStr, val)	-->	"=", space(_), tuple(ArgStr, _),
				{
					string_concat("=", ArgStr, ValStr)
				}.
value("=true", val)	-->	[].

restChars(Chars)	--> 	string_without([9, 10, 13, 32, 40, 41, 44, 46, 91, 93], Chars).

argumentsList(ArgLStr, UArgLStr, GArgLStr, IndArgLStr, "X", ArgList)		--> 	"_", moreArguments(MArgStr, UMArgStr, GMArgStr, MArgList),
											{
												string_concat("_", MArgStr, ArgLStr),
												string_concat("_", UMArgStr, UArgLStr),
												string_concat("_", GMArgStr, GArgLStr),
												string_concat("X", UMArgStr, IndArgLStr),
												addToHead(MArgList, "_", ArgList)
											}.
argumentsList(ArgLStr, UArgLStr, GArgLStr, IndArgLStr, ArgStr, ArgList)		--> 	argument(ArgStr), moreArguments(MArgStr, UMArgStr, GMArgStr, MArgList),
											{
												string_concat(ArgStr, MArgStr, ArgLStr),
												string_concat("_", UMArgStr, UArgLStr),
	
												string_codes(ArgStr, ArgCod),
												list_head(ArgCod, First, _),
												(char_type(First, lower) -> string_concat(ArgStr, GMArgStr, GArgLStr)
												;
												(char_type(First, digit) -> string_concat(ArgStr, GMArgStr, GArgLStr)
												;
												string_concat("_", GMArgStr, GArgLStr))),
										
												string_concat(ArgStr, UMArgStr, IndArgLStr),
												addToHead(MArgList, ArgStr, ArgList)
											}.

argument(ArgStr) 	--> 	functawr(ArgStr).
argument(ArgStr) 	--> 	variable(ArgStr).
argument(ArgStr) 	--> 	number(ArgStr).
argument(ArgStr) 	--> 	list(ArgStr, _).
argument(ArgStr) 	--> 	tuple(ArgStr, _).

moreArguments(MArgStr, MArgStr, MArgStr, [])		--> 	[],
								{
									string_codes(MArgStr, [])
								}.
moreArguments(MArgStr, UMArgStr, GMArgStr, MArgList)	-->	",", space(_), argument(ArgStr), moreArguments(MMArgStr, UMMArgStr, GMMArgStr, MMArgList),
								{
									atomics_to_string([",", ArgStr, MMArgStr], "", MArgStr),
									string_concat(",_", UMMArgStr, UMArgStr),

									string_codes(ArgStr, ArgCod),
									list_head(ArgCod, First, _),
									(char_type(First, lower) -> atomics_to_string([",", ArgStr, GMMArgStr], "", GMArgStr)
									;
									(char_type(First, digit) -> atomics_to_string([",", ArgStr, GMMArgStr], "", GMArgStr)
									;
									string_concat(",_", GMMArgStr, GMArgStr))),
									addToHead(MMArgList, ArgStr, MArgList)
								}.
moreArguments(MArgStr, UMArgStr, GMArgStr, MArgList)	-->	",", space(_), "_", moreArguments(MMArgStr, UMMArgStr, GMMArgStr, MMArgList),
								{
									string_concat(",_", MMArgStr, MArgStr),
									string_concat(",_", UMMArgStr, UMArgStr),
									string_concat(",_", GMMArgStr, GMArgStr),
									addToHead(MMArgList, "_", MArgList)
								}.

% The body of a "holdsFor" statement
forBody(FinalBodyStr, HeadDeclRepr, HeadGraphRepr)	-->	conjunction(BodyStr, _, HeadDeclRepr, HeadGraphRepr), possibleConstraint(PCStr, _),
								{
									atomics_to_string([BodyStr, PCStr], "", FinalBodyStr)
								}.
forBody(FinalBodyStr, HeadDeclRepr, HeadGraphRepr)	-->	disjunction(BodyStr, _, HeadDeclRepr, HeadGraphRepr), possibleConstraint(PCStr, _),
								{
									atomics_to_string([BodyStr, PCStr], "", FinalBodyStr)
								}.

conjunction(CStr, IC, HeadDeclRepr, HeadGraphRepr)	-->	cTerm(CTStr, ICT, HeadDeclRepr, HeadGraphRepr), moreCTerms(MCTStr, IMCT, HeadDeclRepr, HeadGraphRepr),
								{
									IMCT \= [],
	
									addToHead(IMCT, ICT, IMMCT),
									atomics_to_string([CTStr, MCTStr], "", MMCTStr),
	
									split_string(MMCTStr, "\n", ",\t\n", MMCTSubStrs),
									findall((Term, VNames), (member(MMCTSub, MMCTSubStrs), term_string(Term, MMCTSub, [variable_names(VNames)])), Terms),

									%Step 1
									findall(ICU,
									(
										member(ICI, IMMCT),
										atom_string(ICIAtom, ICI), 
										member((complement_all([ICUVar], ICIVar), [ICUAtom=ICUVar, ICIAtom=ICIVar]), Terms),
										\+ var(ICUAtom),
										atom_string(ICUAtom, ICU)
									), 
									ICUS),
									with_output_to(string(ICUSStr), write(ICUS)),
					
									findall(ICI,
									(
										member(ICI, IMMCT), 
										atom_string(ICIAtom, ICI), 
										member((complement_all([_], ICIVar), [_=_, ICIAtom=ICIVar]), Terms)
									), 
									ICIS),
					
									%Step 2
									findall((complement_all([ICUVar], ICIVar), [ICUAtom=ICUVar, ICIAtom=ICIVar]),
									(
										member(ICU, ICUS), 
										atom_string(ICUAtom, ICU), 
										member((complement_all([ICUVar], ICIVar), [ICUAtom=ICUVar, ICIAtom=ICIVar]), Terms)
									),
									Delete),
									subtract(Terms, Delete, NewTerms),
									findall(S, (member((T, V), NewTerms), term_string(T, S, [variable_names(V)])), BodyStrSplit),
									atomics_to_string(BodyStrSplit, ",\n\t", BodyStrPending),
					
									%Step 3
									subtract(IMMCT, ICIS, ComplementFreeIntersection),
									with_output_to(string(ComplementFreeIntersectionStr), write(ComplementFreeIntersection)),
	
									(
										(ICUS \= [], ComplementFreeIntersection \= []) -> 
										(
											length(ComplementFreeIntersection, 1) ->
											(
												list_head(ComplementFreeIntersection, ComplementFreeInterval, []),
												list_head(ICIS, IFB2, []),
				
												atomics_to_string([BodyStrPending], "", FBStr1),
												atomics_to_string([",\n\t", "relative_complement_all(", ComplementFreeInterval, ", ", ICUSStr, ", ", IFB2, ")"], "", FBStr2),
												string_concat(IFB2, "", IC)
											)
											;
											(
												nb_getval(intervalNo, Int),
												NewInt is Int + 1,
												NewerInt is NewInt + 1,
												nb_setval(intervalNo, NewerInt),
												string_concat("I", Int, IFB1),
												string_concat("I", NewInt, IFB2),
				
												atomics_to_string([BodyStrPending, ",\n\t", "intersect_all(", ComplementFreeIntersectionStr, ", ", IFB1, ")"], "", FBStr1),
												atomics_to_string([",\n\t", "relative_complement_all(", IFB1, ", ", ICUSStr, ", ", IFB2, ")"], "", FBStr2),
												string_concat(IFB2, "", IC)
											)
										)
										;
										(
											nb_getval(intervalNo, Int),
											NewInt is Int + 1,
											nb_setval(intervalNo, NewInt),
											string_concat("I", Int, IFB2),
			
											atomics_to_string([BodyStrPending], "", FBStr1),
			
											(ComplementFreeIntersection = [] -> atomics_to_string([",\n\t", "intersect_all(", ICUSStr, ", ", IFB2, ")"], "", FBStr2);
											atomics_to_string([",\n\t", "intersect_all(", ComplementFreeIntersectionStr, ", ", IFB2, ")"], "", FBStr2)),
			
											string_concat(IFB2, "", IC)
										)
									),
	
									atomics_to_string([FBStr1, FBStr2], "", CStr)
								}.

moreCTerms(MMCTStr, IMMCT, HeadDeclRepr, HeadGraphRepr)	-->	",", space(_), cTerm(CTStr, ICT, HeadDeclRepr, HeadGraphRepr), moreCTerms(MCTStr, IMCT, HeadDeclRepr, HeadGraphRepr),
								{
									addToHead(IMCT, ICT, IMMCT),
									atomics_to_string([CTStr, MCTStr], "", MMCTStr)
								}.
moreCTerms("", [], _, _)				-->	[].

cTerm(CTStr, ICT, HeadDeclRepr, HeadGraphRepr)		-->	fluent("sD", "input", Str, _, _, _, ICT, HeadDeclRepr, HeadGraphRepr),
								{
									atomics_to_string([",\n\t", "holdsFor(", Str, ", ", ICT, ")"], "", CTStr)
								}.
cTerm(CTStr, ICT, HeadDeclRepr, HeadGraphRepr)		-->	"(", disjunction(CTStr, ICT, HeadDeclRepr, HeadGraphRepr), ")".
cTerm(CTStr, ICT, HeadDeclRepr, HeadGraphRepr)		-->	"not", space(_), "(", conjunction(CStr, IC, HeadDeclRepr, HeadGraphRepr), ")",
								{
									nb_getval(intervalNo, Int),
									NewInt is Int + 1,
									nb_setval(intervalNo, NewInt),
									string_concat("I", Int, ICT),
									atomics_to_string([CStr, ",\n\t", "complement_all([", IC, "], ", ICT, ")"], "", CTStr)
								}.
cTerm(CTStr, ICT, HeadDeclRepr, HeadGraphRepr)		-->	"not", space(_), "(", disjunction(DStr, ID, HeadDeclRepr, HeadGraphRepr), ")",
								{
									nb_getval(intervalNo, Int),
									NewInt is Int + 1,
									nb_setval(intervalNo, NewInt),
									string_concat("I", Int, ICT),
									atomics_to_string([DStr, ",\n\t", "complement_all([", ID, "], ", ICT, ")"], "", CTStr)
								}.

disjunction(DStr, ID, HeadDeclRepr, HeadGraphRepr)	-->	dTerm(DTStr, IDT, HeadDeclRepr, HeadGraphRepr), moreDTerms(MDTStr, IMDT, HeadDeclRepr, HeadGraphRepr),
								{
									(IMDT \= [] -> 
									(addToHead(IMDT, IDT, IMMDT),
									with_output_to(string(IMMDTStr), write(IMMDT)),
									nb_getval(intervalNo, Int),
									NewInt is Int + 1,
									nb_setval(intervalNo, NewInt),
									string_concat("I", Int, ID),
									atomics_to_string([DTStr, ",\n\t", MDTStr, ",\n\t", "union_all(", IMMDTStr, ", ", ID, ")"], "", DStr))
									;
									atomics_to_string([DTStr], "", DStr))
								}.

moreDTerms(MMDTStr, IMMDT, HeadDeclRepr, HeadGraphRepr)	-->	space(_), "or", space(_), dTerm(DTStr, IDT, HeadDeclRepr, HeadGraphRepr), moreDTerms(MDTStr, IMDT, HeadDeclRepr, HeadGraphRepr),
								{
									addToHead(IMDT, IDT, IMMDT),
									atomics_to_string([DTStr, ",\n\t", MDTStr], "", MMDTStr)
								}.
moreDTerms("", [], _, _)				-->	[].

dTerm(DTStr, IDT, HeadDeclRepr, HeadGraphRepr)		-->	fluent("sD", "input", Str, _, _, _, IDT, HeadDeclRepr, HeadGraphRepr),
								{
									atomics_to_string([",\n\t", "holdsFor(", Str, ", ", IDT, ")"], "", DTStr)
								}.
dTerm(CTStr, ICT, HeadDeclRepr, HeadGraphRepr)		-->	"not", space(N), {N > 0}, fluent("sD", "input", Str, _, _, _, IC, HeadDeclRepr, HeadGraphRepr),
								{
									atomics_to_string([",\n\t", "holdsFor(", Str, ", ", IC, ")"], "", CStr),
									nb_getval(intervalNo, Int),
									NewInt is Int + 1,
									nb_setval(intervalNo, NewInt),
									string_concat("I", Int, ICT),
									atomics_to_string([CStr, ",\n\t", "complement_all([", IC, "], ", ICT, ")"], "", CTStr)
								}.
dTerm(DTStr, IDT, HeadDeclRepr, HeadGraphRepr)		-->	"(", conjunction(DTStr, IDT, HeadDeclRepr, HeadGraphRepr), ")".
dTerm(DTStr, IDT, HeadDeclRepr, HeadGraphRepr)		-->	"not", space(_), "(", conjunction(CStr, IC, HeadDeclRepr, HeadGraphRepr), ")",
								{
									nb_getval(intervalNo, Int),
									NewInt is Int + 1,
									nb_setval(intervalNo, NewInt),
									string_concat("I", Int, IDT),
									atomics_to_string([CStr, ",\n\t", "complement_all([", IC, "], ", IDT, ")"], "", DTStr)
								}.
dTerm(DTStr, IDT, HeadDeclRepr, HeadGraphRepr)		-->	"not", space(_), "(", disjunction(DStr, ID, HeadDeclRepr, HeadGraphRepr), ")",
								{
									nb_getval(intervalNo, Int),
									NewInt is Int + 1,
									nb_setval(intervalNo, NewInt),
									string_concat("I", Int, IDT),
									atomics_to_string([DStr, ",\n\t", "complement_all([", ID, "], ", IDT, ")"], "", DTStr)
								}.

possibleConstraint(Str, I)				-->	",", space(_), constraint(Str, I).
possibleConstraint("", _)				-->	"".

% A constraint (either concerning the duration of a fluent or atemporal)
constraint(PStr, Int)					-->	durationConstraint(PStr, Int).
constraint(PStr, _)					--> 	atemporalConstraint(PStr, _).

durationConstraint(DCStr, IDC)				-->	"duration", space(_), operator(OpStr), space(_), variable(VarStr),
								{
									nb_getval(intervalNo, Int),
									PrevInt is Int - 1,
									NewInt is Int + 1,
									nb_setval(intervalNo, NewInt),
									string_concat("I", Int, IDC),
									atomics_to_string([",\n\tfindall((S,E), (member((S,E), I", PrevInt, "), Diff is E-S, Diff ", OpStr, " ", VarStr, "), ", IDC, ")"], "", DCStr)
								}.
durationConstraint(DCStr, IDC)				-->	"duration", space(_), operator(OpStr), space(_), number(NumStr),
								{
									nb_getval(intervalNo, Int),
									PrevInt is Int - 1,
									NewInt is Int + 1,
									nb_setval(intervalNo, NewInt),
									string_concat("I", Int, IDC),
									atomics_to_string([",\n\tfindall((S,E), (member((S,E), I", PrevInt, "), Diff is E-S, Diff ", OpStr, " ", NumStr, "), ", IDC, ")"], "", DCStr)
								}.

atemporalConstraint(ACStr, _)				-->	fact(FStr),
								{
									atomics_to_string([",\n\t", FStr], "", ACStr)
								}.
atemporalConstraint(ACStr, _)				-->	math(MStr),
								{
									atomics_to_string([",\n\t", MStr], "", ACStr)
								}.
atemporalConstraint(ACStr, _)				-->	"not", space(N), {N > 0}, fact(FStr),
								{
									atomics_to_string([",\n\t\\+ ", FStr], "", ACStr)
								}.
atemporalConstraint(ACStr, _)				-->	"not", space(_), math(MStr),
								{
									atomics_to_string([",\n\t\\+ ", MStr], "", ACStr)
								}.

% The body of an "initiatedAt", "terminatedAt", or "happensAt" statement.
atBody(AtBodyStr, _, HeadDeclRepr, HeadGraphRepr)	-->	initialConditionGroupChain(List1, _, HeadDeclRepr, HeadGraphRepr), regularConditionGroupChains(ListOfLists, _, HeadDeclRepr, HeadGraphRepr),
								{
									addToHead(ListOfLists, List1, List),
	
									prod(List, AltBodyLists),
	
									nb_getval(fourArgs, FA),
									(FA -> findall(AltBodyStr, (member(AltBodyList, AltBodyLists), addToTail(AltBodyList, ", T1=<T, T<T2", AltBodyPlusList), atomics_to_string(AltBodyPlusList, "", AltBodyStr)), AltBodyStrs)
									;
									findall(AltBodyStr, (member(AltBodyList, AltBodyLists), atomics_to_string(AltBodyList, "", AltBodyStr)), AltBodyStrs)),
	
									atomics_to_string(AltBodyStrs, "^", AtBodyStr)
								}.

initialConditionGroupChain(List, _, HeadDeclRepr, HeadGraphRepr)		-->	initialConditionGroup(AtBodyStr, _, HeadDeclRepr, HeadGraphRepr), moreInitialConditionGroups(MIAList, _, HeadDeclRepr, HeadGraphRepr),
											{
												split_string(AtBodyStr, "\n\t", ",\n\t\s", ConditionElementList),
												length(ConditionElementList, Length),
												Length = 1,
												addToHead(MIAList, AtBodyStr, List)
											}.
initialConditionGroupChain(List, _, HeadDeclRepr, HeadGraphRepr)		-->	"(", initialConditionGroup(AtBodyStr, _, HeadDeclRepr, HeadGraphRepr), ")", moreInitialConditionGroups(MIAList, _, HeadDeclRepr, HeadGraphRepr),
											{
												split_string(AtBodyStr, "\n\t", ",\n\t\s", ConditionElementList),
												length(ConditionElementList, Length),
												Length > 1,
												addToHead(MIAList, AtBodyStr, List)
											}.
initialConditionGroupChain(List, _, HeadDeclRepr, HeadGraphRepr)		-->	initialConditionGroup(AtBodyStr, _, HeadDeclRepr, HeadGraphRepr), moreInitialConditionGroups([], _, HeadDeclRepr, HeadGraphRepr),
											{
												split_string(AtBodyStr, "\n\t", ",\n\t\s", ConditionElementList),
												length(ConditionElementList, Length),
												Length > 1,
												addToHead([], AtBodyStr, List)
											}.
initialConditionGroupChain(List, _, HeadDeclRepr, HeadGraphRepr)		-->	"(", initialConditionGroupChain(List, _, HeadDeclRepr, HeadGraphRepr), ")".

moreInitialConditionGroups(MIAList, _, HeadDeclRepr, HeadGraphRepr)		-->	space(_), "or", space(_), initialConditionGroup(AtBodyStr, _, HeadDeclRepr, HeadGraphRepr), moreInitialConditionGroups(MMIAList, _, HeadDeclRepr, HeadGraphRepr),
											{
												split_string(AtBodyStr, "\n\t", ",\n\t\s", ConditionElementList),
												length(ConditionElementList, Length),
												Length = 1,
												addToHead(MMIAList, AtBodyStr, MIAList)
											}.
moreInitialConditionGroups(MIAList, _, HeadDeclRepr, HeadGraphRepr)		-->	space(_), "or", space(_), "(", initialConditionGroup(AtBodyStr, _, HeadDeclRepr, HeadGraphRepr), ")", moreInitialConditionGroups(MMIAList, _, HeadDeclRepr, HeadGraphRepr),
											{
												split_string(AtBodyStr, "\n\t", ",\n\t\s", ConditionElementList),
												length(ConditionElementList, Length),
												Length > 1,
												addToHead(MMIAList, AtBodyStr, MIAList)
											}.
moreInitialConditionGroups([], _, _, _)						-->	[].

regularConditionGroupChains(ListOfLists, _, HeadDeclRepr, HeadGraphRepr)	-->	space(_), ",", space(_), regularConditionGroupChain(List, _, HeadDeclRepr, HeadGraphRepr), regularConditionGroupChains(MLoL, _, HeadDeclRepr, HeadGraphRepr),
											{
												addToHead(MLoL, List, ListOfLists)
											}.
regularConditionGroupChains([], _, _, _)					-->	[].

regularConditionGroupChain(List, _, HeadDeclRepr, HeadGraphRepr)		-->	regularConditionGroup(AtBodyStr, _, HeadDeclRepr, HeadGraphRepr), moreRegularConditionGroups(MIAList, _, HeadDeclRepr, HeadGraphRepr),
											{
												split_string(AtBodyStr, "\n\t", ",\n\t\s", ConditionElementList),
												length(ConditionElementList, Length),
												Length = 1,
												addToHead(MIAList, AtBodyStr, List)
											}.
regularConditionGroupChain(List, _, HeadDeclRepr, HeadGraphRepr)		-->	"(", regularConditionGroup(AtBodyStr, _, HeadDeclRepr, HeadGraphRepr), ")", moreRegularConditionGroups(MIAList, _, HeadDeclRepr, HeadGraphRepr),
											{
												split_string(AtBodyStr, "\n\t", ",\n\t\s", ConditionElementList),
												length(ConditionElementList, Length),
												Length > 1,
												addToHead(MIAList, AtBodyStr, List)
											}.
regularConditionGroupChain(List, _, HeadDeclRepr, HeadGraphRepr)		-->	regularConditionGroup(AtBodyStr, _, HeadDeclRepr, HeadGraphRepr), moreRegularConditionGroups([], _, HeadDeclRepr, HeadGraphRepr),
											{
												split_string(AtBodyStr, "\n\t", ",\n\t\s", ConditionElementList),
												length(ConditionElementList, Length),
												Length > 1,
												addToHead([], AtBodyStr, List)
											}.
regularConditionGroupChain(List, _, HeadDeclRepr, HeadGraphRepr)		-->	"(", regularConditionGroupChain(List, _, HeadDeclRepr, HeadGraphRepr), ")".

moreRegularConditionGroups(MIAList, _, HeadDeclRepr, HeadGraphRepr)		-->	space(_), "or", space(_), regularConditionGroup(AtBodyStr, _, HeadDeclRepr, HeadGraphRepr), moreRegularConditionGroups(MMIAList, _, HeadDeclRepr, HeadGraphRepr),
											{
												split_string(AtBodyStr, "\n\t", ",\n\t\s", ConditionElementList),
												length(ConditionElementList, Length),
												Length = 1,
												addToHead(MMIAList, AtBodyStr, MIAList)
											}.
moreRegularConditionGroups(MIAList, _, HeadDeclRepr, HeadGraphRepr)		-->	space(_), "or", space(_), "(", regularConditionGroup(AtBodyStr, _, HeadDeclRepr, HeadGraphRepr), ")", moreRegularConditionGroups(MMIAList, _, HeadDeclRepr, HeadGraphRepr),
											{
												split_string(AtBodyStr, "\n\t", ",\n\t\s", ConditionElementList),
												length(ConditionElementList, Length),
												Length > 1,
												addToHead(MMIAList, AtBodyStr, MIAList)
											}.
moreRegularConditionGroups([], _, _, _)						-->	[].

initialConditionGroup(AtBodyStr, _, HeadDeclRepr, HeadGraphRepr)		-->	initialCondition(CondStr, _, HeadDeclRepr, HeadGraphRepr), regularConditions(MCondStr, _, HeadDeclRepr, HeadGraphRepr),
											{
												atomics_to_string([CondStr, MCondStr], "", AtBodyStr)
											}.

initialCondition(CondStr, _, HeadDeclRepr, HeadGraphRepr)			-->	"start", space(N), {N > 0}, fluent("sD", "input", CTStr, _, _, _, _, HeadDeclRepr, HeadGraphRepr),
											{
												atomics_to_string([",\n\thappensAt(start(", CTStr, "), T)"], "", CondStr)
											}.
initialCondition(CondStr, _, HeadDeclRepr, HeadGraphRepr)			-->	"end", space(N), {N > 0}, fluent("sD", "input", CTStr, _, _, _, _, HeadDeclRepr, HeadGraphRepr),
											{
												atomics_to_string([",\n\thappensAt(end(", CTStr, "), T)"], "", CondStr)
											}.
initialCondition(CondStr, _, HeadDeclRepr, HeadGraphRepr)			-->	event("input", CTStr, _, _, _, HeadDeclRepr, HeadGraphRepr),
											{
												atomics_to_string([",\n\thappensAt(", CTStr, ", T)"], "", CondStr)
											}.

regularConditions(MCondStr, _, HeadDeclRepr, HeadGraphRepr)			-->	",", space(_), regularCondition(CondStr, _, HeadDeclRepr, HeadGraphRepr), regularConditions(MMCondStr, _, HeadDeclRepr, HeadGraphRepr),
											{
												string_concat(CondStr, MMCondStr, MCondStr)
											}.
regularConditions("", 0, _, _)							-->	[].

regularCondition(CondStr, Priority, HeadDeclRepr, HeadGraphRepr)		-->	"start", space(N), {N > 0}, fluent("sD", "input", CTStr, _, _, Priority, _, HeadDeclRepr, HeadGraphRepr),
											{
												atomics_to_string([",\n\thappensAt(start(", CTStr, "), T)"], "", CondStr)
											}.
regularCondition(CondStr, Priority, HeadDeclRepr, HeadGraphRepr)		-->	"end", space(N), {N > 0}, fluent("sD", "input", CTStr, _, _, Priority, _, HeadDeclRepr, HeadGraphRepr),
											{
												atomics_to_string([",\n\thappensAt(end(", CTStr, "), T)"], "", CondStr)
											}.
regularCondition(CondStr, Priority, HeadDeclRepr, HeadGraphRepr)		-->	"happens", space(N), {N > 0}, event("input", CTStr, _, _, Priority, HeadDeclRepr, HeadGraphRepr),
											{
												atomics_to_string([",\n\thappensAt(", CTStr, ", T)"], "", CondStr)
											}.
regularCondition(CondStr, Priority, HeadDeclRepr, HeadGraphRepr)		-->	"not happens", space(N), {N > 0}, event("input", CTStr, _, _, Priority, HeadDeclRepr, HeadGraphRepr),
											{
												atomics_to_string([",\n\t\\+ happensAt(", CTStr, ", T)"], "", CondStr)
											}.
regularCondition(ACStr, 0, _, _)						-->	atemporalConstraint(ACStr, _).
regularCondition(CondStr, Priority, HeadDeclRepr, HeadGraphRepr)		-->	fluaint("sD", "input", FluentStr, ConstraintStr, Priority, HeadDeclRepr, HeadGraphRepr),
											{
												atomics_to_string([",\n\tholdsAt(", FluentStr, ", T),\n\t", ConstraintStr], "", CondStr)
											}.
regularCondition(CondStr, Priority, HeadDeclRepr, HeadGraphRepr)		-->	fluent("sD", "input", CTStr, _, _, Priority, _, HeadDeclRepr, HeadGraphRepr),
											{
												atomics_to_string([",\n\tholdsAt(", CTStr, ", T)"], "", CondStr)
											}.
regularCondition(CondStr, Priority, HeadDeclRepr, HeadGraphRepr)		-->	"not", space(N), {N > 0}, fluent("sD", "input", CTStr, _, _, Priority, _, HeadDeclRepr, HeadGraphRepr),
											{
												atomics_to_string([",\n\t\\+ holdsAt(", CTStr, ", T)"], "", CondStr)
											}.

regularConditionGroup(AtBodyStr, _, HeadDeclRepr, HeadGraphRepr)		-->	regularCondition(CondStr, _, HeadDeclRepr, HeadGraphRepr), regularConditions(MCondStr, _, HeadDeclRepr, HeadGraphRepr),
											{
												atomics_to_string([CondStr, MCondStr], "", AtBodyStr)
											}.

% A constraint applied directly on the value of a fluent (e.g.: speed(VesselId, Interval) > 20, where "speed/2" is a fluent).
fluaint("sD", "input", CTStr, MStr, Priority, HeadDeclRepr, HeadGraphRepr)	-->	functawr(FncStr), "(", argumentsList(ArgLStr, UArgLStr, GArgLStr, _, _, _), ")", space(_), operator(OpStr), space(_), variable(Var2Str),
											{
												\+ atem(FncStr),
												%atomics_to_string([FncStr, "(", ArgLStr, ")"], "", FStr),
												atomics_to_string([FncStr, "(", ArgLStr, ")=", "Value"], "", CTStr),
												atomics_to_string([FncStr, "(", UArgLStr, ")"], "", DeclRePrefix),
												atomics_to_string([DeclRePrefix, "Value"], "", DeclRepr),
												atomics_to_string([FncStr, "(", GArgLStr, ")=", "Value"], "", GraphRepr),
												%atomics_to_string([FncStr, "(", IndArgLStr, ")=", "Value", ", ", Index], "", IndRepr),
	
												findall((D, I, T, E), (declared(D, G, I, T, E), sub_string(D, 0, _, _, DeclRePrefix), assertz(declared(D, G, I, "sD", "input"))), _),
	
												assertz(defines(DeclRepr, HeadDeclRepr, Priority)),
	
												assertz(graphines(GraphRepr, HeadGraphRepr)),
	
												atomics_to_string(["Value", " ", OpStr, " ", Var2Str], "", MStr)
											}.
fluaint("sD", "input", CTStr, MStr, Priority, HeadDeclRepr, HeadGraphRepr)	-->	functawr(FncStr), "(", argumentsList(ArgLStr, UArgLStr, GArgLStr, _, _, _), ")", space(_), operator(OpStr), space(_), number(NumStr),
											{
												\+ atem(FncStr),
												%atomics_to_string([FncStr, "(", ArgLStr, ")"], "", FStr),
												atomics_to_string([FncStr, "(", ArgLStr, ")=", "Value"], "", CTStr),
												atomics_to_string([FncStr, "(", UArgLStr, ")"], "", DeclRePrefix),
												atomics_to_string([DeclRePrefix, "Value"], "", DeclRepr),
												atomics_to_string([FncStr, "(", GArgLStr, ")=", "Value"], "", GraphRepr),
												%atomics_to_string([FncStr, "(", IndArgLStr, ")=", "Value", ", ", Index], "", IndRepr),
	
												findall((D, I, T, E), (declared(D, G, I, T, E), sub_string(D, 0, _, _, DeclRePrefix), assertz(declared(D, G, I, "sD", "input"))), _),
	
												assertz(defines(DeclRepr, HeadDeclRepr, Priority)),
	
												assertz(graphines(GraphRepr, HeadGraphRepr)),
	
												atomics_to_string(["Value", " ", OpStr, " ", NumStr], "", MStr)
											}.
fluaint("sD", "input", CTStr, MStr, Priority, HeadDeclRepr, HeadGraphRepr)	-->	functawr(FncStr), "(", argumentsList(ArgLStr, UArgLStr, GArgLStr, _, _, _), ")", space(_), operator(OpStr), space(_), numUnit(NUStr),
											{
												\+ atem(FncStr),
												%atomics_to_string([FncStr, "(", ArgLStr, ")"], "", FStr),
												atomics_to_string([FncStr, "(", ArgLStr, ")=", "Value"], "", CTStr),
												atomics_to_string([FncStr, "(", UArgLStr, ")"], "", DeclRePrefix),
												atomics_to_string([DeclRePrefix, "Value"], "", DeclRepr),
												atomics_to_string([FncStr, "(", GArgLStr, ")=", "Value"], "", GraphRepr),
												%atomics_to_string([FncStr, "(", IndArgLStr, ")=", "Value", ", ", Index], "", IndRepr),
	
												findall((D, I, T, E), (declared(D, G, I, T, E), sub_string(D, 0, _, _, DeclRePrefix), assertz(declared(D, G, I, "sD", "input"))), _),
	
												assertz(defines(DeclRepr, HeadDeclRepr, Priority)),
	
												assertz(graphines(GraphRepr, HeadGraphRepr)),
	
												atomics_to_string(["Value", " ", OpStr, " ", NUStr], "", MStr)
											}.

fact(FStr)		-->	functawr(FncStr), "(", argumentsList(ArgLStr, _, _, _, _, _), ")",
				{
					atem(FncStr),
					atomics_to_string([FncStr, "(", ArgLStr, ")"], "", FStr)
				}.

math(MStr)		-->	variable(Var1Str), space(_), operator(OpStr), space(_), variable(Var2Str),
				{
					atomics_to_string([Var1Str, " ", OpStr, " ", Var2Str], "", MStr)
				}.
math(MStr)		-->	variable(Var1Str), space(_), operator(OpStr), space(_), number(NumStr),
				{
					atomics_to_string([Var1Str, " ", OpStr, " ", NumStr], "", MStr)
				}.
math(MStr)		-->	variable(Var1Str), space(_), operator(OpStr), space(_), numUnit(NUStr),
				{
					atomics_to_string([Var1Str, " ", OpStr, " ", NUStr], "", MStr)
				}.

operator(">")		-->	">".
operator(">=")		-->	">=".
operator("<")		-->	"<".
operator("=<")		-->	"=<".
operator("=")		-->	"=".

numUnit(NUStr)		-->	number(NumStr), space(_), functawr(FncStr),
				{
					atomics_to_string([NumStr, " ", FncStr], "", NUStr)
				}.

list(LStr, List)	-->	"[", space(_), argumentsList(ArgLStr, _, _, _, _, List), space(_), "]",
				{
					atomics_to_string(["[", ArgLStr, "]"], "", LStr)
				}.
list("[]", [])		-->	"[]".

tuple(TStr, List)	-->	"(", space(_), argumentsList(ArgLStr, _, _, _, _, List), space(_), ")",
				{
					atomics_to_string(["(", ArgLStr, ")"], "", TStr)
				}.

