-- ============================================
-- SALES DATA WAREHOUSE
-- Database: sales_dw
-- ============================================

-- ============================================
-- DIMENSION TABLES
-- ============================================

CREATE TABLE dim_category (
    category_id INT PRIMARY KEY,
    "Category" VARCHAR(100)
);

CREATE TABLE dim_customer (
    customer_id INT PRIMARY KEY,
    "CustomerName" VARCHAR(255)
);

CREATE TABLE dim_product (
    product_id INT PRIMARY KEY,
    "Category" VARCHAR(100),
    "Sub-Category" VARCHAR(100)
);

CREATE TABLE dim_location (
    location_id INT PRIMARY KEY,
    "State" VARCHAR(100),
    "City" VARCHAR(100)
);

CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    "Order Date" DATE,
    day INT,
    month INT,
    month_name VARCHAR(20),
    quarter VARCHAR(5),
    year INT
);

-- ============================================
-- FACT TABLES
-- ============================================

CREATE TABLE fact_sales (
    order_id VARCHAR(50),
    date_id INT,
    customer_id INT,
    product_id INT,
    category_id INT,
    location_id INT,
    quantity INT,
    sales_amount NUMERIC,
    profit NUMERIC,

    FOREIGN KEY (date_id)
        REFERENCES dim_date(date_id),

    FOREIGN KEY (customer_id)
        REFERENCES dim_customer(customer_id),

    FOREIGN KEY (product_id)
        REFERENCES dim_product(product_id),

    FOREIGN KEY (category_id)
        REFERENCES dim_category(category_id),

    FOREIGN KEY (location_id)
        REFERENCES dim_location(location_id)
);

CREATE TABLE fact_sales_target (
    date_id INT,
    category_id INT,
    target_amount NUMERIC,

    FOREIGN KEY (category_id)
        REFERENCES dim_category(category_id),

    FOREIGN KEY (date_id)
        REFERENCES dim_date(date_id)
);