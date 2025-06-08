package com.example.cinemaapplication.model;

public class Employee {
    private int employeeId;
    private String name;
    private String phone;
    private String email;

    public Employee() {
    }

    public Employee(int employeeId, String name, String phone, String email) {
        this.employeeId = employeeId;
        this.name = name;
        this.phone = phone;
        this.email = email;
    }

    public int getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}