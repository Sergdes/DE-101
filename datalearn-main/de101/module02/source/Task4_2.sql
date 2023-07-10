-- **************************************  calendar_dim
--deleting rows
truncate table calendar_dim CASCADE;
--
insert into calendar_dim 
select 
to_char(date,'yyyymmdd')::int as date_id,  
       extract('year' from date)::int as year,
       extract('quarter' from date)::int as quarter,
       extract('month' from date)::int as month,
       extract('week' from date)::int as week,
       to_char(date, 'dy') as week_day,
       date::date,
       extract('day' from
               (date + interval '2 month - 1 day')
              ) = 29
       as leap
  from generate_series(date '2000-01-01',
                       date '2030-01-01',
                       interval '1 day')
       as t(date);
      
      
-- check data 
select * from calendar_dim 
limit 10;


-- **************************************  geography_dim
-- clean table
truncate table geography_dim CASCADE; 

-- insert data
insert into geography_dim
select row_number() over(), country, region, state, city, postal_code from
(select distinct country, region, state, city, postal_code from orders 
order by country, region, state, city, postal_code) a;

-- City Burlington, Vermont doesn't have postal code
update geography_dim
set postal_code = 05401
where city = 'Burlington'  and postal_code is null;
	   
-- check data
select * from geography_dim; 

select * from geography_dim
where city = 'Burlington'



-- ************************************** product_dim

-- clean table
truncate table product_dim CASCADE; 

--insert data 
insert into product_dim 
select row_number() over(), category, subcategory, product_name, product_id from
(select distinct category, subcategory, product_name, product_id from orders 
order by 1, 2, 3) a;

-- check data
select * from product_dim; 

-- ************************************** customer_dim

-- clean table
truncate table customer_dim CASCADE; 

-- insert data 
insert into customer_dim 
select row_number() over(), customer_id, customer_name, segment from
(select distinct customer_id, customer_name, segment from orders 
order by 1) a;

-- check data
select * from customer_dim; 

-- ************************************** managers_dim

-- clean table
truncate table managers_dim CASCADE; 

-- insert data 
insert into managers_dim 
select row_number() over(), person from
(select distinct person from people) a;

-- check data
select * from managers_dim; 

-- ************************************** ship_dim
-- clean table
truncate table ship_dim CASCADE; 

-- insert data 
insert into ship_dim 
select row_number() over(), ship_mode from
(select distinct ship_mode from orders) a;

-- check data
select * from ship_dim; 

-- ************************************** sales_fact

-- clean table
truncate table sales_fact CASCADE; 

-- insert data 
insert into sales_fact 
select row_number() over(), 
	   profit,
	   discount,
	   o.order_id,
	   quantity,
	   sales,
	   geo_id,
	   cust_id,
	   manager_id,
	   ship_id,
	   to_char(ship_date,'yyyymmdd')::int,
	   prod_id
from orders o left join (select distinct(order_id), returned
                         from returns) as r on o.order_id = r.order_id
                         join geography_dim gd on o.city = gd.city                         
                                                  		    and o.postal_code = gd.postal_code
                         join customer_dim cd on o.customer_id = cd.customer_id 
              					  and o.customer_name = cd.customer_name
              			 join people pl on o.region = pl.region
              			 join managers_dim md on pl.person = md.manager_name
              			 join ship_dim sd on o.ship_mode = sd.ship_mode
              			 join product_dim pd on o.product_id = pd.product_id
              					  and o.product_name = pd.product_name;

-- check data
select count(*) from sales_fact sf
join ship_dim s on sf.ship_id=s.ship_id
join geography_dim g on sf.geo_id=g.geo_id
join product_dim p on sf.prod_id=p.prod_id
join customer_dim cd on sf.cust_id=cd.cust_id;
