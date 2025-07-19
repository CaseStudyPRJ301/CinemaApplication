package com.example.cinemaapplication.repository.Imp;

import com.example.cinemaapplication.repository.BaseRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class UserRepository extends BaseRepository {
    private static final String INSERT_USER = "INSERT INTO User (username, password_hash, role, ref_id) VALUES (?, ?, ?, ?)";
    private static final String CHECK_USER = "SELECT * FROM User WHERE username = ? AND password_hash = ?";
    private static final String CHECK_USERNAME = "SELECT * FROM User WHERE username = ?";
    private static final String CHECK_ADMIN = "SELECT * FROM Admin WHERE username = ? AND password_hash = ?";
    private static final String CHECK_ADMIN_USERNAME = "SELECT * FROM Admin WHERE username = ?";

    public boolean registerUser(String username, String password, String role, int refId) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_USER)) {
            
            // Hash password
            String hashedPassword = hashPassword(password);
            
            ps.setString(1, username);
            ps.setString(2, hashedPassword);
            ps.setString(3, role);
            ps.setInt(4, refId);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public String authenticateUser(String username, String password) {
        String hashedPassword = hashPassword(password);
        
        // Check admin table first
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(CHECK_ADMIN)) {
            
            ps.setString(1, username);
            ps.setString(2, hashedPassword);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return "admin"; // Return admin role
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        // If not admin, check user table
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(CHECK_USER)) {
            
            ps.setString(1, username);
            ps.setString(2, hashedPassword);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("role"); // Return user role (employee/customer)
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null; // Authentication failed
    }

    public boolean isUsernameExists(String username) {
        // Check admin table first
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(CHECK_ADMIN_USERNAME)) {
            
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true; // Username exists in admin table
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        // Check user table
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(CHECK_USERNAME)) {
            
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // Username exists in user table
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    public boolean resetPassword(String username, String newPassword) {
        String query = "UPDATE User SET password_hash = ? WHERE username = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            String hashedPassword = hashPassword(newPassword);
            ps.setString(1, hashedPassword);
            ps.setString(2, username);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
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