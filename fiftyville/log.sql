-- Keep a log of any SQL queries you execute as you solve the mystery.
-- The theft took place on July 28, 2021 and that it took place on Humphrey Street.

-- Get crime description

SELECT description FROM crime_scene_reports
WHERE month=7 AND day=28 AND year=2021 AND street='Humphrey Street';

/*
* Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery.
* Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery. |
* Littering took place at 16:36. No known witnesses.
*/

-- Get witnesses + transcripts

SELECT name, transcript FROM interviews
WHERE month=7 AND day=28 AND year=2021;

/*
| Jose    | “Ah,” said he, “I forgot that I had not seen you for some weeks. It is a little souvenir from the King of Bohemia in return for my assistance in the case of the Irene Adler papers.”                                                                                                                               |
| Eugene  | “I suppose,” said Holmes, “that when Mr. Windibank came back from France he was very annoyed at your having gone to the ball.”                                                                                                                                                                                      |
| Barbara | “You had my note?” he asked with a deep harsh voice and a strongly marked German accent. “I told you that I would call.” He looked from one to the other of us, as if uncertain which to address.                                                                                                                   |
| Ruth    | Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.                                                          |
| Eugene  | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.                                                                                                 |
| Raymond | As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket. |
| Lily    | Our neighboring courthouse has a very annoying rooster that crows loudly at 6am every day. My sons Robert and Patrick took the rooster to a city far, far away, so it may never bother us again. My sons have successfully arrived in Paris.
*/

-- Search license plate

SELECT * FROM bakery_security_logs
WHERE month=7 AND day=28 AND year=2021 AND hour=10 AND minute<=25 AND minute>=15 AND activity='exit';

/*
+-----+------+-------+-----+------+--------+----------+---------------+
| id  | year | month | day | hour | minute | activity | license_plate |
+-----+------+-------+-----+------+--------+----------+---------------+
| 260 | 2021 | 7     | 28  | 10   | 16     | exit     | 5P2BI95       |
| 261 | 2021 | 7     | 28  | 10   | 18     | exit     | 94KL13X       |
| 262 | 2021 | 7     | 28  | 10   | 18     | exit     | 6P58WS2       |
| 263 | 2021 | 7     | 28  | 10   | 19     | exit     | 4328GD8       |
| 264 | 2021 | 7     | 28  | 10   | 20     | exit     | G412CB7       |
| 265 | 2021 | 7     | 28  | 10   | 21     | exit     | L93JTIZ       |
| 266 | 2021 | 7     | 28  | 10   | 23     | exit     | 322W7JE       |
| 267 | 2021 | 7     | 28  | 10   | 23     | exit     | 0NTHK55       |
+-----+------+-------+-----+------+--------+----------+---------------+
*/

-- search people by license plate

SELECT * FROM people
WHERE license_plate IN (
    SELECT license_plate FROM bakery_security_logs
    WHERE month=7 AND day=28 AND year=2021 AND hour=10 AND minute<=25 AND minute>=15 AND activity='exit'
);

/*
+--------+---------+----------------+-----------------+---------------+
|   id   |  name   |  phone_number  | passport_number | license_plate |
+--------+---------+----------------+-----------------+---------------+
| 221103 | Vanessa | (725) 555-4692 | 2963008352      | 5P2BI95       |
| 243696 | Barry   | (301) 555-4174 | 7526138472      | 6P58WS2       |
| 396669 | Iman    | (829) 555-5269 | 7049073643      | L93JTIZ       |
| 398010 | Sofia   | (130) 555-0289 | 1695452385      | G412CB7       |
| 467400 | Luca    | (389) 555-5198 | 8496433585      | 4328GD8       |
| 514354 | Diana   | (770) 555-1861 | 3592750733      | 322W7JE       |
| 560886 | Kelsey  | (499) 555-9472 | 8294398571      | 0NTHK55       |
| 686048 | Bruce   | (367) 555-5533 | 5773159633      | 94KL13X       |
+--------+---------+----------------+-----------------+---------------+
*/

-- Get ATM logs at that time

SELECT * FROM people
WHERE id IN(
    SELECT person_id FROM bank_accounts
    WHERE account_number IN (
        SELECT account_number FROM atm_transactions
        WHERE month=7 AND day=28 AND year=2021 AND atm_location='Leggett Street' AND transaction_type="withdraw"
    )
);

