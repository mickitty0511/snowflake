use role sysadmin;

// JSON DDL スクリプト
USE LIBRARY_CARD_CATALOG;

// JSONデータの取り込み用テーブルを作成します
CREATE TABLE LIBRARY_CARD_CATALOG.PUBLIC.AUTHOR_INGEST_JSON
(
  RAW_AUTHOR  VARIANT
);

// JSON Data 用のファイルフォーマットを作成
CREATE FILE FORMAT LIBRARY_CARD_CATALOG.PUBLIC.JSON_FILE_FORMAT 
TYPE = 'JSON' 
COMPRESSION = 'AUTO' 
ENABLE_OCTAL = false
ALLOW_DUPLICATE = false 
STRIP_OUTER_ARRAY = true
STRIP_NULL_VALUES = false
IGNORE_UTF8_ERRORS = false
;

// ファイル名確認
list @util_db.public.like_a_window_into_an_s3_bucket/au;

// JSONファイルからインポート
copy into author_ingest_json
from @util_db.public.like_a_window_into_an_s3_bucket/author_with_header.json
file_format = (format_name = 'JSON_FILE_FORMAT');

select 
    * 
from author_ingest_json;