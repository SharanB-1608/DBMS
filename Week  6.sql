-- =========================================================
-- RESTAURANT MANAGEMENT SYSTEM
-- =========================================================

-- 1. CREATE DATABASE
-- =========================================================

DROP DATABASE IF EXISTS RestaurantManagementDB;

CREATE DATABASE RestaurantManagementDB;

USE RestaurantManagementDB;


-- =========================================================
-- 2. CREATE CUSTOMER TABLE
-- =========================================================

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15)
);


-- =========================================================
-- 3. CREATE FOOD_ITEM TABLE
-- =========================================================

CREATE TABLE Food_Item (
    food_id INT PRIMARY KEY,
    food_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL
);


-- =========================================================
-- 4. CREATE FOOD_ORDER TABLE
-- =========================================================

CREATE TABLE Food_Order (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id)
);


-- =========================================================
-- 5. CREATE CUSTOMER_FEEDBACK TABLE
-- =========================================================

CREATE TABLE Customer_Feedback (
    feedback_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    food_id INT NOT NULL,
    rating INT NOT NULL,
    feedback_text VARCHAR(255),
    feedback_date DATE NOT NULL,

    FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id),

    FOREIGN KEY (food_id)
        REFERENCES Food_Item(food_id),

    CHECK (rating BETWEEN 1 AND 5)
);


-- =========================================================
-- 6. INSERT CUSTOMER DATA
-- =========================================================

INSERT INTO Customer
(customer_id, customer_name, email, phone)
VALUES
(1, 'Arun', 'arun@gmail.com', '9876543210'),
(2, 'Priya', 'priya@gmail.com', '9876543211'),
(3, 'Rahul', 'rahul@gmail.com', '9876543212'),
(4, 'Divya', 'divya@gmail.com', '9876543213'),
(5, 'Karthik', 'karthik@gmail.com', '9876543214');


-- =========================================================
-- 7. INSERT FOOD ITEM DATA
-- =========================================================

INSERT INTO Food_Item
(food_id, food_name, category, price)
VALUES
(101, 'Chicken Biryani', 'Main Course', 220.00),
(102, 'Paneer Butter Masala', 'Main Course', 180.00),
(103, 'Masala Dosa', 'Breakfast', 90.00),
(104, 'Veg Fried Rice', 'Main Course', 150.00),
(105, 'Chicken Noodles', 'Main Course', 170.00),
(106, 'Gulab Jamun', 'Dessert', 70.00);


-- =========================================================
-- 8. INSERT FOOD ORDER DATA
-- =========================================================

INSERT INTO Food_Order
(order_id, customer_id, order_date, total_amount)
VALUES
(1001, 1, '2026-09-01', 440.00),
(1002, 2, '2026-09-02', 270.00),
(1003, 3, '2026-09-03', 330.00),
(1004, 4, '2026-09-04', 240.00),
(1005, 5, '2026-09-05', 390.00);


-- =========================================================
-- 9. INSERT CUSTOMER FEEDBACK DATA
-- =========================================================

INSERT INTO Customer_Feedback
(feedback_id, customer_id, food_id, rating, feedback_text, feedback_date)
VALUES
(1, 1, 101, 5, 'Very tasty and delicious biryani', '2026-09-01'),
(2, 2, 102, 4, 'Good taste and quality', '2026-09-02'),
(3, 3, 103, 5, 'Crispy and delicious dosa', '2026-09-03'),
(4, 4, 104, 3, 'Good but could be better', '2026-09-04'),
(5, 5, 105, 4, 'Very good noodles', '2026-09-05'),
(6, 2, 101, 5, 'Excellent biryani', '2026-09-06'),
(7, 3, 102, 4, 'Creamy and tasty', '2026-09-06'),
(8, 4, 103, 5, 'Excellent dosa', '2026-09-07'),
(9, 5, 106, 5, 'Sweet and delicious', '2026-09-07'),
(10, 1, 104, 4, 'Nice fried rice', '2026-09-08');


-- =========================================================
-- 10. DISPLAY ALL CUSTOMERS
-- =========================================================

SELECT *
FROM Customer;


-- =========================================================
-- 11. DISPLAY ALL FOOD ITEMS
-- =========================================================

SELECT *
FROM Food_Item;


-- =========================================================
-- 12. DISPLAY ALL FOOD ORDERS
-- =========================================================

SELECT *
FROM Food_Order;


-- =========================================================
-- 13. DISPLAY ALL CUSTOMER FEEDBACK
-- =========================================================

SELECT *
FROM Customer_Feedback;


-- =========================================================
-- 14. RETRIEVE FOOD REVIEW DETAILS
-- =========================================================

SELECT
    cf.feedback_id,
    c.customer_name,
    f.food_name,
    f.category,
    cf.rating,
    cf.feedback_text,
    cf.feedback_date
FROM Customer_Feedback cf
JOIN Customer c
    ON cf.customer_id = c.customer_id
JOIN Food_Item f
    ON cf.food_id = f.food_id
ORDER BY cf.feedback_date;


-- =========================================================
-- 15. CALCULATE AVERAGE RATING FOR EACH FOOD
-- =========================================================

