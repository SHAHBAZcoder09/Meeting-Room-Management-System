package com.shortproject.dto;

import lombok.Data;
import lombok.Builder;

@Data
@Builder
public class DashboardStatsDTO {
    private long totalRooms;
    private long activeBookings;
    private long pendingBookings;
    private long confirmedBookingsToday;
    private long availableRooms;
    private String mostPopularRoomName;
}
