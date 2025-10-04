DROP DATABASE IF EXISTS BlogDB;
CREATE DATABASE BlogDB;
USE BlogDB;


CREATE TABLE Authors (
author_id INT PRIMARY KEY AUTO_INCREMENT,
author_name VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE Articles (
article_id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(255) NOT NULL,
word_count INT NOT NULL,
views INT NOT NULL,
author_id INT NOT NULL,
FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE
);


INSERT INTO Authors (author_name)
VALUES
    ('Maria Charlotte'),
    ('Juan Perez'),
    ('Gemma Alcocer');


INSERT INTO Articles (title, word_count, views, author_id) VALUES
('Best Paint Colors', 814, 14, 1),
('Small Space Decorating Tips', 1146, 221, 2),
('Hot Accessories', 986, 105, 1),
('Mixing Textures', 765, 22, 1),
('Kitchen Refresh', 1242, 307, 2),
('Homemade Art Hacks', 1002, 193, 1),
('Refinishing Wood Floors', 1571, 7542, 3);


DROP DATABASE IF EXISTS AirlineDB;
CREATE DATABASE AirlineDB;
USE AirlineDB;

-- Customers Table
CREATE TABLE Customers (
customer_id INT PRIMARY KEY AUTO_INCREMENT,
customer_name VARCHAR(100) NOT NULL,
customer_status VARCHAR(20),
total_mileage INT NOT NULL
);


CREATE TABLE Aircrafts (
aircraft_id INT PRIMARY KEY AUTO_INCREMENT,
aircraft_name VARCHAR(100) NOT NULL UNIQUE,
total_seats INT NOT NULL
);


CREATE TABLE Flights (
flight_id INT PRIMARY KEY AUTO_INCREMENT,
flight_number VARCHAR(10) NOT NULL UNIQUE,
mileage INT NOT NULL,
aircraft_id INT NOT NULL,
FOREIGN KEY (aircraft_id) REFERENCES Aircrafts(aircraft_id)
);


CREATE TABLE Bookings (
booking_id INT PRIMARY KEY AUTO_INCREMENT,
customer_id INT NOT NULL,
flight_id INT NOT NULL,
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
FOREIGN KEY (flight_id) REFERENCES Flights(flight_id) ON DELETE CASCADE
);


INSERT INTO Customers (customer_name, customer_status, total_mileage) VALUES
('Agustine Riviera', 'Silver', 115235),
('Alaina Sepulvida', 'None', 6008),
('Tom Jones', 'Gold', 205767),
('Sam Rio', 'None', 2653),
('Jessica James', 'Silver', 127656),
('Ana Janco', 'Silver', 136773),
('Jennifer Cortez', 'Gold', 300582),
('Christian Janco', 'Silver', 14642);


INSERT INTO Aircrafts (aircraft_name, total_seats) VALUES
('Boeing 747', 400),
('Airbus A330', 236),
('Boeing 777', 264);


INSERT INTO Flights (flight_number, mileage, aircraft_id) VALUES
('DL143', 135, 1),
('DL122', 4370, 2),
('DL53', 2078, 3),
('DL222', 1765, 3),
('DL37', 531, 1);


INSERT INTO Bookings (customer_id, flight_id) VALUES
(1,1),
(1,2),
(2,2),
(3,2),
(3,3),
(3,4),
(4,1),
(4,5),
(5,1),
(5,2),
(6,4),
(7,4),
(8,4);


USE AirlineDB;

SELECT COUNT(*) AS total_flights FROM Flights;

SELECT AVG(mileage) AS avg_distance FROM Flights;

SELECT AVG(total_seats) AS avg_seats FROM Aircrafts;

SELECT customer_status, AVG(total_mileage) AS avg_miles
FROM Customers
GROUP BY customer_status;

SELECT customer_status, MAX(total_mileage) AS max_miles
FROM Customers
GROUP BY customer_status;

SELECT COUNT(*) AS boeing_count
FROM Aircrafts
WHERE aircraft_name LIKE '%Boeing%';

SELECT *
FROM Flights
WHERE mileage BETWEEN 300 and 2000;

SELECT c.customer_status, AVG(f.mileage) AS avg_booked_distance
FROM Bookings b
         JOIN Customers c ON b.customer_id = c.customer_id
         JOIN Flights f ON b.flight_id = f.flight_id
GROUP BY c.customer_status;

SELECT a.aircraft_name, COUNT(*) AS total_bookings
FROM Bookings b
         JOIN Customers c ON b.customer_id = c.customer_id
         JOIN Flights f ON b.flight_id = f.flight_id
         JOIN Aircrafts a ON f.aircraft_id = a.aircraft_id
WHERE c.customer_status = 'Gold'
GROUP BY a.aircraft_name
ORDER BY total_bookings DESC
    LIMIT 1;