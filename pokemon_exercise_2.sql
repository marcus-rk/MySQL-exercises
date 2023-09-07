-- Makj0005
-- link til opgaver: https://nicklasdean.gitbook.io/ita2023-1.-semester/data-literacy/05-analysis-functions

USE pokemon;  -- use correct database

/* Q1: What is the average speed of all pokemon? (A: 68.9338) */ 
SELECT AVG(speed) AS average_speed
FROM pokemon;

/* Q2: How many pokemon are in the dataset? (A: 151) */
SELECT COUNT(*) AS total_pokemon
FROM pokemon;

/* Q3: What is the maximum primary type? (A: Water) */
SELECT 
	primary_type, 
	COUNT(primary_type) AS total
FROM pokemon
GROUP BY primary_type
ORDER BY total DESC;
-- LIMIT 1;

/* Q4: What is the minimum primary type? (A: Bug) 
Should be 'Fairy' or 'Ice' if u ask me :)
 */
SELECT 
	primary_type, 
	COUNT(primary_type) AS total
FROM pokemon
GROUP BY primary_type
ORDER BY total ASC;
-- LIMIT 1;

/* Q5: Why is 'Water' the maximum and 'Bug' the minimum? Make an informed guess */

/* Q6: What is the max speed of all pokemon? (A: 140) */
SELECT MAX(speed) AS max_speed
FROM pokemon;
          -- Could also be done like this:
SELECT speed AS max_speed
FROM pokemon
ORDER BY max_speed DESC
LIMIT 1;

/* Q7: What is the average speed of all pokemon with 'Ground' as primary type? (A: 58.1250) */
SELECT
	primary_type,
    AVG(speed) AS average_speed
FROM pokemon
WHERE primary_type = "Ground";

/* Q8: Display the average speed of each primary type of pokémon */
SELECT
	primary_type,
    AVG(speed) AS average_speed
FROM pokemon
GROUP BY primary_type
ORDER BY average_speed DESC;
