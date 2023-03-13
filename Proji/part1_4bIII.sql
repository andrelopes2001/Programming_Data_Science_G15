-- INSERT IGNORE INTO dw_weather.dimtime 
SELECT 
    ROW_NUMBER() OVER(order by element.name) AS id,
    element.*
FROM
    db_weather.element;
