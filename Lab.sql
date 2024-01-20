-- 1. 

SELECT
    f.film_id,
    f.title,
    f.rental_duration,
    f.rental_rate,
    f.length,
    f.rating,
    f.special_features,
    COUNT(r.rental_id) AS total_rentals,
    AVG(DATEDIFF(r.return_date, r.rental_date)) AS avg_rental_duration,
    AVG(f.rental_rate) AS avg_rental_rate,
    AVG(f.rental_rate * DATEDIFF(r.return_date, r.rental_date)) AS avg_rental_revenue
FROM
    film f
JOIN
    inventory i ON f.film_id = i.film_id
JOIN
    rental r ON i.inventory_id = r.inventory_id
GROUP BY
    f.film_id,
    f.title,
    f.rental_duration,
    f.rental_rate,
    f.length,
    f.rating,
    f.special_features;
    
-- 4. 
SELECT
    f.film_id,
    f.title,
    IF(COUNT(r.rental_id) > 0, 1, 0) AS rented_last_month
FROM
    film f
LEFT JOIN
    inventory i ON f.film_id = i.film_id
LEFT JOIN
    rental rrentals_june ON i.inventory_id = r.inventory_id
    AND YEAR(r.rental_date) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH)
    AND MONTH(r.rental_date) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH)
GROUP BY
    f.film_id,
    f.title;