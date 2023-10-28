/*
* In 5.sql, write a SQL query that returns the average energy of all the songs.
* Your query should output a table with a single column and a single row containing the average energy.
*/

SELECT AVG(energy) AS avrage FROM songs;

/*
songs/ $ cat 5.sql | sqlite3 songs.db
+---------+
| avrage  |
+---------+
| 0.65906 |
+---------+
*/