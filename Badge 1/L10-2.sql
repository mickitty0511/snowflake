use schema library_card_catalog.public;
use role sysadmin;

//最上位オブジェクトの属性から AUTHOR_UID 値を返します
select raw_author:AUTHOR_UID
from author_ingest_json;

//正規化されたテーブルのように見える方法でデータを返します
SELECT 
 raw_author:AUTHOR_UID
,raw_author:FIRST_NAME::STRING as FIRST_NAME
,raw_author:MIDDLE_NAME::STRING as MIDDLE_NAME
,raw_author:LAST_NAME::STRING as LAST_NAME
FROM AUTHOR_INGEST_JSON;