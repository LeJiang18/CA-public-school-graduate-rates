*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

* 
[Dataset 1 Name] Grads1314

[Dataset Description] A dataset containing information for California high 
school graduates by racial/ethnic group and school for the school year 2013 – 
2014.

[Experimental Unit Description] High Schools within California

[Number of Observations] 2495

[Number of Features] 15

[Data Source] http://dq.cde.ca.gov/dataquest/dlfile/dlfile.aspx?cLevel=School&cYear=2013-14&cCat=GradEth&cPage=filesgrad.asp
I followed the link for the California Department of Education datasets and 
found this one for California high school graduate information. After 
downloading the text file, the information was copied and pasted into Excel 
for visualization.

[Data Dictionary] http://www.cde.ca.gov/ds/sd/sd/fsgrad09.asp

[Unique ID Schema] CDS_CODE, a 14-digit primary key that is a unique ID for a 
school within California

--

[Dataset 2 Name] Grads1415

[Dataset Description] A dataset containing information for California high 
school graduates by racial/ethnic group and school for the school year 2014 – 
2015.

[Experimental Unit Description] High Schools within California

[Number of Observations] 2490

[Number of Features] 15

[Data Source] http://dq.cde.ca.gov/dataquest/dlfile/dlfile.aspx?cLevel=School&cYear=2014-15&cCat=GradEth&cPage=filesgrad.asp
I followed the link for the California Department of Education datasets and 
found this one for California high school graduate information. After 
downloading the text file, the information was copied and pasted into Excel 
for visualization.

[Data Dictionary] http://www.cde.ca.gov/ds/sd/sd/fsgrad09.asp

[Unique ID Schema] CDS_CODE, a 14-digit primary key that is a unique ID for 
a school within California

--

[Dataset 3 Name] GradRates

[Dataset Description] A dataset containing information for graduate rates 
for high schools in California. This dataset also contains dropout 
information.

[Experimental Unit Description] High Schools within California

[Number of Observations] 7543

[Number of Features] 11

[Data Source] http://dq.cde.ca.gov/dataquest/dlfile/dlfile.aspx?cLevel=All&cYear=0910&cCat=NcesRate&cPage=filesncesrate
I followed the link for the California Department of Education datasets and 
found this one for California high school graduate rates. After 
downloading the text file, the information was copied and pasted into Excel 
for visualization.

[Data Dictionary] http://www.cde.ca.gov/ds/sd/sd/fsncesrate.asp

[Unique ID Schema] CDS_CODE, a 14-digit primary key that is a unique ID for a school within California


--
;

* environmental setup;

* setup environmental parameters;
%let inputDataset1URL =
https://github.com/stat6250/team-3_project2/blob/project02/data/Grads1314.xlsx?raw=true
;
%let inputDataset1Type = XLSX;
%let inputDataset1DSN = grads1314_raw;

%let inputDataset2URL =
https://github.com/stat6250/team-3_project2/blob/project02/data/Grads1415.xlsx?raw=true
;
%let inputDataset2Type = XLSX;
%let inputDataset2DSN = grads1415_raw;

%let inputDataset3URL =
https://github.com/stat6250/team-3_project2/blob/project02/data/GradRates.xlsx?raw=true
;
%let inputDataset3Type = XLSX;
%let inputDataset3DSN = gradrates_raw;


* load raw datasets over the wire, if they doesn't already exist;
%macro loadDataIfNotAlreadyAvailable(dsn,url,filetype);
    %put &=dsn;
    %put &=url;
    %put &=filetype;
    %if
        %sysfunc(exist(&dsn.)) = 0
    %then
        %do;
            %put Loading dataset &dsn. over the wire now...;
            filename tempfile "%sysfunc(getoption(work))/tempfile.xlsx";
            proc http
                method="get"
                url="&url."
                out=tempfile
                ;
            run;
            proc import
                file=tempfile
                out=&dsn.
                dbms=&filetype.;
            run;
            filename tempfile clear;
        %end;
    %else
        %do;
            %put Dataset &dsn. already exists. Please delete and try again.;
        %end;
%mend;
%loadDataIfNotAlreadyAvailable(
    &inputDataset1DSN.,
    &inputDataset1URL.,
    &inputDataset1Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset2DSN.,
    &inputDataset2URL.,
    &inputDataset2Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset3DSN.,
    &inputDataset3URL.,
    &inputDataset3Type.
)



