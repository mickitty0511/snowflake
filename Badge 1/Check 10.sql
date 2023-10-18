use role accountadmin;
use schema util_db.public;

select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
 SELECT 'DWW10' as step
  ,( select count(*) 
    from UTIL_DB.INFORMATION_SCHEMA.stages
    where stage_url='s3://uni-lab-files' 
    and stage_type='External Named') as actual
  , 1 as expected
  , 'External stage created' as description
 );