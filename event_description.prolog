holdsFor(working(X)=true, I_working_X_true) :-
	holdsFor(loc(X)=work, I_loc_X_work),
	holdsFor(takingBreak(X)=true, I_takingBreak_X_true),
	complement_all(I_takingBreak_X_true, I_takingBreak_X_true_COMPL),
	intersect_all([I_loc_X_work, I_takingBreak_X_true_COMPL], I_loc_X_work_AND_I_takingBreak_X_true_COMPL),
	union_all(I_loc_X_work_AND_I_takingBreak_X_true_COMPL, [], I_working_X_true).

holdsFor(resting(X)=true, I_resting_X_true) :-
	holdsFor(loc(X)=pub, I_loc_X_pub),
	holdsFor(onHoliday(X)=true, I_onHoliday_X_true),
	holdsFor(loc(X)=work, I_loc_X_work),
	holdsFor(takingBreak(X)=true, I_takingBreak_X_true),
	intersect_all([I_loc_X_work, I_takingBreak_X_true], I_loc_X_work_AND_I_takingBreak_X_true),
	union_all([I_onHoliday_X_true, I_loc_X_work_AND_I_takingBreak_X_true], I_onHoliday_X_true_OR_I_loc_X_work_AND_I_takingBreak_X_true),
	union_all([I_loc_X_pub, I_onHoliday_X_true_OR_I_loc_X_work_AND_I_takingBreak_X_true], I_loc_X_pub_OR_I_onHoliday_X_true_OR_I_loc_X_work_AND_I_takingBreak_X_true),
	union_all(I_loc_X_pub_OR_I_onHoliday_X_true_OR_I_loc_X_work_AND_I_takingBreak_X_true, [], I_resting_X_true).

holdsFor(happy(X)=true, I_happy_X_true) :-
	holdsFor(rich(X)=true, I_rich_X_true),
	holdsFor(resting(X)=true, I_resting_X_true),
	union_all([I_rich_X_true, I_resting_X_true], I_rich_X_true_OR_I_resting_X_true),
	union_all(I_rich_X_true_OR_I_resting_X_true, [], I_happy_X_true).

holdsFor(sad(X)=true, I_sad_X_true) :-
	holdsFor(poor(X)=true, I_poor_X_true),
	holdsFor(working(X)=true, I_working_X_true),
	holdsFor(loc(X)=home, I_loc_X_home),
	holdsFor(changingDiapers(X)=true, I_changingDiapers_X_true),
	intersect_all([I_loc_X_home, I_changingDiapers_X_true], I_loc_X_home_AND_I_changingDiapers_X_true),
	union_all([I_working_X_true, I_loc_X_home_AND_I_changingDiapers_X_true], I_working_X_true_OR_I_loc_X_home_AND_I_changingDiapers_X_true),
	intersect_all([I_poor_X_true, I_working_X_true_OR_I_loc_X_home_AND_I_changingDiapers_X_true], I_poor_X_true_AND_I_working_X_true_OR_I_loc_X_home_AND_I_changingDiapers_X_true),
	union_all(I_poor_X_true_AND_I_working_X_true_OR_I_loc_X_home_AND_I_changingDiapers_X_true, [], I_sad_X_true).

holdsFor(friends(X,Y)=true, I_friends_X_Y_true) :-
	holdsFor(loc(X)=pub, I_loc_X_pub),
	holdsFor(loc(Y)=pub, I_loc_Y_pub),
	holdsFor(rich(X)=true, I_rich_X_true),
	holdsFor(rich(Y)=true, I_rich_Y_true),
	union_all([I_rich_X_true, I_rich_Y_true], I_rich_X_true_OR_I_rich_Y_true),
	complement_all(I_rich_X_true_OR_I_rich_Y_true, I_rich_X_true_OR_I_rich_Y_true_COMPL),
	intersect_all([I_loc_Y_pub, I_rich_X_true_OR_I_rich_Y_true_COMPL], I_loc_Y_pub_AND_I_rich_X_true_OR_I_rich_Y_true_COMPL),
	intersect_all([I_loc_X_pub, I_loc_Y_pub_AND_I_rich_X_true_OR_I_rich_Y_true_COMPL], I_loc_X_pub_AND_I_loc_Y_pub_AND_I_rich_X_true_OR_I_rich_Y_true_COMPL),
	union_all(I_loc_X_pub_AND_I_loc_Y_pub_AND_I_rich_X_true_OR_I_rich_Y_true_COMPL, [], I_friends_X_Y_true).

holdsFor(fighting(X,Y)=true, I_fighting_X_Y_true) :-
	holdsFor(abrupt(X)=true, I_abrupt_X_true),
	holdsFor(abrupt(Y)=true, I_abrupt_Y_true),
	union_all([I_abrupt_X_true, I_abrupt_Y_true], I_abrupt_X_true_OR_I_abrupt_Y_true),
	holdsFor(close(X,Y)=true, I_close_X_Y_true),
	intersect_all([I_abrupt_X_true_OR_I_abrupt_Y_true, I_close_X_Y_true], I_abrupt_X_true_OR_I_abrupt_Y_true_AND_I_close_X_Y_true),
	holdsFor(inactive(X)=true, I_inactive_X_true),
	holdsFor(inactive(Y)=true, I_inactive_Y_true),
	union_all([I_inactive_X_true, I_inactive_Y_true], I_inactive_X_true_OR_I_inactive_Y_true),
	complement_all(I_inactive_X_true_OR_I_inactive_Y_true, I_inactive_X_true_OR_I_inactive_Y_true_COMPL),
	intersect_all([I_abrupt_X_true_OR_I_abrupt_Y_true_AND_I_close_X_Y_true, I_inactive_X_true_OR_I_inactive_Y_true_COMPL], I_abrupt_X_true_OR_I_abrupt_Y_true_AND_I_close_X_Y_true_AND_I_inactive_X_true_OR_I_inactive_Y_true_COMPL),
	union_all(I_abrupt_X_true_OR_I_abrupt_Y_true_AND_I_close_X_Y_true_AND_I_inactive_X_true_OR_I_inactive_Y_true_COMPL, [], I_fighting_X_Y_true).

initiatedAt(moving(P1,P2)=true, T) :-
	happensAt(start(walking(P1)=true), T),
	holdsAt(walking(P2)=true, T),
	holdsAt(close(P1,P2)=true, T).

terminatedAt(moving(P1,P2)=true, T) :-
	happensAt(end(walking(P1)=true), T).

terminatedAt(moving(P1,P2)=true, T) :-
	happensAt(exit(P1), T).

