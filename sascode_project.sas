* project code;

proc import datafile = "C:\Users\casti\OneDrive\Desktop\School_Stuff\Masters_Stuff\STAT 560\Project\covid_surv.csv"
out = work.covid
dbms = CSV; run; 

/* days it takes to recover -- all data */
proc lifetest data = covid plots = (survival);
	time days*status(0);
run;

/* days it takes to die -- all data */
proc lifetest data = covid plots = survival(nocensor test);
	time days*status(1);
run;

/* recovery based on age group */
proc lifetest data = covid plots = (survival);
	time days*status(0);
		strata age_group;
run;

/* recovery based on gender */
proc lifetest data = covid plots = (survival);
	time days*status(0);
		strata gender;
run;

/* cox-proportional hazards model */
data covid1; set covid;
 	M = (gender = 'male');
drop gender VAR1 id symptom country age_group;
run;

proc phreg data = covid1 outest = betas;
	model days*status(1) = age M;
		baseline out = outdata survival = sbar;
run;

proc print data = outdata;
run;
