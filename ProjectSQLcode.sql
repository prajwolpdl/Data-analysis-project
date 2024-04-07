-- Create a join table
select * from Absenteeism_at_work a
left join compensation
on a.id = compensation.id
left join Reasons 
on a.Reason_for_absence = Reasons.number;

--Find the healthiest individuals to provide bonuses to
select * from Absenteeism_at_work a
where Social_smoker = 0 and Social_drinker = 0 
and Body_mass_index < 25 and 
Absenteeism_time_in_hours < (select AVG(Absenteeism_time_in_hours) from Absenteeism_at_work); 


--Compensation rate increase for non smokers ($983,221 budget)
select COUNT(*) from Absenteeism_at_work a
where Social_smoker = 0;
-- (983221/(40*52*686))-> 0.68/hr increase

--Optimize the query
select 
a.ID,
Reasons.Reason,
Month_of_absence,
Body_mass_index,
CASE WHEN Body_mass_index <18.5 then 'Underweight'
	 WHEN Body_mass_index between 18.5 and 25 then 'Healthy'
	 WHEN Body_mass_index between 25 and 30 then 'Overweight'
	 WHEN Body_mass_index >30 then 'Obese'
	 ELSE 'Unknown' END as BMI_Category,
CASE WHEN Month_of_absence IN (12,1,2) Then 'Winter'
	 WHEN Month_of_absence IN (3,4,5) Then 'Spring'
	 WHEN Month_of_absence IN (6,7,8) Then 'Summer'
	 WHEN Month_of_absence IN (9,10,11) Then 'Fall'
	 ELSE 'Unknown' END as Season_names,
Day_of_the_week,
Seasons,
Transportation_expense,
Age,
Work_load_Average_day,
Hit_target,
Disciplinary_failure,
Education,
Son,
Social_drinker,
Social_smoker,
Pet,
Absenteeism_time_in_hours
from Absenteeism_at_work a
left join compensation
on a.id = compensation.id
left join Reasons 
on a.Reason_for_absence = Reasons.number;