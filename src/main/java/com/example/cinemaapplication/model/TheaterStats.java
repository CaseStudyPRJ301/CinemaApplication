package com.example.cinemaapplication.model;

public class TheaterStats {
    private String name;
    private int totalShows;
    private int ticketsSold;
    private double revenue;
    private double occupancyRate;
    
    public TheaterStats() {
    }
    
    public TheaterStats(String name, int totalShows, int ticketsSold, double revenue, double occupancyRate) {
        this.name = name;
        this.totalShows = totalShows;
        this.ticketsSold = ticketsSold;
        this.revenue = revenue;
        this.occupancyRate = occupancyRate;
    }
    
    // Getters and Setters
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public int getTotalShows() {
        return totalShows;
    }
    
    public void setTotalShows(int totalShows) {
        this.totalShows = totalShows;
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
    
    public double getOccupancyRate() {
        return occupancyRate;
    }
    
    public void setOccupancyRate(double occupancyRate) {
        this.occupancyRate = occupancyRate;
    }
} 