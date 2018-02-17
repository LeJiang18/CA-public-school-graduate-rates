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
'Research Question: : How do the top 30 school areas of California in total graduate students compare to their dropout student numbers.?'
;

title2
'Rationale:It would be intriguing to see if the areas with the highest number of graduates would also be among the highest number of dropouts.'
;


footnote1
""
;

*
Methodology: 
Limitations: 
Followup Steps: 
;



title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
title1
'Research Question: What are the counties of the top 20 California High Schools that had the highest number of total high school graduates?' 
;

title2
'Rationale: This would show which counties have the highest populations in California.'
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
proc freq
        data=cde_2014_analytic_file
    ;
    table
             Percent_Eligible_FRPM_K12
            *PCTGE1500
            / missing norow nocol nopercent
    ;
        where
            not(missing(PCTGE1500))
    ;
    format
        Percent_Eligible_FRPM_K12 Percent_Eligible_FRPM_K12_bins.
        PCTGE1500 PCTGE1500_bins.
    ;
run;
title;
footnote;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
title1
'Research Question: Which grade has the highest number of dropouts ?'
;

title2
'This is important to know since then we would know which grade to target the most with counseling or help from teachers.'
;
*
Note: 
Methodology: 
Limitations: 
Followup Steps: 
;
proc print
        data=cde_2014_analytic_file_sort_sat(obs=10)
    ;
    id
        School_Name
    ;
    var
        excess_sat_takers
    ;
run;
title;
footnote;
