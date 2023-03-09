-- Operational Database 3.I
SELECT 
    MIN(YEAR(date)) AS first_year_prcp
FROM
    observation
WHERE
    PRCP IS NOT NULL;

-- Operational Database 3.II
SELECT 
    station
FROM
    observation
WHERE
    date = (SELECT 
            MIN(date) AS first_year
        FROM
            observation
        WHERE
            PRCP IS NOT NULL)
        AND PRCP IS NOT NULL;
        
-- Operational Database 3.III

select count(*), station.country, station.id, country.continent
from station
inner join country on station.country = country.continent
group by station.continent;
