# MLB Sportsbetting ETL Project

*_*UPDATE: As of May 1st 2024, my subscription to PowerBI and the cloud platform Railway hosting my data pipeline have ended with the finishing of the class. The dashboard and data in this repository have MLB Preseason/Regular Season game results and sportbetting odds from March 2nd - May 1st_*

This repository contains my final project for my Graduate Data Engineering class at Willamette University. The end result was a Power BI dashboard connected to my live data source which was a datapipeline serving sportsbetting data from over 20 different US sportsbooks and daily MLB game results. This project showcases my comprehensive ability to carry out an ETL process:

- Extracting data using a Docker Image to pull raw JSONB data from 5 diffferent API endpoints into a cloud hosted PostgreSQL database.
- Transforming that data regularly in the cloud using a Docker Container that uses psql to run SQL code into a database in third normal form (3NF).
- Loading that data into an informative Power BI report that isi able to communicate key insights of MLB sportsbetting odds and team profitability.

View the report Power BI report [here](https://app.powerbi.com/groups/16ae97bc-f021-4246-b11e-638b2ab3cb6a/reports/014bc0ce-8d53-4aa7-b3f9-4febf1e88f1a/ReportSection4636aaa8c019734a14c2?ctid=46bc6c40-368d-4a20-9b1b-c1842f786542&experience=power-bi), or if my school organization's privacy settings do not allow viewing, see images of the dashboard in the [About](#about) section.


## Table of Contents

- [About](#about)
- [Contents](#contents)
- [Skills](#skills)
- [Usage](#usage)
- [License](#license)
- [Contact](#contact)

## About

#### The Problem

A goal of mine has always been to complete a data science project relating to sportsbetting as the data is interesting to me and sportsbetting is such a huge industry. Datasets relating to sportsbetting or odds prices are not widely availible on the usual platforms such as Kaggle or Machine Learning Repositories, so, for my 


#### The Goal

For my Data Engineering final project, my goal was to create a data pipeline in the cloud extracting, transforming, and loading MLB sportsbetting data as the MLB preseason had just begun.

#### The Data

The data for this project comes from [Data Golf's Free PGA Archive](https://datagolf.com/raw-data-archive), where a free sample CSV of 2021 Masters Tournament data was aqquired. Again, raw golf data is not easily accessible and since the scope of this project was visualization and not a data pipeline, the free sample CSV was data used for this project.

#### The Product

The final product was a Shiny App Dashboard that can be viewed at this [link](https://aweirth.shinyapps.io/shiny_masters/). The dashboard achieved the goal of communicating critical insights by showing the dominant performance of Hideki Matsuyama's Strokes Gained Statistics across the board and especially Tee to Green. The dashboard was also able to be understood by peers in my graduate class who are not golf fans, and by friends who are not familiar with statistics or data visualizations. This Shiny App represents how less is more sometimes when communicating data. Only two best graphics from my EDA stage were chosen which cleany and cleary communicate important findings without the dashboard turning into something that resembles an airplane cockpit (example: comparing one data point to a boxplot can communicate a lot of informatin with few pixels).

## Contents

In this repository you will see the following files:

Data:
- **raw_pga_2021.csv:** This is the raw CSV from Data Golf's Archive.
- **masters2021_cleaned111.csv:** This is the cleaned full 2021 Masters CSV from Data Golf, cleaned by the masters_wrangling.R script.
- **masters2021_lb.csv:** This is a wrangled dataframe from the above masters2021_cleaned111 file. This is the data being sent to the leaderboard on the homepage.

Cleaning Script:
- **masters_cleaning.R:** This is the script responsible for cleaning the raw csv and prodicing the cleaned CSV's.

The App:
- **App.R:** This is the R script responsible for producing the R Shiny App. It contains custom HTML/CSS styling and the GGplot code for generating the graphics.

## Skills

Data Cleaning:
- Processed the raw CSV file to handle missing values, inconsistencies, and manipulated the data strucutre to work with my project.
- Engineered new features helpful for construction of the dashboard and communicating insights.
  
Data Visualization:
- Utilized R Shiny App's visualization libraries (e.g., ggplot2, plotly) to create interactive and informative charts, graphs, and tables.
- Designed the dashboard layout to effectively present the insights derived from the data.
- Successfully selected the most effective visualizations from my EDA process.
  
Data Analysis:
- Conducted exploratory data analysis (EDA) to uncover patterns, trends, and relationships within the dataset.
- Employed statistical techniques to derive meaningful insights from the data.
  
Web Development:
- Developed a user-friendly and responsive web interface using HTML, CSS, and JavaScript within the R Shiny framework.
- Customized the appearance and layout of the dashboard to enhance user experience.

## Usage

Instructions on how to use the dashboard are in the "About" tab of the top ribbon. There, you will find helpful tips as well as hints to find the key insights I found in the graphics.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

Feel free to reach out to me if you have questions or comments!

