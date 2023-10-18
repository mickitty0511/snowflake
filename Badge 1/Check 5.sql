-- ワークシート コンテキストの ロールを ACCOUNTADMIN に設定して下さい。
-- ワークシート コンテキストの データベースとスキーマを GRADER 関数の場所に設定して下さい。
-- この行より下は編集しないでください。コードは書かれているとおりに実行する必要があります
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
 SELECT 'DWW05' as step
 ,( select count(*) 
   from GARDEN_PLANTS.INFORMATION_SCHEMA.TABLES 
   where table_name = 'VEGETABLE_DETAILS') as actual
 , 1 as expected
 ,'VEGETABLE_DETAILS Table' as description
); 