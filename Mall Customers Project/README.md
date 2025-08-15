# Overview

Stake holders wants to identify the most important shopping groups based on income
, age, and the mall shopping score. They wan the optimal ammount of groups labeled so the
marketing team can plan a strategy.


## ⚙️ Requirements
 
- Python ≥ 3.8  
- pandas  
- numpy  
- matplotlib  
- seaborn  
- scikit-learn  
- jupyter

## [Data](Data/) 📁


### 📄 [Mall Customers](Data/Mall_Customers.csv)
**Description:** csv file with CustomerID, Gender, Age, Annual Income (k$), Spending Score (1-100) of customers.

## [Jupyter Notebook 📝](Mall_Customers.ipynb)
### 💪 Healthy Bonus Program
The criteria I used to identify healthy employees with low absenteeism were:  
- BMI between 18.5 and 24.9  
- Non-smoker  
- Non-drinker  
- Absenteeism time in hours lower than average  

The following query filters by these criteria, giving us a list of 111 IDs:  

```sql
select ID
from Absenteeism_at_work
where Body_mass_index<24.9 and Body_mass_index>18.5
and Social_drinker=0 and Social_smoker=0 and
Absenteeism_time_in_hours<(select AVG(Absenteeism_time_in_hours) from Absenteeism_at_work)
```
We have a budget of $1,000 USD, so $1,000 ÷ 111 ≈ $9.00 per person.

### 🚭 Non-Smoker Compensation

The following query counts the number of non-smokers, which is 686:

```sql
select count(ID)
from Absenteeism_at_work
where Social_smoker=0;
```

- Non-smokers counted: 686
- Assumptions: 8 hours/day, 5 days/week, 52 weeks/year → 2,080 hours/year per worker
- Total hours: 686 × 2,080 = 1,426,880 hours
- Hourly increase: $983,221 ÷ 1,426,880 ≈ $0.69/hour

Each non-smoker receives approximately $0.69 per hour as part of the annual compensation increase.

### 📊 Absenteeism Dashboard

This final query joins tables to create a complete dataset for visualization. It also added new categories like **Season** and **BMI_category** to make filtering easier in Power BI.

```sql
select a.ID,Reason,Month_of_absence,
case
when Month_of_absence in (12,1,2) then 'Winter'
when Month_of_absence in (3,4,5) then 'Spring'
when Month_of_absence in (6,7,8) then 'Summer'
when Month_of_absence in (9,10,11) then 'Fall'
else 'Unknown'end as Season,
case
when Body_mass_index < 18.5 then 'Underweight'
when Body_mass_index >=18.5 and Body_mass_index<=24.9 then 'Healthy'
when Body_mass_index >24.9 and Body_mass_index<=29.9 then 'Overweight'
when Body_mass_index >29.9 then 'Obese'
else 'Unknown' end as BMI_category,Body_mass_index,
Day_of_the_week,Transportation_expense,Distance_from_Residence_to_Work,
Service_time,age,Work_load_Average_day,Hit_target,Disciplinary_failure,Education,
Son,Social_drinker,Social_smoker,Pet,Absenteeism_time_in_hours,Height,Weight,comp_hr
from Absenteeism_at_work as a
left join compensation as c
on a.ID=c.ID
left join Reasons as r
on a.Reason_for_absence=r.Number
```

## Dashboard Preview

![Dashboard preview](dashboard_preview.png)

# 📊 [Download Power BI dashboard](Absenteeism%20visualizations.pbix)