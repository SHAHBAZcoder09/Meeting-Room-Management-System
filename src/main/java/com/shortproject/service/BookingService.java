package com.shortproject.service;

import com.shortproject.model.Booking;
import com.shortproject.model.MeetingRoom;
import com.shortproject.model.User;
import com.shortproject.repository.BookingRepository;
import com.shortproject.repository.MeetingRoomRepository; // Correct import
import com.shortproject.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class BookingService {

    private final BookingRepository bookingRepository;
    private final MeetingRoomRepository roomRepository; // Used to fetch room context
    private final UserRepository userRepository; // Used to fetch user context

    public Booking createBooking(Long userId, Long roomId, LocalDateTime start, LocalDateTime end, String purpose) {
        // 1. Check availability
        List<Booking> conflicts = bookingRepository.findConflictingBookings(roomId, start, end);
        if (!conflicts.isEmpty()) {
            throw new RuntimeException("Room is already booked for this time slot.");
        }

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        MeetingRoom room = roomRepository.findById(roomId)
                .orElseThrow(() -> new RuntimeException("Room not found"));

        Booking booking = new Booking();
        booking.setUser(user);
        booking.setRoom(room);
        booking.setStartTime(start);
        booking.setEndTime(end);
        booking.setPurpose(purpose);
        booking.setStatus("CONFIRMED");

        return bookingRepository.save(booking);
    }

    public List<Booking> getUserBookings(Long userId) {
        return bookingRepository.findByUserId(userId);
    }

    public void cancelBooking(Long bookingId) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        booking.setStatus("CANCELLED");
        bookingRepository.save(booking);
    }
}
