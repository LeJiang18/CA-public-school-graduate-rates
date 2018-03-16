*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding graduation numbers and rates for various California High
Schools.

Dataset Name: Graduates_analytic_file created in external file
STAT6250-01_w18-team-3_project2_data_preparation.sas, which is assumed to be
in the same directory as this file

See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic dataset cde_2014_analytic_file;
%include '.\STAT6250-01_w18-team-3_project2_data_preparation.sas';


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: Which schools have the highest number of graduates in years 2013-14 and 2014-15?'
;

title2
'Rationale: This helps one to determine the schools having high graduation as they are an indicator of excellent resources .'
;

footnote1
'We have output for the the top 5 California High School for the 2013-14 and 2014-15 academic years.'
;

footnote2 
'This shows that all 5 schools have more than 1000 students graduating which depicts the efficiency of schools .'
; 

footnote3
'Polytechnic High has very good reputation with very good teachers and very excellent management.'
;
*
Note: in the data Grads1314 we are taking the max of the column "TOTAL". 

Methodology: In this Step we used proc sql to find the highest number of 
student top twenty school.

Limitations: We are not sure if the this top schooles have the highest 
number of gratuades.

Followup Steps: in this one we want to see if the total number of 
graduates gos up forthe last ten schools in terms of total graduates.
;

proc print
        data = mt12 (obs=10) noobs label
    ;
    var
    	school
        county
	district
	year
   	total
    ;
    label
    	school='School'
     	county='County'
     	district='District'
   	total='Total number of graduates'
    ;
    format
    	year  YYMMDDw
    	total comma12.2
    ;
run;

title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question:  Which districts and county has the highest graduate 
students percentage ever recorded in all the acadmeic year ?'
;

title2
'Rationale: Determining the districts having the highest graduate students,from here we can estimate the educational progress of that districtand  would help us  to educate students in those districts or schools for maximizing chances of graduation.'
;

footnote1
'The districts having highest graduation rate are Verdes Peninsula Unified (Los Angeles county) and Poway Unified (San Diego county) in the academic year 2009-10.'
;

footnote2
'The percentage of graduates is 99.8% for both counties.'
;

footnote3
'This shows that we need to use thes two districts as an example to learn from their experiences .'
;

*
Note: This makes use of "GRADRATES" column from the data set.

Methodology:  Use PROC Sql  in "GRADRATES" column to examine districts 
with the highest graduation rate.

Limitations: It is hard to analyze data of the different graduation rates
from the districts, since school district rows and individual schools are 
unidentical.

Followup Steps: School district rows should be seperated from individual 
schools so that generated data can be analyzed properly.
;

proc sql;
	select count(district) as Number of Districts
	from grads1314_raw_sorted;
	select count(district) as Number of Districts
	from grads1415_raw_sorted;
quit;

title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question: How does the drop out rate vary among the different grades?'
;

title2
'Rationale: this one will give the school an idea which grade need to focus on to decrease the dropouts.'
;

footnote1
'The grade 12 has the highest number of dropouts i.e 42078 in total of the whole state.'
;

footnote2
'This shows that we need to concentrate on grade 12 which have the highest graduation rate of all and find a solution to reduce the dropouts and increase the grdauates for the development of children.'
;

footnote3
'12th grade students are old and mature enough to work, if they do not have financial support. To meet their and the family needs, they might start working outside resulting in dropping their school and losing a chance to graduate from high school.'
;
*
Note: This compares the column "D9", "D10", "D11", "D12" from gradrates.

Methodology: Use proc Sort to find the min for the columns D9, D10, D11,and 
D12 in the gradrates_raw_sorted created in data.
preparation.we went to see which one has the lowest number.

Limitations: We can further analyze the data to pin point correlations among
the different dropout rates over the years.

Followup Steps: Determine the grades having lowest graduation rate in
each district .
;

proc print
        data = min_Desc (obs=10) noobs label
    ;
    var
    	school
        county
	district
   	D9
	D10
	D11
	D12
    ;
    label
    	school='School'
     	county='County'
     	district='District'
   	D9='9th Grade Dropout'
	D10='10th Grade Dropout'
	D11='11th Grade Dropout'
	D12='12th Grade Dropout'
    ;
    format
    	
    	D9 comma12.2
	D10 comma12.2
	D11 comma12.2
	D12 comma12.2
run;

title;
footnote;
