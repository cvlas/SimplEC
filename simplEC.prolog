:- ['dcg.prolog'].

% -----------------------------------------------
% SIMPL-EC
% -----------------------------------------------
	
simplEC(InputFile, OutputFile) :-
	open(InputFile, read, Input),
	tell(OutputFile),
	read_string(Input, ".", "\r\s\t", 46, String), !,
	string_concat(String, ".", StringDot),
	string_codes(StringDot, Codes),
	phrase(goal, Codes),
	tillTheEndOfFile(Input).
	
tillTheEndOfFile(Input) :-
	read_string(Input, ".", "\r\s\t", 46, String), !,
	string_concat(String, ".", StringDot),
	string_codes(StringDot, Codes),
	phrase(goal, Codes),
	tillTheEndOfFile(Input).
	
tillTheEndOfFile(Input) :-
	read_string(Input, ".", "\r\s\t", 10, String),
	told,
	close(Input), !.

