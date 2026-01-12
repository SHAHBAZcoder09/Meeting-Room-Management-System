<template>
  <div class="login-container">
    <div class="login-card">
      <h1>Welcome Back</h1>
      <p class="subtitle">Please sign in to continue</p>
      
      <form @submit.prevent="handleLogin" class="login-form">
        <div class="form-group">
          <label for="email">Email Address</label>
          <input 
            type="email" 
            id="email" 
            v-model="email" 
            placeholder="name@company.com" 
            required
            autocomplete="email"
          />
        </div>
        
        <div class="form-group">
          <div class="label-row">
            <label for="password">Password</label>
            <a href="#" class="forgot-link">Forgot password?</a>
          </div>
          <input 
            type="password" 
            id="password" 
            v-model="password" 
            placeholder="••••••••" 
            required
            autocomplete="current-password"
          />
        </div>

        <button type="submit" class="submit-btn" :class="{ 'loading': isLoading }">
          <span v-if="!isLoading">Sign In</span>
          <span v-else class="loader"></span>
        </button>
      </form>
      
      <div class="footer-links">
        <p>Don't have an account? <a href="#">Sign up</a></p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';

// Generate 21 Demo Users to match user request style
const DEMO_USERS = Array.from({ length: 21 }, (_, index) => {
  const id = index + 1;
  // Random names and regions for variety
  const firstNames = ['Peng', 'Li', 'Yin', 'Billy', 'Sato', 'Liang', 'John', 'Jane', 'Akira', 'Maria', 'Chen', 'David', 'Sarah', 'Mike', 'Emily', 'Robert', 'Linda', 'William', 'Elizabeth', 'James', 'Barbara'];
  const lastNames = ['Xiuying', 'Ziyi', 'Gonzalez', 'Hazuki', 'Yunxi', 'Smith', 'Doe', 'Yamamoto', 'Garcia', 'Wei', 'Brown', 'Davis', 'Wilson', 'Moore', 'Taylor', 'Anderson', 'Thomas', 'Jackson', 'White', 'Harris', 'Martin'];
  
  const name = `${firstNames[index % firstNames.length]} ${lastNames[index % lastNames.length]}`;
  const regionId = Math.floor(Math.random() * 900) + 100; // Random 3 digit ID
  
  // Random times
  const h = String(Math.floor(Math.random() * 24)).padStart(2, '0');
  const m = String(Math.floor(Math.random() * 60)).padStart(2, '0');
  const s = String(Math.floor(Math.random() * 60)).padStart(2, '0');
  const createdTime = `${h}:${m}:${s}`;
  
  const y = 2020 + Math.floor(Math.random() * 6);
  const mo = String(Math.floor(Math.random() * 12) + 1).padStart(2, '0');
  const d = String(Math.floor(Math.random() * 28) + 1).padStart(2, '0');
  const updatedTime = `${y}-${mo}-${d}`;

  return {
    id,
    name,
    regionId: String(regionId),
    createdTime,
    updatedTime,
    // Add credentials for the first few so we can actually login
    email: index === 0 ? 'admin@company.com' : `user${id}@company.com`,
    password: index === 0 ? 'password123' : 'password'
  };
});

const email = ref('shahbazgaming1@gmail.com');
const password = ref('123456789');
const isLoading = ref(false);
const router = useRouter();

const handleLogin = async () => {
  isLoading.value = true;
  
  // Simulate network delay
  await new Promise(resolve => setTimeout(resolve, 1000));
  
  // Check for valid credentials
  const isValidCredential = (email.value === 'shahbazgaming1@gmail.com' && password.value === '123456789') || 
                            (email.value === 'admin@company.com' && password.value === 'password123');
  
  const user = DEMO_USERS.find(u => u.email === email.value && u.password === password.value) || 
               (isValidCredential ? DEMO_USERS[0] : null);

  if (user || isValidCredential) {
    // Log the entire array of users as requested
    console.log(DEMO_USERS);

    isLoading.value = false;
    router.push('/dashboard');
  } else {
    console.warn('Invalid Credentials given. Try shahbazgaming1@gmail.com / 123456789 or admin@company.com / password123');
    alert('Invalid credentials! Try: shahbazgaming1@gmail.com / 123456789 or admin@company.com / password123');
    isLoading.value = false;
  }
};
</script>

<style scoped>
/* Modern, Premium Dark Aesthetic with Glassmorphism */
.login-container {
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  width: 100%;
  background: radial-gradient(circle at top right, #2d3748, #1a202c);
  background-size: cover;
  color: #fff;
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
  padding: 20px;
}

.login-card {
  width: 100%;
  max-width: 420px;
  background: rgba(255, 255, 255, 0.03);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  padding: 40px;
  border-radius: 24px;
  border: 1px solid rgba(255, 255, 255, 0.08);
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
  text-align: center;
  animation: fadeIn 0.6s ease-out;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}

.brand-logo {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 56px;
  height: 56px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 16px;
  margin-bottom: 24px;
  box-shadow: 0 10px 15px -3px rgba(118, 75, 162, 0.3);
}

.brand-logo svg {
  width: 28px;
  height: 28px;
  color: white;
}

h1 {
  font-size: 1.875rem;
  font-weight: 700;
  margin-bottom: 8px;
  background: linear-gradient(to right, #fff, #a0aec0);
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
}

.subtitle {
  color: #718096;
  font-size: 0.95rem;
  margin-bottom: 32px;
}

.login-form {
  display: flex;
  flex-direction: column;
  gap: 20px;
  text-align: left;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

label {
  font-size: 0.85rem;
  font-weight: 500;
  color: #a0aec0;
}

.label-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

input {
  background: rgba(0, 0, 0, 0.2);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  padding: 12px 16px;
  color: white;
  font-size: 1rem;
  transition: all 0.25s ease;
  outline: none;
}

input:focus {
  border-color: #667eea;
  box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
  background: rgba(0, 0, 0, 0.3);
}

input::placeholder {
  color: #4a5568;
}

.forgot-link {
  font-size: 0.8rem;
  color: #667eea;
  text-decoration: none;
  transition: color 0.2s;
}

.forgot-link:hover {
  color: #764ba2;
  text-decoration: underline;
}

.submit-btn {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
  padding: 14px;
  border-radius: 12px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: transform 0.1s, box-shadow 0.2s, opacity 0.2s;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.2);
  margin-top: 8px;
  position: relative;
  overflow: hidden;
}

.submit-btn:hover {
  transform: translateY(-1px);
  box-shadow: 0 10px 15px -3px rgba(118, 75, 162, 0.3);
}

.submit-btn:active {
  transform: translateY(0);
}

.submit-btn.loading {
  opacity: 0.8;
  cursor: wait;
}

.loader {
  display: inline-block;
  width: 20px;
  height: 20px;
  border: 2px solid rgba(255,255,255,0.3);
  border-radius: 50%;
  border-top-color: white;
  animation: spin 0.8s linear infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

.footer-links {
  margin-top: 24px;
  font-size: 0.9rem;
  color: #718096;
}

.footer-links a {
  color: #667eea;
  text-decoration: none;
  font-weight: 500;
}

.footer-links a:hover {
  text-decoration: underline;
}
</style>
