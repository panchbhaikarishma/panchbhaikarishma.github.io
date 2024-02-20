select * 
from PortfolioProject..CovidDeaths$
where continent is not null	
order by 3,4

select * 
from PortfolioProject..CovidVaccinations$
where continent is not null	
order by 3,4

Select Location, Date, Total_cases, New_cases,Total_deaths,population
from PortfolioProject..CovidDeaths$
where continent is not null	
order by 1,2

--Looking at total cses vs Total deaths
--Shows likelihood of dying if you contrac covid in your country


Select Location, Date, Total_cases,Total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths$
where continent is not null	
order by 1,2

--Looking at Total cases vs population
--Shows what percentage of population got Covid

Select Location, Date,Population,Total_cases, (total_cases/population)*100 as PercentagePopulationInfected
from PortfolioProject..CovidDeaths$
where continent is not null	
order by 1,2

--Looking at Countries with highest Infection rate compared to population

Select Location,Population,Max(Total_cases) as HighestInfectionCount, Max(total_cases/population)*100 as PercentagePopulationInfected
from PortfolioProject..CovidDeaths$
Group by Location,population




order by PercentagePopulationInfected desc

--Showing the countries with Highest Death count per Population

Select Location,Max(cast(Total_Deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths$
where continent is not null	
Group by Location
order by TotalDeathCount desc

--Lets's Break thingd down by Continent
Select continent,Max(cast(Total_Deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths$
where continent is  not null	
Group by continent
order by TotalDeathCount desc


--Showing continents with the hightest death count per population

Select continent,Max(cast(Total_Deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths$
where continent is  not null	
Group by continent
order by TotalDeathCount desc


--Gobal Numbers

Select Sum(new_cases)as Total_cases, SUM(cast(new_Deaths as int))as Total_Deaths,SUM(cast(new_Deaths as int))/SUM(new_Cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths$
where continent is not null	
--group by Date
order by 1,2

---Lokking Totla populations vs Vaccinations
Select * from
PortfolioProject..CovidVaccinations$

Select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(convert(int,vac.new_vaccinations)) over ( Partition by dea.location order by dea.location, dea.date) as Rollingpeoplevaccinated
--,(Rollingpeoplevaccinated/population)*100
from PortfolioProject..CovidDeaths$ dea
join PortfolioProject..CovidVaccinations$ vac
	on dea.location= vac.location
	and dea.date = vac.date	
	where dea.continent is not null
order by 2,3


--Use CTE
with popvsvac( continent, location,date, population,new_vaccinations,rollingpeoplevaccination)
as
(
Select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(convert(int,vac.new_vaccinations)) over ( Partition by dea.location order by dea.location, dea.date) as Rollingpeoplevaccinated
--,(Rollingpeoplevaccinated/population)*100
from PortfolioProject..CovidDeaths$ dea
join PortfolioProject..CovidVaccinations$ vac
	on dea.location= vac.location
	and dea.date = vac.date	
	where dea.continent is not null
--order by 2,3
)
Select *,(rollingpeoplevaccination/population)*100
from popvsvac



--Temp Table
drop table if exists  #PercentPopulationVaccinated
Create table #PercentPopulationVaccinated
(
continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
new_vaccinations numeric,
Rollingpeoplevaccinated numeric
)

insert into #PercentPopulationVaccinated
Select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(convert(int,vac.new_vaccinations)) over ( Partition by dea.location order by dea.location, dea.date) as Rollingpeoplevaccinated
--,(Rollingpeoplevaccinated/population)*100
from PortfolioProject..CovidDeaths$ dea
join PortfolioProject..CovidVaccinations$ vac
	on dea.location= vac.location
	and dea.date = vac.date	
	--where dea.continent is not null
--order by 2,3


Select *,(Rollingpeoplevaccinated/population)*100
from #PercentPopulationVaccinated


--Creating view to store data for later Visualizations

create view PercentPopulationVaccinated as 
select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(convert(int,vac.new_vaccinations)) over ( Partition by dea.location order by dea.location, dea.date) as Rollingpeoplevaccinated
--,(Rollingpeoplevaccinated/population)*100
from PortfolioProject..CovidDeaths$ dea
join PortfolioProject..CovidVaccinations$ vac
	on dea.location= vac.location
	and dea.date = vac.date	
	where dea.continent is not null
--order by 2,3

select *
from PercentPopulationVaccinated








































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































