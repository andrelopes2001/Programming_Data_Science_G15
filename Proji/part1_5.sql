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
ORDER BY YEAR(fo.time_id) DESC;

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
    AVG(cont_elem_obs.number_observations)
FROM
    (SELECT 
        ds.continent_name continent,
            de.name element,
            COUNT(time_id) number_observations
    FROM
        DimStation ds, DimElement de, FactObservation fo
    WHERE
        ds.id = fo.station_id
            AND de.id = fo.element_id
    GROUP BY ds.continent_name , de.name
    ORDER BY ds.continent_name , de.name) AS cont_elem_obs;

-- 5.V
SELECT 
    MONTH(observation.date_id) AS obs_month,
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


SELECT 
    value
FROM
    factobservation fo
        JOIN
    dimstation ds ON fo.station_id = ds.id
GROUP BY ds.country_name;


SELECT ds.country_name, month(fo.time_id) AS month
FROM factobservation fo
JOIN dimstation ds ON fo.station_id = ds.id
GROUP BY ds.country_name, month(fo.time_id)
ORDER BY ds.country_name DESC;


WITH country_month AS(
	select ds.country_name country, dt.month month, AVG(fo.value) AVG_TEMP from DimStation ds, DimElement de, DimTime dt, FactObservation fo  where ds.id=fo.station_id and de.name='TMAX' and de.id=fo.element_id  and dt.date_id=fo.time_id group by ds.country_name,  dt.month order by avg(fo.value) DESC
)
SELECT 
	country,
    -- month,
    MAX(AVG_TEMP)
FROM
	country_month
GROUP BY country
ORDER BY MAX(AVG_TEMP) DESC;

WITH factprcp_2021 AS(
	SELECT 
		dt.year YEARP, 
		avg(fo.value) AVG_PRCP, 
		LAG(avg(fo.value),1) OVER ( ORDER BY dt.year) AVG_PRCP_2006
	FROM 
		FactObservation fo, DimStation ds, DimTime dt, DimElement de
	WHERE 
		ds.country_name='United Kingdom' and fo.station_id=ds.id and dt.year  in (year(curdate())-2, year(curdate())-17) and fo.time_id=dt.date_id and de.name='PRCP' and de.id=fo.element_id
	GROUP BY 
		dt.year
	ORDER BY dt.year DESC
), 
 facttmax_2021 AS
 (
	SELECT 
		dt.year YEARTMAX, 
		MAX(fo.value) TMAX, 
		LAG(MAX(fo.value),1) OVER (ORDER BY dt.year) TMAX_2006
	FROM 
		FactObservation fo, DimStation ds, DimTime dt, DimElement de
	WHERE 
		ds.country_name='United Kingdom' and fo.station_id=ds.id and dt.year  in (year(curdate())-2, year(curdate())-17) and fo.time_id=dt.date_id and de.name='TMAX' and de.id=fo.element_id
	GROUP BY 
		dt.year
	ORDER BY dt.year DESC
),
 facttmin_2021 AS
 (
	SELECT 
		dt.year YEARTMIN, 
		MIN(fo.value) TMIN, 
		LAG(MIN(fo.value),1) OVER (ORDER BY dt.year) TMIN_2006
	FROM 
		FactObservation fo, DimStation ds, DimTime dt, DimElement de
	WHERE 
		ds.country_name='United Kingdom' and fo.station_id=ds.id and dt.year  in (year(curdate())-2, year(curdate())-17) and fo.time_id=dt.date_id and de.name='TMIN' and de.id=fo.element_id
	GROUP BY 
		dt.year
	ORDER BY dt.year DESC
)
SELECT
	AVG_PRCP,
	TMAX, 
	TMIN,
    AVG_PRCP_2006,
    TMAX_2006,
    TMIN_2006,
    AVG_PRCP- AVG_PRCP_2006  INC_AVG_PRCP,
    TMAX-TMAX_2006  INC_TMAX,
    TMIN-TMIN_2006  INC_TMIN
FROM  factprcp_2021, facttmax_2021, facttmin_2021
WHERE facttmax_2021.YEARTMAX=2021 and facttmin_2021.YEARTMIN=2021 and factprcp_2021.YEARP= 2021
-- ORDER BY YEARP DESC;


-- SUM(money) OVER(PARTITION BY EXTRACT(year FROM transaction_date)) AS money_earned

-- select s.name station_name, i.first_year from station s, inventory i where i.station=s.id and i.first_year in (select min(i.first_year) from element e, inventory i where e.property='precipitation'  and e.name=i.element);
-- select cc.name continent, count(s.id) count from continent cc, country c, station s where cc.cc=c.continent and c.fips=s.country group by cc.name order by count(s.id) ASC;
-- select cc.name as continent, count(s.id) as count from continent cc, country c, station s where cc.cc=c.continent and c.fips=s.country group by cc.name order by count(s.id) DESC;
-- select year(o.date_id) YEAR, avg(o.TMAX) AVG_TMAX from observation o, station s, country c where  c.name='Portugal' and c.fips=s.country and s.id=o.station group by year(o.date_id) order by year(o.date_id) ASC;
-- select year(o.date_id) YEAR, avg(o.TMAX) AVG_TMAX from observation o, station s, country c where  c.name='Portugal' and c.fips=s.country and s.id=o.station group by year(o.date_id) order by year(o.date_id) DESC;
-- select year(o.date_id) YEAR, avg(o.PRCP) AVG_PRCP, MAX(TMAX) TMAX, MIN(TMIN) TMIX, MAX(TMAX)-MIN(TMIN) TAMP from observation o, station s, country c where  c.name='United Kingdom' and c.fips=s.country and s.id=o.station and year(o.date_id) between year(curdate())-10 and year(curdate())-1 group by year(o.date_id) order by year(o.date_id) ASC;
-- select year(o.date_id) YEAR, avg(o.PRCP) AVG_PRCP, MAX(TMAX) TMAX, MIN(TMIN) TMIX, MAX(TMAX)-MIN(TMIN) TAMP from observation o, station s, country c where  c.name='United Kingdom' and c.fips=s.country and s.id=o.station and year(o.date_id) between year(curdate())-10 and year(curdate())-1 group by year(o.date_id) order by year(o.date_id) DESC;
