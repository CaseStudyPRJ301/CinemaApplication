package com.example.cinemaapplication.repository;

import com.example.cinemaapplication.model.Movie;
import java.util.List;

public interface IMovieRepository {
    List<Movie> getAllMovies();
    Movie getMovieById(int movieId);
}
