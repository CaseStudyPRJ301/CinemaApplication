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
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(CHECK_USER)) {
            
            String hashedPassword = hashPassword(password);
            ps.setString(1, username);
            ps.setString(2, hashedPassword);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("role");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean isUsernameExists(String username) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(CHECK_USERNAME)) {
            
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            return rs.next();
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