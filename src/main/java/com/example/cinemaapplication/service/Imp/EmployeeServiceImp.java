package com.example.cinemaapplication.service.Imp;

import com.example.cinemaapplication.model.Employee;
import com.example.cinemaapplication.repository.IEmployeeRepository;
import com.example.cinemaapplication.repository.Imp.EmployeeRepositoryImp;
import com.example.cinemaapplication.service.IEmployeeService;

import java.util.List;

public class EmployeeServiceImp implements IEmployeeService {
    private IEmployeeRepository employeeRepository = new EmployeeRepositoryImp();

    @Override
    public List<Employee> getAllEmployees() {
        return employeeRepository.getAllEmployees();
    }

    @Override
    public boolean insertEmployee(Employee employee) {
        return employeeRepository.insertEmployee(employee);
    }
} 