UTIL_DB-- ワークシート コンテキストの ロールを ACCOUNTADMIN に設定して下さい。
-- ワークシート コンテキストの データベースとスキーマを GRADER 関数の場所に設定して下さい。
-- この行より下は編集しないでください。コードは書かれているとおりに実行する必要があります。
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
 SELECT 'DWW09' as step
 ,( select count(*) 
   from GARDEN_PLANTS.INFORMATION_SCHEMA.FILE_FORMATS 
   where FIELD_DELIMITER ='|' 
   ) as actual
 , 1 as expected
 ,'File Format 2 Exists' as description
); 