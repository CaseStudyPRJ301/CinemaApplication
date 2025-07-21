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

    @Override
    public boolean emailExists(String email) {
        return employeeRepository.emailExists(email);
    }

    @Override
    public boolean phoneExists(String phone) {
        return employeeRepository.phoneExists(phone);
    }

    @Override
    public Employee getEmployeeById(int id) {
        return employeeRepository.getEmployeeById(id);
    }

    @Override
    public boolean updateEmployee(Employee employee) {
        return employeeRepository.updateEmployee(employee);
    }

    @Override
    public boolean emailExistsForOtherEmployee(String email, int excludeId) {
        return employeeRepository.emailExistsForOtherEmployee(email, excludeId);
    }

    @Override
    public boolean phoneExistsForOtherEmployee(String phone, int excludeId) {
        return employeeRepository.phoneExistsForOtherEmployee(phone, excludeId);
    }
} 