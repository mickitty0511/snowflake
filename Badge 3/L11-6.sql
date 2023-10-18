use role accountadmin;
use schema util_db.public;

-- set the worksheet drop lists to match the location of your GRADER function
--DO NOT MAKE ANY CHANGES BELOW THIS LINE
select grader(step, (actual = expected), actual, expected, description) as graded_results from (
SELECT 
  'SMEW14' as step
 ,(select count(*) 
   from DEMO_DB.PUBLIC.DETROIT_ZIPS) as actual
 , 9 as expected
 ,'Detroit Zips' as description
); 