-- select distinct count(*) from dw_weather.dimstation;

-- SHOW VARIABLES LIKE 'secure_file_priv';

-- INTO OUTFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\table2.csv'
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n';

-- truncate dw_weather.dimstation;

-- select id from dw_weather.dimstation
-- where id NOT IN (
-- select id from db_weather.station);

-- select min(inv.first_year) from db_weather.inventory inv where inv.element = 'PRCP';

-- 5.V
SELECT 
    country_name,
    MONTH(time_id) AS month,
    AVG(temp_range) AS highest_avg_temp_range
FROM
    (SELECT 
        time_id,
            ds.country_name,
            MAX(value) - MIN(value) AS temp_range
    FROM
        factobservation fo
    JOIN dimstation ds ON fo.station_id = ds.id
    GROUP BY time_id , ds.country_name
    ORDER BY ds.country_name) t1
GROUP BY MONTH(time_id) , country_name
ORDER BY highest_avg_temp_range DESC;


select value, country_name from factobservation fo
join dimstation ds on fo.station_id = ds.id
where country_name = 'Australia';

select element_id, value, country_name from factobservation fo
join dimstation ds on fo.station_id = ds.id
where country_name = 'Australia'
order by country_name;