* sort and check raw datasets for duplicates with respect to their unique ids,
  removing blank rows, if needed;
proc sort
        nodupkey
        data=grads1314_raw
        dupout=grads1314_raw_dups
        out=grads1314_raw_sorted(where=(not(missing(CDS_Code))))
    ;
    by
       CDS_Code
    ;
run;
proc sort
        nodupkey
        data=grads1415_raw
        dupout=grads1415_raw_dups
        out=grads1415_raw_sorted
    ;
    by
        CDS_Code
    ;
run;
proc sort
        nodupkey
        data=gradrates_raw
        dupout=gradrates_raw_dups
        out=gradrates_raw_sorted
    ;
    by
        CDS_CODE
    ;
run;


* combine FRPM data vertically, combine composite key values into a primary key
  key, and compute year-over-year change in Percent_Eligible_FRPM_K12,
  retaining all AY2014-15 fields and y-o-y Percent_Eligible_FRPM_K12 change;
data frpm1415_raw_with_yoy_change;
    retain
        CDS_Code
    ;
    length
        CDS_Code $14.
    ;
    set
        frpm1516_raw_sorted(in=ay2015_data_row)
        frpm1415_raw_sorted(in=ay2014_data_row)
    ;
    retain
        Percent_Eligible_FRPM_K12_1516
    ;
    by
        County_Code
        District_Code
        School_Code
    ;
    if
        ay2015_data_row=1
    then
        do;
            Percent_Eligible_FRPM_K12_1516 = Percent_Eligible_FRPM_K12;
        end;
    else if
        ay2014_data_row=1
        and
        Percent_Eligible_FRPM_K12 > 0
        and
        substr(School_Code,1,6) ne "000000"
    then
        do;
            CDS_Code = cats(County_Code,District_Code,School_Code);
            frpm_rate_change_2014_to_2015 =
                Percent_Eligible_FRPM_K12
                -
                Percent_Eligible_FRPM_K12_1516
            ;
            output;
        end;
run;


* build analytic dataset from raw datasets with the least number of columns and
minimal cleaning/transformation needed to address research questions in
corresponding data-analysis files;
data cde_2014_analytic_file;
    retain
        CDS_Code
        School_Name
        Percent_Eligible_FRPM_K12
        frpm_rate_change_2014_to_2015
        PCTGE1500
        excess_sat_takers
    ;
    keep
        CDS_Code
        School_Name
        Percent_Eligible_FRPM_K12
        frpm_rate_change_2014_to_2015
        PCTGE1500
        excess_sat_takers
    ;
    merge
        frpm1415_raw_with_yoy_change
        gradaf15_raw
        sat15_raw(rename=(CDS=CDS_Code PCTGE1500=PCTGE1500_character))
    ;
    by
        CDS_Code
    ;
    if
        not(missing(compress(PCTGE1500_character,'.','kd')))
    then
        do;
            PCTGE1500 = input(PCTGE1500_character,best12.2);
        end;
    else
        do;
            call missing(PCTGE1500);
        end;
    excess_sat_takers = input(NUMTSTTAKR,best12.) - input(TOTAL,best12.);
    if
        not(missing(CDS_Code))
        and
        not(missing(School_Name))
        and
        not(missing(School_Name))
    ;
run;


* use proc sort to create a temporary sorted table in descending by
frpm_rate_change_2014_to_2015;
proc sort
        data=cde_2014_analytic_file
        out=cde_2014_analytic_file_sort_frpm
    ;
    by descending frpm_rate_change_2014_to_2015;
run;


* use proc sort to create a temporary sorted table in descending by
excess_sat_takers;
proc sort
        data=cde_2014_analytic_file
        out=cde_2014_analytic_file_sort_sat
    ;
    by descending excess_sat_takers;
run;

*combine datasets and use proc sql to calculate total number
of white students graduating in alameda county in each of
the 2 years;

data r1;
	merge grads1314_raw_sorted grads1415_raw_sorted;
	by YEAR;
run;

proc sql;
	select county,year,sum(white)as Total_White_Students
	from r1 where county="Alameda" 
	group by county,year;
quit;

*use proc sql to find the number of hispanic students
graduated in 2 years county wise to get a population
estimate of concentration hispanic students
in each county

proc sql;
	select county,sum(hispanic) as Hispanic_stud_grad
	from r1 group by county;
quit;
