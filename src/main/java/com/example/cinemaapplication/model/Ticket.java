package com.example.cinemaapplication.model;

import java.sql.Timestamp;

public class Ticket {
    private int ticketId;
    private int customerId;
    private int seatId;
    private int showtimeId;
    private int employeeId;
    private Timestamp bookingTime;

    public Ticket() {
    }

    public Ticket(int ticketId, int customerId, int seatId, int showtimeId, int employeeId, Timestamp bookingTime) {
        this.ticketId = ticketId;
        this.customerId = customerId;
        this.seatId = seatId;
        this.showtimeId = showtimeId;
        this.employeeId = employeeId;
        this.bookingTime = bookingTime;
    }

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
}