/*
+--------+---------+----------------+-----------------+---------------+
|   id   |  name   |  phone_number  | passport_number | license_plate |
+--------+---------+----------------+-----------------+---------------+
| 395717 | Kenny   | (826) 555-1652 | 9878712108      | 30G67EN       |
| 396669 | Iman    | (829) 555-5269 | 7049073643      | L93JTIZ       |
| 438727 | Benista | (338) 555-6650 | 9586786673      | 8X428L0       |
| 449774 | Taylor  | (286) 555-6063 | 1988161715      | 1106N58       |
| 458378 | Brooke  | (122) 555-4581 | 4408372428      | QX4YZN3       |
| 467400 | Luca    | (389) 555-5198 | 8496433585      | 4328GD8       |
| 514354 | Diana   | (770) 555-1861 | 3592750733      | 322W7JE       |
| 686048 | Bruce   | (367) 555-5533 | 5773159633      | 94KL13X       |
+--------+---------+----------------+-----------------+---------------+
*/

-- Get phone logs

SELECT * FROM phone_calls
WHERE month=7 AND day=28 AND year=2021 AND duration<60;

/*
+-----+----------------+----------------+------+-------+-----+----------+
| id  |     caller     |    receiver    | year | month | day | duration |
+-----+----------------+----------------+------+-------+-----+----------+
| 221 | (130) 555-0289 | (996) 555-8899 | 2021 | 7     | 28  | 51       |
| 224 | (499) 555-9472 | (892) 555-8872 | 2021 | 7     | 28  | 36       |
| 233 | (367) 555-5533 | (375) 555-8161 | 2021 | 7     | 28  | 45       |
| 251 | (499) 555-9472 | (717) 555-1342 | 2021 | 7     | 28  | 50       |
| 254 | (286) 555-6063 | (676) 555-6554 | 2021 | 7     | 28  | 43       |
| 255 | (770) 555-1861 | (725) 555-3243 | 2021 | 7     | 28  | 49       |
| 261 | (031) 555-6622 | (910) 555-3251 | 2021 | 7     | 28  | 38       |
| 279 | (826) 555-1652 | (066) 555-9701 | 2021 | 7     | 28  | 55       |
| 281 | (338) 555-6650 | (704) 555-2131 | 2021 | 7     | 28  | 54       |
+-----+----------------+----------------+------+-------+-----+----------+
*/

-- Get potential callers

SELECT * FROM people
WHERE phone_number IN (
    SELECT caller FROM phone_calls WHERE month=7 AND day=28 AND year=2021 AND duration<60
);

/*
+--------+---------+----------------+-----------------+---------------+
|   id   |  name   |  phone_number  | passport_number | license_plate |
+--------+---------+----------------+-----------------+---------------+
| 395717 | Kenny   | (826) 555-1652 | 9878712108      | 30G67EN       |
| 398010 | Sofia   | (130) 555-0289 | 1695452385      | G412CB7       |
| 438727 | Benista | (338) 555-6650 | 9586786673      | 8X428L0       |
| 449774 | Taylor  | (286) 555-6063 | 1988161715      | 1106N58       |
| 514354 | Diana   | (770) 555-1861 | 3592750733      | 322W7JE       |
| 560886 | Kelsey  | (499) 555-9472 | 8294398571      | 0NTHK55       |
| 686048 | Bruce   | (367) 555-5533 | 5773159633      | 94KL13X       |
| 907148 | Carina  | (031) 555-6622 | 9628244268      | Q12B3Z3       |
+--------+---------+----------------+-----------------+---------------+
*/

-- Get potential receivers

SELECT * FROM people
WHERE phone_number IN (
    SELECT receiver FROM phone_calls WHERE month=7 AND day=28 AND year=2021 AND duration<60
);

/*
+--------+------------+----------------+-----------------+---------------+
|   id   |    name    |  phone_number  | passport_number | license_plate |
+--------+------------+----------------+-----------------+---------------+
| 250277 | James      | (676) 555-6554 | 2438825627      | Q13SVG6       |
| 251693 | Larry      | (892) 555-8872 | 2312901747      | O268ZZ0       |
| 484375 | Anna       | (704) 555-2131 | NULL            | NULL          |
| 567218 | Jack       | (996) 555-8899 | 9029462229      | 52R0Y8U       |
| 626361 | Melissa    | (717) 555-1342 | 7834357192      | NULL          |
| 712712 | Jacqueline | (910) 555-3251 | NULL            | 43V0R5D       |
| 847116 | Philip     | (725) 555-3243 | 3391710505      | GW362R6       |
| 864400 | Robin      | (375) 555-8161 | NULL            | 4V16VO0       |
| 953679 | Doris      | (066) 555-9701 | 7214083635      | M51FA04       |
+--------+------------+----------------+-----------------+---------------+
*/

