<template>
  <div class="calendar-wrapper fill-height">
    <div class="animated-bg"></div>

    <v-app-bar flat color="transparent" class="px-md-4 border-bottom bg-glass-nav">
       <router-link to="/dashboard" class="text-decoration-none">
         <v-app-bar-title class="font-weight-bold">
           N4<span class="text-primary">Calendar</span>
         </v-app-bar-title>
       </router-link>
       <v-btn to="/dashboard" variant="text" color="white" prepend-icon="mdi-arrow-left">Back to Dashboard</v-btn>
    </v-app-bar>

    <v-main class="position-relative z-index-1">
      <v-container class="py-8" fluid>
        
        <v-card theme="dark" class="bg-glass fill-height" rounded="lg" elevation="0">
            <v-card-title class="d-flex align-center justify-space-between py-4 px-6 border-bottom">
                <div class="d-flex align-center gap-4">
                     <v-btn icon="mdi-chevron-left" variant="tonal" @click="changeWeek(-1)"></v-btn>
                     <h2 class="text-h6 font-weight-bold mx-4">{{ weekLabel }}</h2>
                     <v-btn icon="mdi-chevron-right" variant="tonal" @click="changeWeek(1)"></v-btn>
                </div>
                 <v-btn color="primary" @click="fetchBookings" :loading="loading" prepend-icon="mdi-refresh">Refresh</v-btn>
            </v-card-title>

            <v-card-text class="pa-0 overflow-auto" style="height: calc(100vh - 200px);">
                <div class="calendar-grid">
                     <!-- Header Row -->
                    <div class="grid-header-row">
                        <div class="time-col-spacer sticky-col"></div>
                        <div v-for="day in weekDays" :key="day.dateStr" class="day-header" :class="{ 'current-day': day.isToday }">
                            <div class="text-caption text-uppercase">{{ day.name }}</div>
                            <div class="text-h6 font-weight-bold">{{ day.dateDisplay }}</div>
                        </div>
                    </div>

                    <!-- Time Slots -->
                    <div v-for="hour in hours" :key="hour" class="grid-row">
                        <div class="time-label sticky-col">{{ formatHour(hour) }}</div>
                        <div v-for="day in weekDays" :key="day.dateStr + hour" class="time-slot">
                             <!-- Events -->
                            <template v-for="booking in getBookingsForSlot(day.dateStr, hour)" :key="booking.id">
                                <v-sheet
                                    class="event-chip"
                                    :color="getEventColor(booking.status)"
                                    :style="getEventStyle(booking)"
                                    elevation="2"
                                    rounded
                                    @click="viewBooking(booking)"
                                >
                                    <div class="text-caption font-weight-bold text-truncate">{{ booking.meetingRoom?.name }}</div>
                                    <div class="text-caption" style="font-size: 0.65rem;">
                                        {{ formatTimeShort(booking.startTime) }} - {{ formatTimeShort(booking.endTime) }}
                                    </div>
                                </v-sheet>
                            </template>
                        </div>
                    </div>
                </div>
            </v-card-text>
        </v-card>

      </v-container>
    </v-main>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();
const loading = ref(true);
const bookings = ref([]);
const currentWeekStart = ref(getMonday(new Date()));

const hours = Array.from({ length: 11 }, (_, i) => i + 8); // 8 AM to 6 PM

function getMonday(d) {
  d = new Date(d);
  const day = d.getDay(),
      diff = d.getDate() - day + (day === 0 ? -6 : 1); 
  const monday = new Date(d.setDate(diff));
  monday.setHours(0, 0, 0, 0);
  return monday;
}

const weekDays = computed(() => {
    const days = [];
    const monday = new Date(currentWeekStart.value);
    for (let i = 0; i < 5; i++) { 
        const d = new Date(monday);
        d.setDate(monday.getDate() + i);
        days.push({
            name: d.toLocaleDateString('en-US', { weekday: 'short' }),
            dateDisplay: d.toLocaleDateString('en-US', { day: 'numeric' }),
            dateStr: d.toISOString().split('T')[0], 
            isToday: d.toDateString() === new Date().toDateString()
        });
    }
    return days;
});

const weekLabel = computed(() => {
    const start = weekDays.value[0];
    const end = weekDays.value[weekDays.value.length - 1];
    const month = new Date(currentWeekStart.value).toLocaleDateString('en-US', { month: 'long' });
    return `${month} ${start.dateDisplay} - ${end.dateDisplay}, ${new Date(currentWeekStart.value).getFullYear()}`;
});

const changeWeek = (dir) => {
    const newDate = new Date(currentWeekStart.value);
    newDate.setDate(newDate.getDate() + (dir * 7));
    currentWeekStart.value = newDate;
};

const formatHour = (h) => {
    return h > 12 ? `${h-12} PM` : (h === 12 ? '12 PM' : `${h} AM`);
};

