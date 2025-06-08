package com.example.cinemaapplication.model;

import java.sql.Timestamp;

public class Showtime {
    private int showtimeId;
    private int theaterId;
    private int movieId;
    private Timestamp showTime;

    public Showtime() {
    }

    public Showtime(int showtimeId, int theaterId, int movieId, Timestamp showTime) {
        this.showtimeId = showtimeId;
        this.theaterId = theaterId;
        this.movieId = movieId;
        this.showTime = showTime;
    }

    public int getShowtimeId() {
        return showtimeId;
    }

    public void setShowtimeId(int showtimeId) {
        this.showtimeId = showtimeId;
    }

    public int getTheaterId() {
        return theaterId;
    }

    public void setTheaterId(int theaterId) {
        this.theaterId = theaterId;
    }

    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public Timestamp getShowTime() {
        return showTime;
    }

    public void setShowTime(Timestamp showTime) {
        this.showTime = showTime;
    }
}
