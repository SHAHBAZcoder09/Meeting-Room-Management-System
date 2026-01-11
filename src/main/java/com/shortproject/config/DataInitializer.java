package com.shortproject.config;

import com.shortproject.model.MeetingRoom;
import com.shortproject.repository.MeetingRoomRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DataInitializer {
    
    @Bean
    CommandLineRunner initDatabase(MeetingRoomRepository roomRepository) {
        return args -> {
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
