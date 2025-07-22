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
    
        private static final String SELECT_TICKET_DETAILS_BY_EMPLOYEE_ID =
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
        "WHERE t.employee_id = ? " +
        "ORDER BY t.booking_time DESC";

    private static final String SELECT_ALL_TICKET_DETAILS =
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
    
    public List<TicketDetail> getTicketDetailsByEmployeeId(int employeeId) {
        List<TicketDetail> ticketDetails = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_TICKET_DETAILS_BY_EMPLOYEE_ID)) {
            ps.setInt(1, employeeId);
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
            System.err.println("Error getting ticket details by employee: " + e.getMessage());
            e.printStackTrace();
        }
        return ticketDetails;
    }
    
    public List<TicketDetail> getAllTicketDetails() {
        List<TicketDetail> ticketDetails = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL_TICKET_DETAILS)) {
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
            System.err.println("Error getting all ticket details: " + e.getMessage());
            e.printStackTrace();
        }
        return ticketDetails;
    }
    
    public int getAvailableSeatsForShowtime(int showtimeId) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 "SELECT (SELECT COUNT(*) FROM Seat WHERE theater_id = s.theater_id) - " +
                 "(SELECT COUNT(*) FROM Ticket WHERE showtime_id = ?) as available_seats " +
                 "FROM Showtime s WHERE s.showtime_id = ?")) {
            ps.setInt(1, showtimeId);
            ps.setInt(2, showtimeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int availableSeats = rs.getInt("available_seats");
                    System.out.println("Showtime " + showtimeId + " - Available seats: " + availableSeats);
                    return availableSeats;
                } else {
                    System.out.println("Showtime " + showtimeId + " - No result found");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting available seats for showtime " + showtimeId + ": " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }
    
    public boolean isShowtimeFullyBooked(int showtimeId) {
        // Count booked seats for this specific showtime
        int bookedSeats = getBookedSeatsForShowtime(showtimeId);
        int totalSeats = 60; // Each showtime has 60 seats available
        boolean isFullyBooked = bookedSeats >= totalSeats;
        
        System.out.println("Showtime " + showtimeId + " - Total seats: " + totalSeats + ", Booked seats: " + bookedSeats + ", Is fully booked: " + isFullyBooked);
        
        return isFullyBooked;
    }
    
    public int getBookedSeatsForShowtime(int showtimeId) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 "SELECT COUNT(*) as booked_seats FROM Ticket WHERE showtime_id = ?")) {
            ps.setInt(1, showtimeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int bookedSeats = rs.getInt("booked_seats");
                    System.out.println("Showtime " + showtimeId + " - Booked seats: " + bookedSeats);
                    return bookedSeats;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting booked seats for showtime " + showtimeId + ": " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }
    
    public boolean createDummyBooking(Integer customerId, Integer employeeId, int showtimeId, int theaterId, String selectedSeats, int totalPrice, java.util.Date bookingTime) {
        try (Connection conn = getConnection()) {
            // Parse selected seats
            String[] seatPositions = selectedSeats.split(",");
            
            for (String seatPosition : seatPositions) {
                seatPosition = seatPosition.trim();
                
                // Convert seat position to seat ID (simplified logic)
                int seatId = convertSeatPositionToId(seatPosition, theaterId);
                
                // Create ticket
                PreparedStatement ps = conn.prepareStatement(INSERT_TICKET, PreparedStatement.RETURN_GENERATED_KEYS);
                
                if (customerId != null) {
                    ps.setInt(1, customerId);
                } else {
                    ps.setNull(1, java.sql.Types.INTEGER);
                }
                
                ps.setInt(2, seatId);
                ps.setInt(3, showtimeId);
                
                if (employeeId != null) {
                    ps.setInt(4, employeeId);
                } else {
                    ps.setNull(4, java.sql.Types.INTEGER);
                }
                
                int result = ps.executeUpdate();
                if (result <= 0) {
                    System.err.println("Failed to create ticket for seat: " + seatPosition);
                    return false;
                }
            }
            
            System.out.println("Successfully created dummy booking with " + seatPositions.length + " tickets");
            return true;
            
        } catch (SQLException e) {
            System.err.println("Error creating dummy booking: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    private int convertSeatPositionToId(String seatPosition, int theaterId) {
        // Simplified conversion logic
        // This should match the logic used in the seat selection page
        char row = seatPosition.charAt(0);
        int seatNumber = Integer.parseInt(seatPosition.substring(1));
        
        // Each theater has 56 seats (7 rows x 8 seats)
        int baseSeatId = (theaterId - 1) * 56;
        
        int rowOffset = 0;
        switch (row) {
            case 'A': rowOffset = 0; break;
            case 'B': rowOffset = 8; break;
            case 'C': rowOffset = 16; break;
            case 'D': rowOffset = 24; break;
            case 'E': rowOffset = 32; break;
            case 'F': rowOffset = 40; break;
            case 'G': rowOffset = 48; break;
            default: rowOffset = 0;
        }
        
        int seatId = baseSeatId + rowOffset + seatNumber;
        System.out.println("Converting seat " + seatPosition + " in theater " + theaterId + " to seat ID: " + seatId);
        return seatId;
    }
}
