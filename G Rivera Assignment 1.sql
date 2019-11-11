/* 1. How many airplanes have listed speeds? What is the minimum listed speed and the maximum listed speed? */

-- How many airplanes have listed speeds?
USE flights;
SELECT count(*) AS 'Count of Listed Speeds' from planes
WHERE speed is NOT NULL;

-- What is the minimum listed speed and the maximum listed speed?

USE flights;
SELECT max(speed) AS 'Maximum Listed Speed', min(speed) AS 'Minimum Listed Speed'
from planes
WHERE speed is NOT NULL;


/* 2. What is the total distance flown by all of the planes in January 2013? 
What is the total distance flown by all of the planes in January 2013 where the tailnum is missing? */

-- What is the total distance flown by all of the planes in January 2013? 

USE flights;
SELECT sum(distance) as 'Total Distance Flown Jan 2013'
FROM flights
WHERE year = 2013 and month = 1;

-- What is the total distance flown by all of the planes in January 2013 where the tailnum is missing?

USE flights;
SELECT sum(distance) as 'Total Distance Flown Jan 2013 Missing Tailnum'
FROM flights
WHERE year = 2013 and month = 1 and (tailnum IS NULL or tailnum like '');


/*3. What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer? 
Write this statement first using an INNER JOIN, then using a LEFT OUTER JOIN. How do your results compare?
Write and answer at least one question of your own choosing that joins information 
from at least three of the tables in the flights database. */

-- What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer? (INNER JOIN)

USE flights;
SELECT planes.manufacturer, sum(flights.distance) AS 'distance'
FROM planes
INNER JOIN flights ON planes.tailnum = flights.tailnum
WHERE flights.year = 2013 and flights.month = 7 and flights.day = 5
GROUP BY planes.manufacturer
ORDER BY planes.manufacturer;

-- What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer? (LEFT OUTER JOIN)

USE flights;
SELECT planes.manufacturer, sum(flights.distance) AS 'distance'
FROM planes
LEFT OUTER JOIN flights ON planes.tailnum = flights.tailnum
WHERE flights.year = 2013 and flights.month = 7 and flights.day = 5
GROUP BY planes.manufacturer
ORDER BY planes.manufacturer;

-- Custom Question: List the carrier names and distance of flights on days where there was some precipitation.

USE flights;
select airlines.name, sum(flights.distance)
from weather
INNER JOIN flights on weather.year = flights.year and weather.month = flights.month and weather.day = flights.day
INNER JOIN airlines on flights.carrier = airlines.carrier
WHERE weather.precip > 0
GROUP BY airlines.name
ORDER BY airlines.name;