SELECT
    f.food_id,
    f.food_name,
    AVG(cf.rating) AS average_rating
FROM Customer_Feedback cf
JOIN Food_Item f
    ON cf.food_id = f.food_id
GROUP BY
    f.food_id,
    f.food_name
ORDER BY average_rating DESC;


-- =========================================================
-- 16. COUNT TOTAL REVIEWS FOR EACH FOOD
-- =========================================================

SELECT
    f.food_id,
    f.food_name,
    COUNT(cf.feedback_id) AS total_reviews
FROM Customer_Feedback cf
JOIN Food_Item f
    ON cf.food_id = f.food_id
GROUP BY
    f.food_id,
    f.food_name
ORDER BY total_reviews DESC;


-- =========================================================
-- 17. FIND HIGHEST RATING
-- =========================================================

SELECT
    MAX(rating) AS highest_rating
FROM Customer_Feedback;


-- =========================================================
-- 18. FIND LOWEST RATING
-- =========================================================

SELECT
    MIN(rating) AS lowest_rating
FROM Customer_Feedback;


-- =========================================================
-- 19. FIND OVERALL AVERAGE RATING
-- =========================================================

SELECT
    ROUND(AVG(rating), 2) AS overall_average_rating
FROM Customer_Feedback;


-- =========================================================
-- 20. IDENTIFY HIGHLY RATED FOOD ITEMS
-- =========================================================

SELECT
    f.food_id,
    f.food_name,
    ROUND(AVG(cf.rating), 2) AS average_rating
FROM Customer_Feedback cf
JOIN Food_Item f
    ON cf.food_id = f.food_id
GROUP BY
    f.food_id,
    f.food_name
HAVING AVG(cf.rating) >= 4.5
ORDER BY average_rating DESC;


-- =========================================================
-- 21. FIND TOTAL RESTAURANT SALES
-- =========================================================

SELECT
    SUM(total_amount) AS total_sales
FROM Food_Order;


-- =========================================================
-- 22. FIND AVERAGE ORDER VALUE
-- =========================================================

SELECT
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM Food_Order;


-- =========================================================
-- 23. FIND CUSTOMER ORDER HISTORY
-- =========================================================

SELECT
    c.customer_id,
    c.customer_name,
    fo.order_id,
    fo.order_date,
    fo.total_amount
FROM Customer c
JOIN Food_Order fo
    ON c.customer_id = fo.customer_id
ORDER BY
    c.customer_id,
    fo.order_date;


-- =========================================================
-- 24. FIND CUSTOMERS WHO GAVE 5-STAR RATINGS
-- =========================================================

SELECT
    c.customer_name,
    f.food_name,
    cf.rating,
    cf.feedback_text
FROM Customer_Feedback cf
JOIN Customer c
    ON cf.customer_id = c.customer_id
JOIN Food_Item f
    ON cf.food_id = f.food_id
WHERE cf.rating = 5
ORDER BY cf.rating DESC;


-- =========================================================
-- 25. FIND FOOD ITEMS WITH AVERAGE RATING ABOVE 4
-- =========================================================

SELECT
    f.food_name,
    ROUND(AVG(cf.rating), 2) AS average_rating
FROM Customer_Feedback cf
JOIN Food_Item f
    ON cf.food_id = f.food_id
GROUP BY
    f.food_name
HAVING AVG(cf.rating) > 4
ORDER BY average_rating DESC;


-- =========================================================
-- 26. FIND MOST EXPENSIVE FOOD ITEM
-- =========================================================

SELECT
    food_name,
    category,
    price
FROM Food_Item
WHERE price = (
    SELECT MAX(price)
    FROM Food_Item
);


-- =========================================================
-- 27. FIND CHEAPEST FOOD ITEM
-- =========================================================

SELECT
    food_name,
    category,
    price
FROM Food_Item
WHERE price = (
    SELECT MIN(price)
    FROM Food_Item
);


-- =========================================================
-- 28. COUNT FOOD ITEMS BY CATEGORY
-- =========================================================

SELECT
    category,
    COUNT(food_id) AS total_food_items
FROM Food_Item
GROUP BY category
ORDER BY total_food_items DESC;


-- =========================================================
-- 29. DISPLAY 5-STAR FOOD ITEMS
-- =========================================================

SELECT DISTINCT
    f.food_name
FROM Food_Item f
JOIN Customer_Feedback cf
    ON f.food_id = cf.food_id
WHERE cf.rating = 5;


-- =========================================================
-- 30. COMPLETE RESTAURANT REPORT
-- =========================================================

SELECT
    f.food_name,
    f.category,
    f.price,
    COUNT(cf.feedback_id) AS total_reviews,
    ROUND(AVG(cf.rating), 2) AS average_rating,
    MAX(cf.rating) AS highest_rating,
    MIN(cf.rating) AS lowest_rating
FROM Food_Item f
LEFT JOIN Customer_Feedback cf
    ON f.food_id = cf.food_id
GROUP BY
    f.food_id,
    f.food_name,
    f.category,
    f.price
ORDER BY average_rating DESC;