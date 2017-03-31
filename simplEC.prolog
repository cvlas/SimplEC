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
	read_stream_to_codes(Input, Codes),
	nb_setval(headFluents, []),
	nb_setval(declared, []),
	phrase(goal(DeclStream), Codes),
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

goal(DeclStream)			--> 	ceDefinition(DeclStream), space, goal(DeclStream).
goal(_)					--> 	[].

ceDefinition(DeclStream)		-->	holdsFor(DeclStream).
ceDefinition(DeclStream)		-->	initTerm(DeclStream).
					
holdsFor(DeclStream)			--> 	head(Head, HeadT, DeclStream), space, sep("iff"), space, hfBody(Body, BodyT, DeclStream), ".",
						{
							string_codes(Body, BodyCodes),
							list_head(BodyCodes, _, CommaFreeBodyCodes),
							string_codes(CommaFreeBody, CommaFreeBodyCodes),
							write(Head), write(" :-"), write(CommaFreeBody),
							write(",\n\tunion_all("), write(BodyT), write(", [], "), write(HeadT), write(").\n\n")
						}.

initTerm(DeclStream)			-->	head(Head, _, DeclStream), space, sep("if"), space, itBody(Body, DeclStream), ".",
						{
							string_codes(Body, BodyCodes),
							list_head(BodyCodes, _, CommaFreeBodyCodes),
							string_codes(CommaFreeBody, CommaFreeBodyCodes),
							write(Head), write(" :-"), write(CommaFreeBody), write(".\n\n")
						}.
	
sep("iff")				--> 	"iff".
sep("if")				--> 	"if".

head(HeadStr, CTT, DeclStream)			--> 	fluent("sD", "output", CTStr, CTT, DeclStream),
							{
								string_concat("holdsFor(", CTStr, HeadStrPending1),
								string_concat(HeadStrPending1, ", ", HeadStrPending2),
								string_concat(HeadStrPending2, CTT, HeadStrPending3),
								string_concat(HeadStrPending3, ")", HeadStr),
								nb_getval(headFluents, HF),
								addToTail(HF, CTStr, HF_new),
								nb_setval(headFluents, HF_new)
								%addToTail(Heads, CTStr, HeadsUpdated)
								%, write(DeclStream, CTStr), write(DeclStream, ").\n"),
								%write(DeclStream, "outputEntity("), write(DeclStream, CTStr), write(DeclStream, ").\n"),
								%write(DeclStream, "index("), write(DeclStream, CTStr), write(DeclStream, ", X).\n\n")
							}.
head(HeadStr, CTT, DeclStream) 			--> 	"initiate", space, fluent("simple", "output", CTStr, CTT, DeclStream),
							{
								string_concat("initiatedAt(", CTStr, HeadStrPending1),
								string_concat(HeadStrPending1, ", T)", HeadStr),
								nb_getval(headFluents, HF),
								addToTail(HF, CTStr, HF_new),
								nb_setval(headFluents, HF_new)
								%write(DeclStream, CTStr), write(DeclStream, ").\n"),
								%write(DeclStream, "outputEntity("), write(DeclStream, CTStr), write(DeclStream, ").\n"),
								%write(DeclStream, "index("), write(DeclStream, CTStr), write(DeclStream, ", X).\n\n")
							}.
head(HeadStr, CTT, DeclStream)	 		--> 	"terminate", space, fluent("simple", "output", CTStr, CTT, DeclStream),
							{
								string_concat("terminatedAt(", CTStr, HeadStrPending1),
								string_concat(HeadStrPending1, ", T)", HeadStr)
							}.

