*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding graduates at CA public high schools

Dataset Name: __________ created in external file
STAT6250-01_w18-team-3_project2_data_preparation.sas, which is assumed to be
in the same directory as this file

See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic datasets cde_2014_analytic_file,
  cde_2014_analytic_file_sort_frpm, and cde_2014_analytic_file_sort_sat;
%include '.\STAT6250-01_w18-team-3_project2_data_preparation.sas';


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: Which racial group has the most drop-out students?'
;

title2
'Rationale: We can observe whether there is difference among different racial groups in terms of dropout rates.'
;

footnote1
""
;

*

Methodology: 

Limitations: the total number of a certain racial group matters, should count for rate instead of number of drop-outs.

Followup Steps: 
;

proc print
    data=by_race;
run;

title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: What are the top 5 high schools that have the highest dropout rate?'
;

title2
'Rationale: This can help identify which high schools' students have struggles to graduate and investigate should further aids needed.'
;

footnote1
""
;

*
Note: 

Methodology: 

Limitations: 

Followup Steps: 
;

proc print data=discrepancy1415(obs=10);
run;

title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: What grade has the highest number of dropouts?'
;

title2
"Rationale: We will be able to observe which grade will most dropout students decide to forgo their education from the result."
;

footnote1
""
;

*
Note: 

Methodology: 

Limitations: 

Followup Steps: 
;

proc print data=by_grade;
run;

title;
footnote;

