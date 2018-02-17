*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding graduates at CA public high schools

Dataset Name: cde_2014_analytic_file created in external file
STAT6250-02_s17-team-0_project2_data_preparation.sas, which is assumed to be
in the same directory as this file

See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic datasets cde_2014_analytic_file,
  cde_2014_analytic_file_sort_frpm, and cde_2014_analytic_file_sort_sat;
%include '.\STAT6250-02_s17-team-0_project2_data_preparation.sas';


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: How is the dropout rate relate to different racial group, are they significant?'
;

title2
'Rationale: We can observe whether there is difference among different racial groups in terms of dropout rates.'
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

