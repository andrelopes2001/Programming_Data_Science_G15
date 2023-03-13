SELECT 
    station.id AS id,
    station.latitude as latitude, 
    station.name AS name,
    state.alias,
    state.name AS state_name,
    state.population,
    state.total_area,
    state.land_area,
    state.water_area,
    state.nr_reps,
    country.fips,
    country.name as country_name,
    country.license_plate,
    country.domain,
    continent.cc,
    continent.name as continent_name
FROM
    db_weather.station AS station
        JOIN
    db_weather.state AS state ON station.state = state.alias
        JOIN
    db_weather.country AS country ON station.country = country.fips
        JOIN
    db_weather.continent AS continent ON country.continent = continent.cc;