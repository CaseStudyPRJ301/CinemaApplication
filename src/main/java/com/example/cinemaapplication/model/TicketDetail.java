package com.example.cinemaapplication.model;

import java.sql.Timestamp;

public class TicketDetail {
    private int ticketId;
    private int customerId;
    private int seatId;
    private int showtimeId;
    private int employeeId;
    private Timestamp bookingTime;
    
    // Additional details from joins
    private String movieTitle;
    private String theaterName;
    private String seatPosition;
    private Timestamp showtime;
    private String seatType;
    private double seatPrice;
    
    public TicketDetail() {
    }
    
    public TicketDetail(int ticketId, int customerId, int seatId, int showtimeId, int employeeId, 
                       Timestamp bookingTime, String movieTitle, String theaterName, 
                       String seatPosition, Timestamp showtime, String seatType, double seatPrice) {
        this.ticketId = ticketId;
        this.customerId = customerId;
        this.seatId = seatId;
        this.showtimeId = showtimeId;
        this.employeeId = employeeId;
        this.bookingTime = bookingTime;
        this.movieTitle = movieTitle;
        this.theaterName = theaterName;
        this.seatPosition = seatPosition;
        this.showtime = showtime;
        this.seatType = seatType;
        this.seatPrice = seatPrice;
    }
    
    // Getters and Setters
    public int getTicketId() {
        return ticketId;
    }
    
    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }
    
    public int getCustomerId() {
        return customerId;
    }
    
    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }
    
    public int getSeatId() {
        return seatId;
    }
    
    public void setSeatId(int seatId) {
        this.seatId = seatId;
    }
    
    public int getShowtimeId() {
        return showtimeId;
    }
    
    public void setShowtimeId(int showtimeId) {
        this.showtimeId = showtimeId;
    }
    
    public int getEmployeeId() {
        return employeeId;
    }
    
    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }
    
    public Timestamp getBookingTime() {
        return bookingTime;
    }
    
    public void setBookingTime(Timestamp bookingTime) {
        this.bookingTime = bookingTime;
    }
    
    public String getMovieTitle() {
        return movieTitle;
    }
    
    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }
    
    public String getTheaterName() {
        return theaterName;
    }
    
    public void setTheaterName(String theaterName) {
        this.theaterName = theaterName;
    }
    
    public String getSeatPosition() {
        return seatPosition;
    }
    
    public void setSeatPosition(String seatPosition) {
        this.seatPosition = seatPosition;
    }
    
    public Timestamp getShowtime() {
        return showtime;
    }
    
    public void setShowtime(Timestamp showtime) {
        this.showtime = showtime;
    }
    
    public String getSeatType() {
        return seatType;
    }
    
    public void setSeatType(String seatType) {
        this.seatType = seatType;
    }
    
    public double getSeatPrice() {
        return seatPrice;
    }
    
    public void setSeatPrice(double seatPrice) {
        this.seatPrice = seatPrice;
    }
} 