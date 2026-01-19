<template>
  <div class="auth-page">
    <!-- Animated Background -->
    <div class="bg-wrapper">
      <div class="mesh-gradient"></div>
      <div class="grid-overlay"></div>
      <div class="floating-orb orb-1"></div>
      <div class="floating-orb orb-2"></div>
    </div>

    <!-- Navigation -->
    <nav class="nav-container">
      <div class="nav-content">
        <router-link to="/" class="logo">
          <span class="logo-text">N4</span><span class="logo-accent">Booking</span>
        </router-link>
        
        <div class="nav-actions">
          <LanguageSwitcher />
          <v-btn variant="text" color="white" to="/" class="text-capitalize mr-2">
            <v-icon start icon="mdi-arrow-left" size="small"></v-icon>
            {{ $t('nav.backToHome') }}
          </v-btn>
          <v-btn variant="outlined" color="white" to="/register" class="text-capitalize px-6" rounded="pill">
            {{ $t('nav.createAccount') }}
          </v-btn>
        </div>
      </div>
    </nav>

    <!-- Main Content -->
    <div class="auth-content">
      <div class="auth-container slide-up">
        <!-- Left Side - Branding -->
        <div class="auth-branding d-none d-lg-flex">
          <div class="branding-content">
            <h2 class="branding-title">{{ $t('auth.welcomeBack') }}<br><span class="title-gradient">N4Booking</span></h2>
            <p class="branding-subtitle">{{ $t('home.heroSubtitle') }}</p>
            
            <div class="branding-features">
              <div class="feature-item">
                <v-icon icon="mdi-check-circle" color="success" size="20"></v-icon>
                <span>{{ $t('auth.instantBooking') }}</span>
              </div>
              <div class="feature-item">
                <v-icon icon="mdi-check-circle" color="success" size="20"></v-icon>
                <span>{{ $t('auth.realTimeAvail') }}</span>
              </div>
              <div class="feature-item">
                <v-icon icon="mdi-check-circle" color="success" size="20"></v-icon>
                <span>{{ $t('auth.smartNotifications') }}</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Right Side - Form -->
        <div class="auth-form-container">
          <v-card theme="dark" class="auth-card" elevation="0" rounded="xl">
            <div class="text-center mb-8">
              <div class="avatar-container mb-4">
                <v-avatar color="primary" size="72" class="glow-avatar">
                  <v-icon icon="mdi-login" size="36" color="white"></v-icon>
                </v-avatar>
              </div>
              <h1 class="text-h4 font-weight-bold text-white mb-2">{{ $t('auth.signIn') }}</h1>
              <p class="text-grey-lighten-1">{{ $t('auth.signInSubtitle') }}</p>
            </div>

            <v-form @submit.prevent="handleLogin" v-model="isValid">
              <v-text-field
                v-model="email"
                :label="$t('auth.email')"
                placeholder="name@company.com"
                prepend-inner-icon="mdi-email-outline"
                variant="outlined"
                color="primary"
                class="mb-4"
                :rules="[v => !!v || 'Email is required']"
                bg-color="rgba(0,0,0,0.2)"
              ></v-text-field>

              <v-text-field
                v-model="password"
                :label="$t('auth.password')"
                placeholder="••••••••"
                :type="showPassword ? 'text' : 'password'"
                :append-inner-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
                @click:append-inner="showPassword = !showPassword"
                prepend-inner-icon="mdi-lock-outline"
                variant="outlined"
                color="primary"
                class="mb-2"
                :rules="[v => !!v || 'Password is required']"
                bg-color="rgba(0,0,0,0.2)"
              ></v-text-field>



              <v-btn
                block
                color="primary"
                size="x-large"
                type="submit"
                rounded="lg"
                :loading="isLoading"
                class="text-capitalize font-weight-bold cta-btn mb-4"
                height="52"
              >
                <v-icon icon="mdi-login" class="mr-2"></v-icon>
                {{ $t('auth.signIn') }}
              </v-btn>
            </v-form>

            <div class="text-center text-body-2 text-grey">
              {{ $t('auth.noAccount') }} 
              <router-link to="/register" class="text-primary font-weight-bold text-decoration-none">{{ $t('auth.createOne') }}</router-link>
            </div>
          </v-card>
        </div>
      </div>
    </div>

    <!-- Snackbar -->
    <v-snackbar v-model="snackbar.show" :color="snackbar.color" timeout="4000" location="top">
      {{ snackbar.text }}
      <template v-slot:actions>
        <v-btn variant="text" @click="snackbar.show = false" icon="mdi-close"></v-btn>
      </template>
    </v-snackbar>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import LanguageSwitcher from '@/components/LanguageSwitcher.vue';

const email = ref('');
const password = ref('');
const showPassword = ref(false);
const isLoading = ref(false);
const isValid = ref(false);
const router = useRouter();

const snackbar = ref({ show: false, text: '', color: 'error' });

const showNotification = (text, color = 'error') => {
  snackbar.value = { show: true, text, color };
};

const handleLogin = async () => {
    if (!isValid.value) return;
    
    isLoading.value = true;
    try {
        const response = await fetch('/api/users/login', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email: email.value, password: password.value })
        });

        if (response.ok) {
            const data = await response.json();
            localStorage.setItem('authToken', data.token);
             const userObj = {
                id: data.userId,
                email: data.email,
                firstName: data.firstName,
                lastName: data.lastName,
                role: data.role
            };
            localStorage.setItem('user', JSON.stringify(userObj));
            router.push('/dashboard');
        } else {
            const errorData = await response.json();
            showNotification(errorData.message || 'Invalid credentials', 'error');
        }
    } catch (error) {
        console.error('Login error:', error);
        showNotification('Network error occurred', 'error');
    } finally {
        isLoading.value = false;
    }
};
</script>

