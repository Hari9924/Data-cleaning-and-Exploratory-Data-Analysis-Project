# Data-cleaning-and-Exploratory-Data-Analysis-Project for Global Layoffs Data
## Overview
SQL project on global layoffs data. Cleaned raw data by removing duplicates, handling nulls, standardizing text, and fixing dates. Performed EDA with aggregations, window functions, and CTEs to analyze layoffs by company, industry, country, stage, and time trends

## Process

### Data Cleaning

* Removed duplicate rows using `ROW_NUMBER()` and CTEs.
* Fixed inconsistent text values (e.g., industries like "Crypto" vs "Cryptocurrency").
* Cleaned country names (e.g., "United States." → "United States").
* Converted date strings into proper `DATE` format.
* Filled missing industries using company-level information where possible.
* Dropped helper columns and rows with no meaningful data.

### Exploratory Analysis

After cleaning, I used SQL queries to explore trends:

* Companies with the **largest single-day layoffs**.
* Total layoffs by **company, location, country, and industry**.
* Layoffs grouped by **funding stage** (startup, IPO, unicorn, etc.).
* **Yearly and monthly layoff trends**.
* Top 3 companies with the highest layoffs **per year**.
* **Rolling monthly totals** using window functions.

---

## Key Findings

* Some companies laid off **their entire workforce (100%)**, effectively shutting down.
* **Tech and Crypto** companies had the most layoffs overall.
* The **U.S.** dominated in total layoffs compared to other countries.
* Layoffs spiked during certain years and months, aligning with **economic slowdowns**.
* Both early-stage startups and later-stage companies were affected, but the scale differed.

---

## Tech & Skills

* **MySQL**
* Data cleaning techniques (deduplication, standardization, handling nulls)
* **CTEs, Window Functions, Aggregations, Date Functions**
* Analytical problem-solving using SQL

---

## Repository Contents

* `layoffs_Data_cleaning.sql` → SQL script for cleaning raw data
* `Layoffs_EDA.sql` → SQL script for exploratory analysis
* `layoffs_raw.csv` → Dataset used for the project

---






