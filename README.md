#  Adventure Works Analysis Project (Sales , Profit , Production cost)

##  Overview

Adventure Works Cycles is a global bicycle manufacturer headquartered in Bothell, Washington. The company designs, builds, and sells high-quality metal and composite bicycles across North America, Europe, and Asia.

This project analyzes and visualizes key business metrics such as **sales**, **profit**, and **production cost** from 2010 to 2014 using real-world business data.

---

##  Tools & Technologies Used

- **Excel** (Power Query, Power Pivot, Pivot Tables)
- **Power BI**
- **Tableau**
- **SQL**

---

##  Data Sources

The dataset includes the following 8 files:

1. `DimCustomer`
2. `DimDate`
3. `DimProductCategory`
4. `DimProductSubCategory`
5. `DimSalesTerritory`
6. `FactInternetSales`
7. `FactInternetSalesNew`
8. `DimProduct`

---

##  Data Cleaning Process

- Imported all 8 files into **Power Query**.
- Appended `FactInternetSales` and `FactInternetSalesNew` into a unified table called `Sales`.
- Converted `OrderDateKey` to standard date format.
- Created a **Calendar Table** using `Date & Time` functions.

---

## data modeling:

![datamodeling](https://github.com/Tyaswanth9/Adventureworks-Data-Analyst-Project/blob/myself/data.png)

---

##  Project Objectives


 - Total Orders :60.40K       
 - Total Sales Revenue : $29.36M       
 - Total Production Cost : $17.28M       
 - Total Tax Amount : $2.35M        
 - Profit Margin : 41.51%        

---

##  Excel Dashboard Highlights

- All files loaded via Power Query and linked in Power Pivot.
- KPIs calculated using Pivot Tables and formulas.
- Built slicers and filters for interactivity.
- Page navigation implemented to switch between **Sales**, **Profit**, and **Production Cost** dashboards.

 ## Dashboard images:
 ## sales Dashboard image:
 
 ![Sales Image](https://github.com/Tyaswanth9/Adventureworks-Data-Analyst-Project/blob/myself/dashboardes.png) 
 
 ## profit Dashboard image:
 
 ![Profit Image](https://github.com/Tyaswanth9/Adventureworks-Data-Analyst-Project/blob/myself/dashboardep.png)  
 
 ## Production cost Dashboard image:
 
 ![Production Cost Image](https://github.com/Tyaswanth9/Adventureworks-Data-Analyst-Project/blob/myself/dashboardepro.png)

---

##  Power BI Dashboard Highlights

- Combined fact tables using `Append` in Power Query.
- Created Calendar table with `CALENDARAUTO()` and `DATE` functions in DAX.
- Developed KPIs and parametric dashboards using buttons and slicers.
- Interactive visuals built with cross-filtering, tooltips, and bookmarks.

## Dashboard images:
 ## sales Dashboard image:
   
 ![Sales Image](https://github.com/Tyaswanth9/Adventureworks-Data-Analyst-Project/blob/myself/dashboardps.png)

 ## profit Dashboard image:
 
 ![Profit Image](https://github.com/Tyaswanth9/Adventureworks-Data-Analyst-Project/blob/myself/dashboardpp.png) 

  ## Production cost Dashboard image:
  
 ![Production Cost Image](https://github.com/Tyaswanth9/Adventureworks-Data-Analyst-Project/blob/myself/dashboardpro.png)

---

##  Tableau Dashboard Highlights

- Merged sales tables using **Union**.
- Calendar table created using calculated fields.
- KPIs built using LOD (Level of Detail) expressions.
- Interactive dashboards with filters, parameters, and dashboard actions.

 ## Dashboards images: 
  ## sales Dashboard image:
   
 ![Sales Image](https://github.com/Tyaswanth9/Adventureworks-Data-Analyst-Project/blob/myself/dashboardts.png) 
 
 ## profit Dashboard image:
 
 ![Profit Image](https://github.com/Tyaswanth9/Adventureworks-Data-Analyst-Project/blob/myself/dashboardTp.png) 
 
  ## Production cost Dashboard image:
  
 ![Production Cost Image](https://github.com/Tyaswanth9/Adventureworks-Data-Analyst-Project/blob/myself/dashboardTpro.png)


---

##  SQL Operations

Key SQL activities performed:

- Merged `FactInternetSales` and `FactInternetSalesNew` using `UNION`.
- Created calendar fields using `YEAR()`, `MONTHNAME()`, `DAYNAME()`, `QUARTER()`, etc.
- Used `LEFT JOIN` to integrate fact and dimension tables.
- Calculated KPIs using:
- UNION,SELECT,LEFT JOIN,CONCAT(),SUM(),ROUND(),GROUP BY,ORDER BY,YEAR(),MONTH(),DAY(),MONTHNAME(),DAYNAME(),QUARTER(),DAYOFWEEK(),DATE(),CASE statement ect.

**Union of Fact Internet sales and Fact internet sales new** 

- select * from fact_internet_sales_new
union
select * from factinternetsales;

![image](https://github.com/Tyaswanth9/Adventureworks-Data-Analyst-Project/blob/myself/s1.png)

**calcuate the following fields from the Orderdatekey field ( First Create a Date Field from Orderdatekey)**

- select distinct date(orderdatekey) as date,
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
fisical month
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

![image](https://github.com/Tyaswanth9/Adventureworks-Data-Analyst-Project/blob/myself/s2.png)
 
**total sales**
 - select round(sum((unitprice * orderquantity)-discountamount),2) as "total sales amount",
 concat(round(sum((unitprice * orderquantity)-discountamount)/1000000,2),"M") as "total sales amount in millions" from sales;

![image](https://github.com/Tyaswanth9/Adventureworks-Data-Analyst-Project/blob/myself/tssql.png)
 
 **production cost**
 - select year(orderdatekey)as year,round(sum(totalproductcost),2) as "total production cost" ,
concat(round(sum(totalproductcost)/1000000,2)," M") as "total production cost in millions"
from sales
group by year;

![image](https://github.com/Tyaswanth9/Adventureworks-Data-Analyst-Project/blob/myself/s4.png)

**Calculate the profit**
- select round(sum(salesamount+taxamt-totalproductcost),2)as "Total profit",
concat(round(sum(salesamount+taxamt-totalproductcost)/100000,2)," M")as "Total profit in millions"
 from sales;

![image](https://github.com/Tyaswanth9/Adventureworks-Data-Analyst-Project/blob/myself/s5.png)

 **profit year wise**
 - select year(orderdatekey) as year ,round(sum((unitprice * orderquantity)-discountamount),2) as "total sales amount" ,
round(sum(salesamount+taxamt-totalproductcost),2) as "total profit",
concat(round(sum((unitprice * orderquantity)-discountamount)/1000000,2), " M") as "total sales amount format",
concat(round(sum(salesamount+taxamt-totalproductcost)/1000000,2), " M") as "total sales amount format"
 from sales
group by year(orderdatekey)
order by year asc;

![image](https://github.com/Tyaswanth9/Adventureworks-Data-Analyst-Project/blob/myself/s6.png)

---
##  Key Insights

-  **2013** was the top-performing year for **sales**, **orders**, and **profit**.
-  **June** consistently recorded the highest sales across all years due to holiday seasons.
-  **Australia** had the highest regional sales, while **France** and **Canada** had the lowest.
-  A minimal gap between **sales revenue** and **production cost** each year indicates tight margin control.

---

##  Reflections
During this project , I imporoved my skills in:

## Power BI
- Mastered working with parameters and measures in Power BI.
- Gained hands-on experience in building interactive and dynamic dashboards in Power BI.
- Strengthened data transformation skills including DAX and calendar logic.
- Improved practical knowledge of Power Query.

## Excel
- Mastered working with parameters and measures in Excel.
- Experienced with pivot tables, pivot charts, slicers, and page navigators.

## Tableau
- Mastered working with parameters and measures in Tableau.
- Gained hands-on experience in building interactive and dynamic dashboards in Tableau.
- Strengthened data transformation skills including LOD expressions.
- Improved practical knowledge of Tableau filters.

## SQL
- Strengthened data transformation skills including joins, unions, and SQL aggregations.

---
**Note: This code is provieded for reference only- do not use , copy , modify , or distributions, or reproductions.**
