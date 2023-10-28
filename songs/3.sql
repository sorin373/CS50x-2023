/*
* In 3.sql, write a SQL query to list the names of the top 5 longest songs, in descending order of length.
* Your query should output a table with a single column for the name of each song.
*/

SELECT name FROM songs ORDER BY duration_ms DESC LIMIT 5;

/*
songs/ $ cat 3.sql | sqlite3 songs.db
+-----------------------+
|         name          |
+-----------------------+
| Te Bote - Remix       |
| SICKO MODE            |
| Walk It Talk It       |
| Him & I (with Halsey) |
| Perfect               |
+-----------------------+
*/
