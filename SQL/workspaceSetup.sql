-- Import Dataset: Global Country Information Dataset 2023

-- Create Table
CREATE TABLE IF NOT EXISTS GlobalCountryData (
    Country VARCHAR(100),
    Density FLOAT,  
    Abbreviation VARCHAR(10),  
    AgriculturalLand DECIMAL(4, 1),  -- Percentage
    LandArea INT,  -- In square kilometers
    ArmedForcesSize INT, 
    BirthRate FLOAT,  -- Per 1,000 people
    CallingCode VARCHAR(10),  
    Capital_Major_City VARCHAR(100), -- Capital or Major city
    Co2Emissions FLOAT,  -- In tons
    CPI DECIMAL(7, 2),  
    CPIChange DECIMAL(4, 1),  -- Percentage
    CurrencyCode VARCHAR(5), 
    FertilityRate FLOAT,  
    ForestedArea DECIMAL(4, 1),  -- Percentage
    GasolinePrice DECIMAL(5, 1),  -- Price of gasoline per liter in local currency
    GDP BIGINT,  
    GrossPrimaryEducationEnrollment DECIMAL(4, 1),  -- Percentage
    GrossTertiaryEducationEnrollment DECIMAL(4, 1),  -- Percentage
    InfantMortality FLOAT,  -- Per 1,000 live births before reaching one year of age
    LargestCity VARCHAR(100),
    LifeExpectancy INT,
    MaternalMortalityRatio INT,  -- Per 100,000 live births
    MinimumWage DECIMAL(10, 2),  -- In local currency
    OfficialLanguage VARCHAR(100), 
    OOPHealthExpenditure DECIMAL(4, 1),  -- Out-of-pocket health expenditure (%)
    PhysiciansPerThousand FLOAT, 
    Population BIGINT,  
    LaborForceParticipation DECIMAL(4, 1),  -- Percentage
    TaxRevenue DECIMAL(4, 1),  -- Percentage of GDP
    TotalTaxRate DECIMAL(5, 1),  -- Percentage
    UnemploymentRate DECIMAL(4, 1),  -- Percentage
    UrbanPopulation INT,
    Latitude BIGINT,
    Longitude BIGINT
);

-- Create staging table to have always raw data available
CREATE TABLE globalCountryData_staging AS
SELECT *
FROM globalCountryData;

-- Import Dataset: Global Data on Sustainable Energy (2000-2020)

-- Create Table
CREATE TABLE IF NOT EXISTS globalSustainableEnergyData (
    entity VARCHAR(255),
    year INT,
    electricityAccess DECIMAL(10, 6),            		-- % of population with access to electricity
    cleanCookingAccess DECIMAL(5, 2),           		-- % of the population with primary reliance on clean fuels
    renewableCapacity DECIMAL(6, 2),            		-- Renewable electricity capacity per capita
    financialFlowsToDevCountries BIGINT,				-- Financial flows to developing countries in USD
    renewableShareFinalEnergy DECIMAL(5, 2),    		-- % of renewable energy in final energy consumption
    fossilFuelElectricity DECIMAL(6, 2),        		-- Electricity from fossil fuels (TWh)
    nuclearElectricity DECIMAL(6, 2),          		-- Electricity from nuclear (TWh)
    renewableElectricity DECIMAL(6, 2),         		-- Electricity from renewables (TWh)
    lowCarbonElectricity DECIMAL(5, 2),         		-- % of electricity from low-carbon sources
    energyConsumption DECIMAL(8, 2),            		-- Energy consumption per capita (kWh/person)
    energyIntensity DECIMAL(4, 2),              		-- Energy use per unit of GDP at purchasing power parity (MJ/$2017 PPP GDP)
    co2Emissions DECIMAL(10, 2),                 		-- Carbon dioxide emissions per person in metric tons
    renewablesEquivalentPrimaryEnergy DECIMAL(5, 2), 	-- Renewables as % of equivalent primary energy
    gdpGrowth DECIMAL(5, 2),                     		-- GDP growth rate (%)
    gdp DECIMAL(8, 2),                          		-- GDP per capita
    density INT,
    landArea INT,
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8)
);

-- Create staging table to have always raw data available
CREATE TABLE globalSustainableEnergyData_staging AS
SELECT *
FROM globalSustainableEnergyData;