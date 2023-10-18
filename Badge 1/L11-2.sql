use role sysadmin;

-- Twitter ファイルを保持する新しいデータベースを作成します
CREATE DATABASE SOCIAL_MEDIA_FLOODGATES 
COMMENT = 'There\'s so much data from social media - flood warning';

USE DATABASE SOCIAL_MEDIA_FLOODGATES;

-- 新しいデータベースにテーブルを作成します
CREATE TABLE SOCIAL_MEDIA_FLOODGATES.PUBLIC.TWEET_INGEST 
("RAW_STATUS" VARIANT) 
COMMENT = 'Bring in tweets, one row per tweet or status entity';

-- 新しいデータベースに JSON ファイル形式を作成します
CREATE FILE FORMAT SOCIAL_MEDIA_FLOODGATES.PUBLIC.JSON_FILE_FORMAT 
TYPE = 'JSON' 
COMPRESSION = 'AUTO' 
ENABLE_OCTAL = FALSE 
ALLOW_DUPLICATE = FALSE 
STRIP_OUTER_ARRAY = TRUE 
STRIP_NULL_VALUES = FALSE 
IGNORE_UTF8_ERRORS = FALSE;

-- インポートするJSONデータを探索
list @util_db.public.like_a_window_into_an_s3_bucket/;

-- JSONデータをインポート
copy into tweet_ingest
from @util_db.public.like_a_window_into_an_s3_bucket/nutrition_tweets.json
file_format = (format_name = 'JSON_FILE_FORMAT');

-- インポートしたデータを表示
select * from tweet_ingest;

-- データをSELECTします
SELECT RAW_STATUS
FROM TWEET_INGEST;

SELECT RAW_STATUS:entities
FROM TWEET_INGEST;

SELECT RAW_STATUS:entities:hashtags
FROM TWEET_INGEST;

-- 括弧で囲まれた数字を追加して、特定のハッシュタグを見て探索します
-- このクエリは、各ツイートの最初のハッシュタグのみを返します
SELECT RAW_STATUS:entities:hashtags[0].text
FROM TWEET_INGEST;

-- このSELECTでは、ハッシュタグを含まないツイートを含めないために 
-- WHERE 句が追加されています。 
SELECT RAW_STATUS:entities:hashtags[0].text
FROM TWEET_INGEST
WHERE RAW_STATUS:entities:hashtags[0].text is not null;

-- created_at キーで単純な CAST を実行します
-- ORDER BY 句を追加して、ツイートの作成日で並べ替えます
SELECT RAW_STATUS:created_at::DATE
FROM TWEET_INGEST
ORDER BY RAW_STATUS:created_at::DATE;

-- ハッシュタグ エンティティ全体を返すステートメントをフラット化します
SELECT value
FROM TWEET_INGEST
,LATERAL FLATTEN
(input => RAW_STATUS:entities:hashtags);

SELECT value
FROM TWEET_INGEST
,TABLE(FLATTEN(RAW_STATUS:entities:hashtags));

-- 値をハッシュタグの TEXT のみに制限するフラット化のステートメント
SELECT value:text
FROM TWEET_INGEST
,LATERAL FLATTEN
(input => RAW_STATUS:entities:hashtags);


-- フラット化してハッシュタグのみを返し、TEXTを VARCHAR としてCASTします
SELECT value:text::VARCHAR
FROM TWEET_INGEST
,LATERAL FLATTEN
(input => RAW_STATUS:entities:hashtags);

-- フラット化してハッシュタグのTEXTのみを返し、TEXTを VARCHAR としてキャストします
-- AS コマンドを使用して列に名前を付けます
SELECT value:text::VARCHAR AS THE_HASHTAG
FROM TWEET_INGEST
,LATERAL FLATTEN
(input => RAW_STATUS:entities:hashtags);

-- 返されたテーブルにツイート ID とユーザー ID を追加します
SELECT RAW_STATUS:user:id AS USER_ID
,RAW_STATUS:id AS TWEET_ID
,value:text::VARCHAR AS HASHTAG_TEXT
FROM TWEET_INGEST
,LATERAL FLATTEN
(input => RAW_STATUS:entities:hashtags);