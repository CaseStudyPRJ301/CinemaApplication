package com.example.cinemaapplication.util;

import com.example.cinemaapplication.model.TicketDetail;
import com.example.cinemaapplication.model.BookingGroup;
import java.sql.Timestamp;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.Comparator;

public class BookingGroupUtil {
    
    /**
     * Groups tickets by booking time (within 1 minute tolerance)
     * @param tickets List of ticket details
     * @return List of booking groups
     */
    public static List<BookingGroup> groupTicketsByBookingTime(List<TicketDetail> tickets) {
        Map<Long, BookingGroup> bookingGroups = new HashMap<>();
        
        for (TicketDetail ticket : tickets) {
            // Round booking time to nearest minute for grouping
            long bookingTimeKey = roundToMinute(ticket.getBookingTime().getTime());
            
            BookingGroup group = bookingGroups.get(bookingTimeKey);
            if (group == null) {
                group = new BookingGroup(ticket.getBookingTime());
                bookingGroups.put(bookingTimeKey, group);
            }
            
            group.addTicket(ticket);
        }
        
        // Convert to list and sort by booking time (newest first)
        List<BookingGroup> result = new ArrayList<>(bookingGroups.values());
        result.sort(Comparator.comparing(BookingGroup::getBookingTime).reversed());
        
        return result;
    }
    
    /**
     * Rounds timestamp to nearest minute for grouping purposes
     * @param timestampMillis timestamp in milliseconds
     * @return rounded timestamp in milliseconds
     */
    private static long roundToMinute(long timestampMillis) {
        // Round to nearest minute (60,000 milliseconds)
        return (timestampMillis / 60000) * 60000;
    }
} 