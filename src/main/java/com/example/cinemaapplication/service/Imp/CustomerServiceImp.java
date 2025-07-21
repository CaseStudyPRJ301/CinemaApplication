package com.example.cinemaapplication.service.Imp;

import com.example.cinemaapplication.model.Customer;
import com.example.cinemaapplication.repository.ICustomerRepository;
import com.example.cinemaapplication.repository.Imp.CustomerRepositoryImp;
import com.example.cinemaapplication.service.ICustomerService;

import java.util.List;

public class CustomerServiceImp implements ICustomerService {
    private ICustomerRepository customerRepository = new CustomerRepositoryImp();

    @Override
    public List<Customer> getAllCustomers() {
        return customerRepository.getAllCustomers();
    }

    @Override
    public Customer getCustomerById(int id) {
        return customerRepository.getCustomerById(id);
    }

    @Override
    public boolean insertCustomer(Customer customer) {
        return customerRepository.insertCustomer(customer);
    }
} 