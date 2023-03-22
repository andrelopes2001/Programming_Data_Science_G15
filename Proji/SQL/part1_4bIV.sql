INSERT IGNORE INTO dw_weather.factobservation
SELECT 
    o.date_id, o.station, de.id, o.PRCP AS value
FROM
    db_weather.Observation o,
    dw_weather.dimElement de
WHERE
    de.name = 'PRCP' AND o.PRCP IS NOT NULL 
UNION SELECT 
    o.date_id, o.station, de.id, o.TMAX AS value
FROM
    db_weather.Observation o,
    dw_weather.dimElement de
WHERE
    de.name = 'TMAX' AND o.TMAX IS NOT NULL 
UNION SELECT 
    o.date_id, o.station, de.id, o.TMIN AS value
FROM
    db_weather.Observation o,
    dw_weather.dimElement de
WHERE
    de.name = 'TMIN' AND o.TMIN IS NOT NULL;