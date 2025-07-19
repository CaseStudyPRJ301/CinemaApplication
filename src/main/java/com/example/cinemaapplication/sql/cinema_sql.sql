
-- CINEMA BOOKING DATABASE --

CREATE DATABASE IF NOT EXISTS cinema_application;
USE cinema_application;

-- 0. User Table (dành cho customer & employee)
CREATE TABLE User (
                      user_id INT PRIMARY KEY AUTO_INCREMENT,
                      username VARCHAR(50) UNIQUE NOT NULL,
                      password_hash VARCHAR(255) NOT NULL,
                      role ENUM('customer', 'employee') NOT NULL,
                      ref_id INT NOT NULL
);

-- 1. Admin Table (duy nhất 1 admin, không dùng id)
CREATE TABLE Admin (
                       username VARCHAR(50) PRIMARY KEY,
                       password_hash VARCHAR(255) NOT NULL,
                       name VARCHAR(100),
                       email VARCHAR(100)
);

-- 2. Customer Table
CREATE TABLE Customer (
                          customer_id INT PRIMARY KEY AUTO_INCREMENT,
                          name VARCHAR(100),
                          phone_number VARCHAR(20),
                          email VARCHAR(100),
                          booking_method ENUM('online', 'offline'),
                          created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 3. Employee Table
CREATE TABLE Employee (
                          employee_id INT PRIMARY KEY AUTO_INCREMENT,
                          name VARCHAR(100),
                          phone VARCHAR(20),
                          email VARCHAR(100)
);

-- 4. Movie Table
CREATE TABLE Movie (
                       movie_id INT PRIMARY KEY AUTO_INCREMENT,
                       title VARCHAR(255),
                       genre VARCHAR(100)
);

-- 5. Theater Table
CREATE TABLE Theater (
                         theater_id INT PRIMARY KEY AUTO_INCREMENT,
                         name VARCHAR(100),
                         location VARCHAR(255)
);

-- 6. Showtime Table
CREATE TABLE Showtime (
                          showtime_id INT PRIMARY KEY AUTO_INCREMENT,
                          theater_id INT,
                          movie_id INT,
                          show_time DATETIME,
                          FOREIGN KEY (theater_id) REFERENCES Theater(theater_id),
                          FOREIGN KEY (movie_id) REFERENCES Movie(movie_id)
);

-- 7. Seat Table
CREATE TABLE Seat (
                      seat_id INT PRIMARY KEY AUTO_INCREMENT,
                      theater_id INT,
                      seat_type ENUM('normal', 'vip', 'couple'),
                      price DECIMAL(10,2),
                      FOREIGN KEY (theater_id) REFERENCES Theater(theater_id)
);

-- 8. Ticket Table
CREATE TABLE Ticket (
                        ticket_id INT PRIMARY KEY AUTO_INCREMENT,
                        customer_id INT,
                        seat_id INT,
                        showtime_id INT,
                        employee_id INT,
                        booking_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                        FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
                        FOREIGN KEY (seat_id) REFERENCES Seat(seat_id),
                        FOREIGN KEY (showtime_id) REFERENCES Showtime(showtime_id),
                        FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

-- INSERT SAMPLE DATA --

-- Insert Movies
INSERT INTO Movie (movie_id, title, genre) VALUES
(1, 'Squid Game', 'Thriller'),
(2, 'Last Avatar', 'Fantasy'),
(3, 'The Deer God', 'Adventure');

-- Insert Theaters
INSERT INTO Theater (theater_id, name, location) VALUES
(1, 'Theater 1', 'Level 1 - Screen A'),
(2, 'Theater 2', 'Level 1 - Screen B'), 
(3, 'Theater 3', 'Level 2 - Screen C');

-- Insert Showtimes
INSERT INTO Showtime (showtime_id, theater_id, movie_id, show_time) VALUES
-- Squid Game - Theater 1
(1, 1, 1, '2024-01-20 10:00:00'),
(2, 1, 1, '2024-01-20 13:00:00'),
(3, 1, 1, '2024-01-20 16:00:00'),
(4, 1, 1, '2024-01-20 19:00:00'),
(5, 1, 1, '2024-01-20 22:00:00'),

-- Last Avatar - Theater 2  
(6, 2, 2, '2024-01-20 09:30:00'),
(7, 2, 2, '2024-01-20 12:30:00'),
(8, 2, 2, '2024-01-20 15:30:00'),
(9, 2, 2, '2024-01-20 18:30:00'),
(10, 2, 2, '2024-01-20 21:30:00'),

-- The Deer God - Theater 3
(11, 3, 3, '2024-01-20 11:00:00'),
(12, 3, 3, '2024-01-20 14:00:00'),
(13, 3, 3, '2024-01-20 17:00:00'),
(14, 3, 3, '2024-01-20 20:00:00'),
(15, 3, 3, '2024-01-20 23:00:00');

-- Insert Seats for all 3 theaters
-- Theater 1 Seats (8x8 layout: 56 single seats + 4 couple seats = 60 seats)
-- Row A, B, C: Normal seats (50,000 VND)
INSERT INTO Seat (theater_id, seat_type, price) VALUES
-- Row A (Normal - 8 seats)
(1, 'normal', 50000.00), (1, 'normal', 50000.00), (1, 'normal', 50000.00), (1, 'normal', 50000.00),
(1, 'normal', 50000.00), (1, 'normal', 50000.00), (1, 'normal', 50000.00), (1, 'normal', 50000.00),
-- Row B (Normal - 8 seats)
(1, 'normal', 50000.00), (1, 'normal', 50000.00), (1, 'normal', 50000.00), (1, 'normal', 50000.00),
(1, 'normal', 50000.00), (1, 'normal', 50000.00), (1, 'normal', 50000.00), (1, 'normal', 50000.00),
-- Row C (Normal - 8 seats)
(1, 'normal', 50000.00), (1, 'normal', 50000.00), (1, 'normal', 50000.00), (1, 'normal', 50000.00),
(1, 'normal', 50000.00), (1, 'normal', 50000.00), (1, 'normal', 50000.00), (1, 'normal', 50000.00),

-- Row D, E, F, G: VIP seats (75,000 VND)
-- Row D (VIP - 8 seats)
(1, 'vip', 75000.00), (1, 'vip', 75000.00), (1, 'vip', 75000.00), (1, 'vip', 75000.00),
(1, 'vip', 75000.00), (1, 'vip', 75000.00), (1, 'vip', 75000.00), (1, 'vip', 75000.00),
-- Row E (VIP - 8 seats)
(1, 'vip', 75000.00), (1, 'vip', 75000.00), (1, 'vip', 75000.00), (1, 'vip', 75000.00),
(1, 'vip', 75000.00), (1, 'vip', 75000.00), (1, 'vip', 75000.00), (1, 'vip', 75000.00),
-- Row F (VIP - 8 seats)
(1, 'vip', 75000.00), (1, 'vip', 75000.00), (1, 'vip', 75000.00), (1, 'vip', 75000.00),
(1, 'vip', 75000.00), (1, 'vip', 75000.00), (1, 'vip', 75000.00), (1, 'vip', 75000.00),
-- Row G (VIP - 8 seats)
(1, 'vip', 75000.00), (1, 'vip', 75000.00), (1, 'vip', 75000.00), (1, 'vip', 75000.00),
(1, 'vip', 75000.00), (1, 'vip', 75000.00), (1, 'vip', 75000.00), (1, 'vip', 75000.00),

-- Row H: Couple seats (140,000 VND) - 4 couple seats
(1, 'couple', 140000.00), (1, 'couple', 140000.00), (1, 'couple', 140000.00), (1, 'couple', 140000.00);

-- Theater 2 Seats (Same layout as Theater 1)
INSERT INTO Seat (theater_id, seat_type, price) VALUES
-- Row A, B, C: Normal seats
(2, 'normal', 50000.00), (2, 'normal', 50000.00), (2, 'normal', 50000.00), (2, 'normal', 50000.00),
(2, 'normal', 50000.00), (2, 'normal', 50000.00), (2, 'normal', 50000.00), (2, 'normal', 50000.00),
(2, 'normal', 50000.00), (2, 'normal', 50000.00), (2, 'normal', 50000.00), (2, 'normal', 50000.00),
(2, 'normal', 50000.00), (2, 'normal', 50000.00), (2, 'normal', 50000.00), (2, 'normal', 50000.00),
(2, 'normal', 50000.00), (2, 'normal', 50000.00), (2, 'normal', 50000.00), (2, 'normal', 50000.00),
(2, 'normal', 50000.00), (2, 'normal', 50000.00), (2, 'normal', 50000.00), (2, 'normal', 50000.00),

-- Row D, E, F, G: VIP seats
(2, 'vip', 75000.00), (2, 'vip', 75000.00), (2, 'vip', 75000.00), (2, 'vip', 75000.00),
(2, 'vip', 75000.00), (2, 'vip', 75000.00), (2, 'vip', 75000.00), (2, 'vip', 75000.00),
(2, 'vip', 75000.00), (2, 'vip', 75000.00), (2, 'vip', 75000.00), (2, 'vip', 75000.00),
(2, 'vip', 75000.00), (2, 'vip', 75000.00), (2, 'vip', 75000.00), (2, 'vip', 75000.00),
(2, 'vip', 75000.00), (2, 'vip', 75000.00), (2, 'vip', 75000.00), (2, 'vip', 75000.00),
(2, 'vip', 75000.00), (2, 'vip', 75000.00), (2, 'vip', 75000.00), (2, 'vip', 75000.00),
(2, 'vip', 75000.00), (2, 'vip', 75000.00), (2, 'vip', 75000.00), (2, 'vip', 75000.00),
(2, 'vip', 75000.00), (2, 'vip', 75000.00), (2, 'vip', 75000.00), (2, 'vip', 75000.00),
(2, 'vip', 75000.00), (2, 'vip', 75000.00), (2, 'vip', 75000.00), (2, 'vip', 75000.00),

-- Row H: Couple seats
(2, 'couple', 140000.00), (2, 'couple', 140000.00), (2, 'couple', 140000.00), (2, 'couple', 140000.00);

-- Theater 3 Seats (Same layout as Theater 1 & 2)
INSERT INTO Seat (theater_id, seat_type, price) VALUES
-- Row A, B, C: Normal seats
(3, 'normal', 50000.00), (3, 'normal', 50000.00), (3, 'normal', 50000.00), (3, 'normal', 50000.00),
(3, 'normal', 50000.00), (3, 'normal', 50000.00), (3, 'normal', 50000.00), (3, 'normal', 50000.00),
(3, 'normal', 50000.00), (3, 'normal', 50000.00), (3, 'normal', 50000.00), (3, 'normal', 50000.00),
(3, 'normal', 50000.00), (3, 'normal', 50000.00), (3, 'normal', 50000.00), (3, 'normal', 50000.00),
(3, 'normal', 50000.00), (3, 'normal', 50000.00), (3, 'normal', 50000.00), (3, 'normal', 50000.00),
(3, 'normal', 50000.00), (3, 'normal', 50000.00), (3, 'normal', 50000.00), (3, 'normal', 50000.00),

-- Row D, E, F, G: VIP seats
(3, 'vip', 75000.00), (3, 'vip', 75000.00), (3, 'vip', 75000.00), (3, 'vip', 75000.00),
(3, 'vip', 75000.00), (3, 'vip', 75000.00), (3, 'vip', 75000.00), (3, 'vip', 75000.00),
(3, 'vip', 75000.00), (3, 'vip', 75000.00), (3, 'vip', 75000.00), (3, 'vip', 75000.00),
(3, 'vip', 75000.00), (3, 'vip', 75000.00), (3, 'vip', 75000.00), (3, 'vip', 75000.00),
(3, 'vip', 75000.00), (3, 'vip', 75000.00), (3, 'vip', 75000.00), (3, 'vip', 75000.00),
(3, 'vip', 75000.00), (3, 'vip', 75000.00), (3, 'vip', 75000.00), (3, 'vip', 75000.00),
(3, 'vip', 75000.00), (3, 'vip', 75000.00), (3, 'vip', 75000.00), (3, 'vip', 75000.00),
(3, 'vip', 75000.00), (3, 'vip', 75000.00), (3, 'vip', 75000.00), (3, 'vip', 75000.00),

-- Row H: Couple seats
(3, 'couple', 140000.00), (3, 'couple', 140000.00), (3, 'couple', 140000.00), (3, 'couple', 140000.00);