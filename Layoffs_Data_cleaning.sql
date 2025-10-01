-- DATA CLEANING AND EXPLORATORY DATA ANALYSIS PROJECT

-- Data Cleaning

use world_layoffs;

select * 
from layoffs;

-- remove duplicates in data
-- standardise data in case or letters
-- remove nulls or blank values
-- remove not neccessary columns in data

create table layoffs_staging 
like layoffs;

select * 
from layoffs_staging;

insert layoffs_staging 
select * 
from layoffs;


select *, 
row_number() over(partition by company, industry, 
total_laid_off, percentage_laid_off, `date`) as row_num
from layoffs_staging;

-- create cte for duplicates

with duplicate_cte as
(
select *, 
row_number() over(partition by company, location, industry, 
total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
select * 
from duplicate_cte
where row_num > 1;

select * 
from layoffs_staging
where company = 'Yahoo';

with duplicate_cte as
(
select *, 
row_number() over(partition by company, location, industry, 
total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
delete
from duplicate_cte
where row_num > 1;

CREATE TABLE `layoffs_staging_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * 
from layoffs_staging_2;

insert into layoffs_staging_2
select *, 
row_number() over(partition by company, location, industry, 
total_laid_off, percentage_laid_off, `date`, stage, country, 
funds_raised_millions) as row_num
from layoffs_staging;

SET sql_safe_updates = 0;

delete 
from layoffs_staging_2
where row_num > 1;

select *
from layoffs_staging_2
where row_num > 1;

-- standardising data

select Distinct (company)
from layoffs_staging_2;

select company, trim(company)
from layoffs_staging_2;

SET sql_safe_updates = 0;

update layoffs_staging_2
set company = trim(company);

select distinct *
from layoffs_staging_2
where industry LIKE "Crypto%";

update layoffs_staging_2
set industry = "Crypto"
where industry like "Crypto%";

select distinct location 
from layoffs_staging_2
order by 1; 

select distinct country
from layoffs_staging_2
order by 1; 

update layoffs_staging_2
set country = trim(trailing '.' from country)
where country like "United States%";

select `date`, 
str_to_date(`date`, "%m/%d/%Y")
from layoffs_staging_2
order by 1;

update layoffs_staging_2
set `date` = str_to_date(`date`, "%m/%d/%Y");

select `date`
from layoffs_staging_2;

alter table layoffs_staging_2
modify column `date` DATE;

select *
from layoffs_staging_2;

-- working with null/blank values

select * 
from layoffs_staging_2
where (total_laid_off is NULL or total_laid_off ='')
and (percentage_laid_off is NULL or percentage_laid_off = '');

delete from layoffs_staging_2
where (total_laid_off is NULL or total_laid_off ='')
and (percentage_laid_off is NULL or percentage_laid_off = '');

select *
from layoffs_staging_2
where industry is NULL
or industry = '';

select *
from layoffs_staging_2
where company in ("Airbnb", "Carvana", "Juul");

select t1.industry, t2.industry
from layoffs_staging_2 as t1
join layoffs_staging_2 as t2
on t1.company = t2.company
and t1.location = t2.location
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

update layoffs_staging_2
set industry = null
where industry = '';

update layoffs_staging_2 t1
join layoffs_staging_2 t2
on t1.company = t2.company
set t1.industry = t2.industry
where (t1.industry is null)
and t2.industry is not null;

select * 
from layoffs_staging_2
where company like "bally%";

alter table layoffs_staging_2
drop column row_num;

select * 
from layoffs_staging_2;

