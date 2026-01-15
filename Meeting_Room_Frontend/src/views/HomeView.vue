<template>
  <div class="landing-page">
    <!-- Animated Background -->
    <div class="bg-wrapper">
      <div class="mesh-gradient"></div>
      <div class="grid-overlay"></div>
      <div class="floating-orb orb-1"></div>
      <div class="floating-orb orb-2"></div>
      <div class="floating-orb orb-3"></div>
    </div>

    <!-- Navigation -->
    <nav class="nav-container">
      <div class="nav-content">
        <router-link to="/" class="logo">
          <span class="logo-text">N4</span><span class="logo-accent">Booking</span>
        </router-link>
        
        <div class="nav-links d-none d-md-flex">
          <a href="#features" class="nav-link">{{ $t('home.features.title').split(' ')[0] }}</a>
          <a href="#how-it-works" class="nav-link">{{ $t('home.howItWorks.title').split(' ')[0] }}</a>
          <a href="#testimonials" class="nav-link">{{ $t('home.testimonials.title').split(' ')[0] }}</a>
        </div>

        <div class="nav-actions">
          <LanguageSwitcher />
          <v-btn variant="text" color="white" to="/login" class="text-capitalize mr-2">{{ $t('nav.signIn') }}</v-btn>
          <v-btn color="primary" rounded="pill" to="/register" class="text-capitalize px-6 glow-btn" elevation="0">
            {{ $t('nav.getStarted') }}
          </v-btn>
        </div>
      </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
      <v-container>
        <v-row align="center" justify="center">
          <v-col cols="12" lg="6" class="hero-content">
            <div class="hero-badge slide-up">
              <v-icon icon="mdi-sparkles" size="small" class="mr-1"></v-icon>
              {{ $t('home.badge') }}
            </div>
            
            <h1 class="hero-title slide-up delay-1">
              {{ $t('home.heroTitle') }}
              <span class="title-gradient">{{ $t('home.heroTitleGradient') }}</span>
            </h1>
            
            <p class="hero-subtitle slide-up delay-2">
              {{ $t('home.heroSubtitle') }}
            </p>
            
            <div class="hero-cta slide-up delay-3">
              <v-btn 
                color="primary" 
                size="x-large" 
                rounded="pill" 
                to="/register"
                class="cta-primary"
                height="56"
              >
                {{ $t('home.ctaPrimary') }}
                <v-icon end icon="mdi-arrow-right"></v-icon>
              </v-btn>
              
              <v-btn 
                variant="outlined" 
                color="white" 
                size="x-large" 
                rounded="pill"
                class="cta-secondary"
                height="56"
                @click="scrollToFeatures"
              >
                <v-icon start icon="mdi-play-circle"></v-icon>
                {{ $t('home.ctaDemo') }}
              </v-btn>
            </div>

            <div class="hero-stats slide-up delay-4">
              <div class="stat-item">
                <span class="stat-number">10K+</span>
                <span class="stat-label">{{ $t('home.stats.bookings') }}</span>
              </div>
              <div class="stat-divider"></div>
              <div class="stat-item">
                <span class="stat-number">500+</span>
                <span class="stat-label">Companies</span>
              </div>
              <div class="stat-divider"></div>
              <div class="stat-item">
                <span class="stat-number">99.9%</span>
                <span class="stat-label">Uptime</span>
              </div>
            </div>
          </v-col>

          <v-col cols="12" lg="6" class="hero-visual d-none d-lg-block">
            <div class="visual-container">
              <!-- Main floating card -->
              <div class="floating-card main-card">
                <div class="card-header">
                  <v-avatar color="primary" size="40">
                    <v-icon icon="mdi-door" color="white"></v-icon>
                  </v-avatar>
                  <div class="card-header-text">
                    <div class="card-title">Executive Suite</div>
                    <div class="card-status available">● Available Now</div>
                  </div>
                </div>
                <div class="card-details">
                  <div class="detail-row">
                    <v-icon icon="mdi-account-group" size="small"></v-icon>
                    <span>12 People</span>
                  </div>
                  <div class="detail-row">
                    <v-icon icon="mdi-television" size="small"></v-icon>
                    <span>4K Display</span>
                  </div>
                  <div class="detail-row">
                    <v-icon icon="mdi-video" size="small"></v-icon>
                    <span>Video Conf</span>
                  </div>
                </div>
                <v-btn color="primary" block class="mt-4" rounded="lg">Book Now</v-btn>
              </div>

              <!-- Small floating cards -->
              <div class="floating-card mini-card card-1">
                <v-icon icon="mdi-lightning-bolt" color="warning" size="24"></v-icon>
                <span>Instant Booking</span>
              </div>

              <div class="floating-card mini-card card-2">
                <v-icon icon="mdi-clock-check" color="success" size="24"></v-icon>
                <span>Real-time</span>
              </div>

              <div class="floating-card mini-card card-3">
                <v-icon icon="mdi-shield-check" color="info" size="24"></v-icon>
                <span>Secure</span>
              </div>

              <!-- Glow effect -->
              <div class="visual-glow"></div>
            </div>
          </v-col>
        </v-row>
      </v-container>
    </section>

    <!-- Features Section -->
    <section id="features" class="features-section">
      <v-container>
        <div class="section-header text-center">
          <div class="section-badge">Features</div>
          <h2 class="section-title">Everything You Need to<br><span class="title-gradient">Manage Meetings</span></h2>
          <p class="section-subtitle">Powerful features designed for modern workplaces</p>
        </div>

        <v-row class="mt-12">
          <v-col cols="12" md="4" v-for="(feature, i) in features" :key="i">
            <div class="feature-card" :class="`delay-${i + 1}`">
              <div class="feature-icon" :style="{ background: feature.gradient }">
                <v-icon :icon="feature.icon" size="28" color="white"></v-icon>
              </div>
              <h3 class="feature-title">{{ feature.title }}</h3>
              <p class="feature-description">{{ feature.description }}</p>
            </div>
          </v-col>
        </v-row>
      </v-container>
    </section>

    <!-- How It Works Section -->
    <section id="how-it-works" class="how-it-works-section">
      <v-container>
        <div class="section-header text-center">
          <div class="section-badge">Simple Process</div>
          <h2 class="section-title">Book a Room in<br><span class="title-gradient">3 Easy Steps</span></h2>
        </div>

        <v-row class="mt-12" align="center">
          <v-col cols="12" md="4" v-for="(step, i) in steps" :key="i">
            <div class="step-card">
              <div class="step-number">{{ i + 1 }}</div>
              <div class="step-icon">
                <v-icon :icon="step.icon" size="32" color="primary"></v-icon>
              </div>
              <h3 class="step-title">{{ step.title }}</h3>
              <p class="step-description">{{ step.description }}</p>
            </div>
            <div class="step-connector" v-if="i < steps.length - 1"></div>
          </v-col>
        </v-row>
      </v-container>
    </section>

    <!-- Testimonials Section -->
    <section id="testimonials" class="testimonials-section">
      <v-container>
        <div class="section-header text-center">
          <div class="section-badge">Testimonials</div>
          <h2 class="section-title">Loved by Teams<br><span class="title-gradient">Everywhere</span></h2>
        </div>

        <v-row class="mt-12">
          <v-col cols="12" md="4" v-for="(testimonial, i) in testimonials" :key="i">
            <div class="testimonial-card">
              <div class="testimonial-quote">"{{ testimonial.quote }}"</div>
              <div class="testimonial-author">
                <v-avatar color="primary" size="48">
                  <span class="text-white font-weight-bold">{{ testimonial.initials }}</span>
                </v-avatar>
                <div class="author-info">
                  <div class="author-name">{{ testimonial.name }}</div>
                  <div class="author-role">{{ testimonial.role }}</div>
                </div>
              </div>
            </div>
          </v-col>
        </v-row>
      </v-container>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
      <v-container>
        <div class="cta-content text-center">
          <h2 class="cta-title">Ready to Transform Your<br><span class="title-gradient">Meeting Experience?</span></h2>
          <p class="cta-subtitle">Join thousands of companies already using N4Booking</p>
          <v-btn 
            color="primary" 
            size="x-large" 
            rounded="pill" 
            to="/register"
            class="cta-primary mt-8"
            height="60"
          >
            Get Started Free
            <v-icon end icon="mdi-arrow-right"></v-icon>
          </v-btn>
        </div>
      </v-container>
    </section>

    <!-- Footer -->
    <footer class="footer-section">
      <v-container>
        <v-row>
          <v-col cols="12" md="4">
            <div class="footer-brand">
              <span class="logo-text">N4</span><span class="logo-accent">Booking</span>
            </div>
            <p class="footer-tagline">The smartest way to manage your workspace meetings.</p>
          </v-col>
          <v-col cols="6" md="2">
            <h4 class="footer-heading">Product</h4>
            <ul class="footer-links">
              <li><a href="#features">Features</a></li>
              <li><a href="#how-it-works">How It Works</a></li>
              <li><router-link to="/login">Sign In</router-link></li>
            </ul>
          </v-col>
          <v-col cols="6" md="2">
            <h4 class="footer-heading">Company</h4>
            <ul class="footer-links">
              <li><a href="#">About Us</a></li>
              <li><a href="#">Contact</a></li>
              <li><a href="#">Careers</a></li>
            </ul>
          </v-col>
          <v-col cols="12" md="4">
            <h4 class="footer-heading">Stay Updated</h4>
            <div class="newsletter-form">
              <v-text-field 
                variant="outlined" 
                placeholder="Enter your email" 
                density="compact"
                hide-details
                bg-color="rgba(255,255,255,0.05)"
                class="newsletter-input"
              ></v-text-field>
              <v-btn color="primary" class="newsletter-btn">Subscribe</v-btn>
            </div>
          </v-col>
        </v-row>
        <v-divider class="my-8" color="rgba(255,255,255,0.1)"></v-divider>
        <div class="footer-bottom">
          <span>© 2026 N4Booking. All rights reserved.</span>
          <div class="social-links">
            <v-btn icon="mdi-twitter" variant="text" size="small" color="grey"></v-btn>
            <v-btn icon="mdi-linkedin" variant="text" size="small" color="grey"></v-btn>
            <v-btn icon="mdi-github" variant="text" size="small" color="grey"></v-btn>
          </div>
        </div>
      </v-container>
    </footer>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';
