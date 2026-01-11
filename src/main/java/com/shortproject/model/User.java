package com.shortproject.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String firstName;

    @Column(nullable = false)
    private String lastName;

    @Column(nullable = false)
    private String role;

    @Column(nullable = false, columnDefinition = "BOOLEAN DEFAULT true")
    private boolean active = true;

    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    @Column(nullable = false)
    private LocalDateTime updatedAt = LocalDateTime.now();
}



DELETE FROM Bookings
WHERE booking_id = 5;



UPDATE Bookings
SET 
    start_time = '2023-10-27 16:00:00',
    end_time = '2023-10-27 17:30:00',
    purpose = 'Q4 Strategy Planning (Rescheduled)'
WHERE booking_id = 5;




INSERT INTO Bookings (room_id, user_name, start_time, end_time, purpose)
VALUES (
    101, 
    'John Doe', 
    '2023-10-27 14:00:00', 
    '2023-10-27 15:30:00', 
    'Q4 Strategy Planning'
);