-- Exploratory Data Analysis, Comparative Analysis, Time-Series Analysis

-- Dataset 1: Global Country Infomation (world-data-2023.csv)
-- Objective: Identify insights relating to the current situation (2023) on the economy, energy, healthcare, education and environment

-- Dataset 2: Global Data on Sustainable Energy (global-data-on-sustainable-energy.csv)
-- Objective: Identify key insights related to energy, emissions and sustainability over time, and then integrate this data with the 2023 results present in the first dataset

-- 1. Population distribution, density, land aera and CO2 emissions in 2023

-- Ranking of countries based on population density
SELECT country, population, density, landArea
FROM globalCountryData_staging
ORDER BY density DESC;

-- Create a view to calculate GDP per capita and CO2 emissions per capita.
CREATE VIEW CountrySats AS
	SELECT country, 
	density, 
	gdp, 
	population, 
	gdp/population AS gdpPerCapita,
	co2emissions,
	ROUND(CAST(co2emissions AS numeric) / CAST(population AS numeric), 5) AS emissionsPerCapita,
	forestedArea,
	agriculturalLand
	FROM globalCountryData_staging;

-- Compare population density with GDP per capita, ranking countries by population density
SELECT country, density, gdp, population, gdpPerCapita
FROM CountrySats
	WHERE gdpPerCapita IS NOT NULL
ORDER BY density DESC;

-- Analyze the relationship between population density and CO2 emissions per capita for each country
SELECT country, density, population, co2emissions, emissionsPerCapita
FROM CountrySats
	WHERE emissionsPerCapita IS NOT NULL
ORDER BY density DESC;

SELECT country, population, co2emissions
FROM globalCountryData_staging
	WHERE country ='Italy';

SELECT country, co2emissions
FROM globalSustainableEnergyData_staging
	WHERE country ='Italy';

-- Rank countries by GDP per capita and compare it with CO2 emissions per capita to identify high-income, low-emission countries
SELECT country, gdp, gdpPerCapita, co2emissions, emissionsPerCapita
FROM CountrySats
	WHERE emissionsPerCapita IS NOT NULL
	AND gdpPerCapita IS NOT NULL
ORDER BY gdpPerCapita DESC, 
	emissionsPerCapita ASC;

-- Retrieve a list of countries with the highest percentage of agricultural land
SELECT country, agriculturalLand
FROM globalCountryData_staging
	WHERE agriculturalLand IS NOT NULL
ORDER BY 2 DESC;

-- Retrieve a list of countries with the highest percentage of forested land
SELECT country, forestedArea
FROM globalCountryData_staging
	WHERE forestedArea IS NOT NULL
ORDER BY 2 DESC;

-- Compare agricultural land percentage with CO2 emissions per capita to assess environmental impact
SELECT country, forestedArea, co2emissions, population, emissionsPerCapita
FROM CountrySats
	WHERE forestedArea IS NOT NULL
	AND emissionsPerCapita IS NOT NULL
ORDER BY forestedArea DESC,
	emissionsPerCapita ASC;

-- Identify countries with low forested area and high CO2 emissions per capita, potentially indicating environmental stress
SELECT country, forestedArea, co2emissions, population, emissionsPerCapita
FROM CountrySats
	WHERE forestedArea IS NOT NULL
	AND forestedArea < 20
	AND emissionsPerCapita
ORDER BY emissionsPerCapita DESC;

-- Compare agricultural land percentage with GDP per capita to understand the economic profile of more agricultural countries
SELECT country, agriculturalLand, gdp, population, gdpPerCapita
FROM CountrySats
	WHERE agriculturalLand IS NOT NULL
	AND gdpPerCapita IS NOT NULL
ORDER BY agriculturalLand DESC;

--  Identify countries with high forested area, low CO2 emissions per capita, and high GDP per capita to highlight sustainability leaders (top 10)
/*
SELECT country, forestedArea, co2emissions, emissionsPerCapita, gdpPerCapita
FROM CountrySats
	WHERE emissionsPerCapita IS NOT NULL
	AND gdpPerCapita IS NOT NULL
ORDER BY gdpPerCapita DESC, 
	emissionsPerCapita ASC
LIMIT 10;
*/

WITH sustainabilityLeaders AS (
	SELECT country, forestedArea, co2emissions, emissionsPerCapita, gdpPerCapita,
	DENSE_RANK() OVER (ORDER BY gdpPerCapita DESC) AS gdp_rank
	FROM CountrySats
		WHERE emissionsPerCapita IS NOT NULL
		AND gdpPerCapita IS NOT NULL
)
SELECT *
	FROM sustainabilityLeaders
WHERE gdp_rank <= 10
	ORDER BY gdp_rank;



-- 2. Energy, emissions and sustainability 2000 - 2020

-- Track the trends in CO2 emissions per capita for each country to identify patterns of environmental impact
SELECT country, year, co2emissions AS emissionsPerCapita
FROM globalSustainableEnergyData_staging
	WHERE co2emissions IS NOT NULL
	ORDER BY country, year;

