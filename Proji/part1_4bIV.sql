SELECT 
    observation.date_id AS date,
    observation.station AS station,
    observation.PRCP as precipitation,
    observation.TMAX as max_temperature,
    observation.TMIN as min_temperature,
    inventory.element AS element
FROM
    db_weather.observation AS observation
        JOIN
    db_weather.inventory AS inventory ON observation.station = inventory.station;