-- Cleaning globalCountryData_staging's Data
SELECT *
FROM globalCountryData_staging;

-- Country check
SELECT DISTINCT country
FROM globalCountryData_staging
	ORDER BY 1;

-- Remove S country
DELETE from globalCountryData_staging
	WHERE country = 'S';

-- Find text with ? value
SELECT country
FROM globalCountryData_staging
WHERE country LIKE '%?'
ORDER BY 1;

-- Update text with ? value
UPDATE globalCountryData_staging
SET country = RTRIM(country, '?')
WHERE country LIKE '%?';

-- Remove unneessary
ALTER TABLE globalCountryData_staging
DROP COLUMN capital_major_city, 
	DROP COLUMN largestCity, 
	DROP COLUMN officialLanguage, 
	DROP COLUMN Latitude, 
	DROP COLUMN Longitude;


-- Cleaning globalSustainableEnergyData_staging's Data
SELECT *
FROM globalSustainableEnergyData_staging;
	
-- Entity check
SELECT DISTINCT entity
FROM globalSustainableEnergyData_staging
	ORDER BY 1;

-- Remove unneessary
ALTER TABLE globalSustainableEnergyData_staging
DROP COLUMN latitude, 
	DROP COLUMN longitude;

-- Rename column for readbility
ALTER TABLE globalSustainableEnergyData_staging
	RENAME COLUMN entity to country;

ALTER TABLE globalSustainableEnergyData_staging
	ALTER COLUMN co2emissions TYPE BIGINT;

ALTER TABLE globalSustainableEnergyData_staging
	ALTER COLUMN electricityAccess TYPE DECIMAL(5,2);