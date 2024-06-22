

--select * from Portfolio..CovidVaccination
--order by 3,4

--select the data that we r going to be using it 
--select location,date ,total_cases,population ,(total_cases/population)*100 as PopInfected 
--from CovidDeaths
--where location='Tunisia'
--order by 1,2 


--Looking at countries with highest infection rate compared to population 

--select location,date ,Max(total_cases) ,population ,(total_cases/population)*100 as PopInfected 
--from Portfolio..CovidDeaths 
--order by 1,2 



with PoVsVacc ( Continent , location  , date, population , new_vaccinations, RollingPeapleVaccinated)
as (
select dea.continent , dea.location, dea.date ,dea.population ,vac.new_vaccinations ,
sum(convert(int , vac.new_vaccinations)) over (partition by dea.location order by dea.location , dea.date) as RollingPeapleVaccinated
from CovidDeaths dea join CovidVaccination vac
on dea.location = vac.location 
and dea.date = vac.date 
where dea.continent is not null 
)
select * , (RollingPeapleVaccinated/population)*100
from PoVsVacc


create table PercentPeapleVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric, 
new_vaccinations numeric,
RollingPeapleVaccinated numeric )



create view PercentPeapleVaccinatedView 
as 
select dea.continent , dea.location, dea.date ,dea.population ,vac.new_vaccinations ,
sum(convert(int , vac.new_vaccinations)) over (partition by dea.location order by dea.location , dea.date) as RollingPeapleVaccinated
from CovidDeaths dea join CovidVaccination vac
on dea.location = vac.location 
and dea.date = vac.date 
where dea.continent is not null 