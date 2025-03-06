-- Top 10 Countries by Customer Numbers
SELECT D.country,
       COUNT(A.customer_id) AS customer_count
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id
GROUP BY D.country
ORDER BY customer_count DESC
LIMIT 10;

-- Top 10 Cities in Top 10 Countries
SELECT D.country, C.city,
       COUNT(A.customer_id) AS customer_count
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id
WHERE D.country IN ('India', 'China', 'United States', 'Japan', 'Mexico', 
                    'Brazil', 'Russian Federation', 'Philippines', 'Turkey', 'Indonesia')
GROUP BY D.country, C.city
ORDER BY customer_count DESC
LIMIT 10;
