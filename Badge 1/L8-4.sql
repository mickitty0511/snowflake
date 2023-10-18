--ファイル形式を指定しないファイル内のデータ
select $1
from @util_db.public.like_a_window_into_an_s3_bucket/LU_SOIL_TYPE.tsv;

--同じデータで以前に作成したファイル形式を指定  
select $1, $2, $3
from @util_db.public.like_a_window_into_an_s3_bucket/LU_SOIL_TYPE.tsv
(file_format => garden_plants.veggies.COMMASEP_DBLQUOT_ONEHEADROW);

--同じデータで以前に作成した別のファイル形式を指定
select $1, $2, $3
from @util_db.public.like_a_window_into_an_s3_bucket/LU_SOIL_TYPE.tsv
(file_format => garden_plants.veggies.PIPECOLSEP_ONEHEADROW );


create or replace table LU_SOIL_TYPE(
    SOIL_TYPE_ID number,	
    SOIL_TYPE varchar(15),
    SOIL_DESCRIPTION varchar(75)
);

copy into LU_SOIL_TYPE
from @util_db.public.like_a_window_into_an_s3_bucket/LU_SOIL_TYPE.tsv
file_format = (format_name='L8_CHALLENGE_FF');

select * from LU_SOIL_TYPE;