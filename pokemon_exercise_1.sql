-- Makj0005 
-- link til opgaver: https://nicklasdean.gitbook.io/ita2023-1.-semester/data-literacy/02-types-and-scales

USE pokemon;  -- use correct database

/* Exercise 3.1 - All pokemons with all their columns */
SELECT *
FROM pokemon;

/* Exercise 3.2 - Only the name of all pokemons */
SELECT `name`
FROM pokemon;

/* Exercise 3.3 - All pokemons with grass type (as primary or secondary type) */
SELECT `name`,
primary_type,
secondary_type
FROM pokemon
WHERE primary_type = 'Grass' 
OR secondary_type = 'Grass';

/* Exercise 3.4 - All pokemons with a speed above 56 */
SELECT `name`, speed
FROM pokemon
WHERE speed > 56;

/* Exercise 3.5 - All pokemons with a secondary type */
SELECT `name`, secondary_type
FROM pokemon
WHERE secondary_type != 'NULL';
		/* ?? Kunne løses sådan, hvis NULL i tabellen IKKE var string 'null' ?? */
SELECT `name`, secondary_type
FROM pokemon
WHERE secondary_type IS NOT NULL;

/* Exercise 4.1 - Name of all pokemons with a special defence less than 56
 and a special attack higher than 65 */
 SELECT `name`,
 special_defence,
 special_attack
 FROM pokemon
 WHERE special_defence < 56 
 AND special_attack > 65;
 
 /* Exercise 4.2 - All grass type pokemons starting with the letter 'B' */
 SELECT `name`,
 primary_type,
 secondary_type
 FROM pokemon
 WHERE (primary_type = 'Grass' OR secondary_type = 'Grass') 
 AND `name` LIKE 'B%';

/* Exercise 4.3 - All fire or ground pokemons with an attack higher than 50 */
SELECT `name`,
 primary_type,
 secondary_type,
 attack
 FROM pokemon
 WHERE (primary_type = 'Fire' OR primary_type = 'Ground') 
 OR (secondary_type = 'Fire' OR secondary_type = 'Ground') 
 AND attack > 50;
 
 /* Exercise 4.4 - The first 10 pokemons by pokedex number ordered by their speed */
 SELECT `name`,
 pokedex_number,
 speed
 FROM pokemon
 WHERE pokedex_number BETWEEN 1 AND 10
 ORDER BY speed DESC;
                     /* Kan f.eks. også løses sådan */
 SELECT `name`,
 pokedex_number,
 speed
 FROM pokemon
 WHERE pokedex_number IN (1,2,3,4,5,6,7,8,9,10)
 ORDER BY speed DESC;
 
 /* Exercise Advanced 1 - All pokemons without a secondary type,
 starting with 'P' with an attack or defence above 40 */
 SELECT `name`,
 secondary_type,
 attack,
 defence
 FROM pokemon
 WHERE secondary_type = 'NULL' 
 AND `name` LIKE 'P%' 
 AND (attack > 40 OR defence > 40);
 
 /* Exercise Advanced 2 - The 10 pokemons with the highest attack */
 SELECT `name`, attack
 FROM pokemon
 ORDER BY attack DESC
 LIMIT 10;
 
 /* Exercise Advanced 3 - All pokemons that contains the letter 'C' 
 in their name - ordered alphabetically */
 SELECT `name`
 FROM pokemon
 WHERE `name` LIKE '%C%'
 ORDER BY `name` ASC;
