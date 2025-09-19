---

# 📦 E-commerce Store Database (Tech Gadgets & Accessories)

## 📌 Project Overview

This project is a **relational database management system** (RDBMS) for an e-commerce store that sells tech gadgets and accessories such as phone cases, ergonomic stands, and wireless chargers.

It was designed and implemented in **MySQL** as part of a Database Management Systems assignment.

---

## 🛠️ Features

* **Customer Management** → stores customer details (name, email, phone, address).
* **Product Catalog** → maintains products with categories, price, and stock levels.
* **Order Management** → tracks orders placed by customers.
* **Order Details** → supports multiple products per order (many-to-many).
* **Payments** → records payment transactions for each order.

---

## 🗄️ Database Schema

**Entities and Relationships**

* A customer can place **many orders** (1 → many).
* An order can contain **multiple products** (many → many, handled through `OrderDetails`).
* An order has **one payment** (1 → 1).
* Each product can appear in **many order details** (1 → many).

---

## 📂 Files

* `ecommerce.sql` → contains all SQL statements:

  * `CREATE DATABASE` and `USE`
  * `CREATE TABLE` definitions with constraints
  * `INSERT` statements with sample data
  * Example `SELECT` queries (joins & reports)

---

## ▶️ How to Use

1. Clone this repository or download the `.sql` file.
2. Open MySQL and run:

   ```sql
   SOURCE ecommerce.sql;
   ```
3. Explore the database using queries, e.g.:

   ```sql
   SELECT c.name, o.order_id, p.amount
   FROM Customers c
   JOIN Orders o ON c.customer_id = o.customer_id
   JOIN Payments p ON o.order_id = p.order_id;
   ```

---

## 👤 Author

* **Kairugoodman**
* Database Management Systems Assignment

---
