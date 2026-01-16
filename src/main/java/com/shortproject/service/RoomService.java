package com.shortproject.service;

import com.shortproject.model.Booking; // Add import
import com.shortproject.model.MeetingRoom; // Add this back
import com.shortproject.repository.BookingRepository; // Add import
import com.shortproject.repository.MeetingRoomRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime; // Add import
import java.util.List;

@Service
@RequiredArgsConstructor
public class RoomService {

    private final MeetingRoomRepository roomRepository;
    private final BookingRepository bookingRepository;



    public List<MeetingRoom> getAllRooms() {
        List<MeetingRoom> rooms = roomRepository.findAll();
        LocalDateTime now = LocalDateTime.now();
        
        for (MeetingRoom room : rooms) {
            // "MAINTENANCE" overrides everything
            if ("MAINTENANCE".equals(room.getStatus())) continue;
            
            List<Booking> activeBookings = bookingRepository.findConflictingBookings(room.getId(), now, now);
            if (!activeBookings.isEmpty()) {
                room.setStatus("Occupied");
            } else {
                room.setStatus("Available");
            }
        }
        return rooms;
    }

    public List<MeetingRoom> getAvailableRooms() {
        // This is a naive implementation, real availability depends on time
        return roomRepository.findByStatus("AVAILABLE");
    }

    public MeetingRoom getRoomById(Long id) {
        return roomRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Room not found"));
    }

    public MeetingRoom createRoom(MeetingRoom room) {
        return roomRepository.save(room);
    }
    
    public MeetingRoom updateRoom(Long id, MeetingRoom roomDetails) {
        MeetingRoom room = getRoomById(id);
        room.setName(roomDetails.getName());
        room.setCapacity(roomDetails.getCapacity());
        room.setAmenities(roomDetails.getAmenities());
        room.setDescription(roomDetails.getDescription());
        room.setImageUrl(roomDetails.getImageUrl());
        return roomRepository.save(room);
    }

    public void deleteRoom(Long id) {
        roomRepository.deleteById(id);
    }
    
    public List<MeetingRoom> searchRooms(LocalDateTime start, LocalDateTime end, Integer capacity) {
        List<MeetingRoom> allRooms;
        if (capacity != null) {
            allRooms = roomRepository.findByCapacityGreaterThanEqual(capacity);
        } else {
            allRooms = roomRepository.findAll();
        }

        // Filter out rooms that are booked or in maintenance
        return allRooms.stream().filter(room -> {
            if ("MAINTENANCE".equals(room.getStatus())) return false;
            
            // If timestamps provided, check conflicts
            if (start != null && end != null) {
                List<Booking> conflicts = bookingRepository.findConflictingBookings(room.getId(), start, end);
                return conflicts.isEmpty();
            }
            return true;
        }).toList();
    }
}
