SELECT
  *
FROM
  VEGETABLE_DETAILS;

select
    *
from
    vegetable_details
where 
    plant_name = 'Spinach';

delete from vegetable_details
where plant_name = 'Spinach'
and root_depth_code = 'D';