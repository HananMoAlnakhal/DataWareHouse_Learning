-- Data Warehouse Schema Creation for DVD Rental

-- Drop existing tables if they exist
DROP TABLE IF EXISTS "DWH".fact_rentals;
DROP TABLE IF EXISTS "DWH".dim_date;
DROP TABLE IF EXISTS "DWH".dim_customers;
DROP TABLE IF EXISTS "DWH".dim_films;
DROP TABLE IF EXISTS "DWH".dim_stores;

-- Dimension Table: Date
CREATE TABLE "DWH".dim_date (
    date_id SERIAL PRIMARY KEY,
    full_date DATE NOT NULL,
    year INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL,
    weekday VARCHAR(15) NOT NULL,
    quarter INT NOT NULL
);

-- Dimension Table: Customers
CREATE TABLE "DWH".dim_customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    active BOOLEAN,
    create_date DATE
);

-- Dimension Table: Films
CREATE TABLE "DWH".dim_films (
    film_id INT PRIMARY KEY,
    title VARCHAR(255),
    description TEXT,
    release_year INT,
    language VARCHAR(50),
    rental_rate NUMERIC(5, 2),
    length INT,
    rating VARCHAR(10)
);

-- Dimension Table: Stores
CREATE TABLE "DWH".dim_stores (
    store_id INT PRIMARY KEY,
    manager_staff_id INT,
    address VARCHAR(255),
    city VARCHAR(100),
    country VARCHAR(100)
);

-- Fact Table: Rentals
CREATE TABLE "DWH".fact_rentals (
    rental_id SERIAL PRIMARY KEY,
    rental_date DATE NOT NULL,
    return_date DATE,
    payment_amount NUMERIC(5, 2),
    film_id INT REFERENCES "DWH".dim_films(film_id),
    customer_id INT REFERENCES "DWH".dim_customers(customer_id),
    store_id INT REFERENCES "DWH".dim_stores(store_id),
    date_id INT REFERENCES "DWH".dim_date(date_id)
);
