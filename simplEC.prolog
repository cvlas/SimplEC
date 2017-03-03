:- ['dcg.prolog'].

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

