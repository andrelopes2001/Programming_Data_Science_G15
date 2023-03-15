INSERT IGNORE INTO dw_weather.dimstation
SELECT 
	station.id AS id,
    station.name as name,
    station.latitude as latitude,
    station.longitude as longitude,
    station.elevation as elevation,
    state.alias as state_alias,
    state.name AS state_name,
    state.population as state_population,
    state.total_area as state_total_area,
    state.land_area as state_land_area,
    state.water_area as state_water_area,
    state.nr_reps as state_nr_reps,
    country.fips as country_fips,
    country.name as country_name,
    country.ISO_alpha2 as country_ISO_alpha2,
    country.ISO_alpha3 as country_ISO_alpha3,
    country.ISO_numeric as country_ISO_numeric,
    country.IOC as country_IOC,
    country.license_plate as country_license_plate,
    country.domain as country_domain,
    continent.cc as continent_code,
    continent.name as continent_name
FROM
    db_weather.station AS station
        JOIN
    db_weather.state AS state ON station.state = state.alias
        JOIN
    db_weather.country AS country ON station.country = country.fips
        JOIN
    db_weather.continent AS continent ON country.continent = continent.cc;