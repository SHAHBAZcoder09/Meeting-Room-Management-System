<template>
  <div class="admin-view-wrapper fill-height">
    <div class="animated-bg"></div>
    
    <!-- Top App Bar -->
    <v-app-bar flat color="transparent" class="px-md-4 border-bottom bg-glass-nav">
       <router-link to="/dashboard" class="text-decoration-none">
         <v-app-bar-title class="font-weight-bold">
           N4<span class="text-primary">Admin</span> - Rooms
         </v-app-bar-title>
       </router-link>
       <v-spacer></v-spacer>
       <v-btn to="/admin/bookings" variant="text" color="white" class="mr-2">Manage Bookings</v-btn>
       <v-btn to="/dashboard" variant="text" color="white" prepend-icon="mdi-arrow-left">Dashboard</v-btn>
    </v-app-bar>

    <v-main class="position-relative z-index-1">
      <v-container class="py-8">
        <div class="d-flex justify-space-between align-center mb-6">
            <h1 class="text-h4 font-weight-bold text-white">Manage Rooms</h1>
            <v-btn color="primary" @click="openDialog()" prepend-icon="mdi-plus">Add New Room</v-btn>
        </div>

        <div v-if="loading" class="d-flex justify-center py-12">
            <v-progress-circular indeterminate color="primary" size="64"></v-progress-circular>
        </div>

        <v-card v-else theme="dark" class="bg-glass" rounded="lg" elevation="0">
            <v-list class="bg-transparent pa-0">
                <v-list-item v-if="rooms.length === 0" class="text-center py-6 text-grey">
                    No rooms found. Add one to get started.
                </v-list-item>

                <div v-for="(room, index) in rooms" :key="room.id">
                    <v-list-item class="py-4">
                        <template v-slot:prepend>
                             <v-avatar color="primary" variant="tonal" rounded size="48" class="mr-4">
                                <v-icon icon="mdi-office-building" size="24"></v-icon>
                             </v-avatar>
                        </template>

                        <v-list-item-title class="text-h6 font-weight-bold text-white mb-1">
                            {{ room.name }}
                        </v-list-item-title>
                        <v-list-item-subtitle class="text-medium-emphasis d-flex align-center gap-4">
                            <span><v-icon icon="mdi-account-group" size="x-small" class="mr-1"></v-icon> {{ room.capacity }} people</span>
                            <span>•</span>
                            <span class="text-primary">{{ room.amenities }}</span>
                        </v-list-item-subtitle>

                        <template v-slot:append>
                             <div class="d-flex gap-2">
                                <v-btn 
                                    icon="mdi-pencil" 
                                    variant="text" 
                                    color="info" 
                                    @click="openDialog(room)"
                                ></v-btn>
                                <v-btn 
                                    icon="mdi-delete" 
                                    variant="text" 
                                    color="error" 
                                    @click="deleteRoom(room.id)"
                                ></v-btn>
                             </div>
                        </template>
                    </v-list-item>
                    <v-divider v-if="index < rooms.length - 1" class="border-opacity-10"></v-divider>
                </div>
            </v-list>
        </v-card>
      </v-container>

      <!-- Add/Edit Dialog -->
      <v-dialog v-model="dialog" max-width="500px">
        <v-card theme="dark" class="bg-glass-card">
            <v-card-title class="text-h5 font-weight-bold pa-4 pb-2 text-white">
                {{ isEdit ? 'Edit Room' : 'Add New Room' }}
            </v-card-title>
            <v-card-text class="pa-4">
                <v-form ref="form" @submit.prevent="saveRoom">
                    <v-text-field
                        v-model="editedItem.name"
                        label="Room Name"
                        variant="outlined"
                        required
                        bg-color="rgba(0,0,0,0.2)"
                        class="mb-2"
                    ></v-text-field>
                    <v-text-field
                        v-model.number="editedItem.capacity"
                        type="number"
                        label="Capacity"
                        variant="outlined"
                        required
                         bg-color="rgba(0,0,0,0.2)"
                        class="mb-2"
                    ></v-text-field>
                    <v-text-field
                        v-model="editedItem.amenities"
                        label="Amenities (comma separated)"
                        variant="outlined"
                        placeholder="TV, Whiteboard, Video Conf"
                        required
                         bg-color="rgba(0,0,0,0.2)"
                    ></v-text-field>
                </v-form>
            </v-card-text>
            <v-card-actions class="pa-4 pt-0 justify-end">
                <v-btn color="grey" variant="text" @click="closeDialog">Cancel</v-btn>
                <v-btn color="primary" variant="flat" class="glow-btn" @click="saveRoom">Save</v-btn>
            </v-card-actions>
        </v-card>
      </v-dialog>

    </v-main>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();
const rooms = ref([]);
const loading = ref(true);
const dialog = ref(false);
const isEdit = ref(false);

const editedItem = ref({ id: null, name: '', capacity: 0, amenities: '' });

const fetchRooms = async () => {
    try {
        const token = localStorage.getItem('authToken');
        const res = await fetch('/api/rooms', {
             headers: { 'Authorization': `Bearer ${token}` }
        });
        if(res.ok) {
            rooms.value = await res.json();
        }
    } catch(e) {
        console.error(e);
    } finally {
        loading.value = false;
    }
}

const openDialog = (item = null) => {
    if(item) {
        isEdit.value = true;
        editedItem.value = { ...item };
    } else {
        isEdit.value = false;
        editedItem.value = { id: null, name: '', capacity: 0, amenities: '' };
    }
    dialog.value = true;
}

const closeDialog = () => {
    dialog.value = false;
}

const saveRoom = async () => {
    try {
        const token = localStorage.getItem('authToken');
        const method = isEdit.value ? 'PUT' : 'POST';
        const url = isEdit.value ? `/api/rooms/${editedItem.value.id}` : '/api/rooms';

        const res = await fetch(url, {
            method: method,
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token}`
            },
            body: JSON.stringify(editedItem.value)
        });

        if(res.ok) {
            fetchRooms();
            closeDialog();
        } else {
            alert('Operation failed');
        }
    } catch(e) { console.error(e); }
}

const deleteRoom = async (id) => {
    if(!confirm('Are you sure you want to delete this room?')) return;
    try {
        const token = localStorage.getItem('authToken');
        const res = await fetch(`/api/rooms/${id}`, {
            method: 'DELETE',
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if(res.ok) fetchRooms();
    } catch(e) { console.error(e); }
}

onMounted(fetchRooms);
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
  background: radial-gradient(circle, rgba(16, 185, 129, 0.1) 0%, rgba(15, 23, 42, 0) 50%);
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

.bg-glass-card {
     background: rgba(15, 23, 42, 0.95) !important;
     backdrop-filter: blur(12px);
     border: 1px solid rgba(255, 255, 255, 0.1);
}
</style>
