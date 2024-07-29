# Bike Sharing Demand Analysis

## Table of Contents

- [Project Overview](#project-overview)
- [Data Sources](#data-sources)
- [Result and Findings](#result-and-findings)
- [Recommendations](#recommendations)
- [Limitations](#limitations)

### Project Overview

Glassdoor is a website where employees and former employees can anonymously review companies and their management. It provides insights into company culture, salary information, and job opportunities. Additionally, Glassdoor offers a platform for employers to post job listings and promote their brand to potential candidates. The site aims to help job seekers make informed decisions about their careers and workplaces.

### Objective

The primary goal of this project is to analyze job postings from Glassdoor to gain insights into salary trends, identify factors influencing salary variations, and provide actionable insights for job seekers.

### Exploratory Data Analysis

1. Which data science job titles are most popular in demand?
2. How does data science salary demand vary by US state, Company size, Rating, etc?

### Data Sources

- **Data source:** <a href="https://www.kaggle.com/datasets/rashikrahmanpritom/data-science-job-posting-on-glassdoor?select=Uncleaned_DS_jobs.csv" target="_blank">Kaggle GlassDoor Data Science Dataset</a>
- **Time period:** Assumed to be 2021 as Dataset was last updated in 2021 but no timestamp were given
- **Data size:** glassdoor_DS_jobs (672, 10)
- **Key columns:** Job title, Salary Estimate, Job Description, Rating, Company name, Location, Headquarters, Size, founded
- **Calculated columns:** simple_job_title, Seniority, min_salary, max_salary, avg_salary, job_state, same_state, company age
- [**Download Data set**](https://github.com/AaronW184/GlassDoor-DS-Jobs-EDA/blob/main/glassdoor_DS_jobs.xlsx)

### Tools and Technologies used

Excel - Simple preprocessing (Trimming, checking for duplicates and missing values, checking columns datatypes)

SQL - Data Cleaning and Data Wrangling

Tableau - Data Visualisation

### Steps Involved

- After importing to SQL server, performed data wrangling on dataset. simple_job_title categorised job_title into 5 main jobs (Data scientist, Data Engineer, Analyst, ML Engineer, Manager), Seniority (junior, senior), lower,upper, average of salary range into min_salary, max_salary, avg_salary, US states, Headquarters states extracted into job_state, same_state, and company age was calculated from founded column. Necessary headers were dropped and some headers were reformatted for easier processing.

### Result and Findings

- Data Scientist were highly sought after in 2021, taking 77% of the Data Science job market.

- Data Scientist Jobs were highly demanded in California and Virginia.

- Average Salary across different company sizes were close and comparable. Companies with 51 to 500 employees have better ratings than the rest.

- Companies in the publishing industry pays the best in the private sector, Companies in the wholesale industry pays the best in the public sector.

### Recommendations for Job Seekers

- Since Data Scientist jobs were highly demanded in California and Virginia, consider looking for opportunities in these states. They are likely to have more job openings and potentially higher salaries due to the demand.

- When evaluating potential employers, consider companies with 51 to 500 employees. These companies tend to have better ratings, suggesting a more positive work environment.

- If you're looking to maximize your earning potential, target companies in the publishing industry within the private sector or companies in the wholesale industry within the public sector. These industries offer the highest salaries for Data Scientists.

- Besides improving and building on data science skills, having a strong domain knowledge in these industry can significantly increase job prospects and earnings potential.
