space 			--> 	" ".
space 			--> 	" ", space.
space 			--> 	"\t", space.
space 			--> 	"\n", space.

goal 			--> 	[].
goal 			--> 	ceDefinition, space, goal.

ceDefinition 		--> 	head(Head), space, sep(_), space, body(Body), ".",
				{
					write(Head), write(" :- \n\t"), write(Body), write(".\n")
				}.
	
sep("iff")		--> 	"iff".

head(Head) 		--> 	compoundTerm(CTStr, T),
				{
					string_concat("holdsFor(", CTStr, HeadPending1),
					string_concat(HeadPending1, ", ", HeadPending2),
					string_concat(HeadPending2, T, HeadPending3),
					string_concat(HeadPending3, ")", Head)
				}.

compoundTerm(CTStr, T) 	--> 	functawr(FncStr), "(", argumentsList(ArgLStr), ")", value(ValStr, Str),
				{
					string_concat(FncStr, "(", FncPending1),
					string_concat(FncPending1, ArgLStr, FncPending2),
					string_concat(FncPending2, ")", FncPending3),
					string_concat(FncPending3, ValStr, CTStr),
					string_concat("I_", FncStr, TPending1),
					string_concat(TPending1, "_", TPending2),
					string_concat(TPending2, Str, T)
				}.

functawr(FncStr) 	--> 	[Lower], { char_type(Lower, lower) }, restChars(RCList),
				{
					string_codes(FncStr, [Lower|RCList])
				}.

value("", "")		-->	[].
value(ValStr, Str)		-->	"=", functawr(Str),
				{
					string_concat("=", Str, ValStr)
				}.

restChars([]) 		--> 	[].
restChars([Alnum|Rest])	--> 	[Alnum], { char_type(Alnum, alnum) }, restChars(Rest).

argumentsList(ArgLStr) 	--> 	argument(ArgStr), moreArguments(MArgStr),
				{
					string_concat(ArgStr, MArgStr, ArgLStr)
				}.

argument(ArgStr) 	--> 	[Alpha], { char_type(Alpha, alpha) }, restChars(RCList),
				{
					string_codes(ArgStr, [Alpha|RCList])
				}.

moreArguments(MArgStr)	--> 	[],
				{
					string_codes(MArgStr, [])
				}.
moreArguments(MArgStr)	-->	",", argument(ArgStr), moreArguments(MMArgStr),
				{
					string_concat(",", ArgStr, MArgPending),
					string_concat(MArgPending, MMArgStr, MArgStr)
				}.

body(BodyStr)		-->	expression(BodyStr).

expression(ExprStr, I)	-->	component(CompStr, T1), moreComponents(MCompStr, T2, and),
				{
					string_concat(CompStr, MCompStr, ExprStrPending5),
					string_concat(ExprStrPending5, ",\nintersect_all([", ExprStrPending6),
					string_concat(ExprStrPending6, T1, ExprStrPending7),
					string_concat(ExprStrPending7, ", ", ExprStrPending8),
					string_concat(ExprStrPending8, T2, ExprStrPending9),
					string_concat(ExprStrPending9, "], ", ExprStrPending10),
					string_concat(T1, "_AND_", IPending),
					string_concat(IPending, T2, I),
					string_concat(ExprStrPending10, I, ExprStrPending11),
					string_concat(ExprStrPending11, ")", ExprStr)
				}.
expression(ExprStr, I)	-->	component(CompStr, T1), moreComponents(MCompStr, T2, or),
				{
					string_concat(CompStr, MCompStr, ExprStrPending5),
					string_concat(ExprStrPending5, ",\nunion_all([", ExprStrPending6),
					string_concat(ExprStrPending6, T1, ExprStrPending7),
					string_concat(ExprStrPending7, ", ", ExprStrPending8),
					string_concat(ExprStrPending8, T2, ExprStrPending9),
					string_concat(ExprStrPending9, "], ", ExprStrPending10),
					string_concat(T1, "_OR_", IPending),
					string_concat(IPending, T2, I),
					string_concat(ExprStrPending10, I, ExprStrPending11),
					string_concat(ExprStrPending11, ")", ExprStr)
				}.
expression(ExprStr, I)	-->	component(ExprStr, I), moreComponents(null).

moreComponents(MCompStr, I, and)	-->	",", space, expression(MCompStr, I1).
moreComponents(MCompStr, I, or)	-->	space, "or", space, expression(MCompStr, I1).
moreComponents(null)		-->	[].

component(CompStr, T)	-->	compoundTerm(Str, T),
							{
								string_concat("holdsFor(", Str, CompStrPending1),
								string_concat(CompStrPending1, ", ", CompStrPending2),
								string_concat(CompStrPending2, T, CompStrPending3),
								string_concat(CompStrPending3, ")", CompStr)
							}.
component(CompStr, T)	-->	"(", expression(Str, T), ")".
component(CompStr, T)	-->	"not(", expression(Str, ExpT), ")",
				{
					string_concat(Str, ",\ncomplement(", CompStrPending1),
					string_concat(CompStrPending1, ExpT, CompStrPending2),
					string_concat(CompStrPending2, ", ", CompStrPending3),
					string_concat(CompStrPending3, ExpT, CompStrPending4),
					string_concat(CompStrPending4, "_COMPL", CompStrPending5),
					string_concat(CompStrPending5, ")", CompStr)
				}.
