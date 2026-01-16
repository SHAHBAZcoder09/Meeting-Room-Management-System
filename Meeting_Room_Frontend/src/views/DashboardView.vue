<template>
  <div class="dashboard-wrapper fill-height">
    <div class="animated-bg"></div>
    
    <!-- Top App Bar -->
    <v-app-bar flat color="transparent" class="px-md-4 border-bottom bg-glass-nav">
      <router-link to="/dashboard" class="text-decoration-none">
        <v-app-bar-title class="font-weight-bold">
          N4<span class="text-primary">Booking</span>
        </v-app-bar-title>
      </router-link>

      <template v-if="$vuetify.display.mdAndUp">
        <v-btn to="/dashboard" variant="text" :active="route.path === '/dashboard'" color="white" class="nav-btn">{{ $t('nav.home') }}</v-btn>
        <v-btn to="/calendar" variant="text" :active="route.path === '/calendar'" color="white" class="nav-btn">{{ $t('nav.calendar') }}</v-btn>
        <v-btn to="/my-bookings" variant="text" :active="route.path === '/my-bookings'" color="white" class="nav-btn">{{ $t('nav.myBookings') }}</v-btn>
        <v-btn v-if="isAdmin" to="/admin/bookings" variant="text" :active="route.path.includes('/admin')" color="white" class="nav-btn">{{ $t('nav.admin') }}</v-btn>
      </template>

      <v-spacer></v-spacer>

      <LanguageSwitcher class="mr-2" />

      <v-menu v-if="user.email" min-width="200px" rounded>
        <template v-slot:activator="{ props }">
          <v-btn icon v-bind="props">
            <v-avatar color="primary" size="38">
              <span class="text-h6 text-white">{{ userInitials }}</span>
            </v-avatar>
          </v-btn>
        </template>
        <v-card theme="dark" class="bg-glass-menu">
          <v-list-item
            :prepend-avatar="undefined" 
            :title="userName"
            :subtitle="user.email"
          >
             <template v-slot:prepend>
               <v-avatar color="primary" size="32">{{ userInitials }}</v-avatar>
             </template>
          </v-list-item>
          <v-divider class="my-2"></v-divider>
          <v-list-item to="/profile" prepend-icon="mdi-account-circle" :title="$t('nav.profile')" value="profile"></v-list-item>
          <v-list-item @click="handleLogout" prepend-icon="mdi-logout" :title="$t('nav.logout')" value="logout" color="error"></v-list-item>
        </v-card>
      </v-menu>
    </v-app-bar>

    <v-main class="position-relative z-index-1">
      <v-container class="py-8">
        
        <!-- Welcome Banner -->
        <div class="welcome-banner mb-8">
          <div class="welcome-content">
            <div class="welcome-text">
              <h1 class="welcome-title">{{ greeting }}, {{ user.firstName || 'there' }}! 👋</h1>
              <p class="welcome-subtitle">{{ $t('dashboard.welcomeSubtitle') }}</p>
            </div>
            <div class="welcome-actions d-none d-md-flex">
              <v-btn color="primary" rounded="pill" class="mr-3 glow-btn" to="/calendar">
                <v-icon start icon="mdi-calendar"></v-icon>
                {{ $t('dashboard.viewCalendar') }}
              </v-btn>
              <v-btn variant="outlined" color="white" rounded="pill" to="/my-bookings">
                <v-icon start icon="mdi-bookmark-multiple"></v-icon>
                {{ $t('nav.myBookings') }}
              </v-btn>
            </div>
          </div>
          <div class="welcome-decoration">
            <div class="decoration-circle"></div>
          </div>
        </div>

        <!-- Stats Section -->
        <v-row class="mb-8">
          <v-col cols="12" md="4">
            <v-card theme="dark" elevation="0" class="stat-card fill-height bg-glass" rounded="xl">
              <v-card-text class="pa-5">
                <div class="d-flex align-center mb-4">
                  <div class="stat-icon stat-icon-success">
                    <v-icon icon="mdi-door-open" size="24" color="success"></v-icon>
                  </div>
                  <v-chip color="success" size="small" variant="tonal" class="ml-auto">{{ $t('dashboard.live') }}</v-chip>
                </div>
                <div class="text-h3 font-weight-bold text-white mb-1">{{ stats.availableRooms || 0 }}</div>
                <div class="text-body-2 text-medium-emphasis">{{ $t('dashboard.availableRooms') }}</div>
              </v-card-text>
            </v-card>
          </v-col>
          <v-col cols="12" md="4">
            <v-card theme="dark" elevation="0" class="stat-card fill-height bg-glass" rounded="xl">
              <v-card-text class="pa-5">
                <div class="d-flex align-center mb-4">
                  <div class="stat-icon stat-icon-warning">
                    <v-icon icon="mdi-account-group" size="24" color="warning"></v-icon>
                  </div>
                  <v-chip color="warning" size="small" variant="tonal" class="ml-auto">{{ $t('dashboard.now') }}</v-chip>
                </div>
                <div class="text-h3 font-weight-bold text-white mb-1">{{ stats.activeBookings || 0 }}</div>
                <div class="text-body-2 text-medium-emphasis">{{ $t('dashboard.activeMeetings') }}</div>
              </v-card-text>
            </v-card>
          </v-col>
          <v-col cols="12" md="4">
            <v-card theme="dark" elevation="0" class="stat-card fill-height bg-glass" rounded="xl">
              <v-card-text class="pa-5">
                <div class="d-flex align-center mb-4">
                  <div class="stat-icon stat-icon-info">
                    <v-icon icon="mdi-calendar-check" size="24" color="info"></v-icon>
                  </div>
                  <v-chip color="info" size="small" variant="tonal" class="ml-auto">{{ $t('dashboard.today') }}</v-chip>
                </div>
                <div class="text-h3 font-weight-bold text-white mb-1">{{ stats.confirmedBookingsToday || 0 }}</div>
                <div class="text-body-2 text-medium-emphasis">{{ $t('dashboard.scheduledToday') }}</div>
              </v-card-text>
            </v-card>
          </v-col>
        </v-row>

        <!-- Room Finder Section -->
        <div class="d-flex justify-space-between align-center mb-6">
            <h2 class="text-h5 font-weight-bold text-white">{{ $t('dashboard.conferenceRooms') }}</h2>
             <v-btn icon="mdi-refresh" variant="text" color="white" @click="fetchRooms"></v-btn>
        </div>

        <!-- Filters -->
         <v-card theme="dark" class="mb-8 pa-4 border-thin bg-glass" rounded="lg" elevation="0">
           <v-form @submit.prevent="handleSearch">
             <v-row dense align="center">
               <v-col cols="12" md="3">
                 <v-text-field 
                    v-model="filterDate" 
                    type="date" 
                    label="Date" 
                    variant="outlined" 
                    density="compact"
                    hide-details
                    bg-color="rgba(0,0,0,0.2)"
                 ></v-text-field>
               </v-col>
               <v-col cols="6" md="2">
                  <v-select
                    v-model="filterStart"
                    :items="timeSlots"
                    label="Start Time"
                    variant="outlined"
                    density="compact"
                    hide-details
                    bg-color="rgba(0,0,0,0.2)"
                  ></v-select>
               </v-col>
                <v-col cols="6" md="2">
                  <v-select
                    v-model="filterEnd"
                    :items="timeSlots"
                    label="End Time"
                    variant="outlined"
                    density="compact"
                    hide-details
                    bg-color="rgba(0,0,0,0.2)"
                  ></v-select>
               </v-col>
               <v-col cols="12" md="2">
                 <v-text-field 
                    v-model.number="filterCapacity" 
                    type="number" 
                    label="Capacity" 
                    variant="outlined" 
                    density="compact"
                    hide-details
                    bg-color="rgba(0,0,0,0.2)"
                 ></v-text-field>
               </v-col>
                <v-col cols="12" md="3" class="d-flex gap-2">
                  <v-btn color="primary" prepend-icon="mdi-magnify" type="submit" class="flex-grow-1" height="40">{{ $t('common.search') }}</v-btn>
                  <v-btn variant="outlined" color="grey" @click="clearFilters" height="40">{{ $t('common.refresh') }}</v-btn>
                </v-col>
             </v-row>
           </v-form>
         </v-card>

        <!-- Rooms Grid -->
        <v-row v-if="rooms.length > 0">
          <v-col v-for="room in rooms" :key="room.id" cols="12" sm="6" md="4" lg="3">
             <v-hover v-slot="{ isHovering, props }">
              <v-card 
                theme="dark" 
                v-bind="props" 
                :elevation="isHovering ? 12 : 0" 
                class="room-card d-flex flex-column bg-glass" 
                rounded="lg"
                height="100%"
              >
                 <v-img
                    :src="getRoomImage(room)"
                    height="160"
                    cover
                    class="align-end"
                    gradient="to bottom, rgba(0,0,0,0) 0%, rgba(0,0,0,0.8) 100%"
                 >
                    <v-card-title class="text-white font-weight-bold" style="text-shadow: 0 2px 4px rgba(0,0,0,0.5);">
                        {{ room.name }}
                    </v-card-title>
                 </v-img>
                 
                 <v-card-text class="flex-grow-1 pt-4">
                    <div class="d-flex justify-space-between align-center mb-3">
                       <v-chip :color="getRoomStatusColor(room.status)" size="small" label class="font-weight-bold uppercase">
                          {{ room.status }}
                       </v-chip>
                       <div class="d-flex align-center text-caption text-medium-emphasis">
                            <v-icon icon="mdi-account-group" size="small" class="mr-1"></v-icon>
                            {{ room.capacity }} {{ $t('dashboard.people') }}
                       </div>
                    </div>
                     
                     <div class="amenities-list mb-4">
                        <v-chip 
                            v-for="feature in (room.amenities ? room.amenities.split(',') : [])" 
                            :key="feature" 
                            size="x-small" 
                            variant="outlined" 
                            class="mr-1 mb-1 text-white"
                        >
                            {{ feature.trim() }}
                        </v-chip>
                     </div>
                 </v-card-text>

                 <v-card-actions class="pa-4 pt-0">
                    <v-btn 
                        block 
                        :color="room.status === 'Occupied' ? 'grey' : 'primary'" 
                        :variant="room.status === 'Occupied' ? 'outlined' : 'flat'"
                        :disabled="room.status === 'Occupied'"
                        @click="$router.push(`/book/${room.id}`)"
                        class="font-weight-bold glow-btn"
                    >
                        {{ room.status === 'Occupied' ? $t('dashboard.unavailable') : $t('dashboard.bookRoom') }}
                    </v-btn>
                 </v-card-actions>
              </v-card>
            </v-hover>
          </v-col>
        </v-row>
        
        <div v-else class="text-center py-16">
            <v-icon icon="mdi-magnify" size="64" color="grey-darken-2" class="mb-4"></v-icon>
            <h3 class="text-h6 text-grey">No rooms found</h3>
            <p class="text-caption text-grey-darken-1">Try adjusting your search filters</p>
        </div>

      </v-container>
    </v-main>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import { useI18n } from 'vue-i18n';
