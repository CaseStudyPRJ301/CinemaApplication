package com.example.cinemaapplication.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.ArrayList;

public class BookingGroup {
    private Timestamp bookingTime;
    private List<TicketDetail> tickets;
    private int totalTickets;
    private double totalAmount;
    
    public BookingGroup(Timestamp bookingTime) {
        this.bookingTime = bookingTime;
        this.tickets = new ArrayList<>();
        this.totalTickets = 0;
        this.totalAmount = 0.0;
    }
    
    public void addTicket(TicketDetail ticket) {
        this.tickets.add(ticket);
        this.totalTickets++;
        this.totalAmount += ticket.getSeatPrice();
    }
    
    // Getters and Setters
    public Timestamp getBookingTime() {
        return bookingTime;
    }
    
    public void setBookingTime(Timestamp bookingTime) {
        this.bookingTime = bookingTime;
    }
    
    public List<TicketDetail> getTickets() {
        return tickets;
    }
    
    public void setTickets(List<TicketDetail> tickets) {
        this.tickets = tickets;
    }
    
    public int getTotalTickets() {
        return totalTickets;
    }
    
    public void setTotalTickets(int totalTickets) {
        this.totalTickets = totalTickets;
    }
    
    public double getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    // Helper methods
    public String getMovieTitle() {
        if (!tickets.isEmpty()) {
            return tickets.get(0).getMovieTitle();
        }
        return "";
    }
    
    public String getTheaterName() {
        if (!tickets.isEmpty()) {
            return tickets.get(0).getTheaterName();
        }
        return "";
    }
    
    public Timestamp getShowtime() {
        if (!tickets.isEmpty()) {
            return tickets.get(0).getShowtime();
        }
        return null;
    }
    
    public String getSeatPositions() {
        StringBuilder seats = new StringBuilder();
        for (int i = 0; i < tickets.size(); i++) {
            if (i > 0) seats.append(", ");
            seats.append(tickets.get(i).getSeatPosition());
        }
        return seats.toString();
    }
} 