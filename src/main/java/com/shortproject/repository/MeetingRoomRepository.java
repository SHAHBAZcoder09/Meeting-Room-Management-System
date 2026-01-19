package com.shortproject.repository;

import com.shortproject.model.MeetingRoom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface MeetingRoomRepository extends JpaRepository<MeetingRoom, Long> {
    List<MeetingRoom> findByStatus(String status);
    List<MeetingRoom> findByCapacityGreaterThanEqual(int capacity);
}
