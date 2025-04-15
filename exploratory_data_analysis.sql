-- EXPLORATORY DATA ANALYSIS

SELECT * 
FROM layoffs_staging2;


SELECT MAX(total_laid_off)
FROM layoffs_staging2;

-- Retrieve companies that laid off 100% of their workforce, sorted by the highest number of total layoffs

SELECT *
FROM layoffs_staging2 WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC
;

-- Retrieve companies that laid off 100% of their workforce, ordered by the highest amount of funds raised (in millions)


SELECT *
FROM layoffs_staging2 WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC
;

-- Calculate the total number of layoffs for each company and sort the results by the highest layoffs


SELECT company, SUM(total_laid_off )
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- Get the earliest and latest dates from the dataset


SELECT MIN(`date`) , MAX(`date`)
FROM layoffs_staging2;


-- Calculate the total number of layoffs by industry and sort the results by the highest layoffs


SELECT industry, SUM(total_laid_off )
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- Calculate the total number of layoffs by country and sort the results by the highest layoffs


SELECT country, SUM(total_laid_off )
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;


-- Calculate the total number of layoffs for each year, sorted by the most recent year


SELECT * 
FROM layoffs_staging2;


SELECT YEAR(`date`), SUM(total_laid_off )
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;


-- Calculating the total number of layoffs by stage and sort the results by the highest layoffs


SELECT stage, SUM(total_laid_off )
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;




-- Shows total layoffs per month (YYYY-MM) in ascending order, ignoring rows with NULL 



SELECT *
FROM layoffs_staging2;

SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ;


-- Calculates total layoffs per month and a running total (cumulative layoffs) over time


WITH Rolling_Total AS
(SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS Total_Off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1

)

 SELECT `MONTH`, Total_Off , SUM(Total_Off) OVER( ORDER BY `MONTH` )
 FROM Rolling_Total;
 
 
 
 SELECT company, YEAR(`date`) ,SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY company, YEAR(`date`)
 ORDER BY 3 DESC
 ;
 
 
 
 WITH Company_Year(company,years,total_laid_off) AS 
 ( SELECT company, YEAR(`date`) ,SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY company, YEAR(`date`)
 
 ),Company_Year_Rank AS
  (SELECT *, DENSE_RANK()OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM Company_Year
  WHERE years IS NOT NULL
  ) 
  SELECT *
  FROM Company_Year_Rank
  WHERE ranking <= 5;
 
 
 
 
 
 