import { useI18n } from 'vue-i18n';
import LanguageSwitcher from '@/components/LanguageSwitcher.vue';

const { t } = useI18n();

const features = computed(() => [
  {
    icon: 'mdi-calendar-clock',
    title: t('home.features.smartScheduling'),
    description: t('home.features.smartSchedulingDesc'),
    gradient: 'linear-gradient(135deg, #3b82f6, #8b5cf6)'
  },
  {
    icon: 'mdi-clock-fast',
    title: t('home.features.realTime'),
    description: t('home.features.realTimeDesc'),
    gradient: 'linear-gradient(135deg, #10b981, #06b6d4)'
  },
  {
    icon: 'mdi-bell-ring',
    title: t('home.features.notifications'),
    description: t('home.features.notificationsDesc'),
    gradient: 'linear-gradient(135deg, #f59e0b, #ef4444)'
  }
]);

const steps = computed(() => [
  {
    icon: 'mdi-magnify',
    title: t('home.howItWorks.step1'),
    description: t('home.howItWorks.step1Desc')
  },
  {
    icon: 'mdi-calendar-check',
    title: t('home.howItWorks.step2'),
    description: t('home.howItWorks.step2Desc')
  },
  {
    icon: 'mdi-check-circle',
    title: t('home.howItWorks.step3'),
    description: t('home.howItWorks.step3Desc')
  }
]);

