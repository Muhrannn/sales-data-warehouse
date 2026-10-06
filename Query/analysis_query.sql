-- Total Sales per Category--
SELECT 
    p."Category",
    SUM(f.sales_amount) AS total_sales
FROM fact_sales f
JOIN dim_product p
    ON f.product_id = p.product_id
GROUP BY p."Category"
ORDER BY total_sales DESC;

-- Total Sales dan Profit per Category --

SELECT 
    p."Category",
    SUM(f.sales_amount) AS total_sales,
    SUM(f.profit) AS total_profit
FROM fact_sales f
JOIN dim_product p
    ON f.product_id = p.product_id
GROUP BY p."Category"
ORDER BY total_sales DESC;

-- Monthly Sales vs Target --

SELECT
    d.year,
    d.month,
    p."Category",
    SUM(f.sales_amount) AS actual_sales,
    MAX(t.target_amount) AS target_sales,
    ROUND(
        (
            SUM(f.sales_amount)
            / MAX(t.target_amount)
            * 100
        )::numeric,
        2
    ) AS achievement_pct
FROM fact_sales f
JOIN dim_date d
    ON f.date_id = d.date_id
JOIN dim_product p
    ON f.product_id = p.product_id
JOIN dim_category c
    ON p."Category" = c."Category"
JOIN fact_sales_target t
    ON t.date_id = d.date_id
    AND t.category_id = c.category_id
GROUP BY
    d.year,
    d.month,
    p."Category"
ORDER BY
    d.year,
    d.month,
    p."Category";


-- Total Quantity per Category -- 

SELECT
    p."Category",
    SUM(f.quantity) AS total_quantity
FROM fact_sales f
JOIN dim_product p
    ON f.product_id = p.product_id
GROUP BY p."Category"
ORDER BY total_quantity DESC;

-- Sales per Month --

SELECT
    d.year,
    d.month,
    d.month_name,
    SUM(f.sales_amount) AS total_sales
FROM fact_sales f
JOIN dim_date d
    ON f.date_id = d.date_id
GROUP BY
    d.year,
    d.month,
    d.month_name
ORDER BY
    d.year,
    d.month;
