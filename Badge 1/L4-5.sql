USE WAREHOUSE COMPUTE_WH;

INSERT INTO ROOT_DEPTH
(
    ROOT_DEPTH_ID
    ,ROOT_DEPTH_CODE
    ,ROOT_DEPTH_NAME
    ,UNIT_OF_MEASURE
    ,RANGE_MIN
    ,RANGE_MAX
)

VALUES (
    1
    ,'S'
    ,'Shallow'
    ,'cm'
    ,30
    ,45
)
,(
    2
    ,'M'
    ,'Medium'
    ,'cm'
    ,45
    ,60
)
,(
    3
    ,'D'
    ,'Deep'
    ,'cm'
    ,60
    ,90
);

select * from root_depth

-- to delete target rows 
-- delete from root_depth
-- where root_depth_id = 2;