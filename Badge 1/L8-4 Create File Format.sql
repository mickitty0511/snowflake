use schema GARDEN_PLANTS.VEGGIES;
use role SYSADMIN;

create or replace file format garden_plants.veggies.L8_CHALLENGE_FF 
    TYPE = 'CSV'                  --csv は色々なフラットファイルに使えます。(コンマ区切り、tsv, パイプ区切りなど)
    FIELD_DELIMITER = '0x09'      --tab(0x09)が列の区切り文字で使われます。
    SKIP_HEADER = 1               --一行目はヘッダなのでスキップします。
;

select $1, $2, $3
from @util_db.public.like_a_window_into_an_s3_bucket/LU_SOIL_TYPE.tsv
(file_format => garden_plants.veggies.L8_CHALLENGE_FF);

