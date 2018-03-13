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
'Research Question: Which schools have the highest graduates ?'
;

title2
'Rationale: This helps one to determine the schools which have the best resources as they are an indicator of high graduation.'
;

footnote1
'The top California High Schools.'
;

footnote2 
'This shows us that Downey High and Paramount High have the highest number of  graduation .'
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

proc sql;
	select school,year,total 
        from grads1314_raw_sorted where total = 
	(select max(total) from grads1314_raw_sorted);
quit; 

title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
'Research Question:  Which districts have the highest graduate students percentage ?'
;

title2
'Rationale: Determining the districts having the highest graduate students,from here we can estimate the educational progress of that districtand  would help us  to educate students in those districts or schools for maximizing chances of graduation.'
;

footnote1
'The districts having highest graduation rate are Verdes Peninsula Unified and Poway Unified'
;

footnote2
'This shows that we need to concentrate about this two schools to learn from their experiences .'
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
       select district, year,gradrate
       from gradrates_raw_sorted where gradrate =
       (select max(gradrate)from gradrates_raw_sorted);
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
'The grade 12 has the highest number of dropouts.'
;

footnote2
'This shows that we need to concentrate on grade which have the lowest graduation rate of all and find a solution to reduce the dropouts.'
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
        data = min_Desc (obs=20) 
    ;
    var
   	D9
	D10
	D11
	D12
    ;
run;

title;
footnote;
