<template>
  <div class="dashboard-wrapper">
    <div class="animated-bg"></div>
    
    <!-- Top App Bar -->
    <v-app-bar flat color="transparent" class="px-md-6 border-bottom bg-glass-nav" height="64">
      <router-link to="/dashboard" class="text-decoration-none">
        <v-app-bar-title class="font-weight-bold text-h6">
          N4<span class="text-primary">Booking</span>
        </v-app-bar-title>
      </router-link>

      <div v-if="$vuetify.display.mdAndUp" class="d-flex align-center ml-6">
        <v-btn to="/dashboard" variant="text" :active="route.path === '/dashboard'" color="white" class="nav-btn" rounded="lg">{{ $t('nav.home') }}</v-btn>
        <v-btn to="/calendar" variant="text" :active="route.path === '/calendar'" color="white" class="nav-btn" rounded="lg">{{ $t('nav.calendar') }}</v-btn>
        <v-btn to="/my-bookings" variant="text" :active="route.path === '/my-bookings'" color="white" class="nav-btn" rounded="lg">{{ $t('nav.myBookings') }}</v-btn>
        <v-btn v-if="isAdmin" to="/admin/bookings" variant="text" :active="route.path.includes('/admin')" color="white" class="nav-btn" rounded="lg">{{ $t('nav.admin') }}</v-btn>
      </div>

      <v-spacer></v-spacer>

      <LanguageSwitcher class="mr-3" />

      <v-menu v-if="user.email" min-width="200px" rounded>
        <template v-slot:activator="{ props }">
          <v-btn icon v-bind="props" class="ml-1">
            <v-avatar color="primary" size="36">
              <span class="text-body-1 text-white font-weight-bold">{{ userInitials }}</span>
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
        <div class="section-header mb-6">
          <div class="d-flex align-center">
            <div class="section-icon mr-3">
              <v-icon icon="mdi-door-open" size="24" color="primary"></v-icon>
            </div>
            <div>
              <h2 class="text-h5 font-weight-bold text-white mb-0">{{ $t('dashboard.conferenceRooms') }}</h2>
              <p class="text-caption text-medium-emphasis mb-0">Find and book the perfect space for your meeting</p>
            </div>
          </div>
        </div>

        <!-- Enhanced Filters -->
        <div class="filter-section mb-8">
          <div class="filter-header">
            <v-icon icon="mdi-filter-variant" size="20" class="mr-2 text-primary"></v-icon>
            <span class="text-body-2 font-weight-medium text-white">Quick Filters</span>
          </div>
          <v-form @submit.prevent="handleSearch">
            <div class="filter-grid">
              <div class="filter-item">
                <label class="filter-label">
                  <v-icon icon="mdi-calendar" size="16" class="mr-1"></v-icon>
                  {{ $t('booking.date') }}
                </label>
                <v-text-field 
                   v-model="filterDate" 
                   type="date" 
                   variant="solo-filled" 
                   density="comfortable"
                   hide-details
                   flat
                   class="filter-field"
                   placeholder="Select date"
                   prepend-inner-icon="mdi-calendar"
                ></v-text-field>
              </div>
              
              <div class="filter-item">
                <label class="filter-label">
                  <v-icon icon="mdi-clock-start" size="16" class="mr-1"></v-icon>
                  {{ $t('booking.startTime') }}
                </label>
                <v-select
                  v-model="filterStart"
                  :items="timeSlots"
                  variant="solo-filled"
                  density="comfortable"
                  hide-details
                  flat
                  class="filter-field"
                  placeholder="Start"
                  prepend-inner-icon="mdi-clock-outline"
                ></v-select>
              </div>
              
              <div class="filter-item">
                <label class="filter-label">
                  <v-icon icon="mdi-clock-end" size="16" class="mr-1"></v-icon>
                  {{ $t('booking.endTime') }}
                </label>
                <v-select
                  v-model="filterEnd"
                  :items="timeSlots"
                  variant="solo-filled"
                  density="comfortable"
                  hide-details
                  flat
                  class="filter-field"
                  placeholder="End"
                  prepend-inner-icon="mdi-clock-outline"
                ></v-select>
              </div>
              
              <div class="filter-item">
                <label class="filter-label">
                  <v-icon icon="mdi-account-group" size="16" class="mr-1"></v-icon>
                  {{ $t('booking.capacity') }}
                </label>
                <v-text-field 
                   v-model.number="filterCapacity" 
                   type="number" 
                   variant="solo-filled" 
                   density="comfortable"
                   hide-details
                   flat
                   class="filter-field"
                   placeholder="Min. people"
                   prepend-inner-icon="mdi-account-multiple"
                ></v-text-field>
              </div>
              
              <div class="filter-actions">
                <v-btn 
                  color="primary" 
                  prepend-icon="mdi-magnify" 
                  type="submit" 
                  class="search-btn flex-grow-1" 
                  height="48" 
                  rounded="lg"
                >
                  {{ $t('common.search') }}
                </v-btn>
                <v-btn 
                  variant="outlined" 
                  color="white" 
                  icon="mdi-refresh" 
                  @click="clearFilters" 
                  height="48" 
                  width="48" 
                  rounded="lg"
                  class="reset-btn"
                ></v-btn>
              </div>
            </div>
          </v-form>
        </div>

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
import { ref } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();

