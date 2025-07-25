package com.example.cinemaapplication.service;

import com.example.cinemaapplication.model.Employee;
import java.util.List;

public interface IEmployeeService {
    List<Employee> getAllEmployees();
    boolean insertEmployee(Employee employee);
    Employee getEmployeeById(int id);
    boolean updateEmployee(Employee employee);
    boolean emailExists(String email);
    boolean phoneExists(String phone);
    boolean emailExistsForOtherEmployee(String email, int excludeId);
    boolean phoneExistsForOtherEmployee(String phone, int excludeId);
} 