package com.example.cinemaapplication.repository.Imp;

import com.example.cinemaapplication.model.Movie;
import com.example.cinemaapplication.repository.BaseRepository;
import com.example.cinemaapplication.repository.IMovieRepository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MovieRepositoryImp extends BaseRepository implements IMovieRepository {

    @Override
    public List<Movie> getAllMovies() {
        List<Movie> movies = new ArrayList<>();
        String query = "SELECT movie_id, title, genre FROM Movie";
        
        try {
            PreparedStatement preparedStatement = getConnection().prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();
            
            while (resultSet.next()) {
                Movie movie = new Movie();
                movie.setMovieId(resultSet.getInt("movie_id"));
                movie.setTitle(resultSet.getString("title"));
                movie.setGenre(resultSet.getString("genre"));
                movies.add(movie);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return movies;
    }

    @Override
    public Movie getMovieById(int movieId) {
        String query = "SELECT movie_id, title, genre FROM Movie WHERE movie_id = ?";
        
        try {
            PreparedStatement preparedStatement = getConnection().prepareStatement(query);
            preparedStatement.setInt(1, movieId);
            ResultSet resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                Movie movie = new Movie();
                movie.setMovieId(resultSet.getInt("movie_id"));
                movie.setTitle(resultSet.getString("title"));
                movie.setGenre(resultSet.getString("genre"));
                return movie;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
}
