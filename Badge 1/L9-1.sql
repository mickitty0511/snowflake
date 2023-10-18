use role sysadmin;

// 新しいデータベースを作成し、新しいデータベースを使用するようにコンテキストを設定します
CREATE DATABASE LIBRARY_CARD_CATALOG COMMENT = 'DWW Lesson 9 ';
USE DATABASE LIBRARY_CARD_CATALOG;

// Author （著者） テーブルの作成
CREATE OR REPLACE TABLE AUTHOR (
   AUTHOR_UID NUMBER 
  ,FIRST_NAME VARCHAR(50)
  ,MIDDLE_NAME VARCHAR(50)
  ,LAST_NAME VARCHAR(50)
);

// 最初の 2 人の著者を Author テーブルに挿入します
INSERT INTO AUTHOR(AUTHOR_UID,FIRST_NAME,MIDDLE_NAME, LAST_NAME) 
Values
(1, 'Fiona', '','Macdonald')
,(2, 'Gian','Paulo','Faleschini');

// 新しい行をテーブルで見てください
SELECT * 
FROM AUTHOR;

//See how the nextval function works
SELECT SEQ_AUTHOR_UID.nextval;

show sequences;

select SEQ_AUTHOR_UID.nextval, SEQ_AUTHOR_UID.nextval;
show sequences;