fluent(Type, Etype, CTStr, T, DeclStream)	--> 	functawr(FncStr), "(", argumentsList(ArgLStr, IArgLStr, UArgLStr, IndArgLStr, Index), ")", value(ValStr, Str),
							{
								string_concat(FncStr, "(", FncPending1),
								string_concat(FncPending1, ArgLStr, FncPending2),
								string_concat(FncPending2, ")", FncPending3),
								string_concat(FncPending3, ValStr, CTStr),
								string_concat("I_", FncStr, TPending1),
								string_concat(TPending1, "_", TPending2),
								string_concat(TPending2, IArgLStr, TPending3),
								string_concat(TPending3, "_", TPending4),
								string_concat(TPending4, Str, T),
								nb_getval(headFluents, HF),
								nb_getval(declared, Decl),
								(member(CTStr, HF) -> true
								;
								%string_concat(FncStr, "(", FncPending1),
								%string_concat(FncPending1, ArgLStr, FncPending2),
								%string_concat(FncPending2, ")", FncPending3),
								%string_concat(FncPending3, ValStr, CTStr),
								%string_concat("I_", FncStr, TPending1),
								%string_concat(TPending1, "_", TPending2),
								%string_concat(TPending2, IArgLStr, TPending3),
								%string_concat(TPending3, "_", TPending4),
								%string_concat(TPending4, Str, T),
								%nb_getval(declared, Decl),
								member(CTStr, Decl) -> true
								;
								%string_concat(FncStr, "(", FncPending1),
								%string_concat(FncPending1, ArgLStr, FncPending2),
								%string_concat(FncPending2, ")", FncPending3),
								%string_concat(FncPending3, ValStr, CTStr),
								%string_concat("I_", FncStr, TPending1),
								%string_concat(TPending1, "_", TPending2),
								%string_concat(TPending2, IArgLStr, TPending3),
								%string_concat(TPending3, "_", TPending4),
								%string_concat(TPending4, Str, T),
								write(DeclStream, Type), write(DeclStream, "Fluent("), write(DeclStream, FncPending1), write(DeclStream, UArgLStr), write(DeclStream, ")"), write(DeclStream, ValStr), write(DeclStream, ").\n"),
								write(DeclStream, Etype), write(DeclStream, "Entity("), write(DeclStream, FncPending1), write(DeclStream, UArgLStr), write(DeclStream, ")"), write(DeclStream, ValStr), write(DeclStream, ").\n"),
								write(DeclStream, "index("), write(DeclStream, FncPending1), write(DeclStream, IndArgLStr), write(DeclStream, ")"), write(DeclStream, ValStr), write(DeclStream, ", "), write(DeclStream, Index), write(DeclStream, ").\n\n"),
								addToTail(Decl, CTStr, Decll),
								nb_setval(declared, Decll))
							}.

event(Etype, EvStr, EvT, DeclStream)		-->	functawr(FncStr), "(", argumentsList(ArgLStr, IArgLStr, UArgLStr, IndArgLStr, Index), ")",
							{
								string_concat(FncStr, "(", EvStrPending1),
								string_concat(EvStrPending1, ArgLStr, EvStrPending2),
								string_concat(EvStrPending2, ")", EvStr),
								string_concat("T_", FncStr, EvTPending1),
								string_concat(EvTPending1, "_", EvTPending2),
								string_concat(EvTPending2, IArgLStr, EvT),
								write(DeclStream, "event("), write(DeclStream, EvStrPending1), write(DeclStream, UArgLStr), write(DeclStream, ")).\n"),
								write(DeclStream, Etype), write(DeclStream, "Entity("), write(DeclStream, EvStrPending1), write(DeclStream, UArgLStr), write(DeclStream, ")).\n"),
								write(DeclStream, "index("), write(DeclStream, EvStrPending1), write(DeclStream, IndArgLStr), write(DeclStream, "), "), write(DeclStream, Index), write(DeclStream, ").\n\n")
							}.

functawr(FncStr) 						--> 	[Lower], { char_type(Lower, lower) }, restChars(RCList),
									{
										string_codes(FncStr, [Lower|RCList])
									}.

value("=true", "true")						-->	[].
value(ValStr, Str)						-->	"=", functawr(Str),
									{
										string_concat("=", Str, ValStr)
									}.

restChars([]) 							--> 	[].
restChars([Alnum|Rest])						--> 	[Alnum], { char_type(Alnum, alnum) }, restChars(Rest).

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

hfBody(BodyStr, I, DeclStream)			-->	expression(BodyStr, I, DeclStream).

expression(ExprStr, I, DeclStream)		-->	component(CompStr, T1, DeclStream), moreComponents(MCompStr, T2, and, DeclStream),
							{
								string_concat(CompStr, MCompStr, ExprStrPending5),
								string_concat(ExprStrPending5, ",\n\tintersect_all([", ExprStrPending6),
								string_concat(ExprStrPending6, T1, ExprStrPending7),
								string_concat(ExprStrPending7, ", ", ExprStrPending8),
								string_concat(ExprStrPending8, T2, ExprStrPending9),
								string_concat(ExprStrPending9, "], ", ExprStrPending10),
								string_concat(T1, "_AND_", IPending),
								string_concat(IPending, T2, I),
								string_concat(ExprStrPending10, I, ExprStrPending11),
								string_concat(ExprStrPending11, ")", ExprStr)
							}.
