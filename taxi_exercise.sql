-- Makj0005
-- link til opgave: https://nicklasdean.gitbook.io/ita2023-1.-semester/data-literacy/05-analysis-functions

USE taxi;  -- use correct database

/* When is the busiest time of the day (by the hour)? My Answer: hour 22 */
SELECT
	HOUR(tpep_pickup_datetime) AS `hour`,
    COUNT(*) AS hour_total
FROM trips
GROUP BY `hour`
ORDER BY hour_total DESC; 

/* What payment type has the highest fare amount on average? My Answer: payment_type 1 (Credit card) **/
SELECT
	payment_type,
    AVG(fare_amount) AS average_fare_amount
FROM trips
GROUP BY payment_type
ORDER BY average_fare_amount DESC;

/* At what time of day (by the hour) are the longest trips on average? My Answer: hour 5 */
SELECT
	HOUR(tpep_pickup_datetime) AS `hour`,
    AVG(trip_distance) AS average_trip_distance
FROM trips
GROUP BY `hour`
ORDER BY average_trip_distance DESC;
    
/* What are the average tip amount for each passenger count? */
SELECT
	passenger_count,
    AVG(tip_amount) AS average_tip_amount
FROM trips
GROUP BY passenger_count
ORDER BY average_tip_amount DESC;
/* Does more passengers mean more tips?
No, a passenger count of 4 tends to result in the most generous tippers.
(The max count of passengers in a taxi is 6 - which is actually the worst tippers)
*/

/* Advanced - Do longer turns mean more passengers? (?I think they mean tours/trips?) 
My Answer: Yes, longer tours/trips mean more passengers
*/
SELECT
    CASE
        WHEN trip_distance < 10 THEN 'Short Distance'
        WHEN trip_distance >= 10 AND trip_distance < 20 THEN 'Medium Distance'
        WHEN trip_distance >= 20 THEN 'Long Distance'
    END AS distance_range_enum,
    AVG(passenger_count) AS average_passenger_count
FROM trips
GROUP BY distance_range_enum
ORDER BY average_passenger_count DESC;

-- Read about CASE/WHEN/END: https://sql-bits.com/group-rows-by-a-range-of-values/
/* I've chosen the enum: short, medium and long distance and the trip_distance interval. This can
be set to whatever, but I think this makes the must sense in terms of the data given. 
*/

