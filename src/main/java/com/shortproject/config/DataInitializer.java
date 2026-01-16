package com.shortproject.config;

import com.shortproject.model.MeetingRoom;
import com.shortproject.repository.MeetingRoomRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DataInitializer {
    
    private final org.springframework.security.crypto.password.PasswordEncoder passwordEncoder;

    public DataInitializer(org.springframework.security.crypto.password.PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    @Bean
    CommandLineRunner initDatabase(com.shortproject.repository.MeetingRoomRepository roomRepository, com.shortproject.repository.UserRepository userRepository) {
        return args -> {
            // Seed Admin User
            if (!userRepository.existsByEmail("admin@n4.com")) {
                com.shortproject.model.User admin = new com.shortproject.model.User();
                admin.setFirstName("Super");
                admin.setLastName("Admin");
                admin.setEmail("admin@n4.com");
                admin.setPassword(passwordEncoder.encode("admin123"));
                admin.setRole("ADMIN");
                admin.setActive(true);
                userRepository.save(admin);
                System.out.println("Created default admin: admin@n4.com / admin123");
            }

            // Seed Rooms
            if(roomRepository.count() == 0) {
                MeetingRoom room1 = new MeetingRoom();
                room1.setName("Conference Room A");
                room1.setCapacity(10);
                room1.setAmenities("Projector, Whiteboard, WiFi, Video Conf");
                room1.setDescription("Ideally suited for team standups and client presentations.");
                room1.setStatus("AVAILABLE");
                roomRepository.save(room1);

                MeetingRoom room2 = new MeetingRoom();
                room2.setName("Focus Pod 1");
                room2.setCapacity(2);
                room2.setAmenities("WiFi, Power Outlets, Soundproofing");
                room2.setDescription("A quiet space for deep work or 1-on-1 chats.");
                room2.setStatus("AVAILABLE");
                roomRepository.save(room2);
                
                MeetingRoom room3 = new MeetingRoom();
                room3.setName("Boardroom X");
                room3.setCapacity(20);
                room3.setAmenities("4K Screen, High-end Audio, Catering Service");
                room3.setDescription("Executive boardroom for high-stakes meetings.");
                room3.setStatus("AVAILABLE");
                roomRepository.save(room3);
                
                System.out.println("Initialized database with sample rooms.");
            }
        };
    }
}
