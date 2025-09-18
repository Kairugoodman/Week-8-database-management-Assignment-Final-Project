-- =========================================
-- E-COMMERCE STORE DATABASE
-- Tech Gadgets & Accessories
-- Description: Database for managing customers,
-- products, orders, payments in an online store.
-- =========================================




CREATE DATABASE ecommerce;

USE ecommerce;


-- creating the customer table
-- Stores information about customers who place orders
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(200)
);
-- insert into customers
INSERT INTO Customers (name, email, phone, address) VALUES
('Alice Johnson', 'alice.johnson@example.com', '0712345678', 'Nairobi, Kenya'),
('Brian Kim', 'brian.kim@example.com', '0723456789', 'Mombasa, Kenya'),
('Catherine Otieno', 'catherine.otieno@example.com', '0734567890', 'Kisumu, Kenya'),
('David Mwangi', 'david.mwangi@example.com', '0745678901', 'Nakuru, Kenya'),
('Emily Njeri', 'emily.njeri@example.com', '0756789012', 'Eldoret, Kenya'),
('Felix Oduor', 'felix.oduor@example.com', '0767890123', 'Thika, Kenya');

-- creating products table
-- Stores catalog of products for sale
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,   -- unique ID for each product
    name VARCHAR(150) NOT NULL,                  -- product name (e.g., "Wireless Charger")
    category VARCHAR(100) NOT NULL,              -- type of product (e.g., "Phone Case")
    price DECIMAL(10,2) NOT NULL,                -- price with 2 decimal places
    stock_quantity INT NOT NULL DEFAULT 0,       -- how many items available in stock
    description TEXT,                            -- optional details about product
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- when product was added
);

INSERT INTO Products (name, category, price, stock_quantity, description) VALUES
('Wireless Charger Pad', 'Charger', 2500.00, 50, 'Fast charging wireless pad, Qi-certified'),
('Ergonomic Laptop Stand', 'Stand', 3500.00, 30, 'Adjustable aluminum laptop stand'),
('Silicone Phone Case', 'Phone Case', 800.00, 100, 'Shockproof silicone case for smartphones'),
('Bluetooth Earbuds', 'Audio', 4500.00, 40, 'Noise-cancelling wireless earbuds'),
('Portable Power Bank 20000mAh', 'Charger', 3000.00, 60, 'High capacity portable power bank'),
('Magnetic Car Mount', 'Accessory', 1200.00, 70, 'Magnetic phone holder for cars');



-- One customer can place many orders.
-- Each order belongs to one customer hence the one to many relationship
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,        -- unique ID for each order
    order_date DATE NOT NULL,                       -- when the order was placed
    customer_id INT NOT NULL,                       -- link to the customer who placed it
    status VARCHAR(50) DEFAULT 'Pending',           -- order status (Pending, Shipped, Delivered, Cancelled)
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON DELETE CASCADE                           -- if a customer is deleted, delete their orders too
);
-- insert into orders table
INSERT INTO Orders (order_date, customer_id, status) VALUES
('2025-09-01', 1, 'Pending'),     -- Alice Johnson
('2025-09-02', 2, 'Shipped'),     -- Brian Kim
('2025-09-03', 3, 'Delivered'),   -- Catherine Otieno
('2025-09-04', 4, 'Pending'),     -- David Mwangi
('2025-09-05', 5, 'Delivered'),   -- Emily Njeri
('2025-09-06', 6, 'Pending');     -- Felix Oduor


-- One order can have many products.One product can appear in many orders representing a a many-to-many relationship
-- Handles many-to-many between Orders and Products
CREATE TABLE OrderDetails (
    order_id INT NOT NULL,                       -- the order this product belongs to
    product_id INT NOT NULL,                     -- the product being purchased
    quantity INT NOT NULL DEFAULT 1,             -- how many units of the product
    price_at_purchase DECIMAL(10,2) NOT NULL,    -- record the price at time of order
    PRIMARY KEY (order_id, product_id),          -- composite key: one product per order
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
        ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
        ON DELETE CASCADE
);
-- insert into order details table
INSERT INTO OrderDetails (order_id, product_id, quantity, price_at_purchase) VALUES
-- Order 1: Alice buys a Wireless Charger and 2 Phone Cases
(1, 1, 1, 2500.00),
(1, 3, 2, 800.00),
-- Order 2: Brian buys 1 Laptop Stand
(2, 2, 1, 3500.00),
-- Order 3: Catherine buys 1 pair of Bluetooth Earbuds and 1 Car Mount
(3, 4, 1, 4500.00),
(3, 6, 1, 1200.00),
-- Order 4: David buys 2 Power Banks
(4, 5, 2, 3000.00),
-- Order 5: Emily buys 1 Wireless Charger
(5, 1, 1, 2500.00),
-- Order 6: Felix buys 1 Laptop Stand and 3 Phone Cases
(6, 2, 1, 3500.00),
(6, 3, 3, 800.00);

-- Create Payments Table
-- Each order has one payment
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,      -- unique payment ID
    order_id INT NOT NULL,                          -- link to Orders
    amount DECIMAL(10,2) NOT NULL,                  -- total amount paid
    payment_date DATE NOT NULL,                     -- when payment was made
    payment_method VARCHAR(50) NOT NULL,            -- e.g., Mpesa, Card, PayPal
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
        ON DELETE CASCADE
);

INSERT INTO Payments (order_id, amount, payment_date, payment_method) VALUES
(1, 4100.00, '2025-09-01', 'Mpesa'),       -- Wireless Charger (2500) + 2 Phone Cases (1600)
(2, 3500.00, '2025-09-02', 'Card'),        -- Laptop Stand
(3, 5700.00, '2025-09-03', 'PayPal'),      -- Earbuds (4500) + Car Mount (1200)
(4, 6000.00, '2025-09-04', 'Mpesa'),       -- 2 Power Banks (2×3000)
(5, 2500.00, '2025-09-05', 'Card'),        -- Wireless Charger
(6, 5900.00, '2025-09-06', 'Mpesa');       -- Laptop Stand (3500) + 3 Phone Cases (2400)

SELECT * FROM Orders;
SELECT * FROM OrderDetails;
