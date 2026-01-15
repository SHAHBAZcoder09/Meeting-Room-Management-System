<template>
  <div class="dashboard-container">
    <header class="dashboard-header">
      <div class="header-content">
        <h1>Meeting Room Management</h1>
        <div class="user-info">
          <div class="user-profile">
            <div class="avatar">AD</div>
            <span>Admin User</span>
          </div>
          <button @click="handleLogout" class="logout-btn">Logout</button>
        </div>
      </div>
    </header>

    <main class="main-content">
      <section class="stats-grid">
        <div class="stat-card">
          <h3>Available Rooms</h3>
          <div class="value">8</div>
          <p class="trend positive">+2 from yesterday</p>
        </div>
        <div class="stat-card">
          <h3>Active Meetings</h3>
          <div class="value">3</div>
          <p class="trend">Currently ongoing</p>
        </div>
        <div class="stat-card">
          <h3>Total Bookings</h3>
          <div class="value">24</div>
          <p class="trend positive">Today</p>
        </div>
      </section>

      <section class="rooms-section">
        <div class="section-header">
          <h2>Conference Rooms</h2>
          <button class="action-btn">Book Room</button>
        </div>

        <div class="rooms-grid">
          <div v-for="room in rooms" :key="room.id" class="room-card">
            <div class="room-status" :class="room.status.toLowerCase()">{{ room.status }}</div>
            <h3>{{ room.name }}</h3>
            <p class="capacity">Capacity: {{ room.capacity }} people</p>
            <div class="features">
              <span v-for="feature in room.features" :key="feature">{{ feature }}</span>
            </div>
            <div class="room-footer">
              <span class="location">{{ room.location }}</span>
              <button class="book-btn" :disabled="room.status === 'Occupied'">
                {{ room.status === 'Occupied' ? 'In Use' : 'Book Now' }}
              </button>
            </div>
          </div>
        </div>
      </section>
    </main>
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
.dashboard-container {
  min-height: 100vh;
  background-color: #1a202c;
  color: #fff;
  font-family: 'Inter', sans-serif;
}

.dashboard-header {
  background: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  padding: 20px 40px;
}

.header-content {
  max-width: 1400px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

h1 {
  font-size: 1.5rem;
  font-weight: 600;
  background: linear-gradient(to right, #fff, #a0aec0);
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
  margin: 0;
}

.user-profile {
  display: flex;
  align-items: center;
  gap: 12px;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 20px;
}

.logout-btn {
  background-color: rgba(255, 255, 255, 0.1);
  color: white;
  border: 1px solid rgba(255, 255, 255, 0.3);
  padding: 8px 16px;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 500;
  transition: all 0.3s ease;
}

.logout-btn:hover {
  background-color: rgba(255, 52, 52, 0.6);
  border-color: rgba(255, 52, 52, 0.8);
  transform: translateY(-2px);
}

.avatar {
  width: 40px;
  height: 40px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 0.9rem;
}

.main-content {
  max-width: 1400px;
  margin: 40px auto;
  padding: 0 40px;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 24px;
  margin-bottom: 48px;
}

.stat-card {
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 16px;
  padding: 24px;
  transition: transform 0.2s;
}

.stat-card:hover {
  transform: translateY(-4px);
  background: rgba(255, 255, 255, 0.05);
}

.stat-card h3 {
  font-size: 0.9rem;
  color: #a0aec0;
  margin-bottom: 8px;
  font-weight: 500;
}

.stat-card .value {
  font-size: 2.5rem;
  font-weight: 700;
  margin-bottom: 4px;
  color: white;
}

.trend {
  font-size: 0.85rem;
  color: #718096;
}

.trend.positive {
  color: #48bb78;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}

h2 {
  font-size: 1.5rem;
  font-weight: 600;
}

.action-btn {
  background: #667eea;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 8px;
  font-weight: 500;
  cursor: pointer;
  transition: background 0.2s;
}

.action-btn:hover {
  background: #5a67d8;
}

.rooms-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 24px;
}

.room-card {
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 16px;
  padding: 24px;
  position: relative;
  overflow: hidden;
}

.room-status {
  position: absolute;
  top: 24px;
  right: 24px;
  font-size: 0.75rem;
  padding: 4px 12px;
  border-radius: 20px;
  font-weight: 600;
}

.room-status.available {
  background: rgba(72, 187, 120, 0.2);
  color: #68d391;
}

.room-status.occupied {
  background: rgba(245, 101, 101, 0.2);
  color: #fc8181;
}

.room-card h3 {
  font-size: 1.25rem;
  font-weight: 600;
  margin-bottom: 8px;
  margin-right: 80px;
}

.capacity {
  color: #a0aec0;
  font-size: 0.9rem;
  margin-bottom: 16px;
}

.features {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-bottom: 24px;
}

.features span {
  background: rgba(255, 255, 255, 0.05);
  font-size: 0.8rem;
  padding: 4px 10px;
  border-radius: 6px;
  color: #cbd5e0;
}

.room-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 16px;
  border-top: 1px solid rgba(255, 255, 255, 0.08);
}

.location {
  font-size: 0.85rem;
  color: #718096;
}

.book-btn {
  background: transparent;
  border: 1px solid #667eea;
  color: #667eea;
  padding: 6px 16px;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.2s;
}

.book-btn:hover:not(:disabled) {
  background: #667eea;
  color: white;
}

.book-btn:disabled {
  border-color: #4a5568;
  color: #4a5568;
  cursor: not-allowed;
}
</style>
