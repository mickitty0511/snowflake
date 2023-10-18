use role accountadmin;
use schema global_weather__climate_data_for_bi.standard_tile;


create or replace view demo_db.PUBLIC.DETROIT_ZIPS(
	Zip
) as
    select 
        distinct postal_code 
    from 
        global_weather__climate_data_for_bi.standard_tile.history_day
    where 
        postal_code like '481%' 
        or postal_code like '482%'
;

-- answer to How many rows are in the HISTORY_DAY view?
select 
    count(*) 
from 
    history_day;

-- answer to How many rows in the HISTORY_DAY view are for Detroit Zips (as defined in our view)?
select 
    count(*)
from history_day as hd
join demo_db.public.detroit_zips as dz
on hd.postal_code = dz.zip;