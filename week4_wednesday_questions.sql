-- Week 4 - Wednesday Questions


-- 1. List all customers who live in Texas (use JOINs)
SELECT first_name, last_name, customer_id, district
FROM address as ac
JOIN customer as cus
ON cus.address_id = ac.address_id
WHERE ac.district = 'Texas';


-- 2. Get all payments above $6.99 with the Customer’s full name
SELECT cus.customer_id, cus.first_name, cus.last_name, pay.amount
FROM customer as cus
JOIN payment as pay
ON cus.customer_id = pay.customer_id
WHERE pay.amount > 6.99


-- 3. Show all customer names who have made payments over $175 (use subqueries)
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175
);


-- 4. List all customers that live in Nepal (use the city table)
SELECT cus.customer_id, cus.first_name, cus.last_name, coun.country
FROM customer as cus
JOIN address as ares
ON cus.address_id = ares.address_id
JOIN city as cit
ON cit.city_id = ares.city_id
JOIN country as coun
ON cit.country_id = coun.country_id
WHERE coun.country = 'Nepal';


-- 5. Which staff member had the most transactions?
-- Jon Stephens had the most transactions. 
SELECT staff.staff_id, staff.first_name, staff.last_name, COUNT(*)
FROM staff
JOIN payment as pay
ON staff.staff_id = pay.staff_id
GROUP BY staff.staff_id, staff.first_name, staff.last_name
ORDER BY COUNT(*) DESC;


-- 6. What film had the most actors in it?
-- Movie name : Lambs Cincinatti
-- 15 actors 
SELECT title
FROM film
WHERE film_id in (
	SELECT film_id
	FROM film_actor
	GROUP BY film_id
	ORDER BY COUNT(*) DESC
	LIMIT 1);


-- 7. Which actor has been in the least movies?
-- Emily has been in the least movies 
SELECT first_name, last_name
FROM actor 
WHERE actor_id IN (
SELECT actor_id
	FROM film_actor
	GROUP BY actor_id
	ORDER BY COUNT(*)
	LIMIT 1
);

-- 8. How many districts have more than 5 customers in it?
-- Nine in total 
SELECT district, COUNT(*)
FROM address
GROUP BY district
HAVING COUNT(*) > 5;