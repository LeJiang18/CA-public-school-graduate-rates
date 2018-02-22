*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding graduation numbers and rates for various California High
Schools
Dataset Name: Graduates_analytic_file created in external file
STAT6250-01_w18-team-3_project2_data_preparation.sas, which is assumed to be
in the same directory as this file
See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic dataset cde_2014_analytic_file;
%include '.\STAT6250-01_w18-team-3_project2_data_preparation.sas'


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: What are the counties of the top 10 California High Schools that had the highest number total high school graduates?'
;

title2
'Rationale: This would show which counties have the highest populations in California.'
;


*Note: This compares the column "Total" from Grads1314to the column of the same 
name from Grads1415.
*
Methodology: When combining the files Grads1314 and Grads1415 in data
preparation, take the difference of values of the column Total for each school
and create a new variable called Total_Graduates_Rate_Change.

Limitations: We don't really know if schools kept the same amount of students 
per year. It's possible that a school could have increased the number of
students.

Followup Steps:
;

proc print 
        data=Graduates_analytic_file_Total(obs=10)
    ;
    id 
        CDS_CODE
    ;
    var 
        SCHOOL COUNTY GRADRATE TOTAL
    ;
run; 

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: What are the top 10 schools with the highest graduation rate?'
;

title2
'Rationale: These schools would be interesting to research to see why they have the highest graduation rate.'
;

*
Methodology: Use PROC PRINT to print out the first ten observations
for the GRADRATE column in the temporary dataset created in the data prep file. 
Then compare the graduation rates.

Limitations: This doesn't take into account total number of students. It's
possible a school could have a low total number of students so it would 
have an better chance of having a higher graduation rate.

Followup Steps: Check the bottom ten schools with the lowest gradution rates.
;

proc print 
        data=Graduates_analytic_file_GradRate(obs=20)
    ;
    id 
        CDS_CODE
    ;
    var 
        SCHOOL GRADRATE
    ;
run;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: Which grade has the highest number of dropouts?'
;

title2
'Rationale: This is important to know since then we would know which grade to target the most with counseling or help from teachers.'
;

*
Methodology: Use proc means to find the sum for the columns D9, D10, D11, and 
D12 in the Graduates_analytic_file file created in data.
preparation. Then see which one has the highest number.

Limitations: None

Followup Steps: See which high schools have the highest number of dropouts,
which would demonstrate that these schools maybe need to improve their
teaching/counseling services or something.
;

proc means 
        data=Graduates_analytic_file
        sum
    ;
    id
        CDS_CODE
    ;
    var
        D9 D10 D11 D12
    ;
run;
;