const testimonials = ref([
  {
    quote: "N4Booking has completely transformed how we manage our meeting rooms. The interface is beautiful and intuitive.",
    name: "Sarah Johnson",
    role: "Operations Manager",
    initials: "SJ"
  },
  {
    quote: "Finally, a booking system that just works. Our team loves the real-time availability feature.",
    name: "Michael Chen",
    role: "Tech Lead",
    initials: "MC"
  },
  {
    quote: "The best investment we made for our office. Booking meetings has never been easier.",
    name: "Emily Davis",
    role: "HR Director",
    initials: "ED"
  }
]);

const scrollToFeatures = () => {
  document.getElementById('features')?.scrollIntoView({ behavior: 'smooth' });
};
</script>

<style scoped>
/* ============ Base Styles ============ */
.landing-page {
  background: #0a0e1a;
  min-height: 100vh;
  color: white;
  overflow-x: hidden;
}

/* ============ Animated Background ============ */
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
    radial-gradient(ellipse 60% 40% at 80% 60%, rgba(139, 92, 246, 0.12) 0%, transparent 50%),
    radial-gradient(ellipse 50% 30% at 50% 80%, rgba(6, 182, 212, 0.1) 0%, transparent 50%);
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
  width: 400px;
  height: 400px;
  background: rgba(59, 130, 246, 0.3);
  top: 10%;
  left: 10%;
  animation-delay: 0s;
}

