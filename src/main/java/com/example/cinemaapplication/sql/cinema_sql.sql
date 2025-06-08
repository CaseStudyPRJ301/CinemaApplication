
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
    seat_number VARCHAR(10),
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