import LanguageSwitcher from '@/components/LanguageSwitcher.vue';

const { t } = useI18n();

const router = useRouter();
const route = useRoute();

const user = ref(JSON.parse(localStorage.getItem('user') || '{}'));
const isAdmin = computed(() => user.value.role === 'ADMIN');
const userName = computed(() => user.value.firstName ? `${user.value.firstName} ${user.value.lastName || ''}` : 'User');
const userInitials = computed(() => {
    if(!user.value.firstName) return 'U';
    return `${user.value.firstName[0]}${user.value.lastName ? user.value.lastName[0] : ''}`.toUpperCase();
});

const greeting = computed(() => {
    const hour = new Date().getHours();
    if (hour < 12) return t('dashboard.greetingMorning');
    if (hour < 17) return t('dashboard.greetingAfternoon');
    return t('dashboard.greetingEvening');
});

const handleLogout = () => {
    localStorage.removeItem('authToken');
    localStorage.removeItem('user');
    sessionStorage.clear();
    router.push('/');
};

const rooms = ref([]);
const stats = ref({ availableRooms: 0, activeBookings: 0, confirmedBookingsToday: 0 });

// Filters
const filterDate = ref('');
const filterStart = ref('');
const filterEnd = ref('');
const filterCapacity = ref('');
const timeSlots = [];
for (let i = 8; i <= 20; i++) {
    timeSlots.push(`${i.toString().padStart(2, '0')}:00`);
    timeSlots.push(`${i.toString().padStart(2, '0')}:30`);
}