expression(ExprStr, I, DeclStream)		-->	component(CompStr, T1, DeclStream), moreComponents(MCompStr, T2, or, DeclStream),
							{
								string_concat(CompStr, MCompStr, ExprStrPending5),
								string_concat(ExprStrPending5, ",\n\tunion_all([", ExprStrPending6),
								string_concat(ExprStrPending6, T1, ExprStrPending7),
								string_concat(ExprStrPending7, ", ", ExprStrPending8),
								string_concat(ExprStrPending8, T2, ExprStrPending9),
								string_concat(ExprStrPending9, "], ", ExprStrPending10),
								string_concat(T1, "_OR_", IPending),
								string_concat(IPending, T2, I),
								string_concat(ExprStrPending10, I, ExprStrPending11),
								string_concat(ExprStrPending11, ")", ExprStr)
							}.
expression(ExprStr, I, DeclStream)		-->	component(ExprStr, I, DeclStream), moreComponents(null).

moreComponents(MCompStr, I, and, DeclStream)	-->	",", space, expression(MCompStr, I, DeclStream).
moreComponents(MCompStr, I, or, DeclStream)	-->	space, "or", space, expression(MCompStr, I, DeclStream).
moreComponents(null)				-->	[].

component(CompStr, T, DeclStream)		-->	fluent("sD", "input", Str, T, DeclStream),
							{
								string_concat(",\n\tholdsFor(", Str, CompStrPending1),
								string_concat(CompStrPending1, ", ", CompStrPending2),
								string_concat(CompStrPending2, T, CompStrPending3),
								string_concat(CompStrPending3, ")", CompStr)
							}.
component(CompStr, T, DeclStream)		-->	"(", space, expression(CompStr, T, DeclStream), space, ")".
component(CompStr, T, DeclStream)		-->	"not", space, expression(Str, ExpT, DeclStream),
							{
								string_concat(Str, ",\n\tcomplement_all(", CompStrPending3),
								string_concat(CompStrPending3, ExpT, CompStrPending4),
								string_concat(CompStrPending4, ", ", CompStrPending5),
								string_concat(ExpT, "_COMPL", T),
								string_concat(CompStrPending5, T, CompStrPending6),
								string_concat(CompStrPending6, ")", CompStr)
							}.

itBody(ITBodyStr, DeclStream)			-->	"happens", space, event("input", CTStr, _, DeclStream), moreConditions(MCondStr, DeclStream),
							{
								string_concat(",\n\thappensAt(", CTStr, CondStrPending1),
								string_concat(CondStrPending1, ", T)", CondStr),
								string_concat(CondStr, MCondStr, ITBodyStr)
							}.
itBody(ITBodyStr, DeclStream)			-->	"start", space, fluent(_, _, CTStr, _, DeclStream), moreConditions(MCondStr, DeclStream),
							{
								string_concat(",\n\thappensAt(start(", CTStr, CondStrPending1),
								string_concat(CondStrPending1, "), T)", CondStr),
								string_concat(CondStr, MCondStr, ITBodyStr)
							}.
itBody(ITBodyStr, DeclStream)			-->	"end", space, fluent(_, _, CTStr, _, DeclStream), moreConditions(MCondStr, DeclStream),
							{
								string_concat(",\n\thappensAt(end(", CTStr, CondStrPending1),
								string_concat(CondStrPending1, "), T)", CondStr),
								string_concat(CondStr, MCondStr, ITBodyStr)
							}.

condition(CondStr, DeclStream)			-->	"start", space, fluent(_, _, CTStr, _, DeclStream),
							{
								string_concat(",\n\thappensAt(start(", CTStr, CondStrPending1),
								string_concat(CondStrPending1, "), T)", CondStr)
							}.
condition(CondStr, DeclStream)			-->	"end", space, fluent(_, _, CTStr, _, DeclStream),
							{
								string_concat(",\n\thappensAt(end(", CTStr, CondStrPending1),
								string_concat(CondStrPending1, "), T)", CondStr)
							}.
condition(CondStr, DeclStream)			-->	"happens", space, event("input", CTStr, _, DeclStream),
							{
								string_concat(",\n\thappensAt(", CTStr, CondStrPending1),
								string_concat(CondStrPending1, ", T)", CondStr)
							}.
condition(CondStr, DeclStream)			-->	fluent("simple", "output", CTStr, _, DeclStream),
							{
								string_concat(",\n\tholdsAt(", CTStr, CondStrPending1),
								string_concat(CondStrPending1, ", T)", CondStr)
							}.

moreConditions(MCondStr, DeclStream)		-->	",", space, condition(CondStr, DeclStream), moreConditions(MMCondStr, DeclStream),
							{
								string_concat(CondStr, MMCondStr, MCondStr)
							}.
moreConditions("", _)				-->	[].