-- Get transaction + details about the receiver

SELECT
A.id,
A.account_number,
A.year,
A.month,
A.day,
A.transaction_type,
B.person_id,
C.name,
C.phone_number
FROM atm_transactions A
INNER JOIN bank_accounts B ON A.account_number=B.account_number
INNER JOIN people C ON B.person_id=C.id
WHERE A.account_number IN (
    SELECT account_number FROM bank_accounts
    WHERE person_id IN (
        SELECT id FROM people
        WHERE phone_number IN (
            SELECT receiver FROM phone_calls WHERE month=7 AND day=28 AND year=2021 AND duration<60
        )
    )
) AND month=7 AND (day=28 OR day=29) AND year=2021 AND A.transaction_type='deposit';

/*
+-----+----------------+------+-------+-----+------------------+-----------+--------+----------------+
| id  | account_number | year | month | day | transaction_type | person_id |  name  |  phone_number  |
+-----+----------------+------+-------+-----+------------------+-----------+--------+----------------+
| 494 | 47746428       | 2021 | 7     | 29  | deposit          | 847116    | Philip | (725) 555-3243 |
| 308 | 69638157       | 2021 | 7     | 28  | deposit          | 567218    | Jack   | (996) 555-8899 |
| 393 | 69638157       | 2021 | 7     | 29  | deposit          | 567218    | Jack   | (996) 555-8899 |
| 399 | 72161631       | 2021 | 7     | 29  | deposit          | 251693    | Larry  | (892) 555-8872 |
| 551 | 72161631       | 2021 | 7     | 29  | deposit          | 251693    | Larry  | (892) 555-8872 |
| 417 | 94751264       | 2021 | 7     | 29  | deposit          | 864400    | Robin  | (375) 555-8161 |
+-----+----------------+------+-------+-----+------------------+-----------+--------+----------------+
*/

-- Get people by phone no. and licese plate

SELECT * FROM people
    WHERE license_plate IN (
        SELECT license_plate FROM bakery_security_logs WHERE month=7 AND day=28 AND year=2021 AND hour=10 AND minute<=25 AND minute>=15 AND activity='exit'
    ) and phone_number IN (
        SELECT caller FROM phone_calls WHERE month=7 AND day=28 AND year=2021 AND duration<60
    );

/*
+--------+--------+----------------+-----------------+---------------+
|   id   |  name  |  phone_number  | passport_number | license_plate |
+--------+--------+----------------+-----------------+---------------+
| 398010 | Sofia  | (130) 555-0289 | 1695452385      | G412CB7       |
| 514354 | Diana  | (770) 555-1861 | 3592750733      | 322W7JE       |
| 560886 | Kelsey | (499) 555-9472 | 8294398571      | 0NTHK55       |
| 686048 | Bruce  | (367) 555-5533 | 5773159633      | 94KL13X       |
+--------+--------+----------------+-----------------+---------------+
*/

-- Get flight list

SELECT * FROM flights
WHERE origin_airport_id IN (
    SELECT id FROM airports WHERE city='Fiftyville'
) AND month=7 AND day=29 AND year=2021 ORDER BY hour LIMIT 1;

/*
+----+-------------------+------------------------+------+-------+-----+------+--------+
| id | origin_airport_id | destination_airport_id | year | month | day | hour | minute |
+----+-------------------+------------------------+------+-------+-----+------+--------+
| 36 | 8                 | 4                      | 2021 | 7     | 29  | 8    | 20     |
+----+-------------------+------------------------+------+-------+-----+------+--------+
*/

-- Get destination

SELECT * FROM airports
WHERE id='4';

/*
+----+--------------+-------------------+---------------+
| id | abbreviation |     full_name     |     city      |
+----+--------------+-------------------+---------------+
| 4  | LGA          | LaGuardia Airport | New York City |
+----+--------------+-------------------+---------------+
*/

