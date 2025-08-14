
USE Absenteeism_at_work;
GO
;


select ID,Body_mass_index,Social_drinker,Social_smoker,Absenteeism_time_in_hours
from Absenteeism_at_work
where Body_mass_index<24.9 and Body_mass_index>18.5
and Social_drinker=0 and Social_drinker=0 and
Absenteeism_time_in_hours<(select AVG(Absenteeism_time_in_hours) from Absenteeism_at_work)
;
select count(ID)
from Absenteeism_at_work
where Social_smoker=0;

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