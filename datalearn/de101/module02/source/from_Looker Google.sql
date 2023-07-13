SELECT dateid, "year", quarter, "month", week, "date", week_day, leap
FROM dw.calendar_dim;
SELECT cust_id, customer_id, customer_name
FROM dw.customer_dim;
SELECT geo_id, country, city, state, postal_code
FROM dw.geo_dim;
SELECT prod_id, product_id, product_name, category, sub_category, segment
FROM dw.product_dim;
SELECT sales_id, cust_id, order_date_id, ship_date_id, prod_id, ship_id, geo_id, order_id, sales, profit, quantity, discount
FROM dw.sales_fact;
SELECT ship_id, shipping_mode
FROM dw.shipping_dim;
