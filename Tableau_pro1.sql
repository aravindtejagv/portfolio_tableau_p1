/*
Queries used for tableau project
*/

--1.
select 
SUM(new_cases) as total_cases,SUM(cast(new_deaths as int)) as total_deaths,
sum(cast(coalesce(new_deaths,0) as int))/sum(new_cases)* 100 as death_percentage
from protifolio_project..covid_deaths_data
where continent is not null
order by 1,2;

-- 2. 

-- We take these out as they are not inluded in the above queries and want to stay consistent
-- European Union is part of Europe

select continent,location,SUM(cast(coalesce(new_deaths,0) as int)) as total_death_count
from protifolio_project..covid_deaths_data
where continent is not null and 
location not in ('World', 'European Union', 'International')
group by continent,location
order by total_death_count desc;

--3.
--PercentPopulationInfected and HighestInfectionCount 

select location,population,max(total_cases) as HighestInfectionCount,
max(CAST(total_cases as int)/population)*100 as PercentPopulationInfected
from protifolio_project..covid_deaths_data
group by location,population
order by PercentPopulationInfected desc;

--4.
--PercentPopulationInfected and HighestInfectionCount by date
select location,population,date,max(total_cases) as HighestInfectionCount,
max(CAST(total_cases as int)/population)*100 as PercentPopulationInfected
from protifolio_project..covid_deaths_data
group by location,population,date
order by PercentPopulationInfected desc;





