% -----------------------------------------------
% AUXILIARY TOOLS
% -----------------------------------------------

list_head([H|T], H, T).

% -----------------------------------------------
% SIMPL-EC
% -----------------------------------------------
	
simplEC(InputFile, OutputFile) :-
	open(InputFile, read, Input),
	tell(OutputFile),
	read_stream_to_codes(Input, Codes),
	phrase(goal, Codes),
	told,
	close(Input), !.

% -----------------------------------------------
% DEFINITE CLAUSE GRAMMAR
% -----------------------------------------------

space 					--> 	"\t", space.
space 					--> 	"\n", space.
space 					--> 	"\r", space.
space 					--> 	" ", space.
space					-->	[].

goal 					--> 	ceDefinition, space, goal.
goal 					--> 	[].

ceDefinition 				--> 	head(Head), space, sep(_), space, body(Body, IB), ".",
						{
							string_codes(Body, BodyCodes),
							list_head(BodyCodes, _, CommaFreeBodyCodes),
							string_codes(CommaFreeBody, CommaFreeBodyCodes),
							write("holdsFor("), write(Head), write(", "), write(IB), write(") :-"), write(CommaFreeBody), write(".\n\n")
						}.
	
sep("iff")				--> 	"iff".
sep("if")				--> 	"if".

head(CTStr) 				--> 	compoundTerm(CTStr, _).

compoundTerm(CTStr, T) 			--> 	functawr(FncStr), "(", argumentsList(ArgLStr, IArgLStr), ")", value(ValStr, Str),
						{
							string_concat(FncStr, "(", FncPending1),
							string_concat(FncPending1, ArgLStr, FncPending2),
							string_concat(FncPending2, ")", FncPending3),
							string_concat(FncPending3, ValStr, CTStr),
							string_concat("I_", FncStr, TPending1),
							string_concat(TPending1, "_", TPending2),
							string_concat(TPending2, IArgLStr, TPending3),
							string_concat(TPending3, "_", TPending4),
							string_concat(TPending4, Str, T) 
						}.

functawr(FncStr) 			--> 	[Lower], { char_type(Lower, lower) }, restChars(RCList),
						{
							string_codes(FncStr, [Lower|RCList])
						}.

value("=true", "true")			-->	[].
value(ValStr, Str)			-->	"=", functawr(Str),
						{
							string_concat("=", Str, ValStr)
						}.

restChars([]) 				--> 	[].
restChars([Alnum|Rest])			--> 	[Alnum], { char_type(Alnum, alnum) }, restChars(Rest).

argumentsList(ArgLStr, IArgLStr) 	--> 	argument(ArgStr), moreArguments(MArgStr, IMArgStr),
						{
							string_concat(ArgStr, MArgStr, ArgLStr),
							string_concat(ArgStr, IMArgStr, IArgLStr)
						}.

argument(ArgStr) 			--> 	[Alpha], { char_type(Alpha, alpha) }, restChars(RCList),
						{
							string_codes(ArgStr, [Alpha|RCList])
						}.

moreArguments(MArgStr, MArgStr)		--> 	[],
						{
							string_codes(MArgStr, [])
						}.
moreArguments(MArgStr, IMArgStr)	-->	",", argument(ArgStr), moreArguments(MMArgStr, IMMArgStr),
						{
							string_concat(",", ArgStr, MArgPending),
							string_concat(MArgPending, MMArgStr, MArgStr),
							string_concat("_", ArgStr, IMArgPending),
							string_concat(IMArgPending, IMMArgStr, IMArgStr)
						}.

body(BodyStr, I)			-->	expression(BodyStr, I).

expression(ExprStr, I)			-->	component(CompStr, T1), moreComponents(MCompStr, T2, and),
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
expression(ExprStr, I)			-->	component(CompStr, T1), moreComponents(MCompStr, T2, or),
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
expression(ExprStr, I)			-->	component(ExprStr, I), moreComponents(null).

moreComponents(MCompStr, I, and)	-->	",", space, expression(MCompStr, I).
moreComponents(MCompStr, I, or)		-->	space, "or", space, expression(MCompStr, I).
moreComponents(null)			-->	[].

component(CompStr, T)			-->	compoundTerm(Str, T),
						{
							string_concat(",\n\tholdsFor(", Str, CompStrPending1),
							string_concat(CompStrPending1, ", ", CompStrPending2),
							string_concat(CompStrPending2, T, CompStrPending3),
							string_concat(CompStrPending3, ")", CompStr)
						}.
component(CompStr, T)			-->	"(", space, expression(CompStr, T), space, ")".
component(CompStr, T)			-->	"not", space, expression(Str, ExpT),
						{
							string_concat(Str, ",\n\tcomplement_all(", CompStrPending3),
							string_concat(CompStrPending3, ExpT, CompStrPending4),
							string_concat(CompStrPending4, ", ", CompStrPending5),
							string_concat(ExpT, "_COMPL", T),
							string_concat(CompStrPending5, T, CompStrPending6),
							string_concat(CompStrPending6, ")", CompStr)
						}.

