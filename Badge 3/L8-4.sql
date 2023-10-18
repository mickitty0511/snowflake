select 
    min(date_valid_std) as hs_mn
    , max(date_valid_std) as hs_mx
    , datediff('day', hs_mn, hs_mx)
from
    history_day as hs
join demo_db.public.detroit_zips as dz
on hs.postal_code = dz.zip
;

select 
    min(date_valid_std) as fc_mn
    , max(date_valid_std) as fc_mx
    , datediff('day', fc_mn, fc_mx)
from
    forecast_day fc
join demo_db.public.detroit_zips as dz
on fc.postal_code = dz.zip
;