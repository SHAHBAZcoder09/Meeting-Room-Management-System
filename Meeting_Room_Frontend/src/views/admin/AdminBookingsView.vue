<template>
  <div class="admin-view-wrapper fill-height">
    <div class="animated-bg"></div>
    
     <!-- Top App Bar -->
    <v-app-bar flat color="transparent" class="px-md-4 border-bottom bg-glass-nav">
       <router-link to="/dashboard" class="text-decoration-none">
         <v-app-bar-title class="font-weight-bold">
           N4<span class="text-primary">Admin</span>
         </v-app-bar-title>
       </router-link>
       <v-spacer></v-spacer>
       <v-btn to="/admin/rooms" variant="text" color="white" class="mr-2">Manage Rooms</v-btn>
       <v-btn to="/dashboard" variant="text" color="white" prepend-icon="mdi-arrow-left">Dashboard</v-btn>
    </v-app-bar>

    <v-main class="position-relative z-index-1">
      <v-container class="py-8">
        <h1 class="text-h4 font-weight-bold text-white mb-6">Manage Bookings</h1>

        <!-- Stats Row -->
        <v-row class="mb-6">
            <v-col cols="12" md="3">
                <v-card theme="dark" class="bg-glass-card pa-4 text-center">
                    <div class="text-overline text-medium-emphasis">Total Bookings</div>
                    <div class="text-h4 font-weight-bold text-white">{{ bookings.length }}</div>
                </v-card>
            </v-col>
            <v-col cols="12" md="3">
                <v-card theme="dark" class="bg-glass-card pa-4 text-center">
                    <div class="text-overline text-warning">Pending</div>
                    <div class="text-h4 font-weight-bold text-white">{{ bookings.filter(b => b.status === 'PENDING').length }}</div>
                </v-card>
            </v-col>
             <v-col cols="12" md="3">
                <v-card theme="dark" class="bg-glass-card pa-4 text-center">
                    <div class="text-overline text-success">Confirmed</div>
                    <div class="text-h4 font-weight-bold text-white">{{ bookings.filter(b => b.status === 'CONFIRMED').length }}</div>
                </v-card>
            </v-col>
             <v-col cols="12" md="3">
                <v-card theme="dark" class="bg-glass-card pa-4 text-center">
                    <div class="text-overline text-error">Rejected/Cancelled</div>
                    <div class="text-h4 font-weight-bold text-white">{{ bookings.filter(b => ['REJECTED', 'CANCELLED'].includes(b.status)).length }}</div>
                </v-card>
            </v-col>
        </v-row>

        <div v-if="loading" class="d-flex justify-center py-12">
            <v-progress-circular indeterminate color="primary" size="64"></v-progress-circular>
        </div>

        <v-card v-else theme="dark" class="bg-glass" rounded="lg" elevation="0">
            <v-data-table
                :headers="headers"
                :items="bookings"
                item-value="id"
                class="bg-transparent"
                hover
            >
                <!-- Custom column templating -->
                <template v-slot:item.user="{ item }">
                    <div class="d-flex align-center">
                        <v-avatar color="primary" size="32" class="mr-2">
                            <span class="text-caption text-white font-weight-bold">
                                {{ item.user?.firstName ? item.user.firstName[0].toUpperCase() : 'U' }}
                            </span>
                        </v-avatar>
                        <div>
                            <div class="font-weight-medium">{{ item.user?.firstName }} {{ item.user?.lastName }}</div>
                            <div class="text-caption text-medium-emphasis">{{ item.user?.email }}</div>
                        </div>
                    </div>
                </template>

                 <template v-slot:item.room="{ item }">
                    <span class="font-weight-medium text-primary">{{ item.meetingRoom?.name }}</span>
                </template>

                 <template v-slot:item.date="{ item }">
                    {{ formatDate(item.startTime) }}
                </template>

                 <template v-slot:item.time="{ item }">
                    {{ formatTime(item.startTime) }} - {{ formatTime(item.endTime) }}
                </template>

                <template v-slot:item.status="{ item }">
                    <v-chip :color="getStatusColor(item.status)" size="small" label class="font-weight-bold">
                        {{ item.status }}
                    </v-chip>
                </template>

                <template v-slot:item.actions="{ item }">
                     <div class="d-flex gap-2" v-if="item.status === 'PENDING'">
                        <v-btn 
                            icon="mdi-check" 
                            size="small" 
                            color="success" 
                            variant="tonal" 
                            @click="openActionDialog(item.id, 'approve')"
                            title="Approve"
                        ></v-btn>
                        <v-btn 
                            icon="mdi-close" 
                            size="small" 
                            color="error" 
                            variant="tonal" 
                            @click="openActionDialog(item.id, 'reject')"
                            title="Reject"
                        ></v-btn>
                     </div>
                      <span v-else class="text-caption text-grey">--</span>
                </template>
            </v-data-table>
        </v-card>

      </v-container>
    </v-main>

    <!-- Action Confirmation Dialog -->
    <v-dialog v-model="actionDialog" max-width="400" persistent>
      <v-card theme="dark" class="bg-glass" rounded="lg">
        <v-card-title class="text-h6 pa-6">
          <v-icon :icon="pendingAction.action === 'approve' ? 'mdi-check-circle' : 'mdi-close-circle'" 
                  :color="pendingAction.action === 'approve' ? 'success' : 'error'" 
                  class="mr-2"></v-icon>
          {{ pendingAction.action === 'approve' ? 'Approve' : 'Reject' }} Booking?
        </v-card-title>
        <v-card-text class="px-6 pb-2">
          Are you sure you want to {{ pendingAction.action }} this booking?
        </v-card-text>
        <v-card-actions class="pa-6 pt-4">
          <v-spacer></v-spacer>
          <v-btn variant="text" @click="actionDialog = false">Cancel</v-btn>
          <v-btn :color="pendingAction.action === 'approve' ? 'success' : 'error'" variant="flat" @click="confirmAction">
            Yes, {{ pendingAction.action === 'approve' ? 'Approve' : 'Reject' }}
          </v-btn>
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

