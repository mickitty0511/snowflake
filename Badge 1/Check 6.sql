-- ワークシート コンテキストの ロールを ACCOUNTADMIN に設定して下さい。
-- ワークシート コンテキストの データベースとスキーマを GRADER 関数の場所に設定して下さい。
-- この行より下は編集しないでください。コードは書かれているとおりに実行する必要があります
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from ( 
 SELECT 'DWW06' as step 
,( select row_count 
  from GARDEN_PLANTS.INFORMATION_SCHEMA.TABLES 
  where table_name = 'ROOT_DEPTH') as actual 
, 3 as expected 
,'ROOT_DEPTH row count' as description
);