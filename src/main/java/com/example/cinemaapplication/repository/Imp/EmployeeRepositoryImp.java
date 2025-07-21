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
    private static final String SELECT_EMPLOYEE_BY_ID = "SELECT * FROM Employee WHERE employee_id = ?";
    private static final String UPDATE_EMPLOYEE = "UPDATE Employee SET name = ?, phone = ?, email = ? WHERE employee_id = ?";
    private static final String CHECK_EMAIL_EXISTS = "SELECT COUNT(*) FROM Employee WHERE email = ?";
    private static final String CHECK_PHONE_EXISTS = "SELECT COUNT(*) FROM Employee WHERE phone = ?";
    private static final String CHECK_EMAIL_EXISTS_OTHER = "SELECT COUNT(*) FROM Employee WHERE email = ? AND employee_id != ?";
    private static final String CHECK_PHONE_EXISTS_OTHER = "SELECT COUNT(*) FROM Employee WHERE phone = ? AND employee_id != ?";

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
             PreparedStatement ps = conn.prepareStatement(INSERT_EMPLOYEE, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, employee.getName());
            ps.setString(2, employee.getPhone());
            ps.setString(3, employee.getEmail());
            
            int result = ps.executeUpdate();
            if (result > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        employee.setEmployeeId(rs.getInt(1));
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

    @Override
    public boolean emailExists(String email) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(CHECK_EMAIL_EXISTS)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean phoneExists(String phone) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(CHECK_PHONE_EXISTS)) {
            ps.setString(1, phone);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Employee getEmployeeById(int id) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_EMPLOYEE_BY_ID)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String name = rs.getString("name");
                    String phone = rs.getString("phone");
                    String email = rs.getString("email");
                    return new Employee(id, name, phone, email);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean updateEmployee(Employee employee) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_EMPLOYEE)) {
            ps.setString(1, employee.getName());
            ps.setString(2, employee.getPhone());
            ps.setString(3, employee.getEmail());
            ps.setInt(4, employee.getEmployeeId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean emailExistsForOtherEmployee(String email, int excludeId) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(CHECK_EMAIL_EXISTS_OTHER)) {
            ps.setString(1, email);
            ps.setInt(2, excludeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean phoneExistsForOtherEmployee(String phone, int excludeId) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(CHECK_PHONE_EXISTS_OTHER)) {
            ps.setString(1, phone);
            ps.setInt(2, excludeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
