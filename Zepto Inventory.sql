drop table if exists zepto;

create table zepto(
sku_id serial primary key,
category varchar(120),
name varchar(150) not null,
mrp numeric(8,2),
discountPercent numeric(5,2),
availableQuantity integer,
discountSellingPrice numeric (8,2),
weightInGms integer ,
outOfStock boolean ,
quantity integer
); 

--Data Exploration 

--Count Row 
select count(*) from zepto;

--Sample Data
select * from zepto limit 10;

--null Values 
select * from zepto where 
name is null or
category is null or
mrp is null or
discountpercent is null or
availablequantity is null or
discountsellingprice is null or
weightingms is null or
outofstock is null or
quantity is null 
;

--Different Product Categories 
select distinct category from zepto order by category;

--Checking Product Stock 
select (case when outofstock is true then 'InStock' else 'OutOfStock' end) , 
count(sku_id) as count 
from zepto
group by outofstock 
order by count(sku_id);

--product names present multiple times 
select name , count(name) as total_count from zepto 
group by name
order by count(name) desc;

--Data Cleaning 

-- Product  of cost zero
select * from zepto where mrp = 0 or discountsellingprice = 0;

--Deleting such product 
delete from zepto where mrp =0;

--Convert mrp (paise) to mrp(rupees)
update zepto
set mrp = mrp/100.0, discountsellingprice = discountsellingprice/100.0 ;


--Insights

--Q1 Find the top 10 best value product based on discount percentage 
select distinct name , 
mrp , discountpercent 
from zepto 
order by discountpercent desc 
limit 10;

--Q2 What are the products with high mrp(>250) but out of stock 
select distinct name , mrp  
from zepto 
where outofstock is true and mrp >250
order by mrp desc; 

--Q3 Calculate Estimated revenue for each category
select category , 
round(sum( discountsellingprice * availablequantity),2) as estimated_revenue 
from zepto 
group by category 
order by round(sum( discountsellingprice * availablequantity),2) desc;

--Q4 Find all the products where mrp is greater than 500 and discount is less than 10%
select distinct name, mrp ,discountpercent 
from zepto 
where mrp > 300 and discountpercent < 10 
order by mrp desc , discountpercent desc;  

--Q5 Identify the top 5 best categorieries offering the highest average discount percentage 
select category ,round(avg(discountpercent),2) as avg_discount% 
from zepto 
group by category 
order by avg(discountpercent) desc 
limit 5;

--Q6 Find the price per gram for products above 100g and sort by best value 
select distinct name ,round((discountsellingprice/weightingms),2) as price_per_gms  
from zepto
where weightingms >= 100 
order by round((discountsellingprice/weightingms),2); 

--Q7 Group the products into categories like low , medium , bulk 
select distinct name , weightingms, 
case when weightingms < 1000 then 'Low' 
	 when weightingms< 3000 then 'Meduim' 
	 else 'Bulk' 
end as weight_category
from zepto ;

--Q8 What is the total inventory weight per category 
select category ,
sum(weightingms * availablequantity) as inventory_weight 
from zepto 
group by category 
order by sum(weightingms * availablequantity) desc;
