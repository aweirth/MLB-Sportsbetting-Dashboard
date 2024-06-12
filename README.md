# MLB Sports Betting ETL Project

**UPDATE:** As of May 1st, 2024, my subscription to Power BI and the cloud platform Railway hosting my data pipeline has ended with the conclusion of the class. The dashboard and data in this repository contain MLB Preseason/Regular Season game results and sports betting odds from March 2nd - May 1st.

This repository contains my final project for my Graduate Data Engineering class at Willamette University. The end result was a Power BI dashboard connected to a cloud-hosted PostgreSQL database, which functioned as a data pipeline ingesting sports betting data from over 20 different U.S. sportsbooks and daily MLB game results. The pipeline allowed users to observe live MLB moneyline odds for daily games from over 20 different U.S. sportsbooks, enabling buyers to get the best odds, as well as the ability to analyze the profitability of those odds with attached game results data.

This project showcases my comprehensive ability to carry out an ETL process:

- **Extracting:** Using a Docker Image to pull raw JSONB data from 5 different API endpoints into a cloud-hosted PostgreSQL database.
- **Transforming:** Regularly in the cloud using a Docker Container that uses `psql` to run SQL code into a database in third normal form (3NF).
- **Loading:** That data into an informative Power BI report that is able to communicate key insights of MLB sports betting odds and team profitability.

View the Power BI report here, or if my school organization's privacy settings do not allow viewing, see images of the dashboard in the About section.

## Table of Contents

- [About](#about)
- [Contents](#contents)
- [Skills](#skills)
- [License](#license)
- [Contact](#contact)

## About

### The Problem

A goal of mine has always been to complete a data science project relating to sports betting as the industry is massive and sportsbooks carry out extensive data analysis and machine learning to set odds. Datasets relating to sports betting or odds prices are not widely available on the usual platforms such as Kaggle or Machine Learning Repositories, which is why I had not pursued a project relating to this beforehand.

### The Goal

The goal of this project was to leverage my skills in PostgreSQL, Bash, Docker, and Power BI to extract, transform, and load sports betting data from a variety of API endpoints in order to compile enough meaningful data to carry out an analysis comparing odds prices across U.S. sportsbooks while also comparing profitability among different teams.

Work for this project began in March, which meant the only available sport was MLB preseason, which later switched to the regular season. This led to the primary focus of the project being on MLB game and sports betting data. API calls were made daily for live odds of the day's MLB moneyline matchups as well as the game results at the end of the day. The pipeline gave the ability to observe live MLB moneyline odds for daily games from over 20 different U.S. sportsbooks, as well as the ability to analyze the profitability of those odds with game results data.

### The Data Sources

Data was pulled from a total of 5 different APIs for this project. Listed below are the API sources and ingestion schedules:

**THE ODDS API (Reference Website for Odds APIs)**

- **API Endpoint for MLB Preseason US Region 1 Odds:**
  - This endpoint provided live JSON data for MLB preseason moneyline odds prices from US market 1 sportsbooks for daily games.
  - The API call was made at 2:00 am PST daily.
- **API Endpoint for MLB Preseason US Region 2 Odds:**
  - This endpoint provided live JSON data for MLB preseason moneyline odds prices from US market 2 sportsbooks for daily games.
  - The API call was made at 2:00 am PST daily.

After the conclusion of the preseason:

- **API Endpoint for MLB Regular Season US Region 1 Odds:**
  - This endpoint provided live JSON data for MLB regular season moneyline odds prices from US market 1 sportsbooks for daily games.
  - The API call was made at 2:00 am PST daily.
- **API Endpoint for MLB Regular Season US Region 2 Odds:**
  - This endpoint provided live JSON data for MLB regular season moneyline odds prices from US market 2 sportsbooks for daily games.
  - The API call was made at 2:00 am PST daily.

**The MLB's Live Scoreboard API**

- **API Endpoint for Daily Scoreboard:**
  - This endpoint provided live JSON data for a daily scoreboard of MLB games.
  - The API call was made at 11:55 pm PST daily in order to retrieve the final scores of the daily games.

## Data Pipeline Ingestion and Transformation Diagram

## The Product

The final product was a Power BI dashboard serving live MLB moneyline odds for daily games from over 20 different U.S. sportsbooks, as well as the ability to analyze the profitability of those odds with attached game results data updating daily.

View the Power BI report here, or if my school organization's privacy settings do not allow viewing, see images below:

**Daily Odds Prices Dashboard**

![Power BI Image1](./Images/oddsprices_pbi_dashboard.png)

**Live Profitability Graphic - Most profitable teams off a $10 ML bet every game**

![Power BI Image2](./Images/profits_pbi_dashboard.png)

This dashboard gave daily, real-time insights to sports bettors on the optimal areas for profitability on moneyline betting for MLB games based on differentials in U.S. sportsbook's odds prices and team performance.

## Contents

In this repository you will see the following files:

**Final Data:**
- `mlb_games.csv`: MLB Scoreboard game results from March 2nd, 2024 - May 2nd, 2024.
- `prices.csv`: Moneyline odds prices for every daily game, for each team collected from over 20 different U.S. sportsbooks.
- `ERD`: ERD Images folder containing supplemental images for the project.

**Docker Container Cleaner:** The files in this folder were previously hosted in a GitHub repo that was called on by my cloud service to make regular transformations to my database. The `clean.sql` file has SQL script to clean and transform the raw ingested API data into organized and structured tables.

**Presentation Slides:** My final presentation slideshow to communicate my project.

## Skills

**ETL Workflow:**
- Extracting data using a Docker Image to pull raw JSONB data from 5 different API endpoints into a cloud-hosted PostgreSQL database.
- Transforming that data regularly in the cloud using a Docker Container that uses `psql` to run SQL code into a database in third normal form (3NF).
- Loading that data into an informative Power BI report that is able to communicate key insights of MLB sports betting odds and team profitability.

**Data Cleaning/Wrangling:**
- Extensive data cleaning & wrangling performed in order to create meaningful data tables able to be analyzed in Power BI.

**Power BI:**
- Connected a live data source using an ODBC connector.
- Wrote DAX measures to create important metrics to analyze betting profitability by team.
- Conditional formatting.
- Power Query.
- Matrices & Slicers.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

Feel free to reach out to me if you have questions or comments!


