use schema library_card_catalog.public;
use role sysadmin;

// ネストされた JSON データの取り込みテーブルを作成する
CREATE OR REPLACE TABLE LIBRARY_CARD_CATALOG.PUBLIC.NESTED_INGEST_JSON 
(
  RAW_NESTED_BOOK VARIANT
);

// インポート予定のJSONファイルの名前を確認
list @util_db.public.like_a_window_into_an_s3_bucket;

// ネストされたJSONデータをインポートする
copy into nested_ingest_json
from @util_db.public.like_a_window_into_an_s3_bucket/json_book_author_nested.json
file_format = (format_name = 'JSON_FILE_FORMAT');

///いくつかの簡単なクエリ
SELECT RAW_NESTED_BOOK
FROM NESTED_INGEST_JSON;

SELECT RAW_NESTED_BOOK:year_published
FROM NESTED_INGEST_JSON;m

SELECT RAW_NESTED_BOOK:authors
FROM NESTED_INGEST_JSON;

//括弧内の数字を変更して、別の行から著者を返してみて下さい
SELECT RAW_NESTED_BOOK:authors[0].first_name
FROM NESTED_INGEST_JSON;

//これらの flatten コマンドの例を使用して、ネストされた本と著者のデータを平坦化する方法を確認します
SELECT value:first_name
FROM NESTED_INGEST_JSON
,LATERAL FLATTEN(input => RAW_NESTED_BOOK:authors);

SELECT value:first_name
FROM NESTED_INGEST_JSON
,table(flatten(RAW_NESTED_BOOK:authors));

//返されたフィールドに ”::” を使ってCAST コマンドを追加します
SELECT value:first_name::VARCHAR, value:last_name::VARCHAR
FROM NESTED_INGEST_JSON
,LATERAL FLATTEN(input => RAW_NESTED_BOOK:authors);

//「AS」を使用して列に新しい列名を割り当てます
SELECT value:first_name::VARCHAR AS FIRST_NM
, value:last_name::VARCHAR AS LAST_NM
FROM NESTED_INGEST_JSON
,LATERAL FLATTEN(input => RAW_NESTED_BOOK:authors);