const formatTimeShort = (isoStr) => {
    return new Date(isoStr).toLocaleTimeString([], { hour: 'numeric', minute: '2-digit' });
};

const fetchBookings = async () => {
    loading.value = true;
    try {
        const start = activeWeekStartISO();
        const end = activeWeekEndISO();
        
        const token = localStorage.getItem('authToken');
        const res = await fetch(`/api/bookings/range?start=${start}&end=${end}`, {
             headers: { 'Authorization': `Bearer ${token}` }
        });
        if (res.ok) {
            bookings.value = await res.json();
        }
    } catch (e) {
        console.error(e);
    } finally {
        loading.value = false;
    }
};

const activeWeekStartISO = () => {
    const d = new Date(currentWeekStart.value);
    return d.toISOString().replace('Z', '');
};

const activeWeekEndISO = () => {
    const d = new Date(currentWeekStart.value);
    d.setDate(d.getDate() + 6); 
    d.setHours(23, 59, 59);
    return d.toISOString().replace('Z', '');
};

const getBookingsForSlot = (dateStr, hour) => {
    // Return booking if starts within this hour
    return bookings.value.filter(b => {
        const bStart = new Date(b.startTime);
        return bStart.toISOString().startsWith(dateStr) && bStart.getHours() === hour;
    });
};

const getEventStyle = (booking) => {
     const start = new Date(booking.startTime);
     const end = new Date(booking.endTime);
     const durationMins = (end - start) / (1000 * 60);
     // 60px height per hour slot (approx) -> defined in CSS
     // Let's say 1 hour = 100% of slot height
     // Actually slot height is fixed, e.g. 100px.
     const heightPercentage = (durationMins / 60) * 100; 
     
     // Calculate top offset based on minutes past hour
     const startMins = start.getMinutes();
     const topPercentage = (startMins / 60) * 100;

     return {
         height: `max(40px, ${heightPercentage}%)`,
         top: `${topPercentage}%`,
         position: 'absolute',
         width: '90%',
         zIndex: 10
     };
};

const getEventColor = (status) => {
    switch(status) {
        case 'CONFIRMED': return 'success';
        case 'PENDING': return 'warning';
        default: return 'grey';
    }
}

const viewBooking = (b) => {
    alert(`Booking Details:\nPurpose: ${b.purpose}\nRoom: ${b.meetingRoom?.name}\nBy: ${b.user?.firstName}`);
};

watch(currentWeekStart, fetchBookings);
onMounted(fetchBookings);
</script>

<style scoped>
.calendar-wrapper {
  background: #0f172a;
  position: relative;
  overflow: hidden;
}

.animated-bg {
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: radial-gradient(circle, rgba(59, 130, 246, 0.15) 0%, rgba(15, 23, 42, 0) 50%);
  animation: rotate 20s linear infinite;
  z-index: 0;
}

@keyframes rotate {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.z-index-1 { z-index: 1; }

.bg-glass {
    background: rgba(30, 41, 59, 0.4) !important;
    backdrop-filter: blur(20px);
    border: 1px solid rgba(255, 255, 255, 0.1);
}

.bg-glass-nav {
    background: rgba(15, 23, 42, 0.7) !important;
    backdrop-filter: blur(10px);
    border-bottom: 1px solid rgba(255,255,255,0.05);
}

.calendar-grid {
    display: grid;
    grid-template-columns: 80px repeat(5, 1fr);
    min-width: 800px;
}

.grid-header-row {
    display: contents;
}

.time-col-spacer {
    background: rgba(15, 23, 42, 0.9);
    border-bottom: 1px solid rgba(255,255,255,0.1);
}

.day-header {
    text-align: center;
    padding: 12px;
    background: rgba(30, 41, 59, 0.6);
    border-bottom: 1px solid rgba(255,255,255,0.1);
    border-left: 1px solid rgba(255,255,255,0.05);
}
.day-header.current-day {
    background: rgba(59, 130, 246, 0.2);
    color: #60a5fa;
}

.grid-row {
    display: contents;
}

.time-label {
    padding: 10px;
    text-align: right;
    font-size: 0.75rem;
    color: #94a3b8;
    border-bottom: 1px solid rgba(255,255,255,0.05);
    background: rgba(15, 23, 42, 0.8);
    height: 100px; /* Slot Height */
}

.time-slot {
    border-bottom: 1px solid rgba(255,255,255,0.05);
    border-left: 1px solid rgba(255,255,255,0.05);
    height: 100px; /* Slot Height */
    position: relative;
    padding: 0;
}

.sticky-col {
    position: sticky;
    left: 0;
    z-index: 20;
}

.event-chip {
    cursor: pointer;
    transition: transform 0.2s;
    padding: 4px;
    margin-left: 5%;
}
.event-chip:hover {
    transform: scale(1.05);
    z-index: 50 !important;
}
</style>
