-- ワークシート コンテキストの ロールを ACCOUNTADMIN に設定して下さい。
-- ワークシート コンテキストの データベースとスキーマを GRADER 関数の場所に設定して下さい。
-- この行より下は編集しないでください。コードは書かれているとおりに実行する必要があります
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
 SELECT 'DWW04' as step
 ,( select count(*) as SCHEMAS_FOUND 
   from UTIL_DB.INFORMATION_SCHEMA.SCHEMATA) as actual
 , 2 as expected
 , 'UTIL_DB Schemas' as description
);