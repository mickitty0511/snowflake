create or replace view AVG_CLOUD_COVER_PERCENT_PER_DAY(
    date
    , Average_Cloud_Cover_Percent
) as select 
        date_valid_std
        ,avg(avg_cloud_cover_tot_pct) as avg_cover
    from
        forecast_day as fc
    join 
        demo_db.public.detroit_zips as dz
    on 
        fc.postal_code = dz.zip
    group by 
        date_valid_std
    order by 
        avg_cover;