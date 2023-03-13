SELECT 
    observation.date_id AS date,
    observation.station AS station,
    observation.PRCP AS precipitation,
    observation.TMAX AS max_temperature,
    observation.TMIN AS min_temperature,
    inventory.element AS element
FROM
    db_weather.observation AS observation
        JOIN
    db_weather.inventory AS inventory ON observation.station = inventory.station;