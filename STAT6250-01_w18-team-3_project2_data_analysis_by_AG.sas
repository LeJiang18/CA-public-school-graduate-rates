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
'Research Question: What are the best ten California High Schools whom will have the highest graduates ?'
;

title2
'Rationale: This will be show us where is the best ten high school in cali and we will see where school who have the highest graduates.'
;

footnote1
'The top ten California High Schools.

footnote2
'This shows  us  where is the best schcools in cali and where can have have the highest graduates .'
; 

Note: in the data Grads1314 and data Grads1415 the column "TOTAL" is compared 
amonsgt the 2 datasets.

*
Methodology: In this Step we will combinig Grads1314 and Grads1415 in data
preparation,  after that we will take we take the difference of values, after createing 
a variable called Total Graduates Rate Change,we useed proc
sort to create a table.

Limitations: We are not sure if the this top schooles have the highest number of gratuades.

Followup Steps: in this one we want to see    if the total number of graduates gos up for
the last ten schools in terms of total graduates.
;

proc print 
        data=Graduates_analytic_file_sorted(obs=20)
    ;
    id 
        CDS_CODE
    ;
    var 
        Total_Graduates_Rate_Change
    ;
run; 
title;
footnote;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question:  Which districts have the highest graduate students percentage?'
;

title2
'Rationale: Determining the districts having the highest graduate students percentage, one can estimate the educational progress of that district. This would help people to educate students in those districts or schools for maximizing chances of graduation.'
;

footnote1
'The districts having highest graduation rate are Verdes Peninsula Unified and Poway Unified'
;

*
Note: This makes use of "GRADRATES" column from the data set.
Methodology:  Use PROC SORT in "GRADRATES" column to examine districts 
with the highest graduation rate.

Limitations: It is hard to analyze data of the different graduation rates
from the districts, since school district rows and individual schools are 
unidentical.

Followup Steps: School district rows should be seperated from individual 
schools so that generated data can be analyzed properly.
;

proc print data=Graduates_analytic_file_MC2(obs=10);
		var District Gradrate;
run;

title;
footnote;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: Which grade has the lowest number of dropouts?'
;

title2
'Rationale: This gives the school an idea on which grade to concentrate to increase the number of graduates to decrease dropout rate.Also it gives the academically weaker students more importance.'
;

footnote1
'The grade with the lowest number of dropouts was grade 12.'
;

footnote2
'This shows that we need to concentrate on grade which have the lowest graduation rate of all.This would then require to focus more resources on that grade.'
;

*
Note: This compares the column "D9", "D10", "D11", "D12" from gradrates.

Methodology: Use proc means to find the sum for the columns D9, D10, D11,and 
D12 in the Graduates_analytic_file file created in data.
preparation. Then see which one has the highest number.

Limitations: The data is for a particular year. Not an average for 
over the years.

Followup Steps: Determine the grades having lowest graduation rate in
each school and direct resources towards those grades to increase
graduation.
;

proc means 
        data=Graduates_analytic_file
       min
    ;
    id
        CDS_CODE
    ;
    var
        D9 D10 D11 D12
    ;
run;
title;
footnote;

