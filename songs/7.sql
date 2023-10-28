/*
In 7.sql, write a SQL query that returns the average energy of songs that are by Drake.
Your query should output a table with a single column and a single row containing the average energy.
You should not make any assumptions about what Drake’s artist_id is.
*/

SELECT AVG(energy) AS avrage FROM songs WHERE artist_id=(SELECT id FROM artists WHERE name='Drake');

/*
songs/ $ cat 7.sql | sqlite3 songs.db
+--------+
| avrage |
+--------+
| 0.599  |
+--------+
*/