package com.example.cinemaapplication.service;

import com.example.cinemaapplication.model.Customer;
import java.util.List;

public interface ICustomerService {
    List<Customer> getAllCustomers();
    Customer getCustomerById(int id);
    boolean insertCustomer(Customer customer);
} 