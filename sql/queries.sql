-- 1. List all users with total number of orders
SELECT 
    u.user_id,
    u.name,
    u.email,
    COUNT(o.order_id) AS total_orders
FROM Users u
LEFT JOIN Orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.name, u.email
ORDER BY total_orders DESC;


-- 2. Total revenue generated
SELECT 
    SUM(oi.quantity * oi.price) AS total_revenue
FROM Order_Items oi;


-- 3. Top 10 best-selling products
SELECT 
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_sold
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sold DESC
LIMIT 10;


-- 4. Revenue generated per product
SELECT 
    p.product_name,
    SUM(oi.quantity * oi.price) AS product_revenue
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY product_revenue DESC;


-- 5. Orders with user and order status
SELECT 
    o.order_id,
    u.name AS user_name,
    o.order_date,
    o.status
FROM Orders o
JOIN Users u ON o.user_id = u.user_id
ORDER BY o.order_date DESC;


-- 6. Monthly sales report
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(oi.quantity * oi.price) AS monthly_sales
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;


-- 7. Average rating per product
SELECT 
    p.product_name,
    ROUND(AVG(r.rating), 2) AS avg_rating
FROM Products p
JOIN Reviews r ON p.product_id = r.product_id
GROUP BY p.product_name
ORDER BY avg_rating DESC;


-- 8. Users who spent the most money
SELECT 
    u.name,
    SUM(oi.quantity * oi.price) AS total_spent
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY u.name
ORDER BY total_spent DESC;