-- Get passengers

SELECT * FROM passengers WHERE flight_id=36;

/*
+-----------+-----------------+------+
| flight_id | passport_number | seat |
+-----------+-----------------+------+
| 36        | 7214083635      | 2A   |
| 36        | 1695452385      | 3B   |
| 36        | 5773159633      | 4A   |
| 36        | 1540955065      | 5C   |
| 36        | 8294398571      | 6C   |
| 36        | 1988161715      | 6D   |
| 36        | 9878712108      | 7A   |
| 36        | 8496433585      | 7B   |
+-----------+-----------------+------+
*/

-- Get passengers details by phone_nummber, flight id and licese plate

SELECT * FROM people WHERE passport_number IN (
    SELECT passport_number FROM passengers WHERE flight_id=36
) AND id IN (
    SELECT DISTINCT id FROM people
    WHERE license_plate IN (
        SELECT license_plate FROM bakery_security_logs WHERE month=7 AND day=28 AND year=2021 AND hour=10 AND minute<=25 AND minute>=15 AND activity='exit'
    ) and phone_number IN (
        SELECT caller FROM phone_calls WHERE month=7 AND day=28 AND year=2021 AND duration<60
    )
);

/*
+--------+--------+----------------+-----------------+---------------+
|   id   |  name  |  phone_number  | passport_number | license_plate |
+--------+--------+----------------+-----------------+---------------+
| 398010 | Sofia  | (130) 555-0289 | 1695452385      | G412CB7       |
| 560886 | Kelsey | (499) 555-9472 | 8294398571      | 0NTHK55       |
| 686048 | Bruce  | (367) 555-5533 | 5773159633      | 94KL13X       |
+--------+--------+----------------+-----------------+---------------+
*/

-- Get caller phone no. based on receiver

SELECT * FROM people
WHERE phone_number IN (
    SELECT caller FROM phone_calls
    WHERE receiver='(996) 555-8899'
);

/*
+--------+----------+----------------+-----------------+---------------+
|   id   |   name   |  phone_number  | passport_number | license_plate |
+--------+----------+----------------+-----------------+---------------+
| 231387 | Margaret | (068) 555-0183 | 1782675901      | 60563QT       |
| 398010 | Sofia    | (130) 555-0289 | 1695452385      | G412CB7       |
| 560886 | Kelsey   | (499) 555-9472 | 8294398571      | 0NTHK55       |
+--------+----------+----------------+-----------------+---------------+
*/







-- Putting all the pieces together

SELECT * FROM people
WHERE license_plate IN (
    SELECT license_plate FROM bakery_security_logs
    WHERE month=7 AND day=28 AND year=2021 AND hour=10 AND minute<=25 AND minute>=15 AND activity='exit'
) AND id IN(
    SELECT person_id FROM bank_accounts
    WHERE account_number IN (
        SELECT account_number FROM atm_transactions
        WHERE month=7 AND day=28 AND year=2021 AND atm_location='Leggett Street' AND transaction_type="withdraw"
    )
) AND passport_number IN (
    SELECT passport_number FROM passengers WHERE flight_id=36
) AND id IN (
    SELECT DISTINCT id FROM people
    WHERE license_plate IN (
        SELECT license_plate FROM bakery_security_logs WHERE month=7 AND day=28 AND year=2021 AND hour=10 AND minute<=25 AND minute>=15 AND activity='exit'
    ) and phone_number IN (
        SELECT caller FROM phone_calls WHERE month=7 AND day=28 AND year=2021 AND duration<60
    )
);

/*
+--------+-------+----------------+-----------------+---------------+
|   id   | name  |  phone_number  | passport_number | license_plate |
+--------+-------+----------------+-----------------+---------------+
| 686048 | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       |
+--------+-------+----------------+-----------------+---------------+
*/

-- Getting accomplice

SELECT * FROM people
WHERE phone_number IN (
    SELECT receiver FROM phone_calls WHERE caller='(367) 555-5533' AND month=7 AND day=28 AND year=2021 AND duration<60
);

/*
+--------+-------+----------------+-----------------+---------------+
|   id   | name  |  phone_number  | passport_number | license_plate |
+--------+-------+----------------+-----------------+---------------+
| 864400 | Robin | (375) 555-8161 | NULL            | 4V16VO0       |
+--------+-------+----------------+-----------------+---------------+
*/