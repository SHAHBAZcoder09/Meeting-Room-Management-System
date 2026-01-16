<template>
  <div class="profile-wrapper fill-height">
    <div class="animated-bg"></div>
    
    <!-- Top App Bar -->
    <v-app-bar flat color="transparent" class="px-md-4 border-bottom bg-glass-nav">
      <router-link to="/dashboard" class="text-decoration-none">
        <v-app-bar-title class="font-weight-bold">
          N4<span class="text-primary">Booking</span>
        </v-app-bar-title>
      </router-link>

      <template v-if="$vuetify.display.mdAndUp">
        <v-btn to="/dashboard" variant="text" color="white" class="nav-btn">Home</v-btn>
        <v-btn to="/calendar" variant="text" color="white" class="nav-btn">Calendar</v-btn>
        <v-btn to="/my-bookings" variant="text" color="white" class="nav-btn">My Bookings</v-btn>
      </template>

      <v-spacer></v-spacer>

      <v-btn to="/dashboard" variant="text" color="white" prepend-icon="mdi-arrow-left">Back</v-btn>
    </v-app-bar>

    <v-main class="position-relative z-index-1">
      <v-container class="py-8" style="max-width: 800px;">
        <h1 class="text-h4 font-weight-bold text-white mb-6">My Profile</h1>

        <!-- User Info Card -->
        <v-card theme="dark" class="bg-glass mb-6" rounded="lg" elevation="0">
          <v-card-text class="pa-6">
            <div class="d-flex align-center mb-6">
              <v-avatar color="primary" size="80" class="mr-4">
                <span class="text-h4 text-white font-weight-bold">{{ userInitials }}</span>
              </v-avatar>
              <div>
                <h2 class="text-h5 font-weight-bold text-white">{{ user.firstName }} {{ user.lastName }}</h2>
                <p class="text-subtitle-1 text-medium-emphasis mb-0">{{ user.email }}</p>
                <v-chip :color="user.role === 'ADMIN' ? 'success' : 'primary'" size="small" class="mt-2" label>
                  {{ user.role }}
                </v-chip>
              </div>
            </div>
          </v-card-text>
        </v-card>

        <!-- Edit Profile Form -->
        <v-card theme="dark" class="bg-glass mb-6" rounded="lg" elevation="0">
          <v-card-title class="pa-6 pb-2">
            <v-icon icon="mdi-account-edit" class="mr-2"></v-icon>
            Edit Profile
          </v-card-title>
          <v-card-text class="pa-6 pt-2">
            <v-form @submit.prevent="handleUpdateProfile" v-model="profileFormValid">
              <v-row>
                <v-col cols="12" md="6">
                  <v-text-field
                    v-model="editForm.firstName"
                    label="First Name"
                    variant="outlined"
                    color="primary"
                    :rules="[v => !!v || 'First name is required']"
                    prepend-inner-icon="mdi-account"
                  ></v-text-field>
                </v-col>
                <v-col cols="12" md="6">
                  <v-text-field
                    v-model="editForm.lastName"
                    label="Last Name"
                    variant="outlined"
                    color="primary"
                    :rules="[v => !!v || 'Last name is required']"
                    prepend-inner-icon="mdi-account"
                  ></v-text-field>
                </v-col>
              </v-row>
              <v-text-field
                v-model="editForm.email"
                label="Email"
                variant="outlined"
                color="primary"
                disabled
                prepend-inner-icon="mdi-email"
                hint="Email cannot be changed"
                persistent-hint
              ></v-text-field>
              <v-btn
                color="primary"
                type="submit"
                :loading="profileLoading"
                :disabled="!profileFormValid"
                class="mt-4"
                prepend-icon="mdi-content-save"
              >
                Save Changes
              </v-btn>
            </v-form>
          </v-card-text>
        </v-card>

        <!-- Change Password Form -->
        <v-card theme="dark" class="bg-glass" rounded="lg" elevation="0">
          <v-card-title class="pa-6 pb-2">
            <v-icon icon="mdi-lock-reset" class="mr-2"></v-icon>
            Change Password
          </v-card-title>
          <v-card-text class="pa-6 pt-2">
            <v-form @submit.prevent="handleChangePassword" v-model="passwordFormValid">
              <v-text-field
                v-model="passwordForm.currentPassword"
                label="Current Password"
                :type="showCurrentPassword ? 'text' : 'password'"
                variant="outlined"
                color="primary"
                :rules="[v => !!v || 'Current password is required']"
                prepend-inner-icon="mdi-lock"
                :append-inner-icon="showCurrentPassword ? 'mdi-eye' : 'mdi-eye-off'"
                @click:append-inner="showCurrentPassword = !showCurrentPassword"
              ></v-text-field>
              <v-text-field
                v-model="passwordForm.newPassword"
                label="New Password"
                :type="showNewPassword ? 'text' : 'password'"
                variant="outlined"
                color="primary"
                :rules="[
                  v => !!v || 'New password is required',
                  v => v.length >= 6 || 'Password must be at least 6 characters'
                ]"
                prepend-inner-icon="mdi-lock-plus"
                :append-inner-icon="showNewPassword ? 'mdi-eye' : 'mdi-eye-off'"
                @click:append-inner="showNewPassword = !showNewPassword"
              ></v-text-field>
              <v-text-field
                v-model="passwordForm.confirmPassword"
                label="Confirm New Password"
                :type="showConfirmPassword ? 'text' : 'password'"
                variant="outlined"
                color="primary"
                :rules="[
                  v => !!v || 'Please confirm your new password',
                  v => v === passwordForm.newPassword || 'Passwords do not match'
                ]"
                prepend-inner-icon="mdi-lock-check"
                :append-inner-icon="showConfirmPassword ? 'mdi-eye' : 'mdi-eye-off'"
                @click:append-inner="showConfirmPassword = !showConfirmPassword"
              ></v-text-field>
              <v-btn
                color="warning"
                type="submit"
                :loading="passwordLoading"
                :disabled="!passwordFormValid"
                class="mt-4"
                prepend-icon="mdi-key"
              >
                Change Password
              </v-btn>
            </v-form>
          </v-card-text>
        </v-card>

        <!-- Snackbar for notifications -->
        <v-snackbar v-model="snackbar.show" :color="snackbar.color" timeout="3000">
          {{ snackbar.text }}
          <template v-slot:actions>
            <v-btn variant="text" @click="snackbar.show = false">Close</v-btn>
          </template>
        </v-snackbar>

      </v-container>
    </v-main>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();

