package com.example.cinemaapplication.repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// Kết nối DB
public class BaseRepository {
    private Connection connection;
    private static final String URL = "jdbc:mysql://localhost:3306/cinema_application";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "quan11052005";

    public BaseRepository() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            System.out.println("kết nối thành công");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                System.out.println("kết nối lại thành công");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }
}
