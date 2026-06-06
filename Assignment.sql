-- Select all data from assignment.Customers table   pk customer_id
SELECT * FROM assignment.Customers;

-- Select all data from assignment.Products table  pk product_id
SELECT * FROM assignment.Products;

-- Select all data from assignment.Sales table pk sale_id
SELECT * FROM assignment.Sales; --- common column customer_id, product_id

-- Select all data from assignment.Inventory table pk product_id
SELECT * FROM assignment.Inventory;  ---common product_id

---1. Write a query to select all data from the `Customers` table.
SELECT * FROM assignment.customers c  ;

-- 2. Write a query to select the total number of products from the `Products` table.
select count(*) from assignment.products p ;

-- 3. Write a query to select the product name and its price from the `Products` table where the price is greater than 500.
select product_name,
	price
from assignment.products p
where price > 500;

select avg(price) as avg_price from assignment.products p ;

-- 5. Write a query to find the total sales amount from the `Sales` table.
select sum(total_amount) as total_sales from assignment.sales s ;

-- 6. Write a query to select distinct membership statuses from the `Customers` table.
select distinct c.membership_status from assignment.customers c ;

-- 7. Write a query to concatenate first and last names of all customers and show the result as `full_name`.
select 
	first_name,
	last_name,
	concat(first_name, ' ', last_name) as full_name
from assignment.customers c ;

select first_name ||' '|| last_name as full_name from assignment.customers c;

-- 8. Write a query to find all products in the `Products` table where the category is 'Electronics'.
select * from assignment.products p where p.category ='Electronics';

-- 9. Write a query to find the highest price from the `Products` table.
select
	max(price) as highest_price
from assignment.products p;

-- 10. Write a query to count the number of sales for each product from the `Sales` table.
select * from assignment.sales s ;
select 
	product_id,
	count(*) as number_of_sale
from assignment.sales s
group by product_id
order by product_id;

-- 11. Write a query to find the total quantity sold for each product from the `Sales` table.
select 
	product_id,
	sum(quantity_sold) as total_quantity
from assignment.sales s
group by product_id
order by product_id;
	
-- 12. Write a query to find the lowest price of products in the `Products` table. 
select
	min(price)
from assignment.products s ;

-- 13. Write a query to find customers who have purchased products with a price greater than 1000.
select c.customer_id, c.first_name, c.last_name, p.price, p.product_name
from assignment.customers c 
join assignment.sales s on c.customer_id = s.customer_id
join assignment.products p on s.product_id = p.product_id
where p.price > 1000;

-- 14. Write a query to join the `Sales` and `Products` tables on product_id, and select the product name and total sales amount.
select p.product_name, 
	sum(s.total_amount)
from assignment.products p
join assignment.sales s on p.product_id = s.product_id
group by p.product_name ;

-- 15. Write a query to join the `Customers` and `Sales` tables and find the total amount spent by each customer.
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(s.quantity_sold * s.total_amount) AS customer_total_amount
FROM assignment.customers c
JOIN assignment.sales s 
    ON c.customer_id = s.customer_id
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY 
    customer_total_amount DESC;

-- 16. Write a query to join the `Customers`, `Sales`, and `Products` tables, and show each customer's first and last name, product name, and quantity sold.
select  
	c.first_name, 
	c.last_name, 
	p.price, 
	s.quantity_sold
from assignment.customers c 
join assignment.sales s 
	on c.customer_id = s.customer_id
join assignment.products p 
	on s.product_id = p.product_id;

-- 17. Write a query to perform a self-join on the `Customers` table and find all pairs of customers who have the same membership status.
select * from assignment.customers c;
select 
	c.customer_id as customer, 
	m.membership_status as membership 
from assignment.customers c 
join assignment.customers  m 
	on c.manager_id = m.employee_id;

SELECT 
    c1.customer_id AS customer_1,
    c2.customer_id AS customer_2,
    c1.membership_status
FROM assignment.customers c1
JOIN assignment.customers c2
    ON c1.membership_status = c2.membership_status
    AND c1.customer_id < c2.customer_id;


-- 18. Write a query to join the `Sales` and `Products` tables, and calculate the total number of sales for each product.
select 
	p.product_name,
	sum(quantity_sold)
