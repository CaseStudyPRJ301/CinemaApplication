package com.example.cinemaapplication.service;

import com.example.cinemaapplication.model.Movie;
import java.util.List;

public interface IMovieService {
    List<Movie> getAllMovies();
    Movie getMovieById(int movieId);
} 