.orb-2 {
  width: 300px;
  height: 300px;
  background: rgba(139, 92, 246, 0.25);
  top: 60%;
  right: 10%;
  animation-delay: -5s;
}

.orb-3 {
  width: 250px;
  height: 250px;
  background: rgba(6, 182, 212, 0.2);
  bottom: 20%;
  left: 30%;
  animation-delay: -10s;
}

@keyframes float-orb {
  0%, 100% { transform: translate(0, 0) scale(1); }
  25% { transform: translate(30px, -30px) scale(1.1); }
  50% { transform: translate(-20px, 20px) scale(0.95); }
  75% { transform: translate(20px, 30px) scale(1.05); }
}

/* ============ Navigation ============ */
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

.nav-links {
  display: flex;
  gap: 32px;
}

.nav-link {
  color: rgba(255, 255, 255, 0.7);
  text-decoration: none;
  font-size: 0.9rem;
  font-weight: 500;
  transition: color 0.2s;
}

.nav-link:hover { color: white; }

.nav-actions {
  display: flex;
  align-items: center;
}

/* ============ Hero Section ============ */
.hero-section {
  min-height: 100vh;
  display: flex;
  align-items: center;
  padding-top: 100px;
  position: relative;
  z-index: 1;
}

.hero-content {
  padding-right: 48px;
}

.hero-badge {
  display: inline-flex;
  align-items: center;
  background: rgba(59, 130, 246, 0.15);
  border: 1px solid rgba(59, 130, 246, 0.3);
  padding: 8px 16px;
  border-radius: 50px;
  font-size: 0.85rem;
  font-weight: 600;
  color: #60a5fa;
  margin-bottom: 24px;
}

.hero-title {
  font-size: 3.5rem;
  font-weight: 800;
  line-height: 1.1;
  margin-bottom: 24px;
}

