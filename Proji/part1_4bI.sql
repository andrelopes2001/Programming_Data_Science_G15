INSERT IGNORE INTO dw_weather.dimtime
SELECT DISTINCT
    date_id,
    YEAR(date_id) AS year,
    QUARTER(date_id) AS quarter,
    MONTH(date_id) AS month,
    DAY(date_id) AS day,
    DAYOFWEEK(date_id) AS day_week,
    DAYOFYEAR(date_id) AS day_year,
    CASE
        WHEN
            DAYOFYEAR(CONCAT(YEAR(date_id), '-12-31')) = 365
        THEN
            CASE
                WHEN DAYOFYEAR(date_id) BETWEEN 80 AND 171 THEN 'Spring'
                WHEN DAYOFYEAR(date_id) BETWEEN 172 AND 265 THEN 'Summer'
                WHEN DAYOFYEAR(date_id) BETWEEN 266 AND 354 THEN 'Fall'
                ELSE 'Winter'
            END
        ELSE CASE
            WHEN DAYOFYEAR(date_id) BETWEEN 81 AND 172 THEN 'Spring'
            WHEN DAYOFYEAR(date_id) BETWEEN 173 AND 266 THEN 'Summer'
            WHEN DAYOFYEAR(date_id) BETWEEN 267 AND 355 THEN 'Fall'
            ELSE 'Winter'
        END
    END AS season
FROM
    db_weather.observation
ORDER BY date_id;