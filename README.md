# SustainableWorldData

SustainableWorldData is an SQL-based project that explores global sustainability trends, focusing on CO2 emissions, renewable energy consumption, and electricity access from 2000 to 2023. This project is part of my Data Analysis master program at [Start2Impact University](https://www.start2impact.it/). 

## Project Overview
This project aims to analyze global datasets related to country information and sustainable energy from 2000 to 2023. The primary goal is to gain insights into the relationship between CO2 emissions, renewable energy consumption, and access to electricity across different countries, offering a comprehensive view of sustainability trends worldwide..

The analysis involves a multi-step process:
1. **Data Preparation**: Use of Excel for data preparation
2. **Workspace Setup**: Setting up the environment using the `workspacesetup.sql` script.
3. **Data Cleaning**: Ensuring data accuracy by removing irrelevant information, handling missing values, and standardizing data entries for consistent analysis.
4. **Analysis of Global Country Information Dataset**: The focus here was on examining CO2 emissions and renewable energy adoption in 2023.
5. **Analysis of Global Data on Sustainable Energy**: This step involved a historical analysis of data from 2000 to 2019, identifying long-term trends in CO2 emissions, renewable energy growth, and global electricity access.
6. **Comparative Analysis**: Comparison of historical data with the most recent data.

Each query was designed to extract meaningful insights, facilitating better understanding and strategic planning for stakeholders in the field of sustainability.

## Objectives
The key objectives of this project are:
- Analyze trends in CO2 emissions by country and year.
- Examine the growth of renewable energy sources and their impact on overall energy consumption.
- Investigate the relationship between access to electricity and sustainable energy practices across nations.
- Establish the basis for future data visualizations to communicate sustainability trends.

## Tools Used
- **pgAdmin4** for executing SQL queries and managing the database.
- **Excel** for preliminary data exploration and generating quick insights.
- **Git** for version control to track project updates and contributions.
- **Kaggle** for sourcing datasets and gathering additional context on sustainability.

## Dataset
The project utilizes two primary datasets:
1. [**Global Country Data**](https://www.kaggle.com/datasets/nelgiriyewithana/countries-of-the-world-2023): This dataset provides various demographic and economic indicators for countries. `global-country-data-2023.csv`
   - `Country`: Name of the country
   - `Population`: Total population
   - `GDP`: Gross Domestic Product
   - `Region`: Geographic region
   - Additional metrics

2. [**Sustainable Energy Data**](https://www.kaggle.com/datasets/anshtanwar/global-data-on-sustainable-energy): This dataset includes information on energy consumption, CO2 emissions, and renewable energy sources from 2000 to 2020. `global-data-on-sustainable-energy.csv`
   - `Country`: Name of the country
   - `Year`: Year of data collection
   - `CO2 Emissions`: Total CO2 emissions
   - `Renewable energy share in total final energy consumption`: Percentage of renewable energy in final energy consumption
   - `Renewable Energy`: Percentage of energy from renewable sources
   - `Access to Electricity`: Percentage of population with access to electricity
   - `Energy intensity level of primary energy`: Energy use per unit of GDP at purchasing power parity
   - `GDP growth`: Annual GDP growth rate based on constant local currency
   - `GDP per capita`: Gross domestic product per person
   - Additional metrics

Both datasets have a copy where the raw data is present.

## Contributing
Contributions are welcome! Please open an issue or submit a pull request if you have suggestions for enhancements or corrections.

## Notes
- Ensure that your SQL environment is compatible with the syntax used in the scripts.
- Modify the scripts as necessary to fit your specific database setup.

