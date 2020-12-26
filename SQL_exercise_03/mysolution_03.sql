-- The Warehouse
-- lINK: https://en.wikibooks.org/wiki/SQL_Exercises/The_warehouse
-- 3.1 Select all warehouses.
select * from warehouses;

-- 3.2 Select all boxes with a value larger than $150.
select * from boxes where Value > 150;

-- 3.3 Select all distinct contents in all the boxes.
select distinct(Contents) from boxes;

-- 3.4 Select the average value of all the boxes.
select avg(Value) from boxes;

-- 3.5 Select the warehouse code and the average value of the boxes in each warehouse.
select avg(Value), Warehouse from boxes group by Warehouse;

-- 3.6 Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.
select avg(Value) avg_value, Warehouse from boxes group by Warehouse having avg_value > 150;

-- 3.7 Select the code of each box, along with the name of the city the box is located in.
select b.Code, w.Location from boxes b, warehouses w where b.Warehouse = w.Code;

-- 3.8 Select the warehouse codes, along with the number of boxes in each warehouse. 
	-- Optionally, take into account that some warehouses are empty (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).
select * from warehouses;
insert into warehouses values (6, 'Vancouver', 10);

select w.Code warehouse_code, count(b.Code) qty_boxes
from warehouses w left outer join boxes b on (w.Code = b.Warehouse) 
group by w.Code;

-- 3.9 Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).
select w.Code, w.Capacity, count(b.Code) qty_boxes
from boxes b, warehouses w 
where b.Warehouse = w.Code 
group by w.Code
having qty_boxes > w.Capacity;

-- 3.10 Select the codes of all the boxes located in Chicago.
select b.Code, w.Location
from boxes b, warehouses w 
where b.Warehouse = w.Code
and w.Location = 'Chicago';

-- 3.11 Create a new warehouse in New York with a capacity for 3 boxes.
select * from warehouses;
insert into warehouses values (7, 'New York', 3);

-- 3.12 Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
select * from boxes;
insert into boxes values ('H5RT', 'Papers', 200, 2);

-- 3.13 Reduce the value of all boxes by 15%.
select * from boxes;
update boxes set Value = Value * 0.85 where boxes.Code <> '';

-- 3.14 Remove all boxes with a value lower than $100.
delete from boxes where Value < 100 and boxes.Code <> '';

-- 3.15 Remove all boxes from saturated warehouses.
insert into boxes values ('H5RA', 'Papers', 200, 2);
insert into boxes values ('H5RB', 'Papers', 200, 2);
insert into boxes values ('H5RC', 'Papers', 200, 2);

delete from boxes 
where boxes.Warehouse = (
	select Code from (
		select w.Code, w.Capacity
		from boxes b, warehouses w 
		where b.Warehouse = w.Code 
		group by w.Code 
		having count(b.Code) > w.Capacity) x);

-- 3.16 Add Index for column "Warehouse" in table "boxes"
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
create index Index_Warehouse on Boxes (warehouse);


-- 3.17 Print all the existing indexes
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
show index from Boxes from mydb;

-- 3.18 Remove (drop) the index you added just
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
drop index INDEX_WAREHOUSE on boxes;