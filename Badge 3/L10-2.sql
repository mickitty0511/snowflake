use role accountadmin;
use schema util_db.public;

--Use a COPY INTO to load the data
--the file is named Lotties_LotStock_Data.csv

COPY INTO acme.stock.lotstock
from @util_db.public.like_a_window_into_an_s3_bucket
files = ('smew/Lotties_LotStock_Data.csv')
file_format =(format_name=ACME.STOCK.COMMA_SEP_HEADERROW);


-- After loading your base table is no longer empty
-- it should now have 300 rows
select * from acme.stock.lotstock;

--the View will show just 298 rows because the view only shows
--rows where the date_sold is null
select * from acme.adu.lotstock;