-- Join the Decode Tables with the Table Lottie Provided
--Max has Lottie's VINventory table. Now he'll join his decode tables to the data
-- He'll create a select statement that ties each table into Lottie's VINS
-- Every time he adds a new table, he'll make sure he still has 298 rows

SELECT *
FROM ACME_DETROIT.ADU.LOTSTOCK l-- he uses Lottie's data from the INBOUND SHARE 
JOIN MAX_VIN.DECODE.MODELYEAR y -- and confirms he can join it with his own decode data
ON l.modyearcode=y.modyearcode;

SELECT *
FROM ACME_DETROIT.ADU.LOTSTOCK l -- he uses Lottie's data from the INBOUND SHARE 
JOIN MAX_VIN.DECODE.WMITOMANUF w -- and confirms he can join it with his own decode data
ON l.WMI=w.WMI;

--Add the next table (still 298?)
SELECT *
FROM ACME_DETROIT.ADU.LOTSTOCK l -- he uses Lottie's data from the INBOUND SHARE 
JOIN MAX_VIN.DECODE.WMITOMANUF w -- and confirms he can join it with his own decode data 
ON l.WMI=w.WMI
JOIN MAX_VIN.DECODE.MANUFTOMAKE m
ON w.manuf_id=m.manuf_id;

--Until finally he has all 5 lookup tables added
--He can then remove the asterisk and start narrowing down the 
--fields to include in the final output
SELECT 
l.VIN
,y.MODYEARNAME
,m.MAKE_NAME
,v.DESC1
,v.DESC2
,v.DESC3
,BODYSTYLE
,ENGINE
,DRIVETYPE
,TRANS
,MPG
,MANUF_NAME
,COUNTRY
,VEHICLETYPE
,PLANTNAME
FROM ACME_DETROIT.ADU.LOTSTOCK l -- he joins Lottie's data from the INBOUND SHARE 
JOIN MAX_VIN.DECODE.WMITOMANUF w -- with all his data (he just tested)
    ON l.WMI=w.WMI
JOIN MAX_VIN.DECODE.MANUFTOMAKE m
    ON w.manuf_id=m.manuf_id
JOIN MAX_VIN.DECODE.MANUFPLANTS p
    ON l.plantcode=p.plantcode
    AND m.make_id=p.make_id
JOIN MAX_VIN.DECODE.MMVDS v
    ON v.vds=l.vds 
    and v.make_id = m.make_id
JOIN MAX_VIN.DECODE.MODELYEAR y
    ON l.modyearcode=y.modyearcode;

-- Create a View
-- Once the select statement looks good (above), Max lays a view on top of it
-- this will make it easier to use in a Stored procedure

USE ROLE SYSADMIN;
CREATE DATABASE MAX_OUTGOING; --this new database will be used for his OUTBOUND SHARE
CREATE SCHEMA MAX_OUTGOING.FOR_ACME; --this schema he creates especially for ACME

-- This is a live view of the data Lottie and Caden Need!
CREATE OR REPLACE SECURE VIEW MAX_OUTGOING.FOR_ACME.LOTSTOCKENHANCED as 
(
SELECT 
l.VIN
,y.MODYEARNAME
,m.MAKE_NAME
,v.DESC1
,v.DESC2
,v.DESC3
,BODYSTYLE
,ENGINE
,DRIVETYPE
,TRANS
,MPG
,EXTERIOR
,INTERIOR
,MANUF_NAME
,COUNTRY
,VEHICLETYPE
,PLANTNAME
FROM ACME_DETROIT.ADU.LOTSTOCK l
JOIN MAX_VIN.DECODE.WMITOMANUF w
    ON l.WMI=w.WMI
JOIN MAX_VIN.DECODE.MANUFTOMAKE m
    ON w.manuf_id=m.manuf_id
JOIN MAX_VIN.DECODE.MANUFPLANTS p
    ON l.plantcode=p.plantcode
    AND m.make_id=p.make_id
JOIN MAX_VIN.DECODE.MMVDS v
    ON v.vds=l.vds and v.make_id = m.make_id
JOIN MAX_VIN.DECODE.MODELYEAR y
    ON l.modyearcode=y.modyearcode
);

-- Set Up the Shareback Table
-- Even though it would be nice to share the view back to Lottie, 
-- You can't share a share so we have to make a copy of the data to share back

CREATE OR REPLACE TABLE MAX_OUTGOING.FOR_ACME.LOTSTOCKRETURN
(
     VIN	        VARCHAR(17)
    ,MODYEARNAME	NUMBER(4)
    ,MAKE_NAME	    VARCHAR(50)
    ,DESC1	        VARCHAR(50)
    ,DESC2	        VARCHAR(50)
    ,DESC3	        VARCHAR(50)
    ,BODYSTYLE	    VARCHAR(25)
    ,ENGINE	        VARCHAR(100)
    ,DRIVETYPE	    VARCHAR(50)
    ,TRANS	        VARCHAR(50)
    ,MPG	        VARCHAR(25)
    ,EXTERIOR	    VARCHAR(50)
    ,INTERIOR	    VARCHAR(50)
    ,MANUF_NAME	    VARCHAR(50)
    ,COUNTRY	    VARCHAR(50)
    ,VEHICLETYPE	VARCHAR(50)
    ,PLANTNAME	    VARCHAR(75)
  );