package com.example.cinemaapplication.model;

public class Seat {
    private int seatId;
    private int theaterId;
    private String seatNumber;
    private String seatType; // normal / vip / couple
    private double price;

    public Seat() {
    }

    public Seat(int seatId, int theaterId, String seatNumber, String seatType, double price) {
        this.seatId = seatId;
        this.theaterId = theaterId;
        this.seatNumber = seatNumber;
        this.seatType = seatType;
        this.price = price;
    }

    public int getSeatId() {
        return seatId;
    }

    public void setSeatId(int seatId) {
        this.seatId = seatId;
    }

    public int getTheaterId() {
        return theaterId;
    }

    public void setTheaterId(int theaterId) {
        this.theaterId = theaterId;
    }

    public String getSeatNumber() {
        return seatNumber;
    }

    public void setSeatNumber(String seatNumber) {
        this.seatNumber = seatNumber;
    }

    public String getSeatType() {
        return seatType;
    }

    public void setSeatType(String seatType) {
        this.seatType = seatType;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}