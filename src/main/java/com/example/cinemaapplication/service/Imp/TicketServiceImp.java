package com.example.cinemaapplication.service.Imp;

import com.example.cinemaapplication.model.Ticket;
import com.example.cinemaapplication.repository.ITicketRepository;
import com.example.cinemaapplication.repository.Imp.TicketRepositoryImp;
import com.example.cinemaapplication.service.ITicketService;

import java.util.List;

public class TicketServiceImp implements ITicketService {
    
    private ITicketRepository ticketRepository;
    
    public TicketServiceImp() {
        this.ticketRepository = new TicketRepositoryImp();
    }
    
    @Override
    public boolean createTicketsForBooking(String selectedSeats, int showtimeId, int theaterId, Integer customerId, Integer employeeId) {
        System.out.println("=== CREATING TICKETS FOR BOOKING ===");
        System.out.println("Selected seats: " + selectedSeats);
        System.out.println("Showtime ID: " + showtimeId);
        System.out.println("Theater ID: " + theaterId);
        System.out.println("Customer ID: " + customerId);
        System.out.println("Employee ID: " + employeeId);
        
        // Parse selected seats (e.g., "E5,E6")
        String[] seats = selectedSeats.split(",");
        boolean allTicketsCreated = true;
        
        for (String seatPosition : seats) {
            seatPosition = seatPosition.trim();
            int seatId = convertSeatPositionToSeatId(seatPosition, theaterId);
            
            if (seatId == -1) {
                System.err.println("Invalid seat position: " + seatPosition);
                allTicketsCreated = false;
                continue;
            }
            
            // Create ticket object
            Ticket ticket = new Ticket();
            ticket.setSeatId(seatId);
            ticket.setShowtimeId(showtimeId);
            
            // Set customer_id or employee_id based on role
            if (customerId != null && customerId > 0) {
                ticket.setCustomerId(customerId);
                ticket.setEmployeeId(0); // Will be set to null in repository
            } else if (employeeId != null && employeeId > 0) {
                ticket.setCustomerId(0); // Will be set to null in repository
                ticket.setEmployeeId(employeeId);
            } else {
                System.err.println("Neither customer_id nor employee_id provided");
                allTicketsCreated = false;
                continue;
            }
            
            // Insert ticket
            boolean inserted = ticketRepository.insertTicket(ticket);
            if (!inserted) {
                System.err.println("Failed to insert ticket for seat: " + seatPosition);
                allTicketsCreated = false;
            } else {
                System.out.println("Successfully created ticket for seat: " + seatPosition + " (ID: " + seatId + ")");
            }
        }
        
        System.out.println("All tickets created: " + allTicketsCreated);
        return allTicketsCreated;
    }
    
    /**
     * Convert seat position (e.g., "E5") to seat_id based on theater
     * Theater layout: 8 seats per row
     * A1-A8 (1-8), B1-B8 (9-16), C1-C8 (17-24), 
     * D1-D8 (25-32), E1-E8 (33-40), F1-F8 (41-48), G1-G8 (49-56),
     * H1-H4 (57-60) - couple seats
     * 
     * Theater offset: Theater 1 = +0, Theater 2 = +60, Theater 3 = +120
     */
    private int convertSeatPositionToSeatId(String seatPosition, int theaterId) {
        try {
            if (seatPosition == null || seatPosition.length() < 2) {
                return -1;
            }
            
            char row = seatPosition.charAt(0);
            String numberStr = seatPosition.substring(1);
            
            // Handle couple seats (H1-H4 but displayed as H1, H2, H3, H4)
            if (row == 'H') {
                int number = Integer.parseInt(numberStr);
                if (number < 1 || number > 4) {
                    return -1;
                }
                // H1=57, H2=58, H3=59, H4=60
                int seatId = 56 + number;
                return seatId + ((theaterId - 1) * 60);
            }
            
            // Handle normal/VIP seats (1-8 per row)
            int number = Integer.parseInt(numberStr);
            if (number < 1 || number > 8) {
                return -1;
            }
            
            int rowOffset = 0;
            switch (row) {
                case 'A': rowOffset = 0; break;   // 1-8
                case 'B': rowOffset = 8; break;   // 9-16
                case 'C': rowOffset = 16; break;  // 17-24
                case 'D': rowOffset = 24; break;  // 25-32
                case 'E': rowOffset = 32; break;  // 33-40
                case 'F': rowOffset = 40; break;  // 41-48
                case 'G': rowOffset = 48; break;  // 49-56
                default: return -1;
            }
            
            int seatId = rowOffset + number;
            int theaterOffset = (theaterId - 1) * 60;
            
            System.out.println("Converting " + seatPosition + " -> seatId=" + seatId + " + theaterOffset=" + theaterOffset + " = " + (seatId + theaterOffset));
            
            return seatId + theaterOffset;
            
        } catch (NumberFormatException e) {
            System.err.println("Error parsing seat position: " + seatPosition);
            return -1;
        }
    }
    
    @Override
    public List<Ticket> getTicketsByCustomerId(int customerId) {
        return ticketRepository.getTicketsByCustomerId(customerId);
    }
    
    @Override
    public List<Ticket> getTicketsByEmployeeId(int employeeId) {
        return ticketRepository.getTicketsByEmployeeId(employeeId);
    }
    
    @Override
    public List<Integer> getBookedSeatIdsByShowtime(int showtimeId) {
        return ticketRepository.getBookedSeatIdsByShowtime(showtimeId);
    }
} 