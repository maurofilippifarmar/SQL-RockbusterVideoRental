-- Top 5 Customers by Total Payments (Non-Correlated Subquery)
SELECT A.customer_id, A.first_name, A.last_name, SUM(E.amount) AS total_payment
FROM customer A
INNER JOIN payment E ON A.customer_id = E.customer_id
WHERE A.customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 5
)
GROUP BY A.customer_id, A.first_name, A.last_name
ORDER BY total_payment DESC;

-- Customers with Payments Above Average (Correlated Subquery)
SELECT A.customer_id, A.first_name, A.last_name, SUM(E.amount) AS total_payment
FROM customer A
INNER JOIN payment E ON A.customer_id = E.customer_id
GROUP BY A.customer_id, A.first_name, A.last_name
HAVING SUM(E.amount) > (
    SELECT AVG(SUM(E2.amount))
    FROM payment E2
    GROUP BY E2.customer_id
);

-- Customers from Top 5 Cities (Subquery in WHERE Clause)
SELECT A.customer_id, A.first_name, A.last_name, C.city
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
WHERE C.city IN (
    SELECT C2.city
    FROM city C2
    INNER JOIN address B2 ON C2.city_id = B2.city_id
    INNER JOIN customer A2 ON B2.address_id = A2.address_id
    INNER JOIN payment P2 ON A2.customer_id = P2.customer_id
    GROUP BY C2.city
    ORDER BY SUM(P2.amount) DESC
    LIMIT 5
)
ORDER BY C.city;

-- Payment Count per Customer (Subquery in SELECT Clause)
SELECT A.customer_id,
       A.first_name,
       A.last_name,
       (SELECT COUNT(E.payment_id)
        FROM payment E
        WHERE E.customer_id = A.customer_id) AS payment_count
FROM customer A
ORDER BY payment_count DESC
LIMIT 5;

-- Customers Who Rented and Paid (Subquery with EXISTS)
SELECT A.customer_id, A.first_name, A.last_name
FROM customer A
WHERE EXISTS (
    SELECT 1
    FROM rental R
    WHERE R.customer_id = A.customer_id
) AND EXISTS (
    SELECT 1
    FROM payment P
    WHERE P.customer_id = A.customer_id
);






