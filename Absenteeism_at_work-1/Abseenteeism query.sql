-- HR REQUEST
--Provide a list of Healthy Individuals & Low Absenteeism for
--the healthy bonus program with a budget of $1000 USD

--Calculate a Wage Increase or annual compensation for Non-smokers
-- Insurance Budger of $983.221 for all Non-smokers

--Create a Dashboard for HR to understand Absenteeism at work based
--on approved wireframe

--- finding the healthiest
--- We have BMI as a measure of health, also if is social drinker/smoker, and hte amount of absenteeism
---in hours(if is low we can assume is healthy)
--- Our criteria for the healthiest will be: non social drinker/smoker, with BMI in [25.29.9]
--- with lower absenteeism in hours than average
select ID,Body_mass_index,Social_drinker,Social_smoker,Absenteeism_time_in_hours
from Absenteeism_at_work
where Body_mass_index<24.9 and Body_mass_index>18.5
and Social_drinker=0 and Social_drinker=0 and
Absenteeism_time_in_hours<(select AVG(Absenteeism_time_in_hours) from Absenteeism_at_work)
;
---We got the ID's of the 125 healthiest employess, now we can assign them the bonus of $8

-- Next we count the amount of Non-smokers
select count(ID)
from Absenteeism_at_work
where Social_smoker=0

-- considering our budget of 983.221 and that the workers do 8 hrs 5 days a week for 52 weeks in a year
---,it gives 2080hrs for worker, having 686 it give us 1426880 total hours, then we divide 983.221/1426880
--- that is 0.68$ (rounded) increase per hour

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
;