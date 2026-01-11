package com.shortproject.service;

import com.shortproject.model.MeetingRoom;
import com.shortproject.repository.MeetingRoomRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class RoomService {

    private final MeetingRoomRepository roomRepository;

    public List<MeetingRoom> getAllRooms() {
        return roomRepository.findAll();
    }

    public List<MeetingRoom> getAvailableRooms() {
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
}
