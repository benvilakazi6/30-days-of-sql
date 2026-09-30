SELECT * FROM customers;

SELECT name FROM customers;

SELECT * FROM products
WHERE price > 500;

SELECT * FROM orders
WHERE year=2025;

SELECT * FROM products
WHERE price < 1000
ORDER BY price ASC;

SELECT * FROM products
WHERE price < 1000
ORDER BY price ASC
LIMIT 10;

SELECT * FROM customers
WHERE location='Gauteng';

SELECT * FROM orders
WHERE price >= 1000;

SELECT * FROM customers
WHERE name LIKE '%A';

SELECT * FROM orders
WHERE price BETWEEN 200 AND 800;

SELECT * FROM customers
WHERE location = 'Gauteng' OR location = 'KwaZulu-Natal';

SELECT * FROM orders
WHERE price BETWEEN 500 AND 2000;

SELECT * FROM products
ORDER BY price DESC
LIMIT 5;

SELECT * FROM products
WHERE name LIKE '%Phone%';