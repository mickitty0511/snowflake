-- Join Local Data with Shared Data
SELECT  
    iso_country_name
    , country_name_official,alpha_code_2digit
    ,r_name as region
FROM INTL_DB.PUBLIC.INT_STDS_ORG_3661 i
LEFT JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.NATION n
ON UPPER(i.iso_country_name)=n.n_name
LEFT JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.REGION r
ON n_regionkey = r_regionkey;

-- Convert the Select Statement into a View
CREATE VIEW INTL_DB.PUBLIC.NATIONS_SAMPLE_PLUS_ISO 
( iso_country_name
  ,country_name_official
  ,alpha_code_2digit
  ,region) AS
  SELECT  
    iso_country_name
    , country_name_official,alpha_code_2digit
    ,r_name as region
    FROM INTL_DB.PUBLIC.INT_STDS_ORG_3661 i
    LEFT JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.NATION n
    ON UPPER(i.iso_country_name)=n.n_name
    LEFT JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.REGION r
    ON n_regionkey = r_regionkey
;

SELECT *
FROM INTL_DB.PUBLIC.NATIONS_SAMPLE_PLUS_ISO;