/*
* In 2.sql, write a SQL query to list the names of all songs in increasing order of tempo.
* Your query should output a table with a single column for the name of each song.
*/

SELECT name FROM songs ORDER BY tempo;

/*
songs/ $ cat 2.sql | sqlite3 songs.db
+---------------------------------------------------------+
|                          name                           |
+---------------------------------------------------------+
| changes                                                 |
| SAD!                                                    |
| God's Plan                                              |
| Feel It Still                                           |
| Criminal                                                |
| Lucid Dreams                                            |
| Him & I (with Halsey)                                   |
| Eastside (with Halsey & Khalid)                         |
| River (feat. Ed Sheeran)                                |
| In My Feelings                                          |
| Too Good At Goodbyes                                    |
| I Like Me Better                                        |
| These Days (feat. Jess Glynne, Macklemore & Dan Caplen) |
| Nice For What                                           |
| Flames                                                  |
| Vaina Loca                                              |
| Sin Pijama                                              |
| Bella                                                   |
| Me Niego                                                |
| 1, 2, 3 (feat. Jason Derulo & De La Ghetto)             |
| Plug Walk                                               |
| Perfect Duet (Ed Sheeran & Beyonc?)                     |
| Dura                                                    |
| Perfect                                                 |
| FRIENDS                                                 |
| Taki Taki (with Selena Gomez, Ozuna & Cardi B)          |
| Shape of You                                            |
| Echame La Culpa                                         |
| 2002                                                    |
| Te Bote - Remix                                         |
| All The Stars (with SZA)                                |
| IDGAF                                                   |
| Taste (feat. Offset)                                    |
| Siguelo Bailando                                        |
| Nevermind                                               |
| Ric Flair Drip (& Metro Boomin)                         |
| Happier                                                 |
| Pray For Me (with Kendrick Lamar)                       |
| Back To You - From 13 Reasons Why                       |
| Let Me Go (with Alesso, Florida Georgia Line & watt)    |
| Havana                                                  |
| Solo (feat. Demi Lovato)                                |
| I Miss You (feat. Julia Michaels)                       |
| Finesse (Remix) [feat. Cardi B]                         |
| Rise                                                    |
| The Middle                                              |
| What Lovers Do                                          |
| lovely (with Khalid)                                    |
| New Rules                                               |
| Yes Indeed                                              |
| Youngblood                                              |
| Body (feat. brando)                                     |
| no tears left to cry                                    |
| Promises (with Sam Smith)                               |
| Congratulations                                         |
| One Kiss (with Dua Lipa)                                |
| Wolves                                                  |
| Believer                                                |
| Girls Like You (feat. Cardi B)                          |
| Rewrite The Stars                                       |
| In My Mind                                              |
| FEFE (feat. Nicki Minaj & Murda Beatz)                  |
| Be Alright                                              |
| Jackie Chan                                             |
| Moonlight                                               |
| Never Be the Same                                       |
| Everybody Dies In Their Nightmares                      |
| Fuck Love (feat. Trippie Redd)                          |
| Freaky Friday (feat. Chris Brown)                       |
| Jocelyn Flores                                          |
| Call Out My Name                                        |
| No Brainer                                              |
| I Like It                                               |
| Young Dumb & Broke                                      |
| Look Alive (feat. Drake)                                |
| In My Blood                                             |
| Psycho (feat. Ty Dolla $ign)                            |
| Silence                                                 |
| Mine                                                    |
| I Fall Apart                                            |
| Love Lies (with Normani)                                |
| Better Now                                              |
| God is a woman                                          |
| Walk It Talk It                                         |
| Let You Down                                            |
| HUMBLE.                                                 |
| Meant to Be (feat. Florida Georgia Line)                |
| Nonstop                                                 |
| SICKO MODE                                              |
| XO TOUR Llif3                                           |
| rockstar (feat. 21 Savage)                              |
| Downtown                                                |
| Thunder                                                 |
| Dejala que vuelva (feat. Manuel Turizo)                 |
| Candy Paint                                             |
| Dusk Till Dawn - Radio Edit                             |
| X                                                       |
| Stir Fry                                                |
| This Is Me                                              |
| Corazon (feat. Nego do Borel)                           |
+---------------------------------------------------------+
*/