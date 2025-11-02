-- SQL Script: E-Commerce Database Setup

-- Creating New Database
CREATE DATABASE Final_project_Grp11;

# we will first run DATABSE creation query and then we will run all following query in this new created Database.


-- 1. Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(100)
);

-- 2. Vendors Table
CREATE TABLE Vendors (
    vendor_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100),
    rating DECIMAL(2,1) CHECK (rating BETWEEN 1 AND 5)
);

-- 3. Categories Table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

-- 4. Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category_id INT,
    vendor_id INT,
    price DECIMAL(10,2),
    description TEXT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    FOREIGN KEY (vendor_id) REFERENCES Vendors(vendor_id)
);

-- 5. Inventory Table
CREATE TABLE Inventory (
    product_id INT PRIMARY KEY,
    stock_quantity INT NOT NULL,
    last_updated VARCHAR(100),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- 6. Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50),
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 7. OrderItems Table
CREATE TABLE OrderItems (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- 8. Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- 9. Shipping Table
CREATE TABLE Shipping (
    shipping_id INT PRIMARY KEY,
    order_id INT,
    shipping_date DATE,
    delivery_date DATE,
    shipping_method VARCHAR(50),
    status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- 10. ProductReviews Table
CREATE TABLE ProductReviews (
    review_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Data Insertion in all tables

-- Customers
INSERT INTO Customers (customer_id, name, email, phone, address) VALUES
(1, 'Alice Smith', 'alice@example.com', '123-456-7890', '123 Main St'),
(2, 'Bob Johnson', 'bob@example.com', '234-567-8901', '456 Oak Ave'),
(3, 'Charlie Lee', 'charlie@example.com', '345-678-9012', '789 Pine Rd'),
(4, 'Diana King', 'diana@example.com', '456-789-0123', '321 Cedar Ln'),
(5, 'Eve Adams', 'eve@example.com', '567-890-1234', '654 Birch Blvd'),
(6, 'Frank Wright', 'frank@example.com', '678-901-2345', '987 Maple Dr'),
(7, 'Grace Hall', 'grace@example.com', '789-012-3456', '159 Elm St'),
(8, 'Hank Green', 'hank@example.com', '890-123-4567', '753 Spruce Way'),
(9, 'Ivy Young', 'ivy@example.com', '901-234-5678', '852 Willow Cir'),
(10, 'Jack White', 'jack@example.com', '012-345-6789', '951 Ash Ct');

-- Vendors
INSERT INTO Vendors (vendor_id, name, contact_email, rating) VALUES
(1, 'TechSuppliers Inc.', 'contact@techsuppliers.com', 4.7),
(2, 'BookBazaar', 'support@bookbazaar.com', 4.5),
(3, 'GadgetWorld', 'info@gadgetworld.com', 4.2),
(4, 'SmartGear', 'sales@smartgear.com', 4.8),
(5, 'PrintMedia', 'help@printmedia.com', 4.0),
(6, 'OfficeDepot', 'service@officedepot.com', 4.1),
(7, 'DigitalKing', 'contact@digitalking.com', 4.3),
(8, 'GreenTech', 'hello@greentech.com', 4.6),
(9, 'NextGenBooks', 'nextgen@books.com', 4.4),
(10, 'AccessoryHub', 'support@accessoryhub.com', 4.9);

-- Categories
INSERT INTO Categories (category_id, name, description) VALUES
(1, 'Electronics', 'Devices and accessories'),
(2, 'Books', 'Printed and digital books'),
(3, 'Office Supplies', 'Items for office use'),
(4, 'Home Appliances', 'Appliances for daily home use'),
(5, 'Wearables', 'Smart wearable devices'),
(6, 'Fitness', 'Fitness gear and equipment'),
(7, 'Gaming', 'Gaming consoles and accessories'),
(8, 'Stationery', 'Writing and drawing supplies'),
(9, 'Software', 'Digital software and licenses'),
(10, 'Furniture', 'Desks, chairs, and storage');

-- Products
INSERT INTO Products (product_id, name, category_id, vendor_id, price, description) VALUES
(1, 'Wireless Mouse', 1, 1, 25.99, 'Ergonomic wireless mouse'),
(2, 'Eloquent JavaScript', 2, 2, 30.00, 'Programming book'),
(3, 'Bluetooth Keyboard', 1, 3, 45.00, 'Slim Bluetooth keyboard'),
(4, 'Standing Desk', 10, 10, 250.00, 'Adjustable standing desk'),
(5, 'Smart Watch', 5, 4, 199.99, 'Fitness smart watch'),
(6, 'Yoga Mat', 6, 5, 20.00, 'Non-slip yoga mat'),
(7, 'Gaming Headset', 7, 6, 89.99, 'Surround sound gaming headset'),
(8, 'Ballpoint Pen Set', 8, 7, 5.50, 'Pack of 10 pens'),
(9, 'Photo Editor Software', 9, 8, 59.99, 'Professional photo editing'),
(10, 'Office Chair', 10, 9, 149.00, 'Ergonomic office chair');

-- Inventory
INSERT INTO Inventory (product_id, stock_quantity, last_updated) VALUES
(1, 50, '2025-03-01'),
(2, 100, '2025-03-01'),
(3, 75, '2025-03-01'),
(4, 20, '2025-03-01'),
(5, 40, '2025-03-01'),
(6, 60, '2025-03-01'),
(7, 35, '2025-03-01'),
(8, 200, '2025-03-01'),
(9, 90, '2025-03-01'),
(10, 25, '2025-03-01');

-- Orders
INSERT INTO Orders (order_id, customer_id, order_date, status, total_amount) VALUES
(1, 1, '2025-03-10 10:00:00', 'Shipped', 55.99),
(2, 2, '2025-03-11 11:00:00', 'Delivered', 30.00),
(3, 3, '2025-03-12 12:00:00', 'Processing', 45.00),
(4, 4, '2025-03-13 13:00:00', 'Shipped', 250.00),
(5, 5, '2025-03-14 14:00:00', 'Delivered', 199.99),
(6, 6, '2025-03-15 15:00:00', 'Cancelled', 20.00),
(7, 7, '2025-03-16 16:00:00', 'Delivered', 89.99),
(8, 8, '2025-03-17 17:00:00', 'Shipped', 5.50),
(9, 9, '2025-03-18 18:00:00', 'Processing', 59.99),
(10, 10, '2025-03-19 19:00:00', 'Delivered', 149.00);

-- OrderItems
INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, price) VALUES
(1, 1, 1, 1, 25.99),
(2, 1, 2, 1, 30.00),
(3, 2, 2, 1, 30.00),
(4, 3, 3, 1, 45.00),
(5, 4, 4, 1, 250.00),
(6, 5, 5, 1, 199.99),
(7, 6, 6, 1, 20.00),
(8, 7, 7, 1, 89.99),
(9, 8, 8, 1, 5.50),
(10, 9, 9, 1, 59.99);

-- Payments
INSERT INTO Payments (payment_id, order_id, payment_date, amount, payment_method) VALUES
(1, 1, '2025-03-10 10:05:00', 55.99, 'Credit Card'),
(2, 2, '2025-03-11 11:05:00', 30.00, 'PayPal'),
(3, 3, '2025-03-12 12:05:00', 45.00, 'Debit Card'),
(4, 4, '2025-03-13 13:05:00', 250.00, 'Credit Card'),
(5, 5, '2025-03-14 14:05:00', 199.99, 'UPI'),
(6, 6, '2025-03-15 15:05:00', 20.00, 'Cash on Delivery'),
(7, 7, '2025-03-16 16:05:00', 89.99, 'PayPal'),
(8, 8, '2025-03-17 17:05:00', 5.50, 'Credit Card'),
(9, 9, '2025-03-18 18:05:00', 59.99, 'UPI'),
(10, 10, '2025-03-19 19:05:00', 149.00, 'Debit Card');

-- Shipping
INSERT INTO Shipping (shipping_id, order_id, shipping_date, delivery_date, shipping_method, status) VALUES
(1, 1, '2025-03-11', '2025-03-15', 'Standard', 'Delivered'),
(2, 2, '2025-03-12', '2025-03-16', 'Standard', 'Delivered'),
(3, 3, '2025-03-13', NULL, 'Express', 'Processing'),
(4, 4, '2025-03-14', '2025-03-18', 'Standard', 'Delivered'),
(5, 5, '2025-03-15', '2025-03-19', 'Express', 'Delivered'),
(6, 6, NULL, NULL, 'Standard', 'Cancelled'),
(7, 7, '2025-03-16', '2025-03-20', 'Standard', 'Delivered'),
(8, 8, '2025-03-17', '2025-03-21', 'Standard', 'Delivered'),
(9, 9, NULL, NULL, 'Express', 'Processing'),
(10, 10, '2025-03-19', '2025-03-23', 'Standard', 'Delivered');

-- ProductReviews
INSERT INTO ProductReviews (review_id, customer_id, product_id, rating, comment, review_date) VALUES
(1, 1, 1, 5, 'Excellent mouse!', '2025-03-12 08:30:00'),
(2, 1, 2, 4, 'Great book on JavaScript.', '2025-03-13 09:00:00'),
(3, 2, 3, 4, 'Comfortable keyboard.', '2025-03-14 10:00:00'),
(4, 3, 4, 5, 'Very useful desk.', '2025-03-15 11:00:00'),
(5, 4, 5, 5, 'Love this smart watch!', '2025-03-16 12:00:00'),
(6, 5, 6, 3, 'Average quality.', '2025-03-17 13:00:00'),
(7, 6, 7, 5, 'Amazing sound quality.', '2025-03-18 14:00:00'),
(8, 7, 8, 4, 'Smooth writing pens.', '2025-03-19 15:00:00'),
(9, 8, 9, 5, 'Best editing tool.', '2025-03-20 16:00:00'),
(10, 9, 10, 4, 'Comfortable chair.', '2025-03-21 17:00:00');

#DDL (Data Definition Language)

# A. Add NOT NULL constraints
ALTER TABLE Inventory MODIFY stock_quantity INT NOT NULL;
ALTER TABLE OrderItems MODIFY quantity INT NOT NULL;

# B. Alter Table: CHanging Foreign Key
ALTER TABLE Orders
  DROP FOREIGN KEY orders_ibfk_1,
  ADD CONSTRAINT fk_orders_customer
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id);

#DML (Data Manipulation Language)

#A. Update product price
UPDATE Products
SET price = price * 1.10
WHERE category_id = 1; -- Increase all Electronics by 10%

# B. Change order status
UPDATE Orders
SET status = 'Delivered'
WHERE order_id = 3;

#C. Delete a review
DELETE FROM ProductReviews
WHERE review_id = 6;

#D. Add a new product
INSERT INTO Products (product_id, name, category_id, vendor_id, price, description)
VALUES (11, 'Wireless Charger', 1, 3, 39.99, 'Fast wireless charging pad');

# DQL (Data Query Language)

# A. Total sales by category
SELECT c.name AS category, SUM(oi.quantity * oi.price) AS total_sales
FROM OrderItems oi
JOIN Products p ON oi.product_id = p.product_id
JOIN Categories c ON p.category_id = c.category_id
GROUP BY c.name
ORDER BY total_sales DESC;

# B. Top 5 best-selling products
SELECT p.name, SUM(oi.quantity) AS total_quantity_sold
FROM OrderItems oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY total_quantity_sold DESC
LIMIT 5;

#C. Customer order history
SELECT o.order_id, o.order_date, p.name AS product, oi.quantity, oi.price
FROM Orders o
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
WHERE o.customer_id = 1;

#D. Average rating by product
SELECT p.name, AVG(r.rating) AS avg_rating
FROM ProductReviews r
JOIN Products p ON r.product_id = p.product_id
GROUP BY p.name
ORDER BY avg_rating DESC;

#E. Orders with no payment
SELECT o.order_id, o.total_amount, o.status
FROM Orders o
LEFT JOIN Payments p ON o.order_id = p.order_id
WHERE p.order_id IS NULL;

#CTE (Common Table Expression)
WITH customer_totals AS (
  SELECT o.customer_id, SUM(o.total_amount) AS total_spent
  FROM Orders o
  GROUP BY o.customer_id
)
SELECT c.name, ct.total_spent
FROM customer_totals ct
JOIN Customers c ON ct.customer_id = c.customer_id
ORDER BY ct.total_spent DESC
LIMIT 3;


# HAVING Clause
#List of products with more than 1 review and average rating over 4:
SELECT p.name, COUNT(r.review_id) AS num_reviews, AVG(r.rating) AS avg_rating
FROM ProductReviews r
JOIN Products p ON r.product_id = p.product_id
GROUP BY p.name
HAVING COUNT(r.review_id) > 1 AND AVG(r.rating) > 4;


# Here are some complex queries as per the need for deeper business insights.
# Window Function: Rank Customers by Spending

SELECT 
  c.customer_id,
  c.name,
  SUM(o.total_amount) AS total_spent,
  RANK() OVER (ORDER BY SUM(o.total_amount) DESC) AS spending_rank
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

# Subquery: Products That Were Never Ordered
SELECT p.product_id, p.name
FROM Products p
WHERE NOT EXISTS (
    SELECT 1
    FROM OrderItems oi
    WHERE oi.product_id = p.product_id
);


#CTE + Aggregation: Most Popular Category by Sales
WITH category_sales AS (
  SELECT 
    c.category_id,
    c.name AS category_name,
    SUM(oi.quantity * oi.price) AS total_sales
  FROM OrderItems oi
  JOIN Products p ON oi.product_id = p.product_id
  JOIN Categories c ON p.category_id = c.category_id
  GROUP BY c.category_id, c.name
)
SELECT *
FROM category_sales
ORDER BY total_sales DESC
LIMIT 1;


# RFM Analysis Starter Query (Recency, Frequency, Monetary)
SELECT 
  c.customer_id,
  c.name,
  MAX(o.order_date) AS last_order_date,
  COUNT(o.order_id) AS frequency,
  SUM(o.total_amount) AS monetary
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY monetary DESC;


# Monthly Sales Trends with CTE and DATE_FORMAT
WITH monthly_sales AS (
  SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(total_amount) AS total_revenue
  FROM Orders
  GROUP BY month
)
SELECT * FROM monthly_sales
ORDER BY month;


# Detect Products with Declining Inventory (Simulated Trend)
SELECT i.product_id, p.name, i.stock_quantity, i.last_updated
FROM Inventory i
JOIN Products p ON i.product_id = p.product_id
WHERE i.stock_quantity < 30
ORDER BY i.stock_quantity ASC;

# Sentiment Detection: List Negative Product Reviews
SELECT r.review_id, c.name AS customer, p.name AS product, r.rating, r.comment
FROM ProductReviews r
JOIN Customers c ON r.customer_id = c.customer_id
JOIN Products p ON r.product_id = p.product_id
WHERE r.rating <= 2
ORDER BY r.rating ASC;

# 5 Queries for business needs:
# Customer Lifetime Value (CLV)
WITH customer_orders AS (
  SELECT 
    customer_id,
    order_id,
    total_amount,
    order_date,
    RANK() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rank_by_date
  FROM Orders
),
customer_clv AS (
  SELECT 
    customer_id,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_spent,
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
  FROM customer_orders
  GROUP BY customer_id
)
SELECT 
  c.customer_id,
  c.name,
  clv.total_orders,
  clv.total_spent,
  DATEDIFF(clv.last_order_date, clv.first_order_date) AS customer_lifetime_days
FROM customer_clv clv
JOIN Customers c ON c.customer_id = clv.customer_id
ORDER BY clv.total_spent DESC;


# Top-Selling Products by Month
WITH monthly_sales AS (
  SELECT 
    p.product_id,
    p.name AS product_name,
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(oi.quantity * oi.price) AS monthly_revenue
  FROM OrderItems oi
  JOIN Products p ON p.product_id = oi.product_id
  JOIN Orders o ON o.order_id = oi.order_id
  GROUP BY p.product_id, p.name, month
),
ranked_sales AS (
  SELECT *,
    RANK() OVER (PARTITION BY month ORDER BY monthly_revenue DESC) AS revenue_rank
  FROM monthly_sales
)
SELECT * 
FROM ranked_sales
WHERE revenue_rank = 1;


# Create a View
CREATE VIEW ActiveCustomerSummary AS
SELECT 
  c.customer_id,
  c.name,
  COUNT(o.order_id) AS total_orders,
  SUM(o.total_amount) AS total_spent,
  MAX(o.order_date) AS last_order_date
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING total_orders > 3;



# Customer  Behavior 
SELECT 
  c.customer_id,
  c.name,
  COUNT(o.order_id) AS order_count,
  SUM(o.total_amount) AS total_spent,
  AVG(oi.price * oi.quantity) AS avg_order_item_value
FROM Customers c
JOIN Orders o USING (customer_id)
JOIN OrderItems oi USING (order_id)
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC;



# Repeat Customers by Category
WITH customer_categories AS (
  SELECT 
    o.customer_id,
    p.category_id,
    COUNT(DISTINCT o.order_id) AS num_orders
  FROM Orders o
  JOIN OrderItems oi ON o.order_id = oi.order_id
  JOIN Products p ON oi.product_id = p.product_id
  GROUP BY o.customer_id, p.category_id
)
SELECT 
  cc.customer_id,
  cu.name,
  cat.name AS category_name,
  cc.num_orders
FROM customer_categories cc
JOIN Customers cu ON cc.customer_id = cu.customer_id
JOIN Categories cat ON cc.category_id = cat.category_id
WHERE cc.num_orders >= 2;


# Top 3 Rated Products per Category
WITH product_ratings AS (
  SELECT 
    p.product_id,
    p.name AS product_name,
    p.category_id,
    AVG(r.rating) AS avg_rating
  FROM Products p
  JOIN ProductReviews r ON p.product_id = r.product_id
  GROUP BY p.product_id, p.name, p.category_id
),
ranked_ratings AS (
  SELECT *,
    DENSE_RANK() OVER (PARTITION BY category_id ORDER BY avg_rating DESC) AS rating_rank
  FROM product_ratings
)
SELECT 
  pr.product_name,
  cat.name AS category,
  pr.avg_rating
FROM ranked_ratings pr
JOIN Categories cat ON pr.category_id = cat.category_id
WHERE pr.rating_rank <= 3;




















