SELECT 
    station.id AS station_id,
    station.name AS station_name,
    state.alias,
    state.name AS state_name,
    state.population,
    state.total_area,
    state.land_area,
    state.water_area,
    state.nr_reps,
    country.fips,
    country.name,
    country.license_plate,
    country.domain,
    continent.cc,
    continent.name
FROM
    db_weather.station AS station
        JOIN
    db_weather.state AS state ON station.state = state.alias
        JOIN
    db_weather.country AS country ON station.country = country.fips
        JOIN
    db_weather.continent AS continent ON country.continent = continent.cc;