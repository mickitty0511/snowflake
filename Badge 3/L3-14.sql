use role accountadmin;
use schema util_db.public;

-- set your worksheet drop lists to the location of your GRADER function

--DO NOT EDIT BELOW THIS LINE
select grader(step, (actual = expected), actual, expected, description) as graded_results from(
 SELECT 'SMEW07' as step 
,(select count(*) 
  from INTL_DB.PUBLIC.SIMPLE_CURRENCY ) as actual
, 265 as expected
,'Simple Currency Looks Good' as description
);