const getRoomStatusColor = (status) => {
    if(!status) return 'grey';
    switch(status.toLowerCase()) {
        case 'available': return 'success';
        case 'occupied': return 'error';
        case 'maintenance': return 'warning';
        default: return 'grey';
    }
};

const roomLarge1 = 'https://cache.marriott.com/content/dam/marriott-renditions/OKCAL/okcal-conference-setup-0205-hor-feat.jpg?output-quality=70&interpolation=progressive-bilinear&downsize=1920px%3A*';
const roomLarge2 = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiEw_Xrr6PA9v1O3PEDPQmkYUe1NQJc878sw&s';
import roomExtraLarge from '@/assets/image.png';
import roomSmall from '@/assets/room-small.jpg';

const getRoomImage = (room) => {
    if (!room) return roomSmall;
    if (room.capacity >= 10) return roomExtraLarge;
    if (room.capacity >= 8) {
        // Alternate based on ID if available, otherwise random or fixed
        const id = room.id || 0;
        return id % 2 === 0 ? roomLarge2 : roomLarge1;
    }
    return roomSmall;
};

const fetchStats = async () => {
    try {
        const token = localStorage.getItem('authToken');
        const res = await fetch('/api/stats', { headers: { 'Authorization': `Bearer ${token}` } });
        if(res.ok) stats.value = await res.json();
    } catch(e) { console.error(e); }
}

