CREATE DATABASE JoinAnalysis;
USE JoinAnalysis;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id)
);

CREATE TABLE OrderItems (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    amount DECIMAL(10,2),
    payment_method VARCHAR(30),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Customers VALUES
(1, 'Arun', 'Chennai'),
(2, 'Priya', 'Bengaluru'),
(3, 'Kumar', 'Madurai'),
(4, 'Divya', 'Coimbatore');

INSERT INTO Products VALUES
(101, 'Laptop', 50000.00),
(102, 'Mouse', 500.00),
(103, 'Keyboard', 1000.00),
(104, 'Monitor', 12000.00);

INSERT INTO Orders VALUES
(1001, 1, '2026-09-10', 'Shipped'),
(1002, 2, '2026-09-12', 'Processing'),
(1003, 1, '2026-09-18', 'Delivered'),
(1004, 3, '2026-09-20', 'Cancelled');

INSERT INTO OrderItems VALUES
(1001, 101, 1),
(1001, 102, 2),
(1002, 104, 1),
(1003, 103, 1),
(1004, 102, 1);

INSERT INTO Payments VALUES
(501, 1001, 51000.00, 'Card'),
(502, 1002, 12000.00, 'UPI'),
(503, 1003, 1000.00, 'Cash');

SELECT
    c.customer_name,
    o.order_id,
    p.product_name,
    oi.quantity,
    p.price,
    oi.quantity * p.price AS item_total,
    pay.amount AS payment_amount,
    pay.payment_method
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id
INNER JOIN OrderItems oi
    ON o.order_id = oi.order_id
INNER JOIN Products p
    ON oi.product_id = p.product_id
LEFT JOIN Payments pay
    ON o.order_id = pay.order_id
ORDER BY o.order_id, p.product_id;

SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.status
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_id;

SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.status
FROM Customers c
LEFT JOIN Orders o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_id;

SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.status
FROM Orders o
RIGHT JOIN Customers c
    ON o.customer_id = c.customer_id
ORDER BY c.customer_id, o.order_id;

SELECT
    o.order_id,
    o.order_date,
    o.status,
    c.customer_name,
    c.city,
    p.product_name,
    oi.quantity,
    p.price,
    oi.quantity * p.price AS item_total,
    pay.amount AS payment_amount,
    pay.payment_method
FROM Orders o
INNER JOIN Customers c
    ON o.customer_id = c.customer_id
INNER JOIN OrderItems oi
    ON o.order_id = oi.order_id
INNER JOIN Products p
    ON oi.product_id = p.product_id
LEFT JOIN Payments pay
    ON o.order_id = pay.order_id
WHERE o.order_id = 1001
ORDER BY p.product_id;

SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date,
    o.status,
    p.product_name,
    oi.quantity,
    p.price,
    oi.quantity * p.price AS item_total
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id
INNER JOIN OrderItems oi
    ON o.order_id = oi.order_id
INNER JOIN Products p
    ON oi.product_id = p.product_id
WHERE c.customer_id = 1
ORDER BY o.order_date DESC, o.order_id;

SELECT
    o.order_id,
    c.customer_name,
    o.order_date,
    o.status,
    COALESCE(items.order_total, 0) AS order_total,
    COALESCE(payments.paid_total, 0) AS paid_total
FROM Orders o
INNER JOIN Customers c
    ON o.customer_id = c.customer_id
LEFT JOIN (
    SELECT
        oi.order_id,
        SUM(oi.quantity * p.price) AS order_total
    FROM OrderItems oi
    INNER JOIN Products p
        ON oi.product_id = p.product_id
    GROUP BY oi.order_id
) items ON o.order_id = items.order_id
LEFT JOIN (
    SELECT
        order_id,
        SUM(amount) AS paid_total
    FROM Payments
    GROUP BY order_id
) payments ON o.order_id = payments.order_id
ORDER BY o.order_id;

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * p.price) AS sales_value
FROM Products p
INNER JOIN OrderItems oi
    ON p.product_id = oi.product_id
INNER JOIN Orders o
    ON oi.order_id = o.order_id
WHERE o.status <> 'Cancelled'
GROUP BY p.product_id, p.product_name
ORDER BY units_sold DESC, sales_value DESC;

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS order_count,
    COALESCE(
        SUM(oi.quantity * p.price), 0
    ) AS item_value
FROM Customers c
LEFT JOIN Orders o
    ON c.customer_id = o.customer_id
LEFT JOIN OrderItems oi
    ON o.order_id = oi.order_id
LEFT JOIN Products p
    ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY item_value DESC;

