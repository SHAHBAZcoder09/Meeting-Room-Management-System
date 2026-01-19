package com.shortproject.controller;

import com.shortproject.model.MeetingRoom;
import com.shortproject.service.RoomService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/rooms")
@RequiredArgsConstructor
public class RoomController {

    private final RoomService roomService;

    @GetMapping
    public ResponseEntity<List<MeetingRoom>> getAllRooms() {
        return ResponseEntity.ok(roomService.getAllRooms());
    }

    @GetMapping("/search")
    public ResponseEntity<List<MeetingRoom>> searchRooms(
            @RequestParam(required = false) String date,
            @RequestParam(required = false) String startTime,
            @RequestParam(required = false) String endTime,
            @RequestParam(required = false) Integer capacity) {
        
        LocalDateTime start = null;
        LocalDateTime end = null;

        if (date != null && startTime != null && endTime != null) {
            start = LocalDateTime.parse(date + "T" + startTime);
            end = LocalDateTime.parse(date + "T" + endTime);
        }

        return ResponseEntity.ok(roomService.searchRooms(start, end, capacity));
    }

    @PostMapping
    public ResponseEntity<MeetingRoom> createRoom(@RequestBody MeetingRoom room) {
        return ResponseEntity.ok(roomService.createRoom(room));
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<MeetingRoom> getRoomById(@PathVariable Long id) {
        return ResponseEntity.ok(roomService.getRoomById(id));
    }

    @PutMapping("/{id}")
    public ResponseEntity<MeetingRoom> updateRoom(@PathVariable Long id, @RequestBody MeetingRoom roomDetails) {
        return ResponseEntity.ok(roomService.updateRoom(id, roomDetails));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteRoom(@PathVariable Long id) {
        roomService.deleteRoom(id);
        return ResponseEntity.ok().build();
    }
    
    // Additional admin endpoints can be added here
}
