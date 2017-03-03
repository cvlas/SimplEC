% -----------------------------------------------
% SIMPL-EC
% -----------------------------------------------
	
simplEC(InputFile, OutputFile) :-
	open(InputFile, read, Input),
	tell(OutputFile),
	read_string(Input, ".", "\r\s\t", Dot, String),
	string_concat(String, Dot, StringDot),
	string_codes(StringDot, Codes),
	phrase(goal, Codes),
	tillTheEndOfFile(Input).
	
tillTheEndOfFile(Input) :-
	read_string(Input, ".", "\r\s\t", ".", String),!,
	string_concat(String, ".", StringDot),
	string_codes(StringDot, Codes),
	phrase(goal, Codes),
	tillTheEndOfFile(Input).
	
tillTheEndOfFile(Input) :- told, close(Input), !.