from assignment.products p
join assignment.sales s
	on p.product_id = s.product_id 
group by 
	product_name;
	
-- 19. Write a query to find the products in the `Products` table where the stock quantity is less than 10.
SELECT * FROM assignment.products where stock_quantity < 10;

-- 20. Write a query to join the `Sales` table and the `Products` table, and find products with sales greater than 5.
select p.product_id, p.product_name,
	count(s.sale_id) as sales
from assignment.products p 
join assignment.sales s 	
	on p.product_id = s.product_id 
group by
	p.product_id,
	p.product_name 
having 
	count(s.sale_id) > 5;

SELECT 
    p.product_id, 
    p.product_name,
    COUNT(s.sale_id) AS sales
FROM assignment.products p
JOIN assignment.sales s
    ON p.product_id = s.product_id
GROUP BY
    p.product_id,
    p.product_name
HAVING COUNT(s.sale_id) > 5
ORDER BY sales DESC;

-- 30. Write a query to find the average quantity sold per product.
select * from assignment.products;
select * from assignment.sales;
select 
	s.product_id,
	avg(s.quantity_sold) over (partition by s.product_id) as avg_per_product
FROM
    assignment.sales s;

-- 31. Write a query to find the number of sales made in the month of December 2023.
select count(*) from assignment.sales
WHERE sale_date between  '2023-12-01' and '2023-12-31'; 

-- 32. Write a query to find the total amount spent by each customer in 2023 and list the customers in descending order.
select 
	c.customer_id,
	s.total_amount
from assignment.customers c 
join assignment.sales s 
	on c.customer_id = s.customer_id 
where
	extract(YEAR from s.sale_date) = 2023
group by
	c.customer_id, s.total_amount 
order by
	total_amount desc;


-- 33. Write a query to find all products that have been sold but have less than 5 units left in stock.
select
	p.product_id,
	p.product_name,
	s.quantity_sold	
from 
	assignment.products p
join assignment.sales s 
	on p.product_id =s.product_id
where
	stock_quantity < 5;

-- 34. Write a query to find the total sales for each product and order the result by the highest sales.
select 
	p.product_id,
	p.product_name,
	sum(s.quantity_sold) as total_sales
from assignment.products p
join assignment.sales s
	on p.product_id =s.product_id 
group by
	p.product_id , p.product_name 
order by 
 	sum(s.quantity_sold) desc;

	
-- 35. Write a query to find all customers who bought products within 7 days of their registration date.
select  c.customer_id, c.first_name || c.last_name as names, c.registration_date,  s.sale_date
from assignment.customers c 
join assignment.sales s
	on c.customer_id = s.customer_id 
--order by c.registration_date desc
where s.sale_date 
between c.registration_date and c.registration_date + interval '7 days'; 
				  
-- 36. Write a query to join the `Sales` table with the `Products` table and filter the results by products priced between 100 and 500.
select p.product_id, p.product_name, p.price,  s.total_amount, s.quantity_sold
from assignment.products p
join assignment.sales s 
	on p.product_id=s.product_id
where p.price between 100 and 500
group by p.product_id, s.total_amount, s.quantity_sold;

-- 37. Write a query to find the most frequent customer who made purchases from the `Sales` table.
select c.customer_id, c.first_name || c.last_name as names, count(*) as no_of_sales, s.sale_id
from assignment.customers c
join assignment.sales s on c.customer_id=s.customer_id 
group by c.customer_id,  s.sale_id
having count(*) >1 ;

-- 38. Write a query to find the total quantity of products sold per customer.
select c.customer_id, c.first_name || c.last_name as names, sum(s.quantity_sold) as quantity_of_products, s.sale_id
from customers c
join sales s on c.customer_id=s.customer_id
group by c.customer_id , s.quantity_sold, s.sale_id
order by s.quantity_sold desc;


-- 39. Write a query to find the products with the highest stock and lowest stock, and display them together in a single result set.
select 
	max(stock_quantity),
	min(stock_quantity)
from assignment.products p ;
---group by product_id;

-- 40. Write a query to find products whose names contain the word 'Phone' and their total sales.
select p.product_id, p.product_name, s.quantity_sold, s.total_amount
from products p 
join sales s 
	on p.product_id =s.product_id 
	where p.product_name like '%phone%';

