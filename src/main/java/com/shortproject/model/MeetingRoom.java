package com.shortproject.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Entity
@Table(name = "meeting_rooms")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class MeetingRoom {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private Integer capacity;

    private String amenities; // Comma separated values e.g. "Projector,Whiteboard,WiFi"

    private String description;
    
    // Status: AVAILABLE, MAINTENANCE
    @Column(nullable = false)
    private String status = "AVAILABLE";
    
    private String imageUrl; // Placeholder for UI
}
