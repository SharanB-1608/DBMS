CREATE DATABASE seller_inventory_db;

USE seller_inventory_db;

CREATE TABLE Seller (
    seller_id INT PRIMARY KEY,
    seller_name VARCHAR(60),
    city VARCHAR(40),
    phone VARCHAR(15)
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(60),
    category VARCHAR(40),
    unit_price DECIMAL(10,2),
    seller_id INT,
    FOREIGN KEY (seller_id) REFERENCES Seller(seller_id)
);

CREATE TABLE Inventory (
    stock_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    reorder_level INT,
    stock_status VARCHAR(20),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

INSERT INTO Seller VALUES
(201, 'TechNova Distributors', 'Trichy', '9876501122'),
(202, 'Smart Office Mart', 'Tiruppur', '9876502233'),
(203, 'Digital World Traders', 'Madurai', '9876503344'),
(204, 'NextGen Electronics', 'Salem', '9876504455');

INSERT INTO Product VALUES
(401, 'Mechanical Keyboard', 'Accessories', 1850.00, 201),
(402, 'Bluetooth Speaker', 'Audio', 2750.00, 202),
(403, 'Dual Band Router', 'Networking', 3650.00, 203),
(404, 'Full HD Monitor', 'Display', 9400.00, 204),
(405, 'Ergonomic Mouse', 'Accessories', 1100.00, 201);

INSERT INTO Inventory VALUES
(601, 401, 32, 12, 'In Stock'),
(602, 402, 6, 10, 'Reorder'),
(603, 403, 21, 8, 'In Stock'),
(604, 404, 4, 6, 'Reorder'),
(605, 405, 27, 15, 'In Stock');

SELECT * FROM Seller;

SELECT product_name, category, unit_price
FROM Product;

SELECT Seller.seller_name, Product.product_name, Product.unit_price
FROM Seller
INNER JOIN Product
ON Seller.seller_id = Product.seller_id;

SELECT Product.product_name,
       Inventory.quantity,
       Inventory.reorder_level
FROM Product
INNER JOIN Inventory
ON Product.product_id = Inventory.product_id
WHERE Inventory.quantity <= Inventory.reorder_level;

SELECT Product.product_name, Inventory.quantity
FROM Product
INNER JOIN Inventory
ON Product.product_id = Inventory.product_id
WHERE Inventory.quantity > 25;

SELECT Product.product_id,
       Product.product_name,
       Product.category,
       Inventory.quantity,
       Inventory.reorder_level,
       Inventory.stock_status
FROM Product
INNER JOIN Inventory
ON Product.product_id = Inventory.product_id;

SELECT AVG(unit_price) AS average_product_price
FROM Product;

SELECT SUM(quantity) AS total_stock
FROM Inventory;

UPDATE Inventory
SET quantity = 18,
    stock_status = 'In Stock'
WHERE product_id = 402;

DELETE FROM Inventory WHERE product_id = 404;

DELETE FROM Product WHERE product_id = 404;SELECT Product.product_id,        Product.product_name,        Product.category,        Inventory.quantity,        Inventory.reorder_level,        Inventory.stock_status FROM Product INNER JOIN Inventory ON Product.product_id = Inventory.product_id LIMIT 0, 1000
