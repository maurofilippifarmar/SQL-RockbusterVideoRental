-- Top 5 Customers Who Rented the Most Movies (Inner Join)
SELECT A.customer_id,
       A.first_name,
       A.last_name,
       COUNT(R.rental_id) AS total_rentals
FROM customer A
INNER JOIN rental R ON A.customer_id = R.customer_id
GROUP BY A.customer_id, A.first_name, A.last_name
ORDER BY total_rentals DESC
LIMIT 5;

-- Customers with Payments but No Rentals (Left Join)
SELECT A.customer_id,
       A.first_name,
       A.last_name,
       SUM(P.amount) AS total_payments
FROM customer A
LEFT JOIN rental R ON A.customer_id = R.customer_id
LEFT JOIN payment P ON A.customer_id = P.customer_id
WHERE R.rental_id IS NULL
GROUP BY A.customer_id, A.first_name, A.last_name
ORDER BY total_payments DESC;

-- Customers and Their Cities (Natural Join)
SELECT A.customer_id,
       A.first_name,
       A.last_name,
       C.city
FROM customer A
NATURAL JOIN address B
NATURAL JOIN city C
ORDER BY C.city;

-- Pairs of Customers from the Same City (Self Join)
SELECT A1.first_name AS customer1,
       A2.first_name AS customer2,
       C.city
FROM customer A1
INNER JOIN customer A2 ON A1.address_id = A2.address_id AND A1.customer_id != A2.customer_id
INNER JOIN address B ON A1.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
ORDER BY C.city;

-- All Combinations of Customers and Cities (Cross Join)
SELECT A.first_name AS customer,
       C.city
FROM customer A
CROSS JOIN city C
ORDER BY A.first_name, C.city
LIMIT 20;  -- Limiting to 20 results for readability

-- Cities with Customers but No Payments (Right Join)
SELECT C.city,
       COUNT(A.customer_id) AS customer_count,
       SUM(P.amount) AS total_payments
FROM city C
RIGHT JOIN address B ON C.city_id = B.city_id
RIGHT JOIN customer A ON B.address_id = A.address_id
LEFT JOIN payment P ON A.customer_id = P.customer_id
GROUP BY C.city
HAVING total_payments IS NULL;

-- Detailed Customer Information (Multi-Way Join)
SELECT A.customer_id,
       A.first_name,
       A.last_name,
       C.city,
       D.country,
       SUM(P.amount) AS total_payment
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id
INNER JOIN payment P ON A.customer_id = P.customer_id
GROUP BY A.customer_id, A.first_name, A.last_name, C.city, D.country
ORDER BY total_payment DESC
LIMIT 10;

-- Customers Who Never Made Payments (Anti Join)
SELECT A.customer_id,
       A.first_name,
       A.last_name
FROM customer A
LEFT JOIN payment P ON A.customer_id = P.customer_id
WHERE P.payment_id IS NULL;

-- Customers Who Rented vs. Customers Who Paid (Full Outer Join using UNION)
SELECT A.customer_id, A.first_name, 'Rented' AS activity
FROM customer A
INNER JOIN rental R ON A.customer_id = R.customer_id

UNION

SELECT A.customer_id, A.first_name, 'Paid' AS activity
FROM customer A
INNER JOIN payment P ON A.customer_id = P.customer_id;






