# **Making a data warehouse schema using pgAdmin:**
---
## **Business Questions**:
1. *who is the most frequent customer?*
2. who is the most profitable customer?
3. what is the most popular/profitable film category?
4. what is the most profitable film?
5. where are most of our customers from?
6. profit for each month?
7. which one is the most profitable store in the store chain?
8. we could add much more.......
---
## Changing the old schema into a new one!
   ![dvd rental2](https://github.com/user-attachments/assets/69a8c8a6-b5a3-47b5-b280-f1136b2589b0)
> here we have 5 tables _forget about the actors related tables_
## The tables in our data warehouse schema design are:
-  fact_rental: has all of the rentals' details and payment details from the original schema(rental+payments)
-  dim_store: kept as it is since it was straightforward
-  dim_inventory: has all of the DVD and the film details merged (language, category, film, and original inventory) in one table that has the needed details
-  dim_address: merged(city, country, and original address) in one table to make it easier when querying the info.
-  dim_customers: reduced unnecessary columns
> ### Then the tables were made directly in ***pgAdmin***

## populating the tables:
*used insert into to get the data from the old schema and populate the data warehouse schema*
```sql
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
```
check ![populate the warehouse]() file for full code

## made simpler views:
![image](https://github.com/user-attachments/assets/cc2d2f15-12ef-447c-9f02-c66c7b973f82)

## to explore the schema+ the views
1. download the dvd_rental+datawarehouse.backup
2. open pgAdmin and make a new database
3. restore the file in the database
4. open the schemas

## Comparison between old schema and data warehouse schema:
### business Question example:
### ***What is the most popular film category that has the most sales?***

> Answering using the old schema :

> ![getting the cat sales 1](https://github.com/user-attachments/assets/f0c28539-4c1b-449c-8ef1-71f682284710)

> Answering using the data warehouse:

> ![2](https://github.com/user-attachments/assets/44df16f5-1988-4510-b2a5-b648ff408973)
