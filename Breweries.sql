select*
from fmcg

select 
where countries is null or countries ='';


SELECT DISTINCT brands
FROM fmcg;

copy fmcg from 'C:/Users/hp/Documents/Data Analysis Professional/Sql/International_Breweries.csv' with(format csv, header true);

alter table fmcg
add column territory varchar(50);

alter table fmcg
add column beer_or_malt varchar(50);

update fmcg
set beer_or_malt =  case
       when brands in ('beta malt','grand malt') then 'Malt'
	   else 'Beer'
   end;

update fmcg
set territory =  case
       when countries in ('Nigeria','Ghana') then 'Anglophone'
	   else 'Franchophone'
   end;


alter table fmcg
alter profit set data type numeric 
using profit::numeric;

-----------  profit worth of the breweries inclusive of the anglophone and the francophone territories---

select years,
sum(profit) as total_profit
from fmcg
group by years;

----------Comparison of the total profit between these two territories--------
select territory,
sum(profit) as total_profit
from fmcg
group by territory;

-------Country that generated the highest profit in 2019
select countries,
sum(profit) as total_profit
from fmcg
where years='2019'
group by countries
order by total_profit desc
limit 1;

------The year with the highest profit---
select years,
sum(profit) as total_profit
from fmcg
group by years
order by total_profit desc
limit 1;

---------Month in the three years was the least profit generated----
select months,
sum(profit) as total_profit
from fmcg
group by months
order by total_profit 
limit 1;

----------The minimum profit in the month of December 2018
select min(profit) as minimum_profit
from fmcg
where years='2018' and months='December';

----------The profit in percentage for each of the month in 2019----
select months,
sum(profit) as total_profit,
round ((sum(profit) *100 )/ sum(sum(profit)) over(),2) as total_profit_percentage
from fmcg
where years in ('2019')
group by months
order by total_profit_percentage desc;

--------- Brand who generated the highest profit in Senegal-----
select brands,
sum(profit) as total_profit
from fmcg
where countries='Senegal'
group by brands
order by total_profit desc
limit 1;

--------Profit over the month-------
select months,
sum(profit) as total_profit
from fmcg
group by months
order by total_profit desc;

------Top three brands consumed in the francophone countries, within the last two years-----
select brands,
sum(quantity) as total_quantity
from fmcg
where years in ('2019','2018') and territory='Franchophone'
group by brands
order by sum(quantity) desc
limit 3;

----------- Top two choice of consumer brands in Ghana----
select brands,
sum(quantity) as total_quantity
from fmcg
where countries='Ghana'
group by brands
order by sum(quantity) desc
limit 2;

----------------Details of beers consumed in the past three years in the most oil reached country in West Africa----
select brands,
sum(quantity) as total_quantity
from fmcg
where countries='Nigeria' and beer_or_malt= 'Beer'
group by brands
order by sum(quantity) desc;

-------------------- Favorite malt brand in Anglophone region between 2018 and 2019---------
select brands,
sum(quantity) as total_quantity
from fmcg
where years in ('2019','2018') and territory='Anglophone' and beer_or_malt='Malt'
group by brands
order by sum(quantity) desc
limit 1;

-----------Which brands sold the highest in 2019 in Nigeria-----
select brands,
sum(quantity) as total_quantity
from fmcg
where years in ('2019') and countries='Nigeria'
group by brands
order by sum(quantity) desc;

-----------Favorites brand in South-South region in Nigeria-----
select brands,
sum(quantity) as total_quantity
from fmcg
where region=('southsouth') and countries='Nigeria'
group by brands
order by sum(quantity) desc
limit 1;

-----------Beer consumption in Nigeria----
select brands,
sum(quantity) as total_quantity
from fmcg
where beer_or_malt='Beer' and countries='Nigeria'
group by brands
order by sum(quantity) desc;

------------Level of consumption of Budweiser in the regions in Nigeria----
select region,
sum(quantity) as total_quantity
from fmcg
where brands='budweiser' and countries='Nigeria'
group by region
order by sum(quantity) desc;

---------- Level of consumption of Budweiser in the regions in Nigeria in 2019 (Decision on Promo)-----
select region,
sum(quantity) as total_quantity
from fmcg
where brands='budweiser' and countries='Nigeria' and years in ('2019')
group by region
order by sum(quantity) desc;

----------Country with the highest consumption of beer--------
select countries,
sum(quantity) as total_quantity
from fmcg
where beer_or_malt='Beer'
group by countries
order by sum(quantity) desc
limit 1;

--------- Highest sales personnel of Budweiser in Senegal-------
select sales_rep,
sum(quantity) as total_quantity
from fmcg
where brands='budweiser' and countries in ('Senegal')
group by sales_rep
order by sum(quantity) desc
LIMIT 1;

-------- Country with the highest profit of the fourth quarter in 2019--------
Select countries,
sum(profit) as total_profit
from fmcg
where months in ('October','November','December') and years in ('2019')
group by countries 
order by total_profit desc
limit 1;