holdsFor(headFluent2(X)=true, I_condition6_true_OR_I_condition7_true_OR_I_condition8_true_AND_I_condition9_true_COMPL_AND_I_condition10_true) :- 
	true,
	holdsFor(condition6(X)=true, I_condition6_true),
	holdsFor(condition7(X)=true, I_condition7_true),
	holdsFor(condition8(X)=true, I_condition8_true),
	holdsFor(condition9(X)=true, I_condition9_true),
	intersect_all([I_condition8_true, I_condition9_true], I_condition8_true_AND_I_condition9_true),
	complement(I_condition8_true_AND_I_condition9_true, I_condition8_true_AND_I_condition9_true_COMPL),
	union_all([I_condition7_true, I_condition8_true_AND_I_condition9_true_COMPL], I_condition7_true_OR_I_condition8_true_AND_I_condition9_true_COMPL),
	union_all([I_condition6_true, I_condition7_true_OR_I_condition8_true_AND_I_condition9_true_COMPL], I_condition6_true_OR_I_condition7_true_OR_I_condition8_true_AND_I_condition9_true_COMPL),
	holdsFor(condition10(X)=true, I_condition10_true),
	intersect_all([I_condition6_true_OR_I_condition7_true_OR_I_condition8_true_AND_I_condition9_true_COMPL, I_condition10_true], I_condition6_true_OR_I_condition7_true_OR_I_condition8_true_AND_I_condition9_true_COMPL_AND_I_condition10_true).

holdsFor(headFluent1(X)=true, I_condition1_true_AND_I_condition2_true_AND_I_condition3_true_OR_I_condition4_true_AND_I_condition5_true_COMPL) :- 
	true,
	holdsFor(condition1(X)=true, I_condition1_true),
	holdsFor(condition2(X)=true, I_condition2_true),
	holdsFor(condition3(X)=true, I_condition3_true),
	holdsFor(condition4(X)=true, I_condition4_true),
	union_all([I_condition3_true, I_condition4_true], I_condition3_true_OR_I_condition4_true),
	holdsFor(condition5(X)=true, I_condition5_true),
	complement(I_condition5_true, I_condition5_true_COMPL),
	intersect_all([I_condition3_true_OR_I_condition4_true, I_condition5_true_COMPL], I_condition3_true_OR_I_condition4_true_AND_I_condition5_true_COMPL),
	intersect_all([I_condition2_true, I_condition3_true_OR_I_condition4_true_AND_I_condition5_true_COMPL], I_condition2_true_AND_I_condition3_true_OR_I_condition4_true_AND_I_condition5_true_COMPL),
	intersect_all([I_condition1_true, I_condition2_true_AND_I_condition3_true_OR_I_condition4_true_AND_I_condition5_true_COMPL], I_condition1_true_AND_I_condition2_true_AND_I_condition3_true_OR_I_condition4_true_AND_I_condition5_true_COMPL).

holdsFor(working(X)=true, I_location_work_AND_I_takingBreak_true_COMPL) :- 
	true,
	holdsFor(location(X)=work, I_location_work),
	holdsFor(takingBreak(X)=true, I_takingBreak_true),
	complement(I_takingBreak_true, I_takingBreak_true_COMPL),
	intersect_all([I_location_work, I_takingBreak_true_COMPL], I_location_work_AND_I_takingBreak_true_COMPL).

holdsFor(resting(X)=true, I_location_pub_OR_I_onHoliday_true_OR_I_location_work_AND_I_takingBreak_true) :- 
	true,
	holdsFor(location(X)=pub, I_location_pub),
	holdsFor(onHoliday(X)=true, I_onHoliday_true),
	holdsFor(location(X)=work, I_location_work),
	holdsFor(takingBreak(X)=true, I_takingBreak_true),
	intersect_all([I_location_work, I_takingBreak_true], I_location_work_AND_I_takingBreak_true),
	union_all([I_onHoliday_true, I_location_work_AND_I_takingBreak_true], I_onHoliday_true_OR_I_location_work_AND_I_takingBreak_true),
	union_all([I_location_pub, I_onHoliday_true_OR_I_location_work_AND_I_takingBreak_true], I_location_pub_OR_I_onHoliday_true_OR_I_location_work_AND_I_takingBreak_true).

holdsFor(happy(X)=true, I_rich_true_OR_I_resting_true) :- 
	true,
	holdsFor(rich(X)=true, I_rich_true),
	holdsFor(resting(X)=true, I_resting_true),
	union_all([I_rich_true, I_resting_true], I_rich_true_OR_I_resting_true).

holdsFor(sad(X)=true, I_poor_true_AND_I_working_true_OR_I_atHome_true_AND_I_changingDiapers_true) :- 
	true,
	holdsFor(poor(X)=true, I_poor_true),
	holdsFor(working(X)=true, I_working_true),
	holdsFor(atHome(X)=true, I_atHome_true),
	holdsFor(changingDiapers(X)=true, I_changingDiapers_true),
	intersect_all([I_atHome_true, I_changingDiapers_true], I_atHome_true_AND_I_changingDiapers_true),
	union_all([I_working_true, I_atHome_true_AND_I_changingDiapers_true], I_working_true_OR_I_atHome_true_AND_I_changingDiapers_true),
	intersect_all([I_poor_true, I_working_true_OR_I_atHome_true_AND_I_changingDiapers_true], I_poor_true_AND_I_working_true_OR_I_atHome_true_AND_I_changingDiapers_true).

holdsFor(friends(X,Y)=true, I_atThePub_true_AND_I_atThePub_true_AND_I_rich_true_OR_I_rich_true_COMPL) :- 
	true,
	holdsFor(atThePub(X)=true, I_atThePub_true),
	holdsFor(atThePub(Y)=true, I_atThePub_true),
	holdsFor(rich(X)=true, I_rich_true),
	holdsFor(rich(Y)=true, I_rich_true),
	union_all([I_rich_true, I_rich_true], I_rich_true_OR_I_rich_true),
	complement(I_rich_true_OR_I_rich_true, I_rich_true_OR_I_rich_true_COMPL),
	intersect_all([I_atThePub_true, I_rich_true_OR_I_rich_true_COMPL], I_atThePub_true_AND_I_rich_true_OR_I_rich_true_COMPL),
	intersect_all([I_atThePub_true, I_atThePub_true_AND_I_rich_true_OR_I_rich_true_COMPL], I_atThePub_true_AND_I_atThePub_true_AND_I_rich_true_OR_I_rich_true_COMPL).

