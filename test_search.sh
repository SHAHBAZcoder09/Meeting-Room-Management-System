#!/bin/bash

# Base URL
URL="http://localhost:8080/api"

# 1. Login to get token
echo "Logging in..."
LOGIN_RES=$(curl -s -X POST $URL/users/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "password"
  }')
TOKEN=$(echo $LOGIN_RES | grep -o '"token":"[^"]*' | cut -d'"' -f4)

if [ -z "$TOKEN" ]; then
  echo "Failed to get token"
  exit 1
fi
echo "Got Token"

# 2. Search by Capacity
echo "Searching for capacity >= 50..."
SEARCH_CAP=$(curl -s -H "Authorization: Bearer $TOKEN" "$URL/rooms/search?capacity=50")
echo "Result Capacity search: $SEARCH_CAP"

# 3. Search by Availability (Date/Time)
# Assume we have a booking from 02:00 to 03:00 on 2026-01-15 (from previous repro script)
# So searching for that slot should return nothing (or rooms excluding the booked one)
DATE="2026-01-15"
START="02:00:00"
END="03:00:00"

echo "Searching for available rooms on $DATE $START-$END..."
SEARCH_AVAIL=$(curl -s -H "Authorization: Bearer $TOKEN" "$URL/rooms/search?date=$DATE&startTime=$START&endTime=$END")
echo "Result Availability search: $SEARCH_AVAIL"

# 4. Search by both
echo "Searching for capacity >= 10 AND available..."
SEARCH_BOTH=$(curl -s -H "Authorization: Bearer $TOKEN" "$URL/rooms/search?capacity=10&date=$DATE&startTime=$START&endTime=$END")
echo "Result Both search: $SEARCH_BOTH"
