CREATE DATABASE ProductCategoryDB;

USE ProductCategoryDB;

CREATE TABLE Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    stock INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_product_category
        FOREIGN KEY (category_id)
        REFERENCES Category(category_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

INSERT INTO Category (category_name, description)
VALUES
    ('Electronics', 'Electronic gadgets and devices'),
    ('Groceries', 'Daily household grocery items'),
    ('Stationery', 'Office and school supplies');
    
    SELECT * FROM Category;
    
    INSERT INTO Product (product_name, category_id, price, stock)
VALUES
    ('Wireless Mouse', 1, 599.00, 120),
    ('Bluetooth Speaker', 1, 1499.00, 45),
    ('Basmati Rice 5kg', 2, 650.00, 200),
    ('Notebook Pack (5pc)', 3, 250.00, 300);
    
    SELECT * FROM Product;
    
    INSERT INTO Product
    (product_name, category_id, price, stock)
VALUES
    ('USB-C Charger', 1, 799.00, 80);
    
    UPDATE Product
SET
    price = 549.00,
    stock = stock + 50
WHERE product_id = 1;

DELETE FROM Product
WHERE product_id = 4;

SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price,
    p.stock
FROM Product p
INNER JOIN Category c
    ON p.category_id = c.category_id
ORDER BY c.category_name, p.product_name;

SELECT
    c.category_name,
    p.product_name,
    p.price,
    p.stock
FROM Category c
JOIN Product p
    ON c.category_id = p.category_id
ORDER BY
    c.category_name,
    p.product_name;
    
    SELECT
    c.category_name,
    COUNT(p.product_id) AS total_products,
    COALESCE(SUM(p.stock), 0) AS total_stock,
    COALESCE(SUM(p.price * p.stock), 0) AS total_stock_value
FROM Category c
LEFT JOIN Product p
    ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY total_stock_value DESC;

SELECT
    c.category_name,
    p.product_name,
    p.stock
FROM Category c
JOIN Product p
    ON c.category_id = p.category_id
WHERE p.stock < 50
ORDER BY c.category_name, p.stock;

SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price,
    p.stock
FROM Product p
JOIN Category c
    ON p.category_id = c.category_id
WHERE p.product_name LIKE '%Mouse%';

SELECT
    product_name,
    price,
    stock
FROM Product
WHERE price > 500
ORDER BY price DESC;

SELECT
    SUM(price * stock) AS total_inventory_value
FROM Product;

SELECT * FROM Category;

SELECT * FROM Product;

