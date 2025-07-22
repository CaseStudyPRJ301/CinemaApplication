package com.example.cinemaapplication.model;

import java.sql.Timestamp;

public class BookingStats {
    private String bookingId;
    private String customerName;
    private String movieTitle;
    private String theaterName;
    private Timestamp showtime;
    private String seats;
    private double totalAmount;
    private Timestamp bookingDate;
    
    public BookingStats() {
    }
    
    public BookingStats(String bookingId, String customerName, String movieTitle, 
                       String theaterName, Timestamp showtime, String seats, 
                       double totalAmount, Timestamp bookingDate) {
        this.bookingId = bookingId;
        this.customerName = customerName;
        this.movieTitle = movieTitle;
        this.theaterName = theaterName;
        this.showtime = showtime;
        this.seats = seats;
        this.totalAmount = totalAmount;
        this.bookingDate = bookingDate;
    }
    
    // Getters and Setters
    public String getBookingId() {
        return bookingId;
    }
    
    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }
    
    public String getCustomerName() {
        return customerName;
    }
    
    public void setCustomerName(String customerName) {
        this.customerName = customerName;
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
    
    public Timestamp getShowtime() {
        return showtime;
    }
    
    public void setShowtime(Timestamp showtime) {
        this.showtime = showtime;
    }
    
    public String getSeats() {
        return seats;
    }
    
    public void setSeats(String seats) {
        this.seats = seats;
    }
    
    public double getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    public Timestamp getBookingDate() {
        return bookingDate;
    }
    
    public void setBookingDate(Timestamp bookingDate) {
        this.bookingDate = bookingDate;
    }
} 