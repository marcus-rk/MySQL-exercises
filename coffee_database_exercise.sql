-- Makj0005 
-- link til opgaver: https://nicklasdean.gitbook.io/ita2023-1.-semester/data-literacy/04-joins

/* Notice that the 'gender' datatype is an ENUM - What is an enum? How does it work? 
Det er en form for label/keyword eller konstant ligesom Gender kan være Male eller Female 
*/

USE coffee_database;  -- use correct database

/* Select the order_table id and the customers phone number for all orders of product id 3 */
SELECT 
	OT.order_table_id,
	CU.phone_number
FROM order_table AS OT
INNER JOIN customer AS CU
	ON OT.customer_id = CU.customer_id
INNER JOIN product AS P
	ON OT.product_id = P.product_id
WHERE P.product_id = 3;

/* Select product names and order time for the espresso coffees sold between January 15th 2021 and February 14th 2021 */
SELECT
	P.`name`,
	OT.order_table_datetime
FROM order_table AS OT
INNER JOIN product AS P
	ON P.product_id = OT.product_id
WHERE P.product_id = 1 /* Espresso */
	AND DATE(OT.order_table_datetime) BETWEEN '2021-01-15' AND '2021-02-14';  /* No time interval */

/* Select the product name and price and order time for all orders from females in February 2021 */
SELECT
	P.`name`,
	P.price,
	OT.order_table_datetime,
	CU.gender
FROM order_table AS OT
INNER JOIN product AS P
	ON P.product_id = OT.product_id
INNER JOIN customer AS CU
	ON OT.customer_id = CU.customer_id
WHERE gender = 'F'
	AND MONTH(OT.order_table_datetime) = 2 /* February */
	AND YEAR(OT.order_table_datetime) = 2021; 

/* From the products table, select the name for all products that have a price greater than 30 or a coffee origin of Sri Lanka */
SELECT
	P.`name` AS product_name,
	P.price,
	CO.country_id,
	CO.country AS country_name
FROM product AS P
INNER JOIN country AS CO
	ON P.country_id = CO.country_id
WHERE P.price > 30 OR CO.country_id = 6;

/* From the products table, select the name and price of all produts with a coffee origin equal to Colombia or Sverige. Ordered by name from A-Z */
SELECT
	P.`name` AS product_name,
	P.price
FROM product AS P
INNER JOIN country AS CO
	ON P.country_id = CO.country_id
WHERE CO.country_id = 2 OR CO.country_id = 5 /* Colombia and Sweden */
ORDER BY P.`name` ASC;

/* From the orders table, select all the orders from February 2021 for customers with id's 2, 4, 6 or 8 */
SELECT
	OT.order_table_datetime,
	OT.order_table_id,
	OT.product_id,
	OT.customer_id,
	OT.qty AS product_quantity
FROM order_table AS OT
INNER JOIN customer AS CU
	ON OT.customer_id = CU.customer_id
WHERE CU.customer_id IN (2,4,6,8)
	AND MONTH(OT.order_table_datetime) = 2 /* February */
	AND YEAR(OT.order_table_datetime) = 2021
ORDER BY OT.order_table_datetime ASC;

/* From the customers table, select the first name and phone number of all customers who's last name containing the pattern "ar" */
SELECT
	C.firstname,
	C.lastname,
	C.phone_number
FROM customer AS C
WHERE C.lastname LIKE '%AR%';

/* From the customers table, select the distinct last names and order alphabetically from A-Z */
SELECT DISTINCT C.lastname /* no ducplicates */
FROM customer AS C
ORDER BY C.lastname ASC;

/* From the orders table, select the first 3 orders placed by customer with id 1 in February 2021 */
SELECT 
	OT.order_table_id,
	OT.product_id,
	OT.customer_id,
	OT.qty AS product_quantity,
	OT.order_table_datetime
FROM order_table AS OT
INNER JOIN customer AS CU
	ON OT.customer_id = CU.customer_id
WHERE CU.customer_id = 1
	AND MONTH(OT.order_table_datetime) = 2 /* February */
	AND YEAR(OT.order_table_datetime) = 2021
ORDER BY OT.order_table_datetime ASC
LIMIT 3;

/* From the products table, select the name, price and cofee origin but rename the price to retail_price in the results set */
SELECT
	P.`name`,
	P.price AS retail_price,
	CO.country
FROM product AS P
INNER JOIN country AS CO
	ON P.country_id = CO.country_id;
