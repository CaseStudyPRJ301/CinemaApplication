package com.example.cinemaapplication.listener;

import com.example.cinemaapplication.repository.BaseRepository;
import com.example.cinemaapplication.repository.Imp.AdminRepositoryImp;
import com.example.cinemaapplication.model.Admin;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebListener
public class DatabaseInitializer implements ServletContextListener {
    
    private static final String DEFAULT_ADMIN_USERNAME = "admin";
    private static final String DEFAULT_ADMIN_PASSWORD = "admin123";
    private static final String DEFAULT_ADMIN_NAME = "System Administrator";
    private static final String DEFAULT_ADMIN_EMAIL = "admin@cinema.com";
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Cinema Application starting up...");
        System.out.println("Initializing default admin account...");
        
        try {
            createDefaultAdminIfNotExists();
            System.out.println("Default admin account initialization completed successfully!");
        } catch (Exception e) {
            System.err.println("Error initializing default admin account: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Cinema Application shutting down...");
    }
    
    private void createDefaultAdminIfNotExists() throws SQLException {
        BaseRepository baseRepo = new BaseRepository();
        Connection connection = null;
        PreparedStatement checkStmt = null;
        PreparedStatement insertStmt = null;
        ResultSet rs = null;
        
        try {
            connection = baseRepo.getConnection();
            
            // Check if admin already exists
            String checkQuery = "SELECT COUNT(*) FROM Admin WHERE username = ?";
            checkStmt = connection.prepareStatement(checkQuery);
            checkStmt.setString(1, DEFAULT_ADMIN_USERNAME);
            rs = checkStmt.executeQuery();
            
            if (rs.next() && rs.getInt(1) == 0) {
                // Admin doesn't exist, create it
                String hashedPassword = hashPassword(DEFAULT_ADMIN_PASSWORD);
                
                String insertQuery = "INSERT INTO Admin (username, password_hash, name, email) VALUES (?, ?, ?, ?)";
                insertStmt = connection.prepareStatement(insertQuery);
                insertStmt.setString(1, DEFAULT_ADMIN_USERNAME);
                insertStmt.setString(2, hashedPassword);
                insertStmt.setString(3, DEFAULT_ADMIN_NAME);
                insertStmt.setString(4, DEFAULT_ADMIN_EMAIL);
                
                int result = insertStmt.executeUpdate();
                
                if (result > 0) {
                    System.out.println("Default admin account created successfully!");
                    System.out.println("   Username: " + DEFAULT_ADMIN_USERNAME);
                    System.out.println("   Password: " + DEFAULT_ADMIN_PASSWORD);
                    System.out.println("   Name: " + DEFAULT_ADMIN_NAME);
                    System.out.println("   Email: " + DEFAULT_ADMIN_EMAIL);
                } else {
                    System.err.println("Failed to create default admin account");
                }
            } else {
                System.out.println("Default admin account already exists, skipping creation");
            }
            
        } finally {
            // Clean up resources
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (checkStmt != null) {
                try {
                    checkStmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (insertStmt != null) {
                try {
                    insertStmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }
} 