const headers = [
    { title: 'Booking ID', key: 'id', align: 'start' },
    { title: 'User', key: 'user', align: 'start' },
    { title: 'Room', key: 'room', align: 'start' },
    { title: 'Date', key: 'date', align: 'start' },
    { title: 'Time', key: 'time', align: 'start' },
    { title: 'Purpose', key: 'purpose', align: 'start' },
    { title: 'Status', key: 'status', align: 'start' },
    { title: 'Actions', key: 'actions', align: 'end', sortable: false },
];

const fetchBookings = async () => {
    try {
        const token = localStorage.getItem('authToken');
        if(!token) return router.push('/login');
        
        const res = await fetch('/api/bookings/admin/all', {
            headers: { 'Authorization': `Bearer ${token}` }
        });

        if(res.ok) {
            bookings.value = await res.json();
            // Sort by ID desc by default
            bookings.value.sort((a,b) => b.id - a.id);
        } else if (res.status === 403) {
             alert('Unauthorized access');
             router.push('/dashboard');
        }
    } catch(e) {
        console.error(e);
    } finally {
        loading.value = false;
    }
}

// Snackbar
const snackbar = ref({ show: false, text: '', color: 'success' });

const showNotification = (text, color = 'success') => {
  snackbar.value = { show: true, text, color };
};

// Action dialog
const actionDialog = ref(false);
const pendingAction = ref({ id: null, action: null });

const openActionDialog = (id, action) => {
    pendingAction.value = { id, action };
    actionDialog.value = true;
};

const confirmAction = async () => {
    const { id, action } = pendingAction.value;
    if (!id) return;

    try {
        const token = localStorage.getItem('authToken');
        const endpoint = `/api/bookings/${id}/${action === 'approve' ? 'approve' : 'reject'}`;
        const res = await fetch(endpoint, {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${token}` }
        });

        if(res.ok) {
            showNotification(`Booking ${action}d successfully!`, action === 'approve' ? 'success' : 'warning');
            fetchBookings();
        } else {
             const txt = await res.text();
             showNotification('Action failed: ' + txt, 'error');
        }

    } catch(e) { 
        console.error(e); 
        showNotification('Network error', 'error');
    } finally {
        actionDialog.value = false;
        pendingAction.value = { id: null, action: null };
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
    return new Date(dateStr).toLocaleDateString();
}
const formatTime = (dateStr) => {
    return new Date(dateStr).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
}

onMounted(fetchBookings);
</script>

<style scoped>
.admin-view-wrapper {
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
  background: radial-gradient(circle, rgba(16, 185, 129, 0.12) 0%, rgba(15, 23, 42, 0) 50%);
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
    background: rgba(15, 23, 42, 0.85) !important;
    backdrop-filter: blur(12px);
    border-bottom: 1px solid rgba(255,255,255,0.05);
}

.bg-glass-card {
     background: rgba(30, 41, 59, 0.5) !important;
     backdrop-filter: blur(12px);
     border: 1px solid rgba(255, 255, 255, 0.08);
     border-radius: 16px;
     transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.bg-glass-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 10px 30px -5px rgba(0, 0, 0, 0.3);
    border-color: rgba(16, 185, 129, 0.3);
}
</style>

