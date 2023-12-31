USE DATABASE LIBRARY_CARD_CATALOG;
use schema public;
use role sysadmin;

// 新しいシーケンスを作成します。これは book テーブルのカウンターになります
CREATE OR REPLACE SEQUENCE "LIBRARY_CARD_CATALOG"."PUBLIC"."SEQ_BOOK_UID" 
START 1 
INCREMENT 1 
COMMENT = 'Use this to fill in the BOOK_UID everytime you add a row';

// book テーブルを作成し、NEXTVAL を 
// テーブルに行が追加される際のデフォルト値とします
CREATE OR REPLACE TABLE BOOK
( BOOK_UID NUMBER DEFAULT SEQ_BOOK_UID.nextval
 ,TITLE VARCHAR(50)
 ,YEAR_PUBLISHED NUMBER(4,0)
);

// book テーブルにレコードを挿入します
// BOOK_UID フィールドはシーケンスのデフォルト
// 設定で処理されるため、
// あなたは何もリストする必要はありません
INSERT INTO BOOK(TITLE,YEAR_PUBLISHED)
VALUES
 ('Food',2001)
,('Food',2006)
,('Food',2008)
,('Food',2016)
,('Food',2015);

// リレーションシップ テーブルを作成します
// これは「多対多テーブル」と呼ばれることもあります
CREATE TABLE BOOK_TO_AUTHOR
(  BOOK_UID NUMBER
  ,AUTHOR_UID NUMBER
);

// 既知のリレーションに関する行を挿入
INSERT INTO BOOK_TO_AUTHOR(BOOK_UID,AUTHOR_UID)
VALUES
 (1,1) // This row links the 2001 book to Fiona Macdonald
,(1,2) // This row links the 2001 book to Gian Paulo Faleschini
,(2,3) // Links 2006 book to Laura K Egendorf
,(3,4) // Links 2008 book to Jan Grover
,(4,5) // Links 2016 book to Jennifer Clapp
,(5,6);// Links 2015 book to Kathleen Petelinsek


// 3 つのテーブルを結合して作業を確認します
// 著者ごとに 1 行を取得する必要があります
select * 
from book_to_author ba 
join author a 
on ba.author_uid = a.author_uid 
join book b 
on b.book_uid=ba.book_uid;