-- 41. Write a query to perform an `INNER JOIN` between `Customers` and `Sales`, then display the total sales amount and the product names for customers in the 'Gold' membership status.
select 
	c.customer_id,
	c.first_name || ' ' || c.last_name as names,
	s.total_amount,
	s.product_id,
	p.product_name,
	c.membership_status 
from assignment.customers c 
inner join assignment.sales s
	on c.customer_id = s.customer_id 
join assignment.products p
	on s.product_id = p.product_id 
where c.membership_status ='Gold';

-- 42. Write a query to find the total sales of products by category.
select 
	p.category,
	sum(s.total_amount) as total_amount_sold,
	sum(s.quantity_sold) as total_quantity_sold	
from sales s
join products p 
	on s.product_id = p.product_id 
group by p.category
order by p.category desc;
	
-- 43. Write a query to join the `Products` table with the `Sales` table, and calculate the total sales for each product, grouped by month and year.
select 
	p.product_id,
	p.product_name,
	sum(s.total_amount) as total_amount_sold,
	sum(s.quantity_sold) as total_quantity_sold,
	to_char(s.sale_date, 'yyyy') as year,
	extract(month from s.sale_date) as month
from sales s
join products p 
	on s.product_id = p.product_id 
group by p.product_id, year, month
order by total_amount_sold desc;

-- 44. Write a query to join the `Sales` and `Inventory` tables and find products that have been sold but still have stock remaining.
select s.product_id, s.quantity_sold, i.stock_quantity  
from sales s
join inventory i 
	on s.product_id = i.product_id 
where i.stock_quantity is not null;

-- 45. Write a query to find the top 5 customers who have made the highest purchases.
select 
	c.customer_id,
	concat(c.first_name, ' ',c.last_name) as names,
	sum(s.total_amount) as total_amount
from customers c 
join sales s 
	on c.customer_id = s.customer_id 
group by c.customer_id 
order by total_amount desc
limit 5;

-- 46. Write a query to calculate the total number of unique products sold in 2023.
select 
	count (distinct p.product_name) as total_unique_products
from assignment.products p 
join assignment.sales s 
	on p.product_id =s.product_id 
where extract(year from s.sale_date) =2023;

-- 47. Write a query to find the products that have not been sold in the last 6 months.
select *
from assignment.products p
join assignment.sales s
	on p.product_id = s.product_id
where 
	s.sale_date >= current_date - interval '6 month';
	

-- 48. Write a query to select the products with a price range between $200 and $800, and find the total quantity sold for each.
select
	p.product_id,
	p.product_name,
	sum(s.quantity_sold) as total_quantity,
	p.price
from assignment.products p 
join assignment.sales s 
	on p.product_id=s.product_id 
where p.price between 200 and 800
group by p.product_id;

-- 49. Write a query to find the customers who spent the most money in the year 2023.
select 
	c.customer_id,
	concat(c.first_name, ' ', c.last_name) as name,
	sum(s.total_amount) as total_spent,
	rank() over (order by sum(s.total_amount) desc)
from assignment.customers c 
join assignment.sales s
	on c.customer_id = s.customer_id 
where
	extract(year from s.sale_date) = 2023
group by 
	c.customer_id
order by 
	total_spent desc;

-- 50. Write a query to select the products that have been sold more than 100 times and have a price greater than 200.
select 
	p.product_id,
	p.product_name,
	p.price,
	count(s.sale_id) as number_of_sales
from assignment.products p
join assignment.sales s
	on p.product_id = s.product_id 
where
	p.price < 200
group by
	p.product_id, p.product_name, p.price
having count(s.sale_id) > 100;

-- SUBQUERY QUESTIONS
-- =====================================================

-- 51. Which customers have spent more than the average spending of all customers?
select 
customer_id,
sum(total_amount)
from assignment.sales s
group by customer_id 
having sum(total_amount) >(
	select avg(total_spent)
	from (
		select customer_id, SUM(total_amount) AS total_spent
        from assignment.sales s
        group by customer_id
    ) t
); 
	
 select customer_id, total_amount 
 from assignment.sales s
 where 
 	s.customer_id in 
 (select customer_id from assignment.sales s group by customer_id, total_amount having total_amount > avg(total_amount)  );

   
