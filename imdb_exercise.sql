-- Makj0005 
-- link til opgaver: https://nicklasdean.gitbook.io/ita2023-1.-semester/data-literacy/03-data-quality

USE imdb; -- use correct database
SET sql_safe_updates = 0;

SELECT *
FROM imdb;

/* Hvordan ser datasettet ud? Hvad beskriver det? 
Beskriver imdb information om film 

Identificer kolonner med NULL værdier?
- Color
- Director_Name
- Gross /salg
- Genre
- Budget

Hvilke kolonner har problemer med fejlværdier (ifht. deres skala / "umulige" værdier - fx. en tidslængde mindre end 0)
- duration
- Title_year
- imdb score
*/

/* Ret 3 NULL fejl i datasettet vha. UPDATE 
- Accuracy (ikke præcist)
- Time (ikke updateret)
*/
UPDATE imdb
SET color = 'Color'
WHERE movie_title = 'Batman v Superman: Dawn of Justice';

UPDATE imdb
SET genres = 'BiographyDramaHistory'
WHERE movie_title = 'Son of God';

UPDATE imdb
SET director_name = 'David Fincher'
WHERE movie_title = 'The Girl with the Dragon Tattoo';


/* Ret 3 umulige værdier () i datasettet vha. UPDATE 
- Semantisk: Tid kan ikke være under 0
- Semantisk: Årstal kan ikke være 205
- Semantisk: IMDB score kan ikke være under 0
*/
UPDATE imdb
SET duration = 150 /* negativt tal */
WHERE movie_title = 'The Hobbit: An Unexpected Journey';

UPDATE imdb
SET title_year = 2005 /* 205 */
WHERE movie_title = 'Child 44';

UPDATE imdb
SET title_year = 7.4 /* -7.4 */
WHERE movie_title = 'Cloud Atlas';
