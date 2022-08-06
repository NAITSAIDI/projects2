create database if not exists Proj_2;
use Proj_2;

/* In this table, representing the number of beds per 1000, we created this table were we get the normalized value for each country 
in relation to the other countries */
create table norm_beds as
select economy, (YR2017-(select min(b2.YR2017) from beds as b2 where b2.economy in ("FRA","USA","GBR","JPN")))/(select max(b3.YR2017)-min(b3.YR2017) from beds as b3 where b3.economy in ("FRA","USA","GBR","JPN")) as normalized_beds_per_1000
from beds
where economy IN ("FRA","USA","GBR","JPN");

/*In this table, representing the % of deaths caused by diabetes and cancer, we created this table were we get the normalized value for each country 
in relation to the other countries */
create table norm_mortality as
select economy, (YR2017-(select min(m2.YR2017) from `mortality_%_cancer_diabetes` as m2 where m2.economy in ("FRA","USA","GBR","JPN")))/(select max(m3.YR2017)-min(m3.YR2017) from `mortality_%_cancer_diabetes` as m3 where m3.economy in ("FRA","USA","GBR","JPN")) as normalized_mortality_rate
from `mortality_%_cancer_diabetes`
where economy IN ("FRA","USA","GBR","JPN");

/* In this table, representing the number of nurses and midwives per 1000 people, we created this table were we get the normalized value for each country 
in relation to the other countries*/
create table norm_nurses as
select economy, (YR2017-(select min(n2.YR2017) from nurses_per_1000 as n2 where n2.economy in ("FRA","USA","GBR","JPN")))/(select max(n3.YR2017)-min(n3.YR2017) from nurses_per_1000 as n3 where n3.economy in ("FRA","USA","GBR","JPN")) as normalized_nurses_per_1000
from nurses_per_1000
where economy IN ("FRA","USA","GBR","JPN");


/*In this table, representing the number of doctors per 1000 people we created this table were we get the normalized value for each country 
in relation to the other countries */
create table norm_physicians as
select economy, (YR2017-(select min(p2.YR2017) from physicians_per_1000 as p2 where p2.economy in ("FRA","USA","GBR","JPN")))/(select max(p3.YR2017)-min(p3.YR2017) from physicians_per_1000 as p3 where p3.economy in ("FRA","USA","GBR","JPN")) as normalized_physiscians_per_1000
from physicians_per_1000
where economy IN ("FRA","USA","GBR","JPN");


/*Since we created the normalized tables, we simply join the tables together using the economy as a common key. 
We then add the normalized values we obtained to each other to get the value of the composite indicator based on the criteria 
we defined. Finally, we used the rank function of SQL to get a rank for the countries based on the CI. 
In our comparison, France is the best country with respect to healthcare accessibility, quality and availability   */
select table1.economy as countries, table1.sum_all as composite_indicator, rank() over(order by table1.sum_all desc) as rank_of_country
from (select norm_beds.economy,norm_beds.normalized_beds_per_1000,norm_nurses.normalized_nurses_per_1000, norm_physicians.normalized_physiscians_per_1000, norm_mortality.normalized_mortality_rate*-1,
cast(norm_beds.normalized_beds_per_1000 + norm_nurses.normalized_nurses_per_1000 + norm_physicians.normalized_physiscians_per_1000 + norm_mortality.normalized_mortality_rate*-1 as DECIMAL(10,3))  as sum_all
from norm_beds 
inner join norm_mortality on norm_beds.economy=norm_mortality.economy
inner join norm_nurses on norm_beds.economy=norm_nurses.economy
inner join norm_physicians on norm_beds.economy=norm_physicians.economy) as table1;





