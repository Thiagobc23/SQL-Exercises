-- LINK: https://en.wikibooks.org/wiki/SQL_Exercises/The_computer_store
-- 1.1 Select the names of all the products in the store.
select distinct name from products;

-- 1.2 Select the names and the prices of all the products in the store.
select Name, Price from products;

-- 1.3 Select the name of the products with a price less than or equal to $200.
select Name, Price from products where Price <= 200;

-- 1.4 Select all the products with a price between $60 and $120.
select * from products where Price between 60 and 120;

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
select Name, (Price * 100) as price_in_cents from products;

-- 1.6 Compute the average price of all the products.
select avg(Price) from products;

-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
select avg(products.Price)
from products, manufacturers 
where products.manufacturer = manufacturers.Code 
and manufacturers.Code = 2;

-- 1.8 Compute the number of products with a price larger than or equal to $180.
select count(Code) from products where Price >= 180;

-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
select Name, Price from products where Price >= 180 order by Price Desc, Name Asc;

-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
select * from products, manufacturers where products.manufacturer = manufacturers.Code;

-- 1.11 Select the product name, price, and manufacturer name of all the products.
select products.Name, products.Price, manufacturers.Name 
from products, manufacturers 
where products.manufacturer = manufacturers.Code;

-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
select avg(products.Price), manufacturers.Code 
from products, manufacturers 
where products.Manufacturer = manufacturers.Code
group by manufacturers.code;

-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
select avg(products.Price), manufacturers.Name 
from products, manufacturers 
where products.Manufacturer = manufacturers.Code
group by manufacturers.Name;

-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
select * from (
select avg(products.Price) avg_price, manufacturers.Name
from products, manufacturers
where products.Manufacturer = manufacturers.Code
group by manufacturers.Name) x
where x.avg_price >= 150;

-- 1.15 Select the name and price of the cheapest product.
select Price, Name from products order by Price limit 1;
select Price, Name from products where Price = (select min(Price) from products);

-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
select manufacturers.Name, max(products.Price) 
from products, manufacturers 
where products.Manufacturer = manufacturers.Code 
group by manufacturers.Name;


-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
insert into products values(11, 'Loudspeakers', 70, 2);
-- 1.18 Update the name of product 8 to "Laser Printer".
update products set Name = 'Laser Printer' where Code = 8;

-- 1.19 Apply a 10% discount to all products.
select Price*0.9, products.* from products;

-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
select 
	case 
		when Price >= 120 then Price * 0.9 
		else Price 
	end
	, products.* 
from products