USE db_weather;

-- Operational Database 3.I
SELECT 
    MIN(inventory.first_year) AS first_PRCP_measurement
FROM
    inventory,
    element
WHERE
    element.property = 'precipitation'
        AND element.name = inventory.element;
    
-- Operational Database 3.II
SELECT 
    station.name AS station_name
FROM
    station,
    inventory
WHERE
    inventory.station = station.id
        AND inventory.first_year = (SELECT 
            MIN(inventory.first_year)
        FROM
            element,
            inventory
        WHERE
            element.property = 'precipitation'
                AND element.name = inventory.element);
        
-- Operational Database 3.III
SELECT 
    continent.name AS continent,
    COUNT(station.id) AS station_count
FROM
    station,
    country,
    continent
WHERE
    continent.cc = country.continent
        AND station.country = country.fips
GROUP BY continent.name
ORDER BY station_count DESC;

-- Operational Database 3.IV
SELECT 
    YEAR(observation.date_id) AS obs_year,
    AVG(observation.TMAX) AS average_TMAX
FROM
    observation,
    station,
    country
WHERE
    observation.station = station.id
        AND station.country = country.fips
        AND country.name = 'Portugal'
GROUP BY obs_year;

-- Operational Database 3.V
SELECT 
    MONTH(observation.date_id) AS obs_month,
    AVG(observation.PRCP) AS avg_PRCP,
    AVG(observation.TMAX) AS avg_TMAX,
    AVG(observation.TMIN) AS avg_TMIN,
    AVG(observation.TMAX - observation.TMIN) AS avg_deltaT
FROM
    observation,
    country,
    station
WHERE
    observation.station = station.id
        AND station.country = 'UK'
        AND YEAR(observation.date_id) BETWEEN YEAR(CURDATE()) - 10 AND YEAR(CURDATE()) - 1
GROUP BY obs_month
ORDER BY obs_month;


-- Operational Database 3.VI
SELECT 
    AVG(CASE
        WHEN YEAR(observation.date_id) = 2021 THEN observation.PRCP
    END) - AVG(CASE
        WHEN YEAR(observation.date_id) = 2006 THEN observation.PRCP
    END) AS deltaPRCP,
    AVG(CASE
        WHEN YEAR(observation.date_id) = 2021 THEN observation.TMAX
    END) - AVG(CASE
        WHEN YEAR(observation.date_id) = 2006 THEN observation.TMAX
    END) AS deltaTMAX,
    AVG(CASE
        WHEN YEAR(observation.date_id) = 2021 THEN observation.TMIN
    END) - AVG(CASE
        WHEN YEAR(observation.date_id) = 2006 THEN observation.TMIN
    END) AS deltaTMIN
FROM
    observation,
    country,
    station
WHERE
    observation.station = station.id
        AND station.country = country.fips
        AND country.name = 'United Kingdom'
        AND YEAR(observation.date_id) IN (2006 , 2021);
        