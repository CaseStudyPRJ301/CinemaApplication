package com.example.cinemaapplication.repository.Imp;

import com.example.cinemaapplication.model.Employee;
import com.example.cinemaapplication.repository.IEmployeeRepository;
import com.example.cinemaapplication.repository.BaseRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EmployeeRepositoryImp extends BaseRepository implements IEmployeeRepository {
    private static final String SELECT_ALL_EMPLOYEES = "SELECT * FROM Employee";
    private static final String INSERT_EMPLOYEE = "INSERT INTO Employee (name, phone, email) VALUES (?, ?, ?)";

    @Override
    public List<Employee> getAllEmployees() {
        List<Employee> employees = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL_EMPLOYEES);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int id = rs.getInt("employee_id");
                String name = rs.getString("name");
                String phone = rs.getString("phone");
                String email = rs.getString("email");
                employees.add(new Employee(id, name, phone, email));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }

    @Override
    public boolean insertEmployee(Employee employee) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_EMPLOYEE)) {
            ps.setString(1, employee.getName());
            ps.setString(2, employee.getPhone());
            ps.setString(3, employee.getEmail());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
