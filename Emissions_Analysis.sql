-- 1. Prepare emissions data for geographic visualization

SELECT
    latitude,
    longitude,
    `GHG emissions mtons CO2e` AS emissions
FROM emissions_data;


-- 2. Top 10 counties by emissions per person

SELECT
    county_state_name,
    population,
    TRY_CAST(
        regexp_replace(`GHG emissions mtons CO2e`, ',', '')
        AS DOUBLE
    ) / NULLIF(population, 0) AS emissions_per_person
FROM emissions_data
ORDER BY emissions_per_person DESC
LIMIT 10;


-- 3. Top 10 states by total emissions

SELECT
    state_abbr,
    SUM(
        TRY_CAST(
            regexp_replace(`GHG emissions mtons CO2e`, ',', '')
            AS DOUBLE
        )
    ) AS total_emissions
FROM emissions_data
GROUP BY state_abbr
ORDER BY total_emissions DESC
LIMIT 10;


-- 4. Top 10 counties by total emissions

SELECT
    county_state_name,
    population,
    TRY_CAST(
        regexp_replace(`GHG emissions mtons CO2e`, ',', '')
        AS DOUBLE
    ) AS total_emissions
FROM emissions_data
ORDER BY total_emissions DESC
LIMIT 10;
