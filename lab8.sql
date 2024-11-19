create database lab8

CREATE TABLE salesman (
    salesman_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(10, 2)
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    grade INTEGER,
    salesman_id INTEGER REFERENCES salesman(salesman_id)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    purch_amt DECIMAL(10, 2),
    order_date DATE,
    customer_id INTEGER REFERENCES customers(customer_id),
    salesman_id INTEGER REFERENCES salesman(salesman_id)
);

CREATE ROLE junior_dev WITH LOGIN;

CREATE VIEW new_york_salesmen AS
SELECT * FROM salesman
WHERE city = 'New York';

CREATE VIEW orders_with_names AS
SELECT o.order_id, o.purch_amt, o.order_date,
       s.name AS salesman_name,
       c.name AS customer_name
FROM orders o
JOIN salesman s ON o.salesman_id = s.salesman_id
JOIN customers c ON o.customer_id = c.customer_id;

GRANT ALL PRIVILEGES ON orders_with_names TO junior_dev;

CREATE VIEW highest_grade_customers AS
SELECT * FROM customers
WHERE grade = (SELECT MAX(grade) FROM customers);

GRANT SELECT ON highest_grade_customers TO junior_dev;

CREATE VIEW salesman_count_by_city AS
SELECT city, COUNT(*) AS salesman_count
FROM salesman
GROUP BY city;

CREATE VIEW salesmen_with_multiple_customers AS
SELECT s.salesman_id, s.name, s.city, COUNT(c.customer_id) AS customer_count
FROM salesman s
JOIN customers c ON s.salesman_id = c.salesman_id
GROUP BY s.salesman_id, s.name, s.city
HAVING COUNT(c.customer_id) > 1;

CREATE ROLE intern;
GRANT junior_dev TO intern;
