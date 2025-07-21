package com.example.cinemaapplication.service.Imp;

import com.example.cinemaapplication.model.Movie;
import com.example.cinemaapplication.repository.IMovieRepository;
import com.example.cinemaapplication.repository.Imp.MovieRepositoryImp;
import com.example.cinemaapplication.service.IMovieService;

import java.util.List;

public class MovieServiceImp implements IMovieService {
    private IMovieRepository movieRepository;

    public MovieServiceImp() {
        this.movieRepository = new MovieRepositoryImp();
    }

    @Override
    public List<Movie> getAllMovies() {
        return movieRepository.getAllMovies();
    }

    @Override
    public Movie getMovieById(int movieId) {
        return movieRepository.getMovieById(movieId);
    }
} 