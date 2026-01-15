<template>
  <div class="my-bookings-wrapper fill-height">
    <div class="animated-bg"></div>
    
    <!-- Top App Bar (Reused for consistency - could be a component but duplicating for speed) -->
    <v-app-bar flat color="transparent" class="px-md-4 border-bottom bg-glass-nav">
       <router-link to="/dashboard" class="text-decoration-none">
         <v-app-bar-title class="font-weight-bold">
           N4<span class="text-primary">Booking</span>
         </v-app-bar-title>
       </router-link>
       <v-btn to="/dashboard" variant="text" color="white" prepend-icon="mdi-arrow-left">Back to Dashboard</v-btn>
    </v-app-bar>

    <v-main class="position-relative z-index-1">
      <v-container class="py-8">
        <h1 class="text-h4 font-weight-bold text-white mb-6">My Bookings</h1>

        <div v-if="loading" class="d-flex justify-center py-12">
            <v-progress-circular indeterminate color="primary" size="64"></v-progress-circular>
        </div>

        <div v-else-if="bookings.length === 0" class="text-center py-16">
            <v-icon icon="mdi-calendar-blank" size="64" color="grey-darken-2" class="mb-4"></v-icon>
            <h3 class="text-h6 text-grey">No active bookings</h3>
            <v-btn color="primary" to="/dashboard" class="mt-4">Book a Room</v-btn>
        </div>

        <v-row v-else>
            <v-col v-for="booking in bookings" :key="booking.id" cols="12" md="6" lg="4">
                <v-card theme="dark" class="bg-glass booking-card" rounded="lg" elevation="0">
                    <v-card-item>
                        <template v-slot:prepend>
                            <v-avatar color="primary" variant="tonal" rounded>
                                <v-icon icon="mdi-calendar-check"></v-icon>
                            </v-avatar>
                        </template>
                        <v-card-title class="text-white">{{ booking.meetingRoom?.name || 'Unknown Room' }}</v-card-title>
                        <v-card-subtitle>{{ formatDate(booking.startTime) }}</v-card-subtitle>
                        
                        <template v-slot:append>
                            <v-chip :color="getStatusColor(booking.status)" size="small" class="font-weight-bold uppercase" label>
                                {{ booking.status }}
                            </v-chip>
                        </template>
                    </v-card-item>

                    <v-card-text class="pt-2">
                        <div class="mb-2">
                            <span class="text-grey text-caption d-block">Time</span>
                            <span class="text-white">{{ formatTime(booking.startTime) }} - {{ formatTime(booking.endTime) }}</span>
                        </div>
                        <div>
                            <span class="text-grey text-caption d-block">Purpose</span>
                            <span class="text-white font-weight-medium">{{ booking.purpose }}</span>
                        </div>
                    </v-card-text>

                    <v-card-actions v-if="['PENDING', 'CONFIRMED'].includes(booking.status)">
                        <v-spacer></v-spacer>
                        <v-btn 
                            color="error" 
                            variant="tonal" 
                            @click="openCancelDialog(booking.id)"
                            prepend-icon="mdi-cancel"
                            size="small"
                        >
                            Cancel Booking
                        </v-btn>
                    </v-card-actions>
                </v-card>
            </v-col>
        </v-row>
      </v-container>
    </v-main>

    <!-- Cancel Confirmation Dialog -->
    <v-dialog v-model="cancelDialog" max-width="400" persistent>
      <v-card theme="dark" class="bg-glass" rounded="lg">
        <v-card-title class="text-h6 pa-6">
          <v-icon icon="mdi-alert-circle" color="warning" class="mr-2"></v-icon>
          Cancel Booking?
        </v-card-title>
        <v-card-text class="px-6 pb-2">
          Are you sure you want to cancel this booking? This action cannot be undone.
        </v-card-text>
        <v-card-actions class="pa-6 pt-4">
          <v-spacer></v-spacer>
          <v-btn variant="text" @click="cancelDialog = false">Keep Booking</v-btn>
          <v-btn color="error" variant="flat" @click="confirmCancelBooking">Yes, Cancel</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

    <!-- Snackbar for notifications -->
    <v-snackbar v-model="snackbar.show" :color="snackbar.color" timeout="4000" location="top">
      {{ snackbar.text }}
      <template v-slot:actions>
        <v-btn variant="text" @click="snackbar.show = false" icon="mdi-close"></v-btn>
      </template>
    </v-snackbar>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();
const bookings = ref([]);
const loading = ref(true);

// Snackbar
const snackbar = ref({ show: false, text: '', color: 'success' });

const showNotification = (text, color = 'success') => {
  snackbar.value = { show: true, text, color };
};

// Cancel dialog
const cancelDialog = ref(false);
const bookingToCancel = ref(null);

const fetchBookings = async () => {
  try {
    let user = {};
    try {
        const stored = localStorage.getItem('user');
        if (stored && stored !== 'undefined') user = JSON.parse(stored);
    } catch (e) { console.error(e); }

    const token = localStorage.getItem('authToken');
    if((!user.id && !user.userId) || !token) {
        return router.push('/login');
    }

    const userId = user.id || user.userId;
    const res = await fetch(`/api/bookings/user/${userId}`, {
        headers: { 'Authorization': `Bearer ${token}` }
    });
    
    if (res.ok) {
        bookings.value = await res.json();
    }
  } catch(e) {
    console.error(e);
  } finally {
    loading.value = false;
  }
};

const openCancelDialog = (id) => {
    bookingToCancel.value = id;
    cancelDialog.value = true;
};

const confirmCancelBooking = async () => {
    if (!bookingToCancel.value) return;
    
    try {
        const token = localStorage.getItem('authToken');
        const res = await fetch(`/api/bookings/${bookingToCancel.value}/cancel`, {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if(res.ok) {
            showNotification('Booking cancelled successfully', 'success');
            fetchBookings();
        } else {
            showNotification('Failed to cancel booking', 'error');
        }
    } catch(e) {
        console.error(e);
        showNotification('Network error', 'error');
    } finally {
        cancelDialog.value = false;
        bookingToCancel.value = null;
    }
}

const getStatusColor = (status) => {
    switch(status) {
        case 'CONFIRMED': return 'success';
        case 'PENDING': return 'warning';
        case 'REJECTED': return 'error';
        case 'CANCELLED': return 'grey';
        default: return 'info';
    }
}

const formatDate = (dateStr) => {
    return new Date(dateStr).toLocaleDateString(undefined, { weekday: 'short', year: 'numeric', month: 'short', day: 'numeric' });
}

const formatTime = (dateStr) => {
    return new Date(dateStr).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
}

onMounted(fetchBookings);
</script>

<style scoped>
.my-bookings-wrapper {
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
    background: rgba(30, 41, 59, 0.6) !important;
    backdrop-filter: blur(20px);
    border: 1px solid rgba(255, 255, 255, 0.1);
}

.bg-glass-nav {
    background: rgba(15, 23, 42, 0.7) !important;
    backdrop-filter: blur(10px);
    border-bottom: 1px solid rgba(255,255,255,0.05);
}

.booking-card {
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}
.booking-card:hover {
    transform: translateY(-6px) scale(1.01);
    border-color: rgba(59, 130, 246, 0.5);
    box-shadow: 0 15px 35px -10px rgba(0, 0, 0, 0.4), 0 0 25px rgba(59, 130, 246, 0.1);
}

.uppercase { text-transform: uppercase; letter-spacing: 0.5px; }
</style>
