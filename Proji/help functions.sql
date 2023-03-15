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

select min(inv.first_year) from db_weather.inventory inv where inv.element = 'PRCP';



