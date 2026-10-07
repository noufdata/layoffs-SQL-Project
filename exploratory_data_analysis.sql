-- View the entire dataset
select *
from layoff_staging2;

-- Count the total number of layoff_staging2 record in the dataset
select count(*)
from layoff_staging2;

-- Identify all unique industries represented in the dataset
Select distinct industry 
from layoff_staging2;

-- Find companies with the largest number of employees laid off
select company , total_laid_off
from layoff_staging2
order by total_laid_off desc
limit 10;

-- Find companies with the highest Percentage of workforce laid off
select company , Percentage_laid_off
from layoff_staging2
order by percentage_laid_off desc;

-- Calculate total laid off by country
Select country , sum(total_laid_off) as total_laid_off
from layoff_staging2
group by country
order by total_laid_off desc;

 -- Calculate total laid off by industry
 Select industry , sum(total_laid_off) as total_laid_off
from layoff_staging2
group by industry
order by total_laid_off desc;
 
 -- Analyse layoff_staging2 trends by year 
 select year(`date`) as `year`,
 sum(total_laid_off) as total_layoffs
 from layoff_staging2
 group by `year`
 order by total_layoffs desc;
 
 -- identify the companies responsible for the highest total laidoffs
 select company , sum(total_laid_off) as total_layoffs
 from layoff_staging2
 group by company
 order by total_layoffs desc
 limit 10;
 
 -- Rank the top 10 companies with the highest layoffs each year
 With company_year as (
 select company , year(`date`) as `year` , 
 sum(total_laid_off) as layoffs
 from layoff_staging2
 group by company , `year`),
company_rank as (
select * , dense_rank()  over(partition by `year` order by layoffs desc) as Ranking
from company_year)
select *
from company_rank
where Ranking <= 10;

/*
Key Insights:

1. The United States recorded the highest number of layoffs.
2. The 'Consumer' industry experienced the largest workforce reductions.
3. Layoffs peaked during specific economic downturn periods.
4. Several companies reported laying off 100% of their workforce.
5. Monthly layoffs fluctuated significantly over time.
*/


 
 

