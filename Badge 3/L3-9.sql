-- set your worksheet drop lists to the location of your GRADER function
-- SET YOUR DROPLISTS PRIOR TO RUNNING THE CODE BELOW 

--DO NOT EDIT BELOW THIS LINE
select grader(step, (actual = expected), actual, expected, description) as graded_results from(
SELECT 'SMEW04' as step
 ,(select count(*) 
   from INTL_DB.PUBLIC.NATIONS_SAMPLE_PLUS_ISO) as actual
 , 249 as expected
 ,'Nations Sample Plus Iso' as description
);