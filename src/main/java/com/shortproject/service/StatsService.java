package com.shortproject.service;

import com.shortproject.dto.DashboardStatsDTO;
import com.shortproject.model.Booking;
import com.shortproject.model.MeetingRoom;
import com.shortproject.repository.BookingRepository;
import com.shortproject.repository.MeetingRoomRepository; // Updated to correct repository
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class StatsService {

    private final MeetingRoomRepository roomRepository;
    private final BookingRepository bookingRepository;

    public DashboardStatsDTO getDashboardStats() {
        long totalRooms = roomRepository.count();

        List<Booking> allBookings = bookingRepository.findAll();
        
        long pending = allBookings.stream()
                .filter(b -> "PENDING".equals(b.getStatus()))
                .count();

        LocalDateTime startOfDay = LocalDateTime.of(LocalDate.now(), LocalTime.MIN);
        LocalDateTime endOfDay = LocalDateTime.of(LocalDate.now(), LocalTime.MAX);

        long confirmedToday = allBookings.stream()
                .filter(b -> "CONFIRMED".equals(b.getStatus()))
                .filter(b -> b.getStartTime().isAfter(startOfDay) && b.getStartTime().isBefore(endOfDay))
                .count();
        
        long activeNow = allBookings.stream()
                .filter(b -> "CONFIRMED".equals(b.getStatus()))
                .filter(b -> {
                    LocalDateTime now = LocalDateTime.now();
                    return b.getStartTime().isBefore(now) && b.getEndTime().isAfter(now);
                })
                .count();

        // Find most popular room (simple heuristic: most total bookings)
        String popularRoom = allBookings.stream()
                .filter(b -> "CONFIRMED".equals(b.getStatus()))
                .collect(Collectors.groupingBy(b -> b.getRoom().getName(), Collectors.counting()))
                .entrySet().stream()
                .max(Map.Entry.comparingByValue())
                .map(Map.Entry::getKey)
                .orElse("None");
        
        long maintenanceRooms = roomRepository.findByStatus("MAINTENANCE").size();
        long availableRooms = totalRooms - activeNow - maintenanceRooms;

        return DashboardStatsDTO.builder()
                .totalRooms(totalRooms)
                .pendingBookings(pending)
                .confirmedBookingsToday(confirmedToday)
                .activeBookings(activeNow)
                .availableRooms(availableRooms)
                .mostPopularRoomName(popularRoom)
                .build();
    }
}
