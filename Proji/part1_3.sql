-- Operational Database 3.I

SELECT 
    MIN(inventory.first_year) AS measured_first_time
FROM
    inventory, element
WHERE
    element.property = 'precipitation'
        AND element.name = inventory.element;
    
-- Operational Database 3.II

SELECT 
    station.name
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
    continent.name, COUNT(station.id) as station_count
FROM
    station,
    country,
    continent
WHERE
	continent.cc = country.continent and
    station.country = country.fips
GROUP BY continent.name
order by station_count desc;

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
    AVG(observation.PRCP),
    AVG(observation.TMAX),
    AVG(observation.TMIN),
    AVG(observation.TMAX - observation.TMIN)
FROM
    observation,
    country,
    station
WHERE
    observation.station = station.id
        AND station.country = 'UK'
        AND YEAR(observation.date_id) between year(curdate())-10 and year(curdate())-1 
GROUP BY obs_month
ORDER BY obs_month;


-- Operational Database 3.VI

SELECT 
    data_2021.PRCP_avg - data_2006.PRCP_avg AS PRCP_delta,
    data_2021.TMAX_avg - data_2006.TMAX_avg AS TMAX_delta,
    data_2021.TMIN_avg - data_2006.TMIN_avg AS TMIN_delta
FROM
    (SELECT 
        AVG(observation.PRCP) AS PRCP_avg,
            AVG(observation.TMAX) AS TMAX_avg,
            AVG(observation.TMIN) AS TMIN_avg
    FROM
        observation, country, station
    WHERE
        observation.station = station.id
            AND station.country = country.fips
            AND country.name = 'United Kingdom'
            AND YEAR(observation.date_id) = 2006) AS data_2006,
    (SELECT 
        AVG(observation.PRCP) AS PRCP_avg,
            AVG(observation.TMAX) AS TMAX_avg,
            AVG(observation.TMIN) AS TMIN_avg,
            AVG(observation.TMAX - observation.TMIN) AS deltaT
    FROM
        observation, country, station
    WHERE
        observation.station = station.id
            AND station.country = country.fips
            AND country.name = 'United Kingdom'
            AND YEAR(observation.date_id) = 2021) AS data_2021;