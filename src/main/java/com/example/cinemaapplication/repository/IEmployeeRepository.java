package com.example.cinemaapplication.repository;

import java.util.List;
import com.example.cinemaapplication.model.Employee;

public interface IEmployeeRepository {
    List<Employee> getAllEmployees();
    boolean insertEmployee(Employee employee);
    boolean emailExists(String email);
    boolean phoneExists(String phone);
}
