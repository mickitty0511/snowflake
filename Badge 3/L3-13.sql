use role accountadmin;
use schema intl_db.public;

create or replace view SIMPLE_CURRENCY(
	CTY_CODE
	,CUR_CODE
) as
  SELECT  
    country_char_code
    , currency_char_code
    FROM INTL_DB.PUBLIC.country_code_to_currency_code
;

select * from simple_currency;