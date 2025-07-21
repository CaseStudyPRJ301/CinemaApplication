package com.example.cinemaapplication.repository;

import com.example.cinemaapplication.model.Customer;
import java.util.List;

public interface ICustomerRepository {
    List<Customer> getAllCustomers();
    Customer getCustomerById(int id);
    boolean insertCustomer(Customer customer);
}
