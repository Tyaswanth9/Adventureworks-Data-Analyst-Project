create database adventure_works;
use adventure_works;

#    Union of Fact Internet sales and Fact internet sales new 

--         appending both tables
select * from fact_internet_sales_new
union
select * from factinternetsales;

-- create tempory table as "sales"
create temporary table  sales as
select * from fact_internet_sales_new
union
select * from factinternetsales;

# view tempory table sales
select * from sales;

#      Lookup the productname from the Product sheet to Sales sheet.
select * from dimproduct as product;
select * from sales;

select sales.productkey,product.EnglishProductName from dimproduct as product
left join sales
on product.ProductKey=sales.productkey;

#		Lookup the Customerfullname from the Customer and Unit Price from Product sheet to Sales sheet.

-- using concate function , joins , group by , order by 

select customer.customerkey  , concat(customer.firstname, " " , lastname , " " , middlename) as customer_full_name,
round(sum(sales.unitprice),2) as "total_unit_price" from dimcustomer as customer
left join sales 
on customer.CustomerKey=sales.customerkey
group by  customer.customerkey  ,customer_full_name
order by customer.customerkey asc;

#		calcuate the following fields from the Orderdatekey field ( First Create a Date Field from Orderdatekey)
#	Year, 
# Monthno 
# Monthfullname
#Quarter(Q1,Q2,Q3,Q4)
#YearMonth ( YYYY-MMM)
# Weekdayno
# Weekdayname
# FinancialMOnth
# Financial Quarter 
select distinct date(orderdatekey) as date,
 year(orderdatekey) as year,
month(orderdatekey) as month_no,
monthname(orderdatekey) as "month name",
quarter(orderdatekey) as Quearter,
concat(year(orderdatekey)," - " ,monthname(orderdatekey)) as "year-month",
dayofweek(orderdatekey) as "weekday no",
dayname(orderdatekey) as "weekday name",
case
when quarter(orderdatekey)=1 then "fisical quarter 4"
when quarter(orderdatekey)=2 then "fisical quarter 1"
when quarter(orderdatekey)=3 then "fisical quarter 2"
when quarter(orderdatekey)=4 then "fisical quarter 3"
end as "fisical Quarter",

# fisical month
case 
when month(orderdatekey)= 1 then "fisical month 4"
when month(orderdatekey)= 2 then "fisical month 5"
when month(orderdatekey)= 3 then "fisical month 6"
when month(orderdatekey)= 4 then "fisical month 7"
when month(orderdatekey)= 5 then "fisical month 8"
when month(orderdatekey)= 6 then "fisical month 9"
when month(orderdatekey)= 7 then "fisical month 10"
when month(orderdatekey)= 8 then "fisical month 11"
when month(orderdatekey)= 9 then "fisical month 12"
when month(orderdatekey)= 10 then "fisical month 1"
when month(orderdatekey)= 11 then "fisical month 2"
when month(orderdatekey)= 12 then "fisical month 3"
end as "fisical month"
 from sales;
 
 #		Calculate the Sales amount uning the columns(unit price,order quantity,unit discount)
 
 select round(sum((unitprice * orderquantity)-discountamount),2) as "total sales amount",
 concat(round(sum((unitprice * orderquantity)-discountamount)/1000000,2),"M") as "total sales amount in millions" from sales;
 


#	Calculate the Productioncost uning the columns(unit cost ,order quantity)

select year(orderdatekey)as year,round(sum(totalproductcost),2) as "total production cost" ,
concat(round(sum(totalproductcost)/1000000,2)," M") as "total production cost in millions"
from sales
group by year;

#		Calculate the profit.
select round(sum(salesamount+taxamt-totalproductcost),2)as "Total profit",
concat(round(sum(salesamount+taxamt-totalproductcost)/100000,2)," M")as "Total profit in millions"
 from sales;
 
 # gross profit
 select year(orderdatekey) as year,round(sum(salesamount-totalproductcost),2)as "Total profit",
concat(round(sum(salesamount-totalproductcost)/1000000,2)," M")as "Total profit in millions"
 from sales
 group by year;

#	month wise profit
select monthname(orderdatekey) as "month name", round(sum(salesamount+taxamt-totalproductcost),2) as profit,
concat(round(sum(salesamount+taxamt-totalproductcost)/100000,2)," M") as "profit format"
 from sales
