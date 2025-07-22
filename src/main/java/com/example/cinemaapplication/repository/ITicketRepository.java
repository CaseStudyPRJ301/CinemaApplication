package com.example.cinemaapplication.repository;

import com.example.cinemaapplication.model.Ticket;
import com.example.cinemaapplication.model.TicketDetail;
import java.util.List;

public interface ITicketRepository {
    boolean insertTicket(Ticket ticket);
    List<Ticket> getTicketsByCustomerId(int customerId);
    List<Ticket> getTicketsByEmployeeId(int employeeId);
    List<Ticket> getTicketsByShowtimeId(int showtimeId);
    Ticket getTicketById(int ticketId);
    List<Integer> getBookedSeatIdsByShowtime(int showtimeId);
    List<TicketDetail> getTicketDetailsByCustomerId(int customerId);
}
