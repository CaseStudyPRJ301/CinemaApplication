package com.example.cinemaapplication.service;

import com.example.cinemaapplication.model.Ticket;
import java.util.List;

public interface ITicketService {
    boolean createTicketsForBooking(String selectedSeats, int showtimeId, int theaterId, Integer customerId, Integer employeeId);
    List<Ticket> getTicketsByCustomerId(int customerId);
    List<Ticket> getTicketsByEmployeeId(int employeeId);
    List<Integer> getBookedSeatIdsByShowtime(int showtimeId);
} 