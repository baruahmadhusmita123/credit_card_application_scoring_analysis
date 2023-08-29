-- Group  the customer based on their annual income and find the average of their annual income

with avg_cte as 
(
select round(avg(annual_income),2)as Averageincome
from  credittable)
select averageincome
from avg_cte; #created cte for  average income on total annual income
select 
case 
when annual_income > avg(annual_income) then "Good"
when annual_income = avg(annual_income) then "Average"
when annual_income < avg(annual_income) then "Bad"
End as Customer_Group, Ind_id, Income_type
from credittable
group by Ind_id
;

-- Find the female owners of cars and property

Select * from credittable; 
Select Ind_id, Gender, Property_owner, Car_owner
from credittable
where Gender = "F" and property_owner = "Y" and Car_owner = "Y"; 

-- there are 177 females owing cars and property

-- Find the male customers who are staying with their families

select * from credittable;
select Ind_id, Gender, Children, Marital_status, Family_members
from credittable
where Gender = "M" and Family_members>1; 
-- 470 numbers of male staying with family

-- List the top five people having the highest income 

select ind_id, Gender, Education, round(max(annual_income),2)highest_income, income_type 
from credittable
where annual_income != 0
group by ind_id
having highest_income
order by highest_income desc
limit 5; 
-- top 2 position of highest income is grabbed by 2 female in commercial associate sector 
-- having higher education followed by 3 males.

-- to create a column creditapproved wit label column

alter  table credittable
add column creditapproved varchar(10); 
update credittable 
set creditapproved =
case 
when label = 0  then 'approved'
when label = 1 then 'rejected'
end;

--  How many  married men are having bad credit

select count(gender)total_men, gender, marital_status, creditapproved
from credittable
where gender = 'M' and marital_status = 'Married' and label = 1
group by creditapproved;
-- 51 married men are having bad credits

-- What is the highest education level and what is the total count

select * from  credittable;
select distinct(education)Education_type, count(education)total_count from credittable
group by education_type
order by total_count asc;
-- highest education level is the academic degree and total count is only 2 

-- Between married males and females, who is having more bad credits

select count(gender)total, gender, marital_status, creditapproved
from credittable
where label = 1 and marital_status = "Married"
group by gender, creditapproved
order by total desc;
-- females are having more bad credits than male