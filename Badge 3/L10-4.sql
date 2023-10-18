use role accountadmin;
use schema util_db.public;

-- set your worksheet drop lists to the location of your GRADER function
--DO NOT EDIT ANYTHING BELOW THIS LINE
select grader(step, (actual = expected), actual, expected, description) as graded_results from (
 SELECT 'SMEW12' as step
 ,(select count(*) 
   from SNOWFLAKE.ACCOUNT_USAGE.DATABASES 
   where database_name in ('INTL_DB','DEMO_DB','ACME', 'ACME_DETROIT','ADU_VINHANCED') 
   and deleted is null) as actual
 , 5 as expected
 ,'Databases from all over!' as description
); 


-- 
use role accountadmin;

alter DATABASE ACME rename to back_when_i_pretended_i_was_caden;

-- Set Up the ADU Decode Database and Schemas
USE ROLE SYSADMIN;

--Max created a database to store Vehicle Identification Numbers
CREATE DATABASE max_vin;

DROP SCHEMA max_vin.public;
CREATE SCHEMA max_vin.decode;

-- Max's Decode Tables
--We need a table that will allow WMIs to be decoded into Manufacturer Name, Country and Vehicle Type
CREATE TABLE MAX_VIN.DECODE.WMITOMANUF 
(
     WMI	        VARCHAR(6)
    ,MANUF_ID	    NUMBER(6)
    ,MANUF_NAME	    VARCHAR(50)
    ,COUNTRY	    VARCHAR(50)
    ,VEHICLETYPE    VARCHAR(50)
 );
 
--We need a table that will allow you to go from Manufacturer to Make
--For example, Mercedes AG of Germany and Mercedes USA both roll up into Mercedes
--But they use different WMI Codes
CREATE TABLE MAX_VIN.DECODE.MANUFTOMAKE
(
     MANUF_ID	NUMBER(6)
    ,MAKE_NAME	VARCHAR(50)
    ,MAKE_ID	NUMBER(5)
);

--We need a table that can decode the model year
-- The year 2001 is represented by the digit 1
-- The year 2020 is represented by the letter L
CREATE TABLE MAX_VIN.DECODE.MODELYEAR
(
     MODYEARCODE	VARCHAR(1)
    ,MODYEARNAME	NUMBER(4)
);

--We need a table that can decode which plant at which 
--the vehicle was assembled
--You might have code "A" for Honda and code "A" for Ford
--so you need both the Make and the Plant Code to properly decode 
--the plant code
CREATE TABLE MAX_VIN.DECODE.MANUFPLANTS
(
     MAKE_ID	NUMBER(5)
    ,PLANTCODE	VARCHAR(1)
    ,PLANTNAME	VARCHAR(75)
 );
 
--We need to use a combination of both the Make and VDS 
--to decode many attributes including the engine, transmission, etc
CREATE TABLE MAX_VIN.DECODE.MMVDS
(
     MAKE_ID	NUMBER(3)
    ,MODEL_ID	NUMBER(6)
    ,MODEL_NAME	VARCHAR(50)
    ,VDS	VARCHAR(5)
    ,DESC1	VARCHAR(25)
    ,DESC2	VARCHAR(25)
    ,DESC3	VARCHAR(50)
    ,DESC4	VARCHAR(25)
    ,DESC5	VARCHAR(25)
    ,BODYSTYLE	VARCHAR(25)
    ,ENGINE	VARCHAR(100)
    ,DRIVETYPE	VARCHAR(50)
    ,TRANS	VARCHAR(50)
    ,MPG	VARCHAR(25)
);

-- A File Format to Help Max Load the Data
--Create a file format and then load each of the 5 Lookup Tables
--You need a file format if you want to load the table
CREATE FILE FORMAT MAX_VIN.DECODE.COMMA_SEP_HEADERROW 
TYPE = 'CSV' 
COMPRESSION = 'AUTO' 
FIELD_DELIMITER = ',' 
RECORD_DELIMITER = '\n' 
SKIP_HEADER = 1 
FIELD_OPTIONALLY_ENCLOSED_BY = '\042'  
TRIM_SPACE = TRUE 
ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE 
ESCAPE = 'NONE' 
ESCAPE_UNENCLOSED_FIELD = '\134' 
DATE_FORMAT = 'AUTO' 
TIMESTAMP_FORMAT = 'AUTO' 
NULL_IF = ('\\N');