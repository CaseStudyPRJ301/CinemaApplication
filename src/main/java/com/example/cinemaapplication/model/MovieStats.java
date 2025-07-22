package com.example.cinemaapplication.model;

public class MovieStats {
    private String title;
    private int ticketsSold;
    private double revenue;
    private double rating;
    
    public MovieStats() {
    }
    
    public MovieStats(String title, int ticketsSold, double revenue, double rating) {
        this.title = title;
        this.ticketsSold = ticketsSold;
        this.revenue = revenue;
        this.rating = rating;
    }
    
    // Getters and Setters
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public int getTicketsSold() {
        return ticketsSold;
    }
    
    public void setTicketsSold(int ticketsSold) {
        this.ticketsSold = ticketsSold;
    }
    
    public double getRevenue() {
        return revenue;
    }
    
    public void setRevenue(double revenue) {
        this.revenue = revenue;
    }
    
    public double getRating() {
        return rating;
    }
    
    public void setRating(double rating) {
        this.rating = rating;
    }
} 