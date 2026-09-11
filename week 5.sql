CREATE DATABASE ProductReviewDB; 
USE ProductReviewDB;

CREATE TABLE Product ( 
    ProductID INT PRIMARY KEY, 
    ProductName VARCHAR(100) NOT NULL, 
    Category VARCHAR(50), 
    Price DECIMAL(10,2) 
); 

CREATE TABLE Customer ( 
    CustomerID INT PRIMARY KEY, 
    CustomerName VARCHAR(100) NOT NULL, 
    Email VARCHAR(100) UNIQUE 
); 

CREATE TABLE Review ( 
    ReviewID INT PRIMARY KEY, 
    ProductID INT NOT NULL, 
    CustomerID INT NOT NULL, 
    ReviewText VARCHAR(500), 
    ReviewDate DATE, 
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID), 
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) 
); 

CREATE TABLE Rating ( 
    RatingID INT PRIMARY KEY, 
    ReviewID INT NOT NULL, 
    RatingValue INT NOT NULL, 
    FOREIGN KEY (ReviewID) REFERENCES Review(ReviewID), 
    CHECK (RatingValue BETWEEN 1 AND 5) 
); 

INSERT INTO Product VALUES 
(101, 'Laptop', 'Electronics', 55000.00), 
(102, 'Smartphone', 'Electronics', 30000.00), 
(103, 'Headphones', 'Accessories', 2500.00), 
(104, 'Smart Watch', 'Wearables', 6000.00), 
(105, 'Bluetooth Speaker', 'Accessories', 3500.00); 

INSERT INTO Customer VALUES 
(1, 'Arun', 'arun@example.com'), 
(2, 'Priya', 'priya@example.com'), 
(3, 'Rahul', 'rahul@example.com'), 
(4, 'Divya', 'divya@example.com'), 
(5, 'Kiran', 'kiran@example.com'); 

INSERT INTO Review VALUES 
(1, 101, 1, 'Excellent laptop with good performance.', '2026-09-01'), 
(2, 102, 2, 'Good phone with a clear display.', '2026-09-02'), 
(3, 103, 3, 'Sound quality is very good.', '2026-09-03'), 
(4, 104, 4, 'Useful features and attractive design.', '2026-09-04'), 
(5, 105, 5, 'Good speaker, but battery could be better.', '2026-09-05'), 
(6, 101, 2, 'Fast and reliable for daily work.', '2026-09-06'), 
(7, 102, 3, 'Camera quality is impressive.', '2026-09-07'); 

INSERT INTO Rating VALUES 
(1, 1, 5), 
(2, 2, 4), 
(3, 3, 5), 
(4, 4, 4), 
(5, 5, 3), 
(6, 6, 5), 
(7, 7, 4); 

SELECT 
    p.ProductName, 
    c.CustomerName, 
    r.ReviewText, 
    rt.RatingValue, 
    r.ReviewDate 
FROM Product p 
JOIN Review r ON p.ProductID = r.ProductID 
JOIN Customer c ON r.CustomerID = c.CustomerID 
JOIN Rating rt ON r.ReviewID = rt.ReviewID 
ORDER BY r.ReviewDate; 

SELECT 
    p.ProductID, 
    p.ProductName, 
    ROUND(AVG(rt.RatingValue), 2) AS AverageRating 
FROM Product p 
JOIN Review r ON p.ProductID = r.ProductID 
JOIN Rating rt ON r.ReviewID = rt.ReviewID 
GROUP BY p.ProductID, p.ProductName; 

SELECT 
    p.ProductID, 
    p.ProductName, 
    ROUND(AVG(rt.RatingValue), 2) AS AverageRating 
FROM Product p 
JOIN Review r ON p.ProductID = r.ProductID 
JOIN Rating rt ON r.ReviewID = rt.ReviewID 
GROUP BY p.ProductID, p.ProductName 
HAVING AVG(rt.RatingValue) >= 4 
ORDER BY AverageRating DESC;

SELECT 
    p.ProductName, 
    ROUND(AVG(rt.RatingValue), 2) AS AverageRating 
FROM Product p 
JOIN Review r ON p.ProductID = r.ProductID 
JOIN Rating rt ON r.ReviewID = rt.ReviewID 
GROUP BY p.ProductID, p.ProductName 
ORDER BY AverageRating DESC 
LIMIT 1; 

SELECT 
    p.ProductName, 
    COUNT(r.ReviewID) AS TotalReviews 
FROM Product p 
LEFT JOIN Review r ON p.ProductID = r.ProductID 
GROUP BY p.ProductID, p.ProductName 
ORDER BY TotalReviews DESC;

SELECT 
    p.ProductName, 
    COUNT(rt.RatingID) AS TotalRatings, 
    ROUND(AVG(rt.RatingValue), 2) AS AverageRating, 
    MAX(rt.RatingValue) AS HighestRating, 
    MIN(rt.RatingValue) AS LowestRating 
FROM Product p 
JOIN Review r ON p.ProductID = r.ProductID 
JOIN Rating rt ON r.ReviewID = rt.ReviewID 
GROUP BY p.ProductID, p.ProductName; 