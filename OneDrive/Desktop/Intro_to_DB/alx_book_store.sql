-- alx_book_store.sql
-- Schema for alx_book_store (all SQL keywords are uppercase)

SET FOREIGN_KEY_CHECKS = 0;

DROP DATABASE IF EXISTS alx_book_store;
CREATE DATABASE alx_book_store CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE alx_book_store;

-- Authors table
DROP TABLE IF EXISTS Authors;
CREATE TABLE Authors (
  author_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  author_name VARCHAR(215) NOT NULL,
  PRIMARY KEY (author_id)
) ENGINE=InnoDB;

-- Books table
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
  book_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  title VARCHAR(130) NOT NULL,
  author_id INT UNSIGNED NOT NULL,
  price DOUBLE NOT NULL DEFAULT 0,
  publication_date DATE,
  PRIMARY KEY (book_id),
  INDEX idx_books_author_id (author_id),
  CONSTRAINT fk_books_author
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Customers table
DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
  customer_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  customer_name VARCHAR(215) NOT NULL,
  email VARCHAR(215),
  address TEXT,
  PRIMARY KEY (customer_id),
  UNIQUE KEY uq_customers_email (email)
) ENGINE=InnoDB;

-- Orders table
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  order_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  customer_id INT UNSIGNED NOT NULL,
  order_date DATE NOT NULL,
  PRIMARY KEY (order_id),
  INDEX idx_orders_customer_id (customer_id),
  CONSTRAINT fk_orders_customer
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Order_Details table
DROP TABLE IF EXISTS Order_Details;
CREATE TABLE Order_Details (
  orderdetailid INT UNSIGNED NOT NULL AUTO_INCREMENT,
  order_id INT UNSIGNED NOT NULL,
  book_id INT UNSIGNED NOT NULL,
  quantity DOUBLE NOT NULL DEFAULT 1,
  PRIMARY KEY (orderdetailid),
  INDEX idx_od_order_id (order_id),
  INDEX idx_od_book_id (book_id),
  CONSTRAINT fk_od_order
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_od_book
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB;

SET FOREIGN_KEY_CHECKS = 1;

-- OPTIONAL: sample data to verify the schema (you can remove these inserts if not wanted)
INSERT INTO Authors (author_name) VALUES
  ('George Orwell'),
  ('Jane Austen'),
  ('Chinua Achebe');

INSERT INTO Books (title, author_id, price, publication_date) VALUES
  ('1984', 1, 12.99, '1949-06-08'),
  ('Pride and Prejudice', 2, 9.50, '1813-01-28'),
  ('Things Fall Apart', 3, 11.00, '1958-06-17');

INSERT INTO Customers (customer_name, email, address) VALUES
  ('Maruf Ashiru', 'maruf@example.com', 'Ibadan, Nigeria'),
  ('Aisha Bello', 'aisha@example.com', 'Lagos, Nigeria');

INSERT INTO Orders (customer_id, order_date) VALUES
  (1, '2025-10-01'),
  (2, '2025-10-03');

INSERT INTO Order_Details (order_id, book_id, quantity) VALUES
  (1, 1, 1),  -- Maruf bought '1984'
  (1, 3, 2),  -- Maruf bought 2 copies of 'Things Fall Apart'
  (2, 2, 1);  -- Aisha bought 'Pride and Prejudice'
