-- Keep a log of any SQL queries you execute as you solve the mystery.
SELECT
  *
FROM
  crime_scene_reports
WHERE
  street = 'Humphrey Street'
  AND MONTH = '7'
  AND DAY = '28';

-- Get the statements from the 3 witnesses
-- NOTE:
-- - Ruth (161) saw a car leaving the bakery.
--   - Check bakery_security_logs
-- - Eugene (162) saw and recognized the perp. Perp withdraws money from Leggett Street ATM
--   - Check atm_transactions
-- - Raymond (163) overheard about buying the earliest flight on the day after the crime
--   - Check flights
SELECT
  *
FROM
  interviews
WHERE
  YEAR = '2021'
  AND MONTH = '7'
  AND DAY = '28';

-- Get list of suspects based on people that withdrew money from Leggett Street ATM
SELECT
  atm_transactions.account_number,
  bank_accounts.person_id,
  people.name,
  people.phone_number,
  people.passport_number,
  people.license_plate
FROM
  atm_transactions
  JOIN bank_accounts ON atm_transactions.account_number = bank_accounts.account_number
  JOIN people ON bank_accounts.person_id = people.id
WHERE
  YEAR = '2021'
  AND MONTH = '7'
  AND DAY = '28'
  AND atm_location = 'Leggett Street';

-- Match the suspected license plates to corresponding car owner names
SELECT
  bakery_security_logs.license_plate,
  people.name
FROM
  bakery_security_logs
  JOIN people ON bakery_security_logs.license_plate = people.license_plate
WHERE
  bakery_security_logs.year = '2021'
  AND bakery_security_logs.month = '7'
  AND bakery_security_logs.day = '28'
  AND bakery_security_logs.activity = 'exit'
  AND bakery_security_logs.license_plate IN (
    SELECT
      people.license_plate
    FROM
      atm_transactions
      JOIN bank_accounts ON atm_transactions.account_number = bank_accounts.account_number
      JOIN people ON bank_accounts.person_id = people.id
    WHERE
      YEAR = '2021'
      AND MONTH = '7'
      AND DAY = '28'
      AND atm_location = 'Leggett Street'
  );

-- Get which flight the perp will fly on
-- NOTE:
-- - Perp will take the 8AM flight to New York City on July 29, 2021
-- - Flight ID 36
SELECT
  flights.id AS flight_id,
  destination.city AS destination_city,
  flights.hour AS time_of_flight
FROM
  flights
  JOIN airports AS origin ON origin.id = flights.origin_airport_id
  JOIN airports AS destination ON destination.id = flights.destination_airport_id
WHERE
  YEAR = '2021'
  AND MONTH = '7'
  AND DAY = '29'
ORDER BY
  flights.hour;

-- Get passengers for flight id 36
-- NOTE:
-- - Narrowed down to Bruce, Taylor, Kenny, Luca
SELECT
  passengers.passport_number,
  people.name
FROM
  passengers
  JOIN people ON passengers.passport_number = people.passport_number
WHERE
  flight_id = '36'
  AND passengers.passport_number IN (
    SELECT
      people.passport_number
    FROM
      atm_transactions
      JOIN bank_accounts ON atm_transactions.account_number = bank_accounts.account_number
      JOIN people ON bank_accounts.person_id = people.id
    WHERE
      YEAR = '2021'
      AND MONTH = '7'
      AND DAY = '28'
      AND atm_location = 'Leggett Street'
  );

-- Match phone_call records on time (less than a minute) of incident to corresponding names
-- NOTE
-- - Narrowed to Bruce (accompliced by Robin)
-- - Narrowed to Taylor (accompliced by James)
SELECT
  phone_calls.caller,
  p_caller.name,
  phone_calls.receiver,
  p_receiver.name,
  phone_calls.duration
FROM
  phone_calls
  JOIN people AS p_caller ON phone_calls.caller = p_caller.phone_number
  JOIN people AS p_receiver ON phone_calls.receiver = p_receiver.phone_number
WHERE
  phone_calls.year = '2021'
  AND phone_calls.month = '7'
  AND phone_calls.day = '28'
  AND phone_calls.duration < 60
  AND phone_calls.caller IN (
    SELECT
      people.phone_number
    FROM
      atm_transactions
      JOIN bank_accounts ON atm_transactions.account_number = bank_accounts.account_number
      JOIN people ON bank_accounts.person_id = people.id
    WHERE
      YEAR = '2021'
      AND MONTH = '7'
      AND DAY = '28'
      AND atm_location = 'Leggett Street'
  );

-- Match phone_call records on time of incident to corresponding names
SELECT
  phone_calls.caller,
  p_caller.name,
  phone_calls.receiver,
  p_receiver.name,
  phone_calls.duration
FROM
  phone_calls
  JOIN people AS p_caller ON phone_calls.caller = p_caller.phone_number
  JOIN people AS p_receiver ON phone_calls.receiver = p_receiver.phone_number
WHERE
  phone_calls.year = '2021'
  AND phone_calls.month = '7'
  AND phone_calls.day = '28'
  AND phone_calls.caller IN (
    SELECT
      people.phone_number
    FROM
      atm_transactions
      JOIN bank_accounts ON atm_transactions.account_number = bank_accounts.account_number
      JOIN people ON bank_accounts.person_id = people.id
    WHERE
      YEAR = '2021'
      AND MONTH = '7'
      AND DAY = '28'
      AND atm_location = 'Leggett Street'
  );

-- Match passengers to corresponding names
SELECT
  phone_calls.caller,
  people.name
FROM
  phone_calls
  JOIN people ON phone_calls.caller = people.phone_number
WHERE
  phone_calls.year = '2021'
  AND phone_calls.month = '7'
  AND phone_calls.day = '28'
  AND phone_calls.caller IN (
    SELECT
      people.phone_number
    FROM
      atm_transactions
      JOIN bank_accounts ON atm_transactions.account_number = bank_accounts.account_number
      JOIN people ON bank_accounts.person_id = people.id
    WHERE
      YEAR = '2021'
      AND MONTH = '7'
      AND DAY = '28'
      AND atm_location = 'Leggett Street'
  );
