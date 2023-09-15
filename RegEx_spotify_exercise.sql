-- Makj0005 
-- link til opgaver: https://nicklasdean.gitbook.io/ita2023-1.-semester/data-literacy/06-analysis-subqueries

USE spotify;  -- use correct database

/* How many artist have numbers in their artist name? (RegEx)*/
SELECT COUNT(DISTINCT artist) AS total -- No duplicates
FROM spotify
WHERE artist REGEXP '\\d';

/* How many distinct artists either start with a number ?OR? ends with a number? */
SELECT COUNT(DISTINCT artist) AS total -- No duplicates
FROM spotify
WHERE artist REGEXP '^\\d|\\d$';

/* How many songs have features? (feat.) OR (with) OR (Featuring) */
SELECT COUNT(*) AS total_features
FROM spotify
WHERE song REGEXP '\\bfeat\\.\\b|\\bfeat\\b' -- feat. or feat
   OR song REGEXP '\\b\\(with\\b' -- (with
   OR song REGEXP '\\bFeaturing\\b'; -- Featuring