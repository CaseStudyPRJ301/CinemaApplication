package com.example.cinemaapplication.repository;

import java.util.List;
import com.example.cinemaapplication.model.Employee;

public interface IEmployeeRepository {
    List<Employee> getAllEmployees();
    boolean insertEmployee(Employee employee);
    Employee getEmployeeById(int id);
    boolean updateEmployee(Employee employee);
    boolean emailExists(String email);
    boolean phoneExists(String phone);
    boolean emailExistsForOtherEmployee(String email, int excludeId);
    boolean phoneExistsForOtherEmployee(String phone, int excludeId);
}