-- 52. Which products are priced higher than the average price of all products?
select p.product_id, p.product_name, p.price  from assignment.products p where price > (select avg(p.price) from assignment.products p);


-- 53. Which customers have never made a purchase?
select c.customer_id, c.first_name || ' ' || c.last_name as full_name from assignment.customers c 
where (select s.customer_id from assignment.sales s where product_id) ;

-- 54. Which products have never been sold?
SELECT c.customer_id, c.first_name || ' ' || c.last_name as full_name
FROM assignment.customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM assignment.sales s
    WHERE c.customer_id = s.customer_id
);

-- 55. Which customer made the single most expensive purchase?
select c.customer_id from assignment.customers c
join assignment.sales s 
	on c.customer_id = s.customer_id 
join assignment.products p
	on s.product_id = p.product_id 
where 
	(select max(p.price) from assignment.products p );



-- COMMON TABLE EXPRESSIONS (CTEs)
-- =====================================================

-- 61. Create an intermediate result that calculates the total amount spent by each customer,
--     then determine which customers are the top 5 highest spenders.
with total_customer_spending  as (
select 
s.customer_id,
sum(s.total_amount) as customer_spending
from assignment.sales s
group by customer_id
)
select *,
rank() over (order by customer_spending desc ) as rank
from total_customer_spending 
order by customer_spending desc 
limit 5;

  
-- 62. Create an intermediate result that calculates total quantity sold per product,
--     then determine which products are the top 3 most sold.
with total_quantity_sold as ( 
select 
	product_id,
	sum(quantity_sold) as sold_quantity
from assignment.sales s
group by product_id
)
select *,
	rank() over (order by sold_quantity desc) as rank
	from total_quantity_sold
order by sold_quantity desc
limit 3;

-- 63. Create an intermediate result showing total sales per product category,
--     then determine which category generates the highest revenue.
with sales_per_category as (
select 
	p.category,
	sum(s.total_amount) as total_category_amount
from assignment.products p
join assignment.sales s
	on p.product_id = s.product_id 
group by p.category 
)
select 
	max(total_category_amount) as maximum_revenuebycategory
from sales_per_category;


-- 64. Create an intermediate result that calculates the number of purchases per customer,
--     then identify customers who purchased more than twice.
with purchase_number  as (
select
	c.customer_id,
	count(s.sale_id) as no_of_sales
from assignment.customers c
join assignment.sales s
	on c.customer_id = s.customer_id
group by 
	c.customer_id 
)
select * from purchase_number ps
group by ps.customer_id , ps.no_of_sales
having count(ps.no_of_sales ) > 2;


-- 65. Create an intermediate result that calculates the total quantity sold per product,
--     then determine which products sold more than the average quantity sold.
select * from assignment.customers c ;

with total_quantity_per_product as (
select 
	p.product_id,
	p.product_name,
	sum(s.quantity_sold) as total_quantity
from assignment.products p 
join assignment.sales s 
	on p.product_id = s.product_id 
group by p.product_id , p.product_name 
)
select 
	tqp.product_id , tqp.product_name, tqp.total_quantity
	--avg(tqp.total_quantity)
from total_quantity_per_product tqp
where tqp.total_quantity > (select avg(tqp.total_quantity) from total_quantity_per_product tqp)
order by total_quantity desc;


-- 66. Create an intermediate result that calculates total spending per customer,
--     then determine which customers spent more than the average spending.
with total_customer_spending as(
select
	c.customer_id,
	c.first_name ||' ' || c.last_name as names,
	sum(s.total_amount) as customer_spending
from assignment.customers c 
join assignment.sales s 
	on c.customer_id = s.customer_id
group by c.customer_id 
)
select * from total_customer_spending tcs
where tcs.customer_spending > (select avg(tcs.customer_spending) from total_customer_spending tcs);

-- 67. Create an intermediate result that calculates total revenue per product,
--     then list the products ordered from highest revenue to lowest.

with total_revenue_per_product as (
select 
	s.product_id,
	sum(s.total_amount) as total_revenue
from assignment.sales s
group by s.product_id
)
select * from total_revenue_per_product trp
order by total_revenue desc;
	


 
 

