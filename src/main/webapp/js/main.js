// API Base URL
const API_BASE_URL = 'http://localhost:8080/api';

// Get stored token from localStorage
function getToken() {
    return localStorage.getItem('authToken');
}

// Set token in localStorage
function setToken(token) {
    localStorage.setItem('authToken', token);
}

// Clear token from localStorage
function clearToken() {
    localStorage.removeItem('authToken');
    localStorage.removeItem('userEmail');
}

// Store user email
function setUserEmail(email) {
    localStorage.setItem('userEmail', email);
}

// Get user email
function getUserEmail() {
    return localStorage.getItem('userEmail');
}

// Check if user is logged in
function isLoggedIn() {
    return getToken() !== null;
}

// Show logout button if logged in
window.addEventListener('load', function () {
    if (isLoggedIn()) {
        const logoutBtn = document.getElementById('logoutBtn');
        if (logoutBtn) {
            logoutBtn.style.display = 'block';
        }
    }
});

// Logout function
function logout() {
    clearToken();
    alert('Logged out successfully!');
    window.location.href = '/';
}

// Show error message
function showError(elementId, message) {
    const element = document.getElementById(elementId);
    if (element) {
        element.textContent = message;
        element.style.display = 'block';
    }
}

// Hide error message
function hideError(elementId) {
    const element = document.getElementById(elementId);
    if (element) {
        element.textContent = '';
        element.style.display = 'none';
    }
}

// Validate email format
function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

// Validate password strength
function isValidPassword(password) {
    return password.length >= 6;
}

// Format date to readable format
function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString() + ' ' + date.toLocaleTimeString();
}

// Make API call with authentication
async function apiCall(endpoint, method = 'GET', data = null) {
    const options = {
        method: method,
        headers: {
            'Content-Type': 'application/json'
        }
    };

    const token = getToken();
    if (token) {
        options.headers['Authorization'] = `Bearer ${token}`;
    }

    if (data) {
        options.body = JSON.stringify(data);
    }

    try {
        const response = await fetch(`${API_BASE_URL}${endpoint}`, options);

        if (response.status === 401) {
            clearToken();
            window.location.href = '/login';
            return null;
        }

        if (response.status === 404 && endpoint.includes('/users')) {
            return null;
        }

        return await response.json();
    } catch (error) {
        console.error('API Error:', error);
        throw error;
    }
}

// Check if page is protected
function protectPage() {
    if (!isLoggedIn()) {
        alert('Please login first!');
        window.location.href = '/login';
    }
}

// Debounce function for search
function debounce(func, delay) {
    let timeoutId;
    return function (...args) {
        clearTimeout(timeoutId);
        timeoutId = setTimeout(() => func.apply(this, args), delay);
    };
}
