-- Average Amount Paid by Top 5 Customers
WITH top_customers AS (
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
    LIMIT 5
)
SELECT AVG(total_amount_paid) AS average_payment
FROM top_customers;

-- Top 5 Customers Distribution by Country
SELECT D.country, 
       COUNT(DISTINCT A.customer_id) AS all_customer_count,
       COUNT(top_5_customers.customer_id) AS top_customer_count
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id
LEFT JOIN (
    SELECT A.customer_id
    FROM customer A
    INNER JOIN address B ON A.address_id = B.address_id
    INNER JOIN city C ON B.city_id = C.city_id
    INNER JOIN country D ON C.country_id = D.country_id
    INNER JOIN payment E ON A.customer_id = E.customer_id
    WHERE C.city IN ('Aurora', 'Acua', 'Citrus Heights', 'Iwaki', 'Ambattur',
                     'Shanwei', 'So Leopoldo', 'Teboksary', 'Tianjin', 'Cianjur')
    GROUP BY A.customer_id
    ORDER BY SUM(E.amount) DESC
    LIMIT 5
) AS top_5_customers ON A.customer_id = top_5_customers.customer_id
GROUP BY D.country
ORDER BY all_customer_count DESC
LIMIT 5;
