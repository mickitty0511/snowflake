use schema garden_plants.veggies;
use role sysadmin;

create or replace table VEGETABLE_DETAILS_PLANT_HEIGHT (
    PLANT_NAME varchar(25)
    ,UOM varchar(1)
    ,LOW_END_OF_RANGE number
    ,HIGH_END_OF_RANGE number
);

copy into vegetable_details_plant_height
from @util_db.public.like_a_window_into_an_s3_bucket/veg_plant_height.csv
file_format = (format_name = 'COMMASEP_DBLQUOT_ONEHEADROW');

select * from vegetable_details_plant_height;
