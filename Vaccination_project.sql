-- use database
USE protifolio_project;
/*to know table definition in SQL SERVER
exec sp_help 'protifolio_project..covid_vaccination';
*/
sp_help [covid_vaccination];

-- view availble columns in vaccination table
select * from protifolio_project..covid_vaccination;

-- checking ditinct iso_code of loction in table 
select distinct iso_code from protifolio_project..covid_vaccination order by iso_code;
/*
select distinct cv_a.iso_code from protifolio_project..covid_vaccination cv_a
join protifolio_project..covid_vaccination cv_b on cv_a.iso_code=cv_b.iso_code;
*/

select distinct iso_code,continent,location,total_tests,positive_rate,
total_vaccinations,people_vaccinated,people_fully_vaccinated,population,median_age
from protifolio_project..covid_vaccination order by iso_code;

---- total vaccination per location
select continent,location,sum(cast(coalesce(total_vaccinations,0) as bigint))as total_vacc_per_loc
from protifolio_project..covid_vaccination
where continent is not null and 
location not in ('World','European Union','International')
group by continent,location
order by total_vacc_per_loc desc;

--maximum people fully vaccinated and percentage people fully vaccinated 

select distinct continent,location,total_vaccinations,
people_fully_vaccinated,population,
MAX(cast(people_fully_vaccinated as int)) as max_ppl_fully_vacc,
SUM(cast(people_fully_vaccinated as int)/population)*100 as pcntg_ppl_fully_vacc
from protifolio_project..covid_vaccination
where continent is not null
group by continent,location,total_vaccinations,
people_fully_vaccinated,population
order by max_ppl_fully_vacc desc;

--maximum people fully vaccinated and percentage people fully vaccinated at certain date

select distinct continent,location,date,total_vaccinations,
people_fully_vaccinated,population,
MAX(cast(people_fully_vaccinated as int)) as max_ppl_fully_vacc,
SUM(cast(people_fully_vaccinated as int)/population)*100 as pcntg_ppl_fully_vacc
from protifolio_project..covid_vaccination
where continent is not null
group by continent,location,date,total_vaccinations,
people_fully_vaccinated,population
order by max_ppl_fully_vacc desc;