group by monthname(orderdatekey)
order by "month name" asc;

# year wise profit
select year(orderdatekey) as "year", round(sum(salesamount-totalproductcost),2) as profit,
# change into millions
concat(round(sum(salesamount-totalproductcost)/1000000,2), " M") 
 as "profit in format"
 from sales
group by year(orderdatekey)
order by "year" asc;

# fisical Quarter wise profit
select case
when quarter(orderdatekey)=1 then "fisical quarter 4"
when quarter(orderdatekey)=2 then "fisical quarter 1"
when quarter(orderdatekey)=3 then "fisical quarter 2"
when quarter(orderdatekey)=4 then "fisical quarter 3"
end as fisical_Quarter, 
round(sum(salesamount+taxamt-totalproductcost),2) as profit,
# change into millions
concat(round(sum(salesamount+taxamt-totalproductcost)/1000000,2)," M") as "profit format"
 from sales
group by fisical_Quarter
order by fisical_Quarter asc;

#		year wise sales
select year(orderdatekey) as year ,round(sum((unitprice * orderquantity)-discountamount),2) as "total sales amount",
# change into millions
concat(round(sum((unitprice * orderquantity)-discountamount)/1000000,2), " M") as "total sales amount format into millions" 
 from sales
group by year(orderdatekey)
order by year asc;

 #		fisical Quarter wise sales
select case
when quarter(orderdatekey)=1 then "fisical quarter 4"
when quarter(orderdatekey)=2 then "fisical quarter 1"
when quarter(orderdatekey)=3 then "fisical quarter 2"
when quarter(orderdatekey)=4 then "fisical quarter 3"
end as fisical_Quarter,
round(sum((unitprice * orderquantity)-discountamount),2) as "total sales amount" from sales
group by fisical_quarter
order by fisical_Quarter asc;

# month wise sales
select monthname(orderdatekey) as "month name",
round(sum((unitprice * orderquantity)-discountamount),2) as "total sales amount",
# change into millions
concat(round(sum((unitprice * orderquantity)-discountamount)/1000000,2), " M") as "total sales amount format into millions" 
 from sales
group by monthname(orderdatekey)
order by "month name" asc;

# day wise sales
select day(orderdatekey) as day,
round(sum((unitprice * orderquantity)-discountamount),2) as "total sales amount",
# change into millions
concat(round(sum((unitprice * orderquantity)-discountamount)/1000000,2)," M") as "total sales amount format"
 from sales
group by day(orderdatekey)
order by day asc;


# year wise profit and sales

select year(orderdatekey) as year ,round(sum((unitprice * orderquantity)-discountamount),2) as "total sales amount" ,
round(sum(salesamount+taxamt-totalproductcost),2) as "total profit",
concat(round(sum((unitprice * orderquantity)-discountamount)/1000000,2), " M") as "total sales amount format",
concat(round(sum(salesamount+taxamt-totalproductcost)/1000000,2), " M") as "total sales amount format"
 from sales
group by year(orderdatekey)
order by year asc;

# month wise profit and sales
select monthname(orderdatekey) as "month name",
round(sum((unitprice * orderquantity)-discountamount),2) as "total sales amount" ,
round(sum(salesamount+taxamt-totalproductcost),2) as "total profit",
# change into millions
concat(round(sum((unitprice * orderquantity)-discountamount)/1000000,2), " M") as "total sales amount format" ,
concat(round(sum(salesamount+taxamt-totalproductcost)/1000000,2)," M") as "total profit format"
from sales
group by monthname(orderdatekey)
order by "month name" asc;

# day wise profit and sales
select day(orderdatekey) as day,
round(sum((unitprice * orderquantity)-discountamount),2) as "total sales amount",
round(sum(salesamount+taxamt-totalproductcost),2) as "total profit",
# change into millions
concat(round(sum((unitprice * orderquantity)-discountamount)/1000000,2)," M") as "total sales amount",
concat(round(sum(salesamount+taxamt-totalproductcost)/1000000,2)," M") as "total profit"
 from sales
group by day(orderdatekey)
order by day asc;

#	show Salesamount and Productioncost together