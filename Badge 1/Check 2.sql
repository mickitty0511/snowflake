--これらを手動で設定するか、次の 3 行のコードを編集して使うことができます

use database UTIL_DB;
use schema PUBLIC;
use role ACCOUNTADMIN;

--この行より下は編集しないでください

select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
 SELECT 'DWW02' as step 
 ,( select count(*) 
   from GARDEN_PLANTS.INFORMATION_SCHEMA.SCHEMATA 
   where schema_name = 'PUBLIC') as actual 
 , 0 as expected 
 ,'Deleted PUBLIC schema.' as description
); 