<style scoped>
.auth-page {
  min-height: 100vh;
  background: #0a0e1a;
  position: relative;
  overflow: hidden;
}

/* Background */
.bg-wrapper {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 0;
  pointer-events: none;
}

.mesh-gradient {
  position: absolute;
  width: 100%;
  height: 100%;
  background: 
    radial-gradient(ellipse 80% 50% at 20% 40%, rgba(59, 130, 246, 0.15) 0%, transparent 50%),
    radial-gradient(ellipse 60% 40% at 80% 60%, rgba(139, 92, 246, 0.12) 0%, transparent 50%);
}

.grid-overlay {
  position: absolute;
  width: 100%;
  height: 100%;
  background-image: 
    linear-gradient(rgba(255,255,255,0.02) 1px, transparent 1px),
    linear-gradient(90deg, rgba(255,255,255,0.02) 1px, transparent 1px);
  background-size: 60px 60px;
}

.floating-orb {
  position: absolute;
  border-radius: 50%;
  filter: blur(60px);
  animation: float-orb 20s ease-in-out infinite;
}

.orb-1 {
  width: 300px;
  height: 300px;
  background: rgba(59, 130, 246, 0.25);
  top: 20%;
  left: 10%;
}

.orb-2 {
  width: 250px;
  height: 250px;
  background: rgba(139, 92, 246, 0.2);
  bottom: 20%;
  right: 15%;
  animation-delay: -10s;
}

@keyframes float-orb {
  0%, 100% { transform: translate(0, 0) scale(1); }
  50% { transform: translate(30px, -30px) scale(1.1); }
}

/* Navigation */
.nav-container {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 100;
  padding: 16px 0;
  background: rgba(10, 14, 26, 0.8);
  backdrop-filter: blur(20px);
  border-bottom: 1px solid rgba(255, 255, 255, 0.05);
}

.nav-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 24px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.logo {
  text-decoration: none;
  font-size: 1.5rem;
  font-weight: 800;
}

.logo-text { color: white; }
.logo-accent { color: #3b82f6; }

.nav-actions {
  display: flex;
  align-items: center;
}

/* Content */
.auth-content {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 100px 24px 40px;
  position: relative;
  z-index: 1;
}

.auth-container {
  display: flex;
  max-width: 1000px;
  width: 100%;
  gap: 48px;
}

/* Left Branding */
.auth-branding {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding-right: 48px;
}

.branding-title {
  font-size: 2.5rem;
  font-weight: 800;
  color: white;
  line-height: 1.2;
  margin-bottom: 16px;
}

.title-gradient {
  background: linear-gradient(135deg, #60a5fa 0%, #a78bfa 50%, #22d3ee 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.branding-subtitle {
  color: rgba(255, 255, 255, 0.6);
  font-size: 1.1rem;
  line-height: 1.6;
  margin-bottom: 32px;
}

.branding-features {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.feature-item {
  display: flex;
  align-items: center;
  gap: 12px;
  color: rgba(255, 255, 255, 0.8);
}

/* Right Form */
.auth-form-container {
  flex: 1;
  max-width: 450px;
}

.auth-card {
  background: rgba(30, 41, 59, 0.6) !important;
  backdrop-filter: blur(24px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  padding: 40px;
}

.avatar-container {
  display: inline-block;
}

.glow-avatar {
  box-shadow: 0 0 40px rgba(59, 130, 246, 0.5), 0 0 80px rgba(59, 130, 246, 0.3);
}

.cta-btn {
  background: linear-gradient(135deg, #3b82f6 0%, #8b5cf6 100%) !important;
  box-shadow: 0 0 30px rgba(59, 130, 246, 0.4);
}

/* Animations */
.slide-up {
  opacity: 0;
  transform: translateY(30px);
  animation: slideUp 0.8s cubic-bezier(0.16, 1, 0.3, 1) forwards;
}

@keyframes slideUp {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@media (max-width: 960px) {
  .auth-container {
    flex-direction: column;
    align-items: center;
  }
  
  .auth-form-container {
    max-width: 100%;
  }
}

@media (max-width: 600px) {
  .nav-container {
    padding: 12px 0;
  }
  
  .nav-content {
    padding: 0 16px;
  }
  
  .logo {
    font-size: 1.25rem;
  }
  
  .nav-actions .v-btn {
    padding: 0 10px !important;
    font-size: 0.75rem;
  }
  
  .auth-content {
    padding: 80px 16px 24px;
  }
  
  .auth-card {
    padding: 24px 20px;
  }
  
  .auth-card .text-h4 {
    font-size: 1.5rem !important;
  }
  
  .auth-card .text-grey-lighten-1 {
    font-size: 0.85rem;
  }
  
  .glow-avatar {
    width: 56px !important;
    height: 56px !important;
  }
  
  .glow-avatar .v-icon {
    font-size: 28px !important;
  }
  
  .cta-btn {
    height: 48px !important;
    font-size: 0.9rem;
  }
}

@media (max-width: 400px) {
  .auth-card {
    padding: 20px 16px;
  }
  
  .auth-card .text-h4 {
    font-size: 1.25rem !important;
  }
  
  .nav-actions .v-btn:not(:last-child) {
    display: none;
  }
}
</style>