const fetchRooms = async () => {
  try {
    const res = await fetch('/api/rooms', {
      headers: { 'Authorization': `Bearer ${localStorage.getItem('authToken')}` }
    });
    if (res.ok) rooms.value = await res.json();
  } catch (error) {
    console.error(error);
  }
};

const handleSearch = async () => {
    let query = '/api/rooms/search?';
    const params = new URLSearchParams();
    
    if (filterDate.value && filterStart.value && filterEnd.value) {
        params.append('date', filterDate.value);
        params.append('startTime', filterStart.value);
        params.append('endTime', filterEnd.value);
    }
    if (filterCapacity.value) {
        params.append('capacity', filterCapacity.value);
    }
    
    if (!filterDate.value && !filterCapacity.value) {
        fetchRooms();
        return;
    }

    try {
        const token = localStorage.getItem('authToken');
        const res = await fetch(`${query}${params.toString()}`, {
             headers: { 'Authorization': `Bearer ${token}` }
        });
        if (res.ok) rooms.value = await res.json();
    } catch(e) {
        console.error(e);
    }
};

const clearFilters = () => {
    filterDate.value = '';
    filterStart.value = '';
    filterEnd.value = '';
    filterCapacity.value = '';
    fetchRooms();
};

onMounted(() => {
    fetchRooms();
    fetchStats();
});
</script>

<style scoped>
.dashboard-wrapper {
  background: #0f172a;
  position: relative;
  overflow-x: hidden;
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
  pointer-events: none;
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
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
}

.bg-glass-nav {
    background: rgba(15, 23, 42, 0.7) !important;
    backdrop-filter: blur(10px);
    border-bottom: 1px solid rgba(255,255,255,0.05);
}

.bg-glass-menu {
    background: rgba(15, 23, 42, 0.95) !important;
    backdrop-filter: blur(16px);
    border: 1px solid rgba(255,255,255,0.1);
}

.room-card {
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    border: 1px solid rgba(255, 255, 255, 0.1);
}
.room-card:hover {
    transform: translateY(-8px) scale(1.02);
    border-color: rgba(59, 130, 246, 0.5);
    box-shadow: 0 20px 40px -10px rgba(0, 0, 0, 0.4), 0 0 30px rgba(59, 130, 246, 0.15);
}

