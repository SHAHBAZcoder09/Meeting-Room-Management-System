package com.shortproject.repository;

import com.shortproject.model.Booking;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Long> {
    List<Booking> findByUserId(Long userId);
    List<Booking> findByRoomId(Long roomId);
    
    @Query("SELECT b FROM Booking b WHERE b.room.id = :roomId AND b.status = 'CONFIRMED' AND " +
           "((b.startTime BETWEEN :start AND :end) OR (b.endTime BETWEEN :start AND :end) OR " +
           "(:start BETWEEN b.startTime AND b.endTime))")
    List<Booking> findConflictingBookings(@Param("roomId") Long roomId, 
                                          @Param("start") LocalDateTime start, 
                                          @Param("end") LocalDateTime end);
}
