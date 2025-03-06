-- Top 5 Paying Customers from Top 10 Cities
SELECT A.customer_id,
       A.first_name,
       A.last_name,
       C.city,
       D.country,
       SUM(E.amount) AS total_amount_paid
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id
INNER JOIN payment E ON A.customer_id = E.customer_id
WHERE C.city IN ('Aurora', 'Acua', 'Citrus Heights', 'Iwaki', 'Ambattur',
                 'Shanwei', 'So Leopoldo', 'Teboksary', 'Tianjin', 'Cianjur')
GROUP BY A.customer_id, A.first_name, A.last_name, C.city, D.country
ORDER BY total_amount_paid DESC
LIMIT 5;

-- Top 10 Customers by Total Payments
SELECT A.customer_id,
       A.first_name,
       A.last_name,
       SUM(E.amount) AS total_amount_paid
FROM customer A
INNER JOIN payment E ON A.customer_id = E.customer_id
GROUP BY A.customer_id, A.first_name, A.last_name
ORDER BY total_amount_paid DESC
LIMIT 10;

-- Top 5 Customers by Average Payment Amount
SELECT A.customer_id,
       A.first_name,
       A.last_name,
       AVG(E.amount) AS average_payment
FROM customer A
INNER JOIN payment E ON A.customer_id = E.customer_id
GROUP BY A.customer_id, A.first_name, A.last_name
ORDER BY average_payment DESC
LIMIT 5;

-- Total Payment Breakdown for Top Customers (By City and Country)
SELECT C.city,
       D.country,
       SUM(E.amount) AS total_city_payment
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id
INNER JOIN payment E ON A.customer_id = E.customer_id
GROUP BY C.city, D.country
ORDER BY total_city_payment DESC
LIMIT 10;

-- Top 5 Customers by Payment Frequency
SELECT A.customer_id,
       A.first_name,
       A.last_name,
       COUNT(E.payment_id) AS payment_frequency
FROM customer A
INNER JOIN payment E ON A.customer_id = E.customer_id
GROUP BY A.customer_id, A.first_name, A.last_name
ORDER BY payment_frequency DESC
LIMIT 5;

-- Customer Retention Analysis for Top Customers
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
SELECT COUNT(*) / (SELECT COUNT(*) FROM customer) * 100 AS retention_rate
FROM active_customers;




