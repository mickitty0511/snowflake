use schema library_card_catalog.public;
use role sysadmin;

CREATE SEQUENCE 
    AUTHOR_UID START = 3 
    INCREMENT = 1
    COMMENT = 'Use this to fill in AUTHOR_UID'
;

// カウンター (シーケンス) をドロップして再作成し、3 から始まるようにします 
// 次に、他の著者レコードをAuthorテーブルに追加します
CREATE OR REPLACE SEQUENCE LIBRARY_CARD_CATALOG.PUBLIC.SEQ_AUTHOR_UID
START 3 
INCREMENT 1 
COMMENT = 'Use this to fill in the AUTHOR_UID every time you add a row';

//残りの著者レコードを追加し、数字を入れる代わりに 
// nextval 関数を使用します
INSERT INTO AUTHOR(AUTHOR_UID,FIRST_NAME,MIDDLE_NAME, LAST_NAME) 
Values
(SEQ_AUTHOR_UID.nextval, 'Laura', 'K','Egendorf')
,(SEQ_AUTHOR_UID.nextval, 'Jan', '','Grover')
,(SEQ_AUTHOR_UID.nextval, 'Jennifer', '','Clapp')
,(SEQ_AUTHOR_UID.nextval, 'Kathleen', '','Petelinsek');