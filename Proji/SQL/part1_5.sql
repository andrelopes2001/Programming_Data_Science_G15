USE dw_weather;

-- 5.I
SELECT 
    YEAR(fo.time_id) year, SUM(fo.value) ANNUAL_PRCP
FROM
    DimStation ds,
    DimElement de,
    FactObservation fo
WHERE
    ds.country_name = 'Portugal'
        AND de.name = 'PRCP'
        AND de.id = fo.element_id
        AND ds.id = fo.station_id
GROUP BY YEAR(fo.time_id)
ORDER BY YEAR(fo.time_id);

-- 5.II
SELECT 
    ds.country_name country
FROM
    DimStation ds,
    DimElement de,
    DimTime dt,
    FactObservation fo
WHERE
    ds.id = fo.station_id
        AND de.name = 'TMAX'
        AND de.id = fo.element_id
        AND dt.date_id = fo.time_id
GROUP BY dt.year , ds.country_name
ORDER BY AVG(fo.value) DESC
LIMIT 1;


-- 5.III
SELECT 
    dt.day_week WEEK_DAY
FROM
    DimElement de,
    DimTime dt,
    FactObservation fo
WHERE
    de.name = 'PRCP'
        AND de.id = fo.element_id
        AND dt.date_id = fo.time_id
GROUP BY dt.day_week
ORDER BY SUM(fo.value) DESC
LIMIT 1;

-- 5.IV
SELECT 
    cont_elem_obs.element,
    AVG(cont_elem_obs.number_observations) AS avg_continent
FROM
    (SELECT 
        ds.continent_name continent,
            de.descripttion element,
            COUNT(time_id) number_observations
    FROM
        DimStation ds, DimElement de, FactObservation fo
    WHERE
        ds.id = fo.station_id
            AND de.id = fo.element_id
    GROUP BY ds.continent_name , de.descripttion
    ORDER BY ds.continent_name , de.descripttion) AS cont_elem_obs
GROUP BY cont_elem_obs.element
ORDER BY cont_elem_obs.element;

-- 5.V
WITH country_month AS(
	select ds.country_name country, dt.month month, AVG(CASE WHEN de.name = 'TMAX' THEN fo.value END) - AVG(CASE WHEN de.name = 'TMIN' THEN fo.value END) AS deltaT  from DimStation ds, DimElement de, DimTime dt, FactObservation fo  where ds.id=fo.station_id and de.name in ('TMAX', 'TMIN') and de.id=fo.element_id  and dt.date_id=fo.time_id group by ds.country_name,  dt.month order by avg(fo.value) DESC
),
country_max AS (
SELECT 
	country,
    -- month,
    MAX(deltaT) MAX_deltaT
FROM country_month
GROUP BY country
ORDER BY MAX(deltaT) DESC
)
SELECT
	cm.country,
    month
FROM country_month cm, country_max cmax
WHERE cm.country=cmax.country and cm.deltaT=cmax.MAX_deltaT
ORDER BY cm.country ASC;

-- 5.VI
SELECT 
    AVG(CASE
        WHEN
            YEAR(fo.time_id) = 2021
                AND de.name = 'PRCP'
        THEN
            fo.value
    END) - AVG(CASE
        WHEN
            YEAR(fo.time_id) = 2006
                AND de.name = 'PRCP'
        THEN
            fo.value
    END) AS deltaPRCP,
    AVG(CASE
        WHEN
            YEAR(fo.time_id) = 2021
                AND de.name = 'TMAX'
        THEN
            fo.value
    END) - AVG(CASE
        WHEN
            YEAR(fo.time_id) = 2006
                AND de.name = 'TMAX'
        THEN
            fo.value
    END) AS deltaTMAX,
    AVG(CASE
        WHEN
            YEAR(fo.time_id) = 2021
                AND de.name = 'TMIN'
        THEN
            fo.value
    END) - AVG(CASE
        WHEN
            YEAR(fo.time_id) = 2006
                AND de.name = 'TMIN'
        THEN
            fo.value
    END) AS deltaTMIN
FROM
    factobservation fo,
    dimelement de,
    dimstation ds
WHERE
    fo.element_id = de.id
        AND fo.station_id = ds.id
        AND ds.country_name = 'United Kingdom'
        AND de.name IN ('PRCP' , 'TMAX', 'TMIN')
        AND YEAR(fo.time_id) IN (2006 , 2021);