-- Track the share of renewable energy and the amount of electricity generated from renewables
SELECT country, year, renewableShareFinalEnergy, renewableElectricity
FROM globalSustainableEnergyData_staging
	WHERE renewableShareFinalEnergy IS NOT NULL
	AND renewableElectricity IS NOT NULL
ORDER BY country, year;

-- Calculate the percentage change in CO2 emissions from 2000 to 2019
WITH emissionsTrend AS (
	SELECT country, year, co2emissions AS emissions
	FROM globalSustainableEnergyData_staging
	WHERE year IN (2000, 2019) 
		AND co2emissions IS NOT NULL
)
SELECT
	e2000.country,
	e2000.emissions AS emission2000,
	e2019.emissions AS emission2019,
	CASE
		WHEN e2000.emissions = 0 THEN NULL
		ELSE
			ROUND(
				((e2019.emissions::DECIMAL - e2000.emissions::DECIMAL) / e2000.emissions::DECIMAL) * 100, 2
			)
	END AS percentageChange
FROM emissionsTrend e2000
JOIN emissionsTrend e2019 ON e2000.country = e2019.country
	AND e2000.year = 2000
	AND e2019.year = 2019
ORDER BY percentageChange DESC;

-- Calculate the percentage change in renewable energy and the amount of electricity generated from renewables from 2000 to 2019
WITH renewableTrend AS (
	-- Select renewable data for the years 2000 and 2019
	SELECT country, year, renewableShareFinalEnergy, renewableElectricity
	FROM globalSustainableEnergyData_staging
	WHERE year IN (2000, 2019)
	AND renewableShareFinalEnergy IS NOT NULL
	AND renewableElectricity IS NOT NULL
)
SELECT
	r2000.country,
--	r2000.renewableShareFinalEnergy AS renewableShare2000,
--	r2019.renewableShareFinalEnergy AS renewableShare2019,
--	r2000.renewableElectricity AS renewableElectricity2000,
--	r2019.renewableElectricity AS renewableElectricity2019,
	-- Calculate the percentage change in renewable share of final energy consumption
	CASE
			WHEN r2000.renewableShareFinalEnergy = 0 THEN NULL
			ELSE
				ROUND(
					((r2019.renewableShareFinalEnergy - r2000.renewableShareFinalEnergy) / r2000.renewableShareFinalEnergy) * 100, 2
				)
		 END AS percentageRenewableShare, -- percentage change in renewable energy 
	-- Calculate the percentage change in renewable electricity generation
	CASE
			WHEN r2000.renewableElectricity = 0 THEN NULL
			ELSE
				ROUND(
					((r2019.renewableElectricity - r2000.renewableElectricity) / r2000.renewableElectricity) * 100, 2
				)
		 END AS percentageChangeRenewableElectricity -- percentage change in the amount of electricity generated from renewables
FROM renewableTrend r2000
JOIN renewableTrend r2019 ON r2000.country = r2019.country
	AND r2000.year = 2000
	AND r2019.year = 2019
-- Ensure that at least one of the percentage change values is not null
WHERE (r2000.renewableShareFinalEnergy != 0 OR r2000.renewableElectricity != 0)
ORDER BY percentageRenewableShare DESC, percentageChangeRenewableElectricity DESC;

-- Understand how access to electricity has evolved globally across different countries
SELECT country, year, electricityAccess
FROM globalSustainableEnergyData_staging
	WHERE electricityAccess IS NOT NULL
	ORDER BY country, year;

-- Understand how energy consumption per capita has changed over time across different countries
SELECT country, year, energyConsumption
FROM globalSustainableEnergyData_staging
	WHERE energyConsumption IS NOT NULL
ORDER BY country, year;

-- Explore the relationship between GDP per capita and energy intensity levels over time
SELECT country, year, gdp, energyIntensity
FROM globalSustainableEnergyData_staging
	WHERE energyIntensity IS NOT NULL
	AND gdp IS NOT NULL
ORDER BY country, year;



-- Comparative analysis

-- Compare CO2 emissions per country in 2023 (using CountryStats view) with 2019
SELECT 
	s.country,
	((s.co2emissions * 1.102)::INT) AS emissions2019, -- conversion from metric tons to tons
	g.co2emissions AS emissions2023
FROM globalSustainableEnergyData_staging s
JOIN globalCountryData_staging g
	ON s.country = g.country
	WHERE s.year = 2019
ORDER BY s.country;

-- Calculate the percentage change in CO2 emissions from 2019 to 2023
WITH emissionsChange AS (
	SELECT 
		s.country,
		ROUND(s.co2emissions * 1.102, 0) AS emissions2019, -- conversion from metric tons to tons
       	g.co2emissions::NUMERIC AS emissions2023 
	FROM globalSustainableEnergyData_staging s
	JOIN globalCountryData_staging g
		ON s.country = g.country
	WHERE s.year = 2019
)
SELECT 
	country,
	emissions2019,
	emissions2023,
	ROUND(
		((emissions2023 - emissions2019) / emissions2019) * 100, 0
	)  AS percentageChange
FROM emissionsChange
WHERE emissions2019 IS NOT NULL
	AND emissions2023 IS NOT NULL
ORDER BY percentageChange ASC;


