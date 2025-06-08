package com.example.cinemaapplication.model;

public class Theater {
    private int theaterId;
    private String name;
    private String location;

    public Theater() {
    }

    public Theater(int theaterId, String name, String location) {
        this.theaterId = theaterId;
        this.name = name;
        this.location = location;
    }

    public int getTheaterId() {
        return theaterId;
    }

    public void setTheaterId(int theaterId) {
        this.theaterId = theaterId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
}
