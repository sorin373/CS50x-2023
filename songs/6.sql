/*
* In 6.sql, write a SQL query that lists the names of songs that are by Post Malone.
* Your query should output a table with a single column for the name of each song.
* You should not make any assumptions about what Post Malone’s artist_id is.
*/

SELECT name FROM songs WHERE artist_id=(SELECT id FROM artists WHERE name='Post Malone');

/*
songs/ $ cat 6.sql | sqlite3 songs.db
+------------------------------+
|             name             |
+------------------------------+
| rockstar (feat. 21 Savage)   |
| Psycho (feat. Ty Dolla $ign) |
| Better Now                   |
| I Fall Apart                 |
| Candy Paint                  |
| Congratulations              |
+------------------------------+
*/