const user = ref(JSON.parse(localStorage.getItem('user') || '{}'));
const userInitials = computed(() => {
  if (!user.value.firstName) return 'U';
  return `${user.value.firstName[0]}${user.value.lastName ? user.value.lastName[0] : ''}`.toUpperCase();
});

// Edit Profile Form
const editForm = ref({
  firstName: user.value.firstName || '',
  lastName: user.value.lastName || '',
  email: user.value.email || ''
});
const profileFormValid = ref(false);
const profileLoading = ref(false);

// Change Password Form
const passwordForm = ref({
  currentPassword: '',
  newPassword: '',
  confirmPassword: ''
});
const passwordFormValid = ref(false);
const passwordLoading = ref(false);
const showCurrentPassword = ref(false);
const showNewPassword = ref(false);
const showConfirmPassword = ref(false);

// Snackbar
const snackbar = ref({ show: false, text: '', color: 'success' });

const showNotification = (text, color = 'success') => {
  snackbar.value = { show: true, text, color };
};

const handleUpdateProfile = async () => {
  if (!profileFormValid.value) return;
  profileLoading.value = true;

  try {
    const token = localStorage.getItem('authToken');
    const res = await fetch(`/api/users/${user.value.id}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
      },
      body: JSON.stringify({
        firstName: editForm.value.firstName,
        lastName: editForm.value.lastName,
        email: editForm.value.email
      })
    });

    if (res.ok) {
      const updatedUser = await res.json();
      // Update local storage
      const storedUser = JSON.parse(localStorage.getItem('user') || '{}');
      storedUser.firstName = updatedUser.firstName;
      storedUser.lastName = updatedUser.lastName;
      localStorage.setItem('user', JSON.stringify(storedUser));
      user.value = storedUser;
      showNotification('Profile updated successfully!', 'success');
    } else {
      showNotification('Failed to update profile', 'error');
    }
  } catch (e) {
    console.error(e);
    showNotification('Network error', 'error');
  } finally {
    profileLoading.value = false;
  }
};

const handleChangePassword = async () => {
  if (!passwordFormValid.value) return;
  passwordLoading.value = true;

  try {
    const token = localStorage.getItem('authToken');
    const res = await fetch(`/api/users/${user.value.id}/change-password`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
      },
      body: JSON.stringify({
        currentPassword: passwordForm.value.currentPassword,
        newPassword: passwordForm.value.newPassword
      })
    });

    if (res.ok) {
      showNotification('Password changed successfully!', 'success');
      // Clear form
      passwordForm.value = { currentPassword: '', newPassword: '', confirmPassword: '' };
    } else {
      const data = await res.json();
      showNotification(data.error || 'Failed to change password', 'error');
    }
  } catch (e) {
    console.error(e);
    showNotification('Network error', 'error');
  } finally {
    passwordLoading.value = false;
  }
};

onMounted(() => {
  if (!localStorage.getItem('authToken')) {
    router.push('/login');
  }
});
</script>

<style scoped>
.profile-wrapper {
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
  background: radial-gradient(circle, rgba(139, 92, 246, 0.15) 0%, rgba(15, 23, 42, 0) 50%);
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
}

.bg-glass-nav {
    background: rgba(15, 23, 42, 0.7) !important;
    backdrop-filter: blur(10px);
    border-bottom: 1px solid rgba(255,255,255,0.05);
}
</style>
