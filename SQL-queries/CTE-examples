-- Average Payment per Customer (Simple CTE)
WITH customer_payments AS (
    SELECT A.customer_id,
           SUM(E.amount) AS total_payment
    FROM customer A
    INNER JOIN payment E ON A.customer_id = E.customer_id
    GROUP BY A.customer_id
)
SELECT AVG(total_payment) AS avg_payment_per_customer
FROM customer_payments;

-- Monthly and Yearly Revenue Comparison (Multiple CTEs)
WITH monthly_revenue AS (
    SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month,
           SUM(amount) AS monthly_total
    FROM payment
    GROUP BY month
),
yearly_revenue AS (
    SELECT YEAR(payment_date) AS year,
           SUM(amount) AS yearly_total
    FROM payment
    GROUP BY year
)
SELECT M.month, M.monthly_total, Y.yearly_total
FROM monthly_revenue M
CROSS JOIN yearly_revenue Y
WHERE YEAR(M.month) = Y.year
ORDER BY M.month;

-- Customer Referral Hierarchy (Recursive CTE)
WITH RECURSIVE referral_hierarchy AS (
    SELECT customer_id, first_name, referred_by
    FROM customer
    WHERE referred_by IS NULL  -- Root level (no referrer)
    
    UNION ALL
    
    SELECT C.customer_id, C.first_name, C.referred_by
    FROM customer C
    INNER JOIN referral_hierarchy RH ON C.referred_by = RH.customer_id
)
SELECT * FROM referral_hierarchy ORDER BY referred_by, customer_id;

-- Top 5 Cities by Total Payments (Aggregating CTE)
WITH city_payments AS (
    SELECT C.city,
           SUM(P.amount) AS total_payment
    FROM payment P
    INNER JOIN customer A ON P.customer_id = A.customer_id
    INNER JOIN address B ON A.address_id = B.address_id
    INNER JOIN city C ON B.city_id = C.city_id
    GROUP BY C.city
)
SELECT city, total_payment
FROM city_payments
ORDER BY total_payment DESC
LIMIT 5;

-- Top Customers by Country (CTE with JOIN)
WITH customer_payments AS (
    SELECT A.customer_id,
           D.country,
           SUM(E.amount) AS total_payment
    FROM customer A
    INNER JOIN payment E ON A.customer_id = E.customer_id
    INNER JOIN address B ON A.address_id = B.address_id
    INNER JOIN city C ON B.city_id = C.city_id
    INNER JOIN country D ON C.country_id = D.country_id
    GROUP BY A.customer_id, D.country
)
SELECT country, MAX(total_payment) AS top_payment
FROM customer_payments
GROUP BY country
ORDER BY top_payment DESC;

-- Rank Customers by Payment Amount (CTE for Ranking)
WITH ranked_customers AS (
    SELECT A.customer_id,
           A.first_name,
           A.last_name,
           SUM(E.amount) AS total_payment,
           RANK() OVER (ORDER BY SUM(E.amount) DESC) AS payment_rank
    FROM customer A
    INNER JOIN payment E ON A.customer_id = E.customer_id
    GROUP BY A.customer_id, A.first_name, A.last_name
)
SELECT * FROM ranked_customers WHERE payment_rank <= 5;

-- Average Payment for Top Cities (Nested CTE)
WITH top_cities AS (
    SELECT C.city,
           SUM(P.amount) AS total_payment
    FROM payment P
    INNER JOIN customer A ON P.customer_id = A.customer_id
    INNER JOIN address B ON A.address_id = B.address_id
    INNER JOIN city C ON B.city_id = C.city_id
    GROUP BY C.city
    ORDER BY total_payment DESC
    LIMIT 5
),
city_payments AS (
    SELECT P.amount, C.city
    FROM payment P
    INNER JOIN customer A ON P.customer_id = A.customer_id
    INNER JOIN address B ON A.address_id = B.address_id
    INNER JOIN city C ON B.city_id = C.city_id
    WHERE C.city IN (SELECT city FROM top_cities)
)
SELECT city, AVG(amount) AS avg_payment
FROM city_payments
GROUP BY city;

-- Active Customers with Payments Every Month (CTE for Filtering)
WITH monthly_payments AS (
    SELECT A.customer_id,
           DATE_FORMAT(E.payment_date, '%Y-%m') AS month
    FROM customer A
    INNER JOIN payment E ON A.customer_id = E.customer_id
    WHERE YEAR(E.payment_date) = 2024
    GROUP BY A.customer_id, month
),
active_customers AS (
    SELECT customer_id
    FROM monthly_payments
    GROUP BY customer_id
    HAVING COUNT(DISTINCT month) = 12
)
SELECT * FROM active_customers;





