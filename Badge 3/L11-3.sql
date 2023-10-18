use role accountadmin;
use schema util_db.public;

-- set the worksheet drop lists to match the location of your GRADER function

--DO NOT MAKE ANY CHANGES BELOW THIS LINE
select grader(step, (actual = expected), actual, expected, description) as graded_results from
(
SELECT 'SMEW13' as step
 ,(select count(*) 
   from MAX_OUTGOING.FOR_ACME.LOTSTOCKRETURN) as actual
 , 298 as expected
 ,'LotStockReturn Table loaded' as description
);