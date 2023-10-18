use role accountadmin;
use database util_db; --そのままでOKですが、必要であれば、別のデータベースに変更してください。
use schema public; --そのままでOKですが、必要であれば、別のスキーマに変更してください。

select grader(step, (actual = expected), actual, expected, description) as graded_results from
(SELECT 
 'DORA_IS_WORKING' as step
 ,(select 123) as actual
 ,123 as expected
 ,'Dora is working!' as description
); 