#!/bin/bash

# Base URL
URL="http://localhost:8080/api"

# 1. Register a user
echo "Registering user..."
REGISTER_RES=$(curl -s -X POST $URL/users/register \
  -H "Content-Type: application/json" \
  -d '{
    "firstName": "Test",
    "lastName": "User",
    "email": "test@example.com",
    "password": "password",
    "role": "USER"
  }')
echo "Register Response: $REGISTER_RES"

# 2. Login
echo "Logging in..."
LOGIN_RES=$(curl -s -X POST $URL/users/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "password"
  }')
echo "Login Response: $LOGIN_RES"

TOKEN=$(echo $LOGIN_RES | grep -o '"token":"[^"]*' | cut -d'"' -f4)
USER_ID=$(echo $LOGIN_RES | grep -o '"userId":[0-9]*' | cut -d':' -f2)

if [ -z "$TOKEN" ]; then
  echo "Failed to get token"
  exit 1
fi

echo "Token: $TOKEN"
echo "UserId: $USER_ID"

# 3. Get Room ID (Create one if likely needed, or list)
# Assume rooms exist from data initializer.
ROOMS_RES=$(curl -s -H "Authorization: Bearer $TOKEN" $URL/rooms)
ROOM_ID=$(echo $ROOMS_RES | grep -o '"id":[0-9]*' | head -n 1 | cut -d':' -f2)

if [ -z "$ROOM_ID" ]; then
  echo "No rooms found, creating one..."
  # Create room (need admin? SecurityConfig permits all)
  ROOM_RES=$(curl -s -X POST $URL/rooms \
    -H "Content-Type: application/json" \
    -d '{
      "name": "Test Room",
      "capacity": 10
    }')
  ROOM_ID=$(echo $ROOM_RES | grep -o '"id":[0-9]*' | cut -d':' -f2)
fi
echo "Using Room ID: $ROOM_ID"

# 4. Check Rooms before booking
echo "Checking rooms (1)..."
curl -s -o /dev/null -w "%{http_code}" -H "Authorization: Bearer $TOKEN" $URL/rooms
echo ""

# 5. Book Room
echo "Booking room..."
START_TIME=$(date -v+1H +%Y-%m-%dT%H:00:00)
END_TIME=$(date -v+2H +%Y-%m-%dT%H:00:00)

BOOK_RES=$(curl -s -X POST $URL/bookings \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "{
    \"userId\": $USER_ID,
    \"roomId\": $ROOM_ID,
    \"startTime\": \"$START_TIME\",
    \"endTime\": \"$END_TIME\",
    \"purpose\": \"Test Booking\"
  }")
echo "Booking Response: $BOOK_RES"

# 6. Check Rooms after booking (Simulate Dashboard refresh)
echo "Checking rooms (2)..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: Bearer $TOKEN" $URL/rooms)
echo "Status Code: $STATUS"

if [ "$STATUS" == "401" ]; then
  echo "ISSUE REPRODUCED: 401 after booking"
else
  echo "No 401 detected."
fi
