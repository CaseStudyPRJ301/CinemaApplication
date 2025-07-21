package com.example.cinemaapplication.repository.Imp;

import com.example.cinemaapplication.model.Customer;
import com.example.cinemaapplication.repository.ICustomerRepository;
import com.example.cinemaapplication.repository.BaseRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class CustomerRepositoryImp extends BaseRepository implements ICustomerRepository {
    private static final String SELECT_ALL_CUSTOMERS = "SELECT * FROM Customer ORDER BY created_at DESC";
    private static final String SELECT_CUSTOMER_BY_ID = "SELECT * FROM Customer WHERE customer_id = ?";
    private static final String INSERT_CUSTOMER = "INSERT INTO Customer (name, phone_number, email) VALUES (?, ?, ?)";

    @Override
    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL_CUSTOMERS);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int id = rs.getInt("customer_id");
                String name = rs.getString("name");
                String phoneNumber = rs.getString("phone_number");
                String email = rs.getString("email");
                Timestamp createdAt = rs.getTimestamp("created_at");
                customers.add(new Customer(id, name, phoneNumber, email, createdAt));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    @Override
    public Customer getCustomerById(int id) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_CUSTOMER_BY_ID)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String name = rs.getString("name");
                    String phoneNumber = rs.getString("phone_number");
                    String email = rs.getString("email");
                    Timestamp createdAt = rs.getTimestamp("created_at");
                    return new Customer(id, name, phoneNumber, email, createdAt);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean insertCustomer(Customer customer) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_CUSTOMER, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getPhoneNumber());
            ps.setString(3, customer.getEmail());
            
            int result = ps.executeUpdate();
            if (result > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        customer.setCustomerId(rs.getInt(1));
                        return true;
                    }
                }
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
