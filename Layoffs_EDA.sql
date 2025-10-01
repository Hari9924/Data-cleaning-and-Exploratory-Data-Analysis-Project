-- Exploratory Data Analysis-------------------------------------------------------------------------------------------------------------

select * 
from layoffs_staging_2;

select *
from layoffs_staging_2
where total_laid_off =  (select max(total_laid_off) 
from layoffs_staging_2);

select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging_2;

select * 
from layoffs_staging_2
where percentage_laid_off = 1
order by total_laid_off desc;

select * 
from layoffs_staging_2
where percentage_laid_off = 1
order by funds_raised_millions desc;


-- SOMEWHAT TOUGHER AND MOSTLY USING GROUP BY--------------------------------------------------------------------------------------------------

-- Companies with the biggest single Layoff

SELECT company, total_laid_off
from layoffs_staging_2
ORDER BY 2 desc;

-- now that's just on a single day

-- Companies with the most Total Layoffs
SELECT company, SUM(total_laid_off)
from layoffs_staging_2
GROUP BY company
ORDER BY 2 desc;




-- by location
SELECT location, SUM(total_laid_off)
from layoffs_staging_2
GROUP BY location
ORDER BY 2 desc;


select MIN(`date`), max(`date`)
from layoffs_staging_2;
-- this it total in the past 3 years or in the dataset

SELECT country, SUM(total_laid_off)
from layoffs_staging_2
GROUP BY country
ORDER BY 2 desc;

SELECT YEAR(date), SUM(total_laid_off)
from layoffs_staging_2
GROUP BY YEAR(date)
ORDER BY 1 ASC;


SELECT industry, SUM(total_laid_off)
from layoffs_staging_2
GROUP BY industry
ORDER BY 2 DESC;


SELECT stage, SUM(total_laid_off)
from layoffs_staging_2
GROUP BY stage
ORDER BY 2 DESC;






-- TOUGHER QUERIES------------------------------------------------------------------------------------------------------------------------------------

-- Earlier we looked at Companies with the most Layoffs. Now let's look at that per year. It's a little more difficult.
-- I want to look at 

WITH Company_Year AS 
(
  SELECT company, YEAR(date) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging_2
  GROUP BY company, YEAR(date)
)
, Company_Year_Rank AS (
  SELECT company, years, total_laid_off, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;




-- Rolling Total of Layoffs Per Month
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging_2
GROUP BY dates
ORDER BY dates ASC;

-- now use it in a CTE so we can query off of it
WITH DATE_CTE AS 
(
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging_2
GROUP BY dates
ORDER BY dates ASC
)
SELECT dates, SUM(total_laid_off) OVER (ORDER BY dates ASC) as rolling_total_layoffs
FROM DATE_CTE
ORDER BY dates ASC;



