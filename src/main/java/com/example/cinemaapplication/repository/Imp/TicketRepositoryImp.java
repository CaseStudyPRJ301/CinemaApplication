package com.example.cinemaapplication.repository.Imp;

import com.example.cinemaapplication.model.Ticket;
import com.example.cinemaapplication.model.TicketDetail;
import com.example.cinemaapplication.repository.ITicketRepository;
import com.example.cinemaapplication.repository.BaseRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class TicketRepositoryImp extends BaseRepository implements ITicketRepository {
    
    private static final String INSERT_TICKET = "INSERT INTO Ticket (customer_id, seat_id, showtime_id, employee_id, booking_time) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";
    private static final String SELECT_TICKETS_BY_CUSTOMER = "SELECT * FROM Ticket WHERE customer_id = ?";
    private static final String SELECT_TICKETS_BY_EMPLOYEE = "SELECT * FROM Ticket WHERE employee_id = ?";
    private static final String SELECT_TICKETS_BY_SHOWTIME = "SELECT * FROM Ticket WHERE showtime_id = ?";
    private static final String SELECT_TICKET_BY_ID = "SELECT * FROM Ticket WHERE ticket_id = ?";
    private static final String SELECT_BOOKED_SEAT_IDS = "SELECT seat_id FROM Ticket WHERE showtime_id = ?";
    private static final String SELECT_TICKET_DETAILS_BY_CUSTOMER_ID = 
        "SELECT t.ticket_id, t.customer_id, t.seat_id, t.showtime_id, t.employee_id, t.booking_time, " +
        "m.title as movie_title, th.name as theater_name, " +
        "CONCAT(CASE " +
        "  WHEN s.seat_id <= 8 THEN 'A' " +
        "  WHEN s.seat_id <= 16 THEN 'B' " +
        "  WHEN s.seat_id <= 24 THEN 'C' " +
        "  WHEN s.seat_id <= 32 THEN 'D' " +
        "  WHEN s.seat_id <= 40 THEN 'E' " +
        "  WHEN s.seat_id <= 48 THEN 'F' " +
        "  WHEN s.seat_id <= 56 THEN 'G' " +
        "  WHEN s.seat_id <= 60 THEN 'H' " +
        "END, " +
        "CASE " +
        "  WHEN s.seat_id <= 8 THEN s.seat_id " +
        "  WHEN s.seat_id <= 16 THEN s.seat_id - 8 " +
        "  WHEN s.seat_id <= 24 THEN s.seat_id - 16 " +
        "  WHEN s.seat_id <= 32 THEN s.seat_id - 24 " +
        "  WHEN s.seat_id <= 40 THEN s.seat_id - 32 " +
        "  WHEN s.seat_id <= 48 THEN s.seat_id - 40 " +
        "  WHEN s.seat_id <= 56 THEN s.seat_id - 48 " +
        "  WHEN s.seat_id <= 60 THEN s.seat_id - 56 " +
        "END) as seat_position, " +
        "st.show_time, s.seat_type, s.price " +
        "FROM Ticket t " +
        "JOIN Showtime st ON t.showtime_id = st.showtime_id " +
        "JOIN Movie m ON st.movie_id = m.movie_id " +
        "JOIN Theater th ON st.theater_id = th.theater_id " +
        "JOIN Seat s ON t.seat_id = s.seat_id " +
        "WHERE t.customer_id = ? " +
        "ORDER BY t.booking_time DESC";
    
    @Override
    public boolean insertTicket(Ticket ticket) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_TICKET, PreparedStatement.RETURN_GENERATED_KEYS)) {
            
            System.out.println("Inserting ticket: customerId=" + ticket.getCustomerId() + 
                             ", seatId=" + ticket.getSeatId() + 
                             ", showtimeId=" + ticket.getShowtimeId() + 
                             ", employeeId=" + ticket.getEmployeeId());
            
            // Set customer_id (null if employee booking)
            if (ticket.getCustomerId() > 0) {
                ps.setInt(1, ticket.getCustomerId());
            } else {
                ps.setNull(1, java.sql.Types.INTEGER);
            }
            
            ps.setInt(2, ticket.getSeatId());
            ps.setInt(3, ticket.getShowtimeId());
            
            // Set employee_id (null if customer booking)  
            if (ticket.getEmployeeId() > 0) {
                ps.setInt(4, ticket.getEmployeeId());
            } else {
                ps.setNull(4, java.sql.Types.INTEGER);
            }
            
            int result = ps.executeUpdate();
            if (result > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        ticket.setTicketId(rs.getInt(1));
                        System.out.println("Ticket inserted successfully with ID: " + ticket.getTicketId());
                        return true;
                    }
                }
            }
            return false;
        } catch (SQLException e) {
            System.err.println("Error inserting ticket: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public List<Ticket> getTicketsByCustomerId(int customerId) {
        // TODO: Implement later if needed
        return new ArrayList<>();
    }
    
    @Override
    public List<Ticket> getTicketsByEmployeeId(int employeeId) {
        // TODO: Implement later if needed  
        return new ArrayList<>();
    }
    
    @Override
    public List<Ticket> getTicketsByShowtimeId(int showtimeId) {
        // TODO: Implement later if needed
        return new ArrayList<>();
    }
    
    @Override
    public Ticket getTicketById(int ticketId) {
        // TODO: Implement later if needed
        return null;
    }
    
    @Override
    public List<Integer> getBookedSeatIdsByShowtime(int showtimeId) {
        List<Integer> bookedSeatIds = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_BOOKED_SEAT_IDS)) {
            ps.setInt(1, showtimeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    bookedSeatIds.add(rs.getInt("seat_id"));
                }
            }
            System.out.println("Found " + bookedSeatIds.size() + " booked seats for showtime " + showtimeId + ": " + bookedSeatIds);
        } catch (SQLException e) {
            System.err.println("Error getting booked seat IDs: " + e.getMessage());
            e.printStackTrace();
        }
        return bookedSeatIds;
    }
    
    public List<TicketDetail> getTicketDetailsByCustomerId(int customerId) {
        List<TicketDetail> ticketDetails = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_TICKET_DETAILS_BY_CUSTOMER_ID)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    TicketDetail detail = new TicketDetail(
                        rs.getInt("ticket_id"),
                        rs.getInt("customer_id"),
                        rs.getInt("seat_id"),
                        rs.getInt("showtime_id"),
                        rs.getInt("employee_id"),
                        rs.getTimestamp("booking_time"),
                        rs.getString("movie_title"),
                        rs.getString("theater_name"),
                        rs.getString("seat_position"),
                        rs.getTimestamp("show_time"),
                        rs.getString("seat_type"),
                        rs.getDouble("price")
                    );
                    ticketDetails.add(detail);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting ticket details: " + e.getMessage());
            e.printStackTrace();
        }
        return ticketDetails;
    }
}
