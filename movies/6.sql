/*
* In 6.sql, write a SQL query to determine the average rating of all movies released in 2012.
* Your query should output a table with a single column and a single row (not counting the header) containing the average rating.
*/

SELECT AVG(rating) AS avrage FROM ratings WHERE movie_id IN (SELECT id FROM movies WHERE year='2012');

/*
movies/ $ cat 6.sql | sqlite3 movies.db
+------------------+
|      avrage      |
+------------------+
| 6.29787154592979 |
+------------------+
*/