.stat-card {
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}
.stat-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 10px 30px -5px rgba(0, 0, 0, 0.3);
}

.uppercase { text-transform: uppercase; letter-spacing: 0.5px; font-size: 0.7rem !important; }

.glow-btn {
    box-shadow: 0 0 15px rgba(59, 130, 246, 0.4);
    transition: all 0.3s ease;
}
.glow-btn:hover {
    box-shadow: 0 0 25px rgba(59, 130, 246, 0.6);
}

/* Welcome Banner */
.welcome-banner {
    background: linear-gradient(135deg, rgba(59, 130, 246, 0.15) 0%, rgba(139, 92, 246, 0.1) 100%);
    border: 1px solid rgba(59, 130, 246, 0.2);
    border-radius: 24px;
    padding: 32px;
    position: relative;
    overflow: hidden;
}

.welcome-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: relative;
    z-index: 1;
}

.welcome-title {
    font-size: 1.75rem;
    font-weight: 700;
    color: white;
    margin-bottom: 8px;
}

.welcome-subtitle {
    color: rgba(255, 255, 255, 0.7);
    margin: 0;
}

.welcome-decoration {
    position: absolute;
    right: -50px;
    top: -50px;
    width: 200px;
    height: 200px;
    pointer-events: none;
}

.decoration-circle {
    width: 100%;
    height: 100%;
    border-radius: 50%;
    background: radial-gradient(circle, rgba(59, 130, 246, 0.3) 0%, transparent 70%);
    filter: blur(30px);
}

/* Stat Icons */
.stat-icon {
    width: 48px;
    height: 48px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.stat-icon-success {
    background: rgba(16, 185, 129, 0.15);
}

.stat-icon-warning {
    background: rgba(245, 158, 11, 0.15);
}

.stat-icon-info {
    background: rgba(59, 130, 246, 0.15);
}

/* ============ Responsive Styles ============ */
@media (max-width: 960px) {
  .welcome-content {
    flex-direction: column;
    text-align: center;
    gap: 24px;
  }
  
  .welcome-actions {
    justify-content: center;
  }
}

@media (max-width: 600px) {
  .dashboard-wrapper {
    padding-bottom: 20px;
  }
  
  /* Welcome Banner */
  .welcome-banner {
    padding: 20px;
    border-radius: 16px;
  }
  
  .welcome-title {
    font-size: 1.25rem;
    margin-bottom: 4px;
  }
  
  .welcome-subtitle {
    font-size: 0.85rem;
  }
  
  .welcome-decoration {
    display: none;
  }
  
  /* Stats Cards */
  .stat-card .v-card-text {
    padding: 16px !important;
  }
  
  .stat-icon {
    width: 40px;
    height: 40px;
  }
  
  .stat-card .text-h3 {
    font-size: 1.5rem !important;
  }
  
  .stat-card .text-body-2 {
    font-size: 0.75rem;
  }
  
  /* Filters */
  .bg-glass.pa-4 {
    padding: 16px !important;
  }
  
  /* Room Cards */
  .room-card {
    margin-bottom: 8px;
  }
  
  .room-card .v-img {
    height: 140px !important;
  }
  
  .room-card .v-card-title {
    font-size: 1rem !important;
  }
  
  .room-card .v-card-text {
    padding: 12px !important;
  }
  
  .amenities-list {
    margin-bottom: 12px !important;
  }
  
  .room-card .v-card-actions {
    padding: 12px !important;
  }
  
  /* Section Heading */
  .text-h5 {
    font-size: 1.1rem !important;
  }
  
  /* App Bar */
  .bg-glass-nav {
    padding: 0 8px;
  }
  
  .nav-btn {
    font-size: 0.75rem !important;
    padding: 0 8px !important;
  }
}

/* Extra small devices */
@media (max-width: 400px) {
  .welcome-banner {
    padding: 16px;
  }
  
  .welcome-title {
    font-size: 1.1rem;
  }
  
  .stat-card .text-h3 {
    font-size: 1.25rem !important;
  }
}
</style>
