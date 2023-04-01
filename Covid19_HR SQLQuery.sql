
--Covid-19 & Human Resources Analytics

Select *
From CovidProject..CovidHR
Where location like '%canada%'
Order by 1


-- Confirmed COVID-19 cases

SELECT [Confirmed case], COUNT ([Confirmed case]) AS count_cases
From CovidProject..CovidHR
Where location like '%canada%'and [Confirmed case] = 'Yes'
GROUP BY [Confirmed case]


--Total Gender of Employees

Select Gender, COUNT (Gender) As Total_Employees_Gender
From CovidProject..CovidHR
Where location like '%canada%'
Group by Gender
Order by 1


--Total No of Employees

Select COUNT (Gender) As Total_Employees
From CovidProject..CovidHR
Where location like '%canada%'


--Risk level based on age

Select Age,
Case
	When Age > 45 Then 'High_Risk'
	Else 'Low_Risk'
	End as Risk_Level
From CovidProject..CovidHR
Where location like '%canada%'


--Count of Employees at risk

With risk_count As (
Select Age,
Case
	When Age >= 45 Then 'High_Risk'
	Else 'Low_Risk'
	End as Risk_Level
From CovidProject..CovidHR
Where location like '%canada%'
)
Select Count (Case When Risk_Level = 'High_Risk' then 1 Else 0 End) as Employees_at_risk
From risk_count
Where Risk_Level = 'High_Risk'
Group by Risk_Level


--Employees at risk by Gender

With risk_count As (
Select Age, Gender,
Case
	When Age >= 45 Then 'High_Risk'
	Else 'Low_Risk'
	End as Risk_Level
From CovidProject..CovidHR
Where location like '%canada%'
)
Select Gender, Count (Case When Risk_Level = 'High_Risk' then 1 Else 0 End) as Employees_at_risk
From risk_count
Where Risk_Level = 'High_Risk'
Group by Risk_Level, Gender


--Employees and At-risk groups by Region

With Risk_count As (
Select Age, Gender, [BU region] As Region,
Case
	When Age >= 45 Then 'High_Risk'
	Else 'Low_Risk'
	End as Risk_Level
From CovidProject..CovidHR
Where location like '%canada%'
)
Select Region, COUNT (Gender) As Total_Employees, Count (Case When Risk_Level = 'High_Risk' then 1 End) as Employees_at_risk
From Risk_count
Group by Region


--Employees and At-risk and NOT At-risk groups by Region

With Risk_count As (
Select Age, Gender, [BU region] As Region,
Case
	When Age < 45 Then 'Low_Risk'
	Else 'High_Risk'
	End as Risk_Level
From CovidProject..CovidHR
Where location like '%canada%'
)
Select Region, Count (Case When Risk_Level = 'Low_Risk' then 1 End) as Low_risk_Employees, 
Count (Case When Risk_Level = 'High_Risk' then 1 End) as Employees_at_risk, COUNT (Gender) As Total_Employees
From Risk_count
Group by Region


--Age Distribution of Employees | At-risk

With Risk_count As (
Select Age, AgeGroup, Gender,
Case
	When Age >= 45 Then 'High_Risk'
	Else 'Low_Risk'
	End as Risk_Level
From CovidProject..CovidHR
Where location like '%canada%'
)
Select AgeGroup, COUNT (Gender) As Total_Employees, Count (Case When Risk_Level = 'High_Risk' then 1 End) as Employees_at_risk,
Count (Case When Risk_Level = 'Low_Risk' then 1 End) as Low_risk_Employees 
From Risk_count
Group by AgeGroup


-- At-risk, Confirmed COVID-19 cases and Total Employees by Gender

With Risk_count As (
Select Age, AgeGroup, Gender, [Confirmed case],
Case
	When Age >= 45 Then 'High_Risk'
	Else 'Low_Risk'
	End as Risk_Level
From CovidProject..CovidHR
Where location like '%canada%'
)
Select Gender, COUNT (Gender) As Total_Employees, Count (Case When Risk_Level = 'High_Risk' then 1 End) as Employees_at_risk,
Count (Case When ([Confirmed case]) = 'Yes' then 1 End) AS Confirmed_cases
From Risk_count
Group by Gender