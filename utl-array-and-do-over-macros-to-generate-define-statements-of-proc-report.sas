Array and do_over macros to generate define statements of proc report

Problem: The op wanted to do the following

proc report data=finaldata;

   array headers(*) $ ("title1" "title2" "title3" "title4" "title5");

   array cols(*) (mycol1 mycol2 mycol3 mycol4 mycol5);

   do i=1 to dim(headers);
       define cols(i) / headers(i);
   end;

run;quit;

github
http://tinyurl.com/y6srlffh
https://github.com/rogerjdeangelis/utl-array-and-do-over-macros-to-generate-define-statements-of-proc-report

SAS Forum
http://tinyurl.com/y4tj9jzv
https://communities.sas.com/t5/ODS-and-Base-Reporting/using-loop-in-the-define-step-of-proc-report/m-p/535099

macros
https://tinyurl.com/y9nfugth
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories

For more functional barry and bdo_over macros by
Bartosz Jablonski
yabwon@gmail.com



INPUT
=====

  SASHELP.CLASS

  %array(cols,values=name age sex height weight);
  %array(hdrs,values=Student!Age!Sex!Student#Height!Student#Weight,delim=!);


EXAMPLE OUTPUT
==============

                        Student   Student
  Student    Age  Sex    Height    Weight

  Alfred      14  M          69     112.5
  Alice       13  F        56.5        84
  Barbara     13  F        65.3        98
  Carol       14  F        62.8     102.5

 ...

SOLUTION
========

%array(cols,values=name age sex height weight);
%array(hdrs,values=Student!Age!Sex!Student#Height!Student#Weight,delim=!);

proc report data=sashelp.class nowd missing split='#' headskip;

  cols %do_over(cols,phrase=? );

  %do_over(cols hdrs,phrase=%str(
     define ?cols / "?hdrs" width=8;
  ));

run;quit;


