-- Base de Datos II - Clase 17
-- Alumno: Bruno Segura

USE sakila;

-- Ejercicio 1
SHOW INDEX FROM address;

SELECT address_id, address, postal_code
FROM address
WHERE postal_code IN ('35200', '17886', '53561');

SELECT address_id, address, postal_code
FROM address
WHERE postal_code NOT IN ('35200', '17886', '53561');

SELECT dir.address, dir.postal_code, ciudad.city, pais.country
FROM address dir
JOIN city ciudad ON dir.city_id = ciudad.city_id
JOIN country pais ON ciudad.country_id = pais.country_id
WHERE dir.postal_code IN ('35200', '17886', '53561');

-- Sin el indice

EXPLAIN ANALYZE
SELECT address_id, address, postal_code
FROM address
WHERE postal_code IN ('35200', '17886', '53561');

EXPLAIN ANALYZE
SELECT address_id, address, postal_code
FROM address
WHERE postal_code NOT IN ('35200', '17886', '53561');

EXPLAIN ANALYZE
SELECT dir.address, dir.postal_code, ciudad.city, pais.country
FROM address dir
JOIN city ciudad ON dir.city_id = ciudad.city_id
JOIN country pais ON ciudad.country_id = pais.country_id
WHERE dir.postal_code IN ('35200', '17886', '53561');

-- Agrego el indice al codigo postal
CREATE INDEX indice_codigo_postal ON address(postal_code);

-- Con el indice

EXPLAIN ANALYZE
SELECT address_id, address, postal_code
FROM address
WHERE postal_code IN ('35200', '17886', '53561');

EXPLAIN ANALYZE
SELECT address_id, address, postal_code
FROM address
WHERE postal_code NOT IN ('35200', '17886', '53561');

EXPLAIN ANALYZE
SELECT dir.address, dir.postal_code, ciudad.city, pais.country
FROM address dir
JOIN city ciudad ON dir.city_id = ciudad.city_id
JOIN country pais ON ciudad.country_id = pais.country_id
WHERE dir.postal_code IN ('35200', '17886', '53561');

-- Ejercicio 2

-- Comparo nombre y apellido
SHOW INDEX FROM actor;

SELECT * FROM actor
WHERE first_name = 'PENELOPE';

SELECT * FROM actor
WHERE last_name = 'GUINESS';

EXPLAIN ANALYZE
SELECT * FROM actor
WHERE first_name = 'PENELOPE';

EXPLAIN ANALYZE
SELECT * FROM actor
WHERE last_name = 'GUINESS';

-- Ejercicio 3
-- Busco la misma palabra de dos maneras

SELECT film_id, title, description
FROM film
WHERE description LIKE '%documentary%';

EXPLAIN ANALYZE
SELECT film_id, title, description
FROM film
WHERE description LIKE '%documentary%';

SHOW INDEX FROM film_text;

CREATE FULLTEXT INDEX indice_descripcion ON film_text(description);

SELECT film_id, title, description
FROM film_text
WHERE MATCH(description) AGAINST('documentary' IN NATURAL LANGUAGE MODE);

EXPLAIN ANALYZE
SELECT film_id, title, description
FROM film_text
WHERE MATCH(description) AGAINST('documentary' IN NATURAL LANGUAGE MODE);
