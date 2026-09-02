create database amazon;
alter table amazon.customers_1 change Name name varchar(100);

-- task3
-- retrieve all customers from a specifuc category
select CustomerID,Name,Age,city from amazon.customers
where city="bettyport";

select * from amazon.products
where category  ="fruit";

-- task 4
-- write ddl statement to recreate the customers table with the follopwing constrains
-- 1.
-- 2.
alter table amazon.customers 
modify age int not null check (age>=18);

alter table amazon.customers
modify name varchar(100) unique;

-- task 5
select * from amazon.products;
insert into amazon.products(ProductID,ProductName,Category,SubCategory,PricePerUnit,StockQuantity,SupplierID)
value ('Gh389dhneekeybssgs','Puremilk','Diary','Subdiary',24,21,'S1001'),
('P1001','Milk','Diary','subdiary',25,22,'S1002'),
('P1002','Milkshake','Diary','Subdiary',26,23,'S1003');

-- task 6

select * from amazon.products;

select * from amazon.products;
set sql_safe_update=0;

select*from amazon.products;
update amazon.products set StockQuantity=600
where productID="0006853b-74cb-44a2-91ed-699aa31c5b5b";

-- task 7

select city from amazon.suppliers;
select suppliersid from amazon.suppliers
where city = 'South Ana';
delete from amazon.suppliers
where SupplierID = "03ec3130-f542-432e-b173-f10efd69026"; 

-- task 8

alter table amazon.reviews
modify rating int check (rating between 1 and 5);
-- add a default constraint for the remember column in the customers table (default value: "no")
alter table amazon.customers
modify Primemember varchar(100) default("no");

-- task 9

select * from amazon.orders
where OrderDate > 2024-01-01;

-- having clause to list products with average ratings greater than 4.
select p.productname as productname,r.productID as productID,avg(r.rating)as avg_rating from amazon.products as p
left join amazon.reviews as r
on p.ProductID=r.ProductID
group by p.ProductID,r.ProductID
having avg(r.rating)>4;

-- task 12

create table amazon.sub_category(ProductID varchar(100), SubCategory text);
insert into amazon.sub_category(ProductID, SubCategory)
values ("0006853b-74cb-44a2-91ed-699aa31c5b5b","Sub-Bakery-1"),
("0219aafa-5dbc-4d92-acd9-8a78b4158651", "Sub-Dairy-3"),
("0297061c-1241-4540-ac99-ac6a44fa507e", "Sub-Bakery-4"),
("02c7c358-da33-4586-832-52459b7394fc","Sub-Snacks-1"),
("030ff542-d5f3-4387-9654-90ae0e38702c","Sub-Meat-4");

create table amazon.Categories (ProductID varchar(100), ProductName varchar(100), Category varchar(100));
insert into amazon.Categories( ProductID, ProductName, Category)
values ("0006853b-74cb-44a2-91ed-699aa31c5b5b", "Enter Dair", "Dairy"),
("0297061c-1241-4540-ac99-ac6a44fa507e", "Word Fruit", "Meat"),
("030ff542-d5f3-4387-9654-90ae0e38702c", "Room Snack", "Snacks"),
("0fd54576-f933-4c77-8c7e-d5d482ff2e4e", "Push Snack", "Snacks"),
("11c83d33-0898-4711-84f5-0da2e020c8c5", "Door Vegetable", "Vegetables");

-- task 13

select p.ProductID,s.total_sales from amazon.order_details as p
join(select ProductID,sum(PricePerUnit*StockQuantity) as total_sales
from amazon.products
group by ProductID) as  s
on p.ProductID=s.ProductID
order by s.total_sales desc
limit 3;

-- task 14

select city,count(primemember) from amazon.customers
group by city
order by count(Primemember) desc;

select category,count(productID)as orders from amazon.products
group by Category
order by count(productID) desc;

-- Task 10

-- 1.Calculate each customer's total spending.
select customerID,sum(OrderAmount) as total_spend from amazon.orders
group  by customerID;

-- 2.Rank customers based on their spending.
select customerID,sum(OrderAmount+ DeliveryFee), rank() over (order by sum(OrderAmount+DeliveryFee)  desc) as spending_rank
from amazon.orders
group by CustomerID;

-- 3.Identify customers who have spent more than ₹5000.
select customerID,sum(OrderAmount) as spent_amount from amazon.orders
group by customerID
having sum(OrderAmount)>5000;


-- task 11

-- 1.Join the Orders and OrdersDetails tables to calculate total revenue per order.
select o.orderID,sum(u.unitprice*u.Quantity+u.Discount)as reve_per_order from amazon.orders as o
left join amazon.order_details as u
on u.OrderID=o.OrderID 
group by o.orderID;

-- 2.Identify customrs who placed the most orders in a specific time period.
select CustomerID,count(*) as most_orders  from amazon.orders
where OrderDate between "2025-31-25" and "2025-01-01"
group by CustomerID
order by most_orders desc;

-- 3. Find the Supplier with the most products in stock.
select SupplierID,sum(StockQuantity) as total_stock from amazon.products
group by SupplierID order by sum(StockQuantity) desc;