.title-gradient {
  display: block;
  background: linear-gradient(135deg, #60a5fa 0%, #a78bfa 50%, #22d3ee 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.hero-subtitle {
  font-size: 1.25rem;
  color: rgba(255, 255, 255, 0.7);
  line-height: 1.7;
  margin-bottom: 32px;
  max-width: 500px;
}

.hero-cta {
  display: flex;
  gap: 16px;
  flex-wrap: wrap;
}

.cta-primary {
  background: linear-gradient(135deg, #3b82f6 0%, #8b5cf6 100%) !important;
  box-shadow: 0 0 30px rgba(59, 130, 246, 0.4);
  font-weight: 600;
  text-transform: none;
  padding: 0 32px !important;
}

.cta-secondary {
  border: 2px solid rgba(255, 255, 255, 0.2) !important;
  font-weight: 600;
  text-transform: none;
  padding: 0 32px !important;
}

.hero-stats {
  display: flex;
  align-items: center;
  gap: 24px;
  margin-top: 48px;
  padding-top: 32px;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.stat-item {
  display: flex;
  flex-direction: column;
}

.stat-number {
  font-size: 1.5rem;
  font-weight: 700;
  color: white;
}

.stat-label {
  font-size: 0.85rem;
  color: rgba(255, 255, 255, 0.5);
}

.stat-divider {
  width: 1px;
  height: 40px;
  background: rgba(255, 255, 255, 0.1);
}

/* ============ Hero Visual ============ */
.hero-visual {
  position: relative;
}

.visual-container {
  position: relative;
  width: 100%;
  height: 500px;
}

.visual-glow {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 400px;
  height: 400px;
  background: radial-gradient(circle, rgba(59, 130, 246, 0.2) 0%, transparent 70%);
  filter: blur(40px);
}

.floating-card {
  position: absolute;
  background: rgba(30, 41, 59, 0.6);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 16px;
  padding: 20px;
}

.main-card {
  width: 280px;
  top: 15%;
  left: 10%;
  z-index: 3;
  animation: float 6s ease-in-out infinite;
}

.card-header {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 16px;
}

.card-title {
  font-weight: 600;
  font-size: 1.1rem;
}

.card-status.available {
  color: #10b981;
  font-size: 0.8rem;
}

.card-details {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
}

.detail-row {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 0.85rem;
  color: rgba(255, 255, 255, 0.7);
}

.mini-card {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 14px 18px;
  font-size: 0.9rem;
  font-weight: 500;
}

.card-1 {
  top: 5%;
  right: 15%;
  animation: float 8s ease-in-out infinite reverse;
}

.card-2 {
  top: 55%;
  right: 5%;
  animation: float 7s ease-in-out infinite;
  animation-delay: -2s;
}

.card-3 {
  bottom: 10%;
  left: 25%;
  animation: float 9s ease-in-out infinite;
  animation-delay: -4s;
}

@keyframes float {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-20px); }
}

/* ============ Sections Common ============ */
.section-header {
  margin-bottom: 48px;
}

.section-badge {
  display: inline-block;
  background: rgba(59, 130, 246, 0.15);
  border: 1px solid rgba(59, 130, 246, 0.3);
  padding: 6px 14px;
  border-radius: 50px;
  font-size: 0.8rem;
  font-weight: 600;
  color: #60a5fa;
  margin-bottom: 16px;
}

.section-title {
  font-size: 2.5rem;
  font-weight: 800;
  line-height: 1.2;
  margin-bottom: 16px;
}

.section-subtitle {
  font-size: 1.1rem;
  color: rgba(255, 255, 255, 0.6);
}

/* ============ Features Section ============ */
.features-section {
  padding: 120px 0;
  position: relative;
  z-index: 1;
}

.feature-card {
  background: rgba(30, 41, 59, 0.4);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 20px;
  padding: 32px;
  height: 100%;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.feature-card:hover {
  transform: translateY(-8px);
  border-color: rgba(59, 130, 246, 0.3);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
}

.feature-icon {
  width: 56px;
  height: 56px;
  border-radius: 14px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 20px;
}

.feature-title {
  font-size: 1.25rem;
  font-weight: 700;
  margin-bottom: 12px;
}

.feature-description {
  color: rgba(255, 255, 255, 0.6);
  line-height: 1.6;
}

/* ============ How It Works ============ */
.how-it-works-section {
  padding: 120px 0;
  position: relative;
  z-index: 1;
  background: rgba(15, 23, 42, 0.5);
}

.step-card {
  text-align: center;
  padding: 32px;
  position: relative;
}

.step-number {
  position: absolute;
  top: 0;
  left: 50%;
  transform: translateX(-50%);
  font-size: 4rem;
  font-weight: 900;
  color: rgba(59, 130, 246, 0.1);
  z-index: 0;
}

.step-icon {
  width: 72px;
  height: 72px;
  background: rgba(59, 130, 246, 0.15);
  border: 1px solid rgba(59, 130, 246, 0.3);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 20px;
  position: relative;
  z-index: 1;
}

.step-title {
  font-size: 1.25rem;
  font-weight: 700;
  margin-bottom: 12px;
}

.step-description {
  color: rgba(255, 255, 255, 0.6);
  line-height: 1.6;
}

/* ============ Testimonials ============ */
.testimonials-section {
  padding: 120px 0;
  position: relative;
  z-index: 1;
}

.testimonial-card {
  background: rgba(30, 41, 59, 0.4);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 20px;
  padding: 32px;
  height: 100%;
  transition: all 0.3s ease;
}

.testimonial-card:hover {
  border-color: rgba(59, 130, 246, 0.3);
}

.testimonial-quote {
  font-size: 1rem;
  line-height: 1.7;
  color: rgba(255, 255, 255, 0.8);
  margin-bottom: 24px;
  font-style: italic;
}

.testimonial-author {
  display: flex;
  align-items: center;
  gap: 12px;
}

.author-name {
  font-weight: 600;
}

.author-role {
  font-size: 0.85rem;
  color: rgba(255, 255, 255, 0.5);
}

/* ============ CTA Section ============ */
.cta-section {
  padding: 120px 0;
  position: relative;
  z-index: 1;
  background: linear-gradient(180deg, transparent 0%, rgba(59, 130, 246, 0.1) 100%);
}

.cta-title {
  font-size: 2.5rem;
  font-weight: 800;
  line-height: 1.2;
  margin-bottom: 16px;
}

.cta-subtitle {
  font-size: 1.1rem;
  color: rgba(255, 255, 255, 0.6);
}

/* ============ Footer ============ */
.footer-section {
  padding: 80px 0 40px;
  position: relative;
  z-index: 1;
  background: rgba(10, 14, 26, 0.9);
  border-top: 1px solid rgba(255, 255, 255, 0.05);
}

.footer-brand {
  font-size: 1.5rem;
  font-weight: 800;
  margin-bottom: 12px;
}

.footer-tagline {
  color: rgba(255, 255, 255, 0.5);
  font-size: 0.9rem;
}

.footer-heading {
  font-size: 0.9rem;
  font-weight: 600;
  margin-bottom: 16px;
  color: rgba(255, 255, 255, 0.8);
}

.footer-links {
  list-style: none;
  padding: 0;
  margin: 0;
}

.footer-links li {
  margin-bottom: 10px;
}

.footer-links a {
  color: rgba(255, 255, 255, 0.5);
  text-decoration: none;
  font-size: 0.9rem;
  transition: color 0.2s;
}

.footer-links a:hover {
  color: #3b82f6;
}

.newsletter-form {
  display: flex;
  gap: 8px;
}

.newsletter-input {
  flex: 1;
}

.newsletter-btn {
  text-transform: none;
}

.footer-bottom {
  display: flex;
  justify-content: space-between;
  align-items: center;
  color: rgba(255, 255, 255, 0.4);
  font-size: 0.85rem;
}

.social-links {
  display: flex;
  gap: 8px;
}

/* ============ Animations ============ */
.slide-up {
  opacity: 0;
  transform: translateY(30px);
  animation: slideUp 0.8s cubic-bezier(0.16, 1, 0.3, 1) forwards;
}

.delay-1 { animation-delay: 0.1s; }
.delay-2 { animation-delay: 0.2s; }
.delay-3 { animation-delay: 0.3s; }
.delay-4 { animation-delay: 0.4s; }

@keyframes slideUp {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.glow-btn {
  box-shadow: 0 0 20px rgba(59, 130, 246, 0.4);
}

/* ============ Responsive ============ */
@media (max-width: 960px) {
  .hero-title {
    font-size: 2.5rem;
  }
  
  .hero-content {
    padding-right: 0;
    text-align: center;
  }
  
  .hero-subtitle {
    margin-left: auto;
    margin-right: auto;
  }
  
  .hero-cta {
    justify-content: center;
  }
  
  .hero-stats {
    justify-content: center;
  }
  
  .section-title {
    font-size: 2rem;
  }
}
</style>
