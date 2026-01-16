<template>
  <div class="booking-wrapper fill-height">
    <div class="animated-bg"></div>
    
    <v-container class="fill-height justify-center position-relative z-index-1">
      <v-container class="py-12">
        <v-row justify="center">
          <v-col cols="12" md="8">
            <v-card theme="dark" class="bg-glass" elevation="10" rounded="xl">
               <v-img
                  :src="getRoomImage(room)"
                  height="200"
                  cover
                  class="align-end"
                  gradient="to bottom, rgba(0,0,0,0) 0%, rgba(0,0,0,0.8) 100%"
               >
                  <v-card-title class="text-h4 font-weight-bold text-white pa-6">
                    {{ $t('booking.bookRoom') }} <span class="text-primary">{{ room?.name }}</span>
                  </v-card-title>
               </v-img>
        <v-card-subtitle class="text-center text-medium-emphasis mb-6">
            {{ $t('booking.capacity') }}: {{ room.capacity }} {{ $t('dashboard.people') }}
        </v-card-subtitle>

        <v-card-text>
            <v-form @submit.prevent="submitBooking" ref="form">
                <v-text-field
                    v-model="purpose"
                    :label="$t('booking.purpose')"
                    variant="outlined"
                    prepend-inner-icon="mdi-text-box-outline"
                    placeholder="e.g. Q4 Strategy Meeting"
                    required
                    bg-color="rgba(0,0,0,0.2)"
                    class="mb-2"
                ></v-text-field>

                <v-text-field
                    v-model="bookingDate"
                    type="date"
                    :label="$t('booking.date')"
                    variant="outlined"
                    prepend-inner-icon="mdi-calendar"
                    :min="today"
                    required
                    bg-color="rgba(0,0,0,0.2)"
                    class="mb-2"
                ></v-text-field>

                <v-row>
                    <v-col cols="6">
                        <v-text-field
                            v-model="startTime"
                            type="time"
                            :label="$t('booking.startTime')"
                            variant="outlined"
                            prepend-inner-icon="mdi-clock-start"
                            required
                            bg-color="rgba(0,0,0,0.2)"
                        ></v-text-field>
                    </v-col>
                     <v-col cols="6">
                        <v-text-field
                            v-model="endTime"
                            type="time"
                            :label="$t('booking.endTime')"
                            variant="outlined"
                            prepend-inner-icon="mdi-clock-end"
                            required
                            bg-color="rgba(0,0,0,0.2)"
                        ></v-text-field>
                    </v-col>
                </v-row>

                <div class="d-flex gap-4 mt-6">
                    <v-btn 
                        color="grey" 
                        variant="text" 
                        size="large" 
                        class="flex-1-0" 
                        @click="$router.back()"
                    >
                        {{ $t('booking.cancel') }}
                    </v-btn>
                    <v-btn 
                        color="primary" 
                        type="submit" 
                        size="large" 
                        class="flex-1-0 glow-btn" 
                        :loading="submitting"
                    >
                        {{ $t('booking.confirm') }}
                    </v-btn>
                </div>
            </v-form>
        </v-card-text>
      </v-card>
          </v-col>
        </v-row>
      </v-container>
    </v-container>

    <v-overlay v-model="loading" class="align-center justify-center">
        <v-progress-circular indeterminate color="primary" size="64"></v-progress-circular>
    </v-overlay>

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
import { ref, computed, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { useI18n } from 'vue-i18n';

const { t } = useI18n();
const route = useRoute();
const router = useRouter();
const roomId = route.params.roomId;

const room = ref({});
const loading = ref(true);
const submitting = ref(false);

// Form
const purpose = ref('');
const bookingDate = ref('');
const startTime = ref('');
const endTime = ref('');

const today = new Date().toISOString().split('T')[0];

// Snackbar
const snackbar = ref({ show: false, text: '', color: 'error' });

const showNotification = (text, color = 'error') => {
  snackbar.value = { show: true, text, color };
};

const roomLarge1 = 'https://cache.marriott.com/content/dam/marriott-renditions/OKCAL/okcal-conference-setup-0205-hor-feat.jpg?output-quality=70&interpolation=progressive-bilinear&downsize=1920px%3A*';
const roomLarge2 = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiEw_Xrr6PA9v1O3PEDPQmkYUe1NQJc878sw&s';
import roomExtraLarge from '@/assets/image.png';
import roomSmall from '@/assets/room-small.jpg';

const getRoomImage = (room) => {
    if (!room || !room.capacity) return roomSmall;
    if (room.capacity >= 10) return roomExtraLarge;
    if (room.capacity >= 8) {
         const id = room.id || 0;
         return id % 2 === 0 ? roomLarge2 : roomLarge1;
    }
    return roomSmall;
};

const fetchRoomDetails = async () => {
    try {
        const token = localStorage.getItem('authToken');
        const res = await fetch(`/api/rooms/${roomId}`, {
             headers: { 'Authorization': `Bearer ${token}` }
        });
        if(res.ok) {
            room.value = await res.json();
        } else {
            console.error('Room not found');
            router.push('/dashboard');
        }
    } catch(e) {
        console.error(e);
    } finally {
        loading.value = false;
    }
}

const submitBooking = async () => {
    if (!purpose.value || !bookingDate.value || !startTime.value || !endTime.value) {
        showNotification('Please fill in all fields', 'warning');
        return;
    }

    submitting.value = true;
    try {
        let user = {};
        try {
            const stored = localStorage.getItem('user');
            if (stored && stored !== 'undefined') user = JSON.parse(stored);
        } catch (e) {
            console.error('User parse error', e);
        }

        if (!user.id && !user.userId) {
            showNotification('User not valid. Please log in again.', 'error');
            router.push('/');
            return;
        }

        const token = localStorage.getItem('authToken');
        
        const startDateTime = `${bookingDate.value}T${startTime.value}:00`;
        const endDateTime = `${bookingDate.value}T${endTime.value}:00`;

        const payload = {
            userId: user.id || user.userId,
            roomId: roomId,
            startTime: startDateTime,
            endTime: endDateTime,
            purpose: purpose.value
        };

        const res = await fetch('/api/bookings', {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${token}`,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(payload)
        });

        if(res.ok) {
            showNotification('Booking submitted successfully!', 'success');
            setTimeout(() => router.push('/my-bookings'), 1000);
        } else {
            const err = await res.text();
            showNotification('Booking failed: ' + err, 'error');
        }
    } catch(e) {
        console.error(e);
        showNotification('An error occurred', 'error');
    } finally {
        submitting.value = false;
    }
}

onMounted(fetchRoomDetails);
</script>

<style scoped>
.booking-wrapper {
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

.z-index-1 { z-index: 1; position: relative; }

.bg-glass {
    background: rgba(30, 41, 59, 0.6) !important;
    backdrop-filter: blur(20px);
    border: 1px solid rgba(255, 255, 255, 0.1);
}

.glow-btn {
    box-shadow: 0 0 15px rgba(59, 130, 246, 0.4);
}

/* ============ Responsive Styles ============ */
@media (max-width: 600px) {
  .booking-wrapper .py-12 {
    padding-top: 24px !important;
    padding-bottom: 24px !important;
  }
  
  .bg-glass {
    border-radius: 16px !important;
  }
  
  .bg-glass .v-img {
    height: 150px !important;
  }
  
  .bg-glass .v-card-title {
    font-size: 1.25rem !important;
    padding: 16px !important;
  }
  
  .bg-glass .v-card-subtitle {
    font-size: 0.85rem;
    margin-bottom: 16px !important;
  }
  
  .bg-glass .v-card-text {
    padding: 16px !important;
  }
  
  .d-flex.gap-4 {
    flex-direction: column;
    gap: 12px !important;
  }
  
  .d-flex.gap-4 .v-btn {
    width: 100%;
  }
}

@media (max-width: 400px) {
  .bg-glass .v-card-title {
    font-size: 1.1rem !important;
  }
}
</style>
