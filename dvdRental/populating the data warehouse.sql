INSERT INTO
	"DWH".DIM_ADDRESS
SELECT
	ADDRE.ADDRESS_ID AS ADDRESS_ID,
	CITY.CITY AS CITY_NAME,
	COUNTRY.COUNTRY AS COUNTRY_NAME,
	ADDRE.DISTRICT AS DISTRICT,
	ADDRE.ADDRESS AS ADDRESS
FROM
	PUBLIC.ADDRESS ADDRE
	JOIN PUBLIC.CITY CITY ON (ADDRE.CITY_ID = CITY.CITY_ID)
	JOIN PUBLIC.COUNTRY COUNTRY ON (CITY.COUNTRY_ID = COUNTRY.COUNTRY_ID);
/*inserting data to store dim */
INSERT INTO
	"DWH".dim_stores
select 
	s.store_id,
	s.manager_staff_id,
	s.address_id
from public.store s
/*the customer table*/
INSERT INTO
	"DWH".dim_customers
select 
	c.customer_id as customer_id,
	c.first_name as first_name,
	c.last_name as last_name,
	c.email as email,
	c.activebool as active,
	c.create_date as create_date,
	c.address_id as address_id,
	c.store_id as store_id
from public.customer c

INSERT INTO
	"DWH".dim_inventory
select 
	i.inventory_id as inventory_id,
	f.title as title,
	f.release_year as release_year,
	l.name as language,
	f.length as length,
	f.rating as rating,
	i.store_id as store_id,
	c.name as category_name
from public.inventory i join public.film f on(i.film_id=f.film_id)
join public.language l on(f.language_id=l.language_id)
join public.film_category fc on(i.film_id=fc.film_id)
join public.category c on(fc.category_id=c.category_id)
-------------------------------------------------------------------

INSERT INTO
	"DWH".fact_rentals
select 
	r.rental_id as rental_id,
	r.rental_date as rental_date,
	p.payment_date as payment_date,
	p.amount as payment_amount,
	r.inventory_id as inventory_id,
	p.customer_id as customer_id,
	c.store_id as store_id,
	c.address_id as rental_address
from public.payment p join public.rental r on(p.rental_id=r.rental_id)
join public.customer c on(r.customer_id=c.customer_id)

