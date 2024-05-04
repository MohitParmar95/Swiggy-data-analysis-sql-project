create database swiggy;
use swiggy;

select * from card;
select * from cuisine;
select * from customers;
select * from details;
select * from orders;
select * from dish;

-- 1)   Details of customers whose name starts with 'A' and have gmail id
select * from customers where name like "A%" and email like "%gmail.com";

-- 2)	Details of customers containing 3 times 5 in password
select * from customers where password like "%5%5%5%";

-- 3)	Name & address of North Indian restaurant which is situated in 456 Elm St
select r_name , address from cuisine where cuisine = "North Indian" and address = "456 Elm St";

-- 4)	Names of restaurant which is either Italian or situated in '433 Oak St'
select r_name ,cuisine, address  from cuisine where cuisine = "Italian" or address = "433 Oak St";

-- 5)	How many orders were palced with amount 650 or more
select count(order_id) as num_order from orders where amount >= 650 ;


-- 6)	Find details of those customers who have never ordered 

select c.name 
from customers c 
left join orders o on c.user_id = o.user_id
where o.user_id is null; 

-- 7)	Find out details of restaurants having sales greater than x (1000 or any amount)
 
select o.r_id,cu.r_name ,sum(o.amount) as sales
 from cuisine cu 
 inner join orders o 
 on cu.r_id = o.r_id
 group by o.r_id, cu.r_name
 having sum(o.amount)>1000;


-- 8)	Show all order details for a particular customer ('Vartika')

select o.*,c.name 
from orders o 
inner join customers c on c.user_id =o.user_id
where c.name = "Vartika";

-- 9)	What is the average Price per dish 

select d.f_id,d.f_name,round(avg(ca.price)) avg_price
from card ca 
inner join dish d on ca.f_id = d.f_id 
group by d.f_name,d.f_id;

-- 10)	Find out number of times each customer ordered food from each restaurants 

SELECT c.user_id, c.name, cu.r_name, COUNT(o.r_id) orders 
from customers c 
join orders o on c.user_id = o.user_id 
inner join cuisine cu on o.r_id = cu.r_id 
group by c.user_id, c.name,cu.r_name;

-- 11)	Find the top restaurant in terms of the number of orders for a given month 

select o.r_id,cu.r_name,month(o.date) month_ ,count(o.r_id)
from cuisine cu 
inner join orders o on cu.r_id = o.r_id 
group by o.r_id,cu.r_name , month(o.date) 
order by count(o.r_id) desc limit 1;

-- 12)	Who is most loyal customer of dominos?

select c.user_id,c.name as customer_name,count(o.order_id) as order_count
from customers c
join orders o on c.user_id = o.user_id
join cuisine cu on o.r_id = cu.r_id
where cu.r_name = 'Dominos'
group by c.user_id,c.name
order by order_count desc
limit 1;