const handleLogout = () => {
  // Clear any stored user data/tokens
  localStorage.removeItem('authToken');
  localStorage.removeItem('user');
  sessionStorage.clear();
  
  // Redirect to login page
  router.push('/');
};

const rooms = ref([
  {
    id: 1,
    name: 'Nebula Conference Hall',
    capacity: 20,
    status: 'Available',
    location: 'Floor 2, East Wing',
    features: ['Projector', 'Video Conf', 'Whiteboard']
  },
  {
    id: 2,
    name: 'Starlight Huddle',
    capacity: 6,
    status: 'Occupied',
    location: 'Floor 2, West Wing',
    features: ['TV Screen', 'Whiteboard']
  },
  {
    id: 3,
    name: 'Galaxy Boardroom',
    capacity: 12,
    status: 'Available',
    location: 'Floor 3, Executive Suite',
    features: ['Projector', 'Video Conf', 'Catering']
  },
  {
    id: 4,
    name: 'Comet Pod',
    capacity: 4,
    status: 'Available',
    location: 'Lobby Area',
    features: ['Soundproof', 'TV Screen']
  }
]);
</script>

<style scoped>
.dashboard-wrapper {
  background: #0f172a;
  position: relative;
  overflow: hidden;
  min-height: 100vh;
}

.animated-bg {
  position: fixed;
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

/* Navbar Buttons */
.nav-btn {
    font-weight: 500;
    font-size: 0.875rem;
    letter-spacing: 0.025em;
    padding: 0 16px;
    margin: 0 2px;
    transition: all 0.2s ease;
}

.nav-btn:hover {
    background: rgba(255, 255, 255, 0.08);
}

.nav-btn.v-btn--active {
    background: rgba(59, 130, 246, 0.15);
    color: rgb(59, 130, 246) !important;
}

/* Filter Card */
.filter-card {
    background: rgba(30, 41, 59, 0.5) !important;
}

.filter-row {
    gap: 8px 0;
}

.filter-input :deep(.v-field) {
    border-radius: 10px;
}

.filter-input :deep(.v-field__outline) {
    color: rgba(255, 255, 255, 0.15);
}

.filter-input :deep(.v-field--focused .v-field__outline) {
    color: rgba(59, 130, 246, 0.6);
}

.filter-btn {
    font-weight: 600;
    box-shadow: 0 0 15px rgba(59, 130, 246, 0.3);
}

/* Section Header */
.section-header {
    padding-bottom: 16px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.06);
}

.section-icon {
    width: 44px;
    height: 44px;
    background: rgba(59, 130, 246, 0.15);
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* Enhanced Filter Section */
.filter-section {
    background: linear-gradient(135deg, rgba(30, 41, 59, 0.6) 0%, rgba(30, 41, 59, 0.4) 100%);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 20px;
    padding: 24px;
    position: relative;
    overflow: hidden;
}

.filter-section::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 3px;
    background: linear-gradient(90deg, rgba(59, 130, 246, 0.8), rgba(139, 92, 246, 0.8));
}

.filter-header {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
    padding-bottom: 16px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.06);
}

.filter-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr) auto;
    gap: 16px;
    align-items: end;
}

@media (max-width: 1264px) {
    .filter-grid {
        grid-template-columns: repeat(2, 1fr);
    }
    .filter-actions {
        grid-column: span 2;
    }
}

@media (max-width: 600px) {
    .filter-grid {
        grid-template-columns: 1fr;
    }
    .filter-actions {
        grid-column: span 1;
    }
}

.filter-item {
    display: flex;
    flex-direction: column;
}

.filter-label {
    display: flex;
    align-items: center;
    font-size: 0.75rem;
    font-weight: 500;
    color: rgba(255, 255, 255, 0.6);
    margin-bottom: 8px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.filter-field :deep(.v-field) {
    background: rgba(15, 23, 42, 0.6) !important;
    border-radius: 12px !important;
    border: 1px solid rgba(255, 255, 255, 0.08);
    transition: all 0.2s ease;
}

.filter-field :deep(.v-field:hover) {
    border-color: rgba(59, 130, 246, 0.3);
}

.filter-field :deep(.v-field--focused) {
    border-color: rgba(59, 130, 246, 0.6);
    box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

.filter-field :deep(.v-field__input) {
    color: white;
    font-size: 0.9rem;
}

.filter-field :deep(.v-field__input::placeholder) {
    color: rgba(255, 255, 255, 0.4);
}

.filter-actions {
    display: flex;
    gap: 12px;
    align-items: flex-end;
    min-width: 200px;
}

.search-btn {
    font-weight: 600;
    font-size: 0.9rem;
    letter-spacing: 0.025em;
    box-shadow: 0 4px 20px rgba(59, 130, 246, 0.35);
    transition: all 0.3s ease;
}

.search-btn:hover {
    box-shadow: 0 6px 25px rgba(59, 130, 246, 0.5);
    transform: translateY(-2px);
}

.reset-btn {
    flex-shrink: 0;
    border: 1px solid rgba(255, 255, 255, 0.3) !important;
    background: rgba(255, 255, 255, 0.05) !important;
}

.reset-btn:hover {
    background: rgba(255, 255, 255, 0.12) !important;
    border-color: rgba(255, 255, 255, 0.5) !important;
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
