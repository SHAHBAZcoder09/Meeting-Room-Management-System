// Handle user registration
async function handleRegister(event) {
    event.preventDefault();

    // Clear previous errors
    document.querySelectorAll('.error-message').forEach(el => el.textContent = '');
    document.getElementById('errorMessage').style.display = 'none';

    // Get form values
    const firstName = document.getElementById('firstName').value.trim();
    const lastName = document.getElementById('lastName').value.trim();
    const email = document.getElementById('regEmail').value.trim();
    const password = document.getElementById('regPassword').value;
    const confirmPassword = document.getElementById('confirmPassword').value;

    // Validate inputs
    let hasError = false;

    if (!firstName) {
        showError('firstNameError', 'First name is required');
        hasError = true;
    }

    if (!lastName) {
        showError('lastNameError', 'Last name is required');
        hasError = true;
    }

    if (!email) {
        showError('emailError', 'Email is required');
        hasError = true;
    } else if (!isValidEmail(email)) {
        showError('emailError', 'Invalid email format');
        hasError = true;
    }

    if (!password) {
        showError('passwordError', 'Password is required');
        hasError = true;
    } else if (!isValidPassword(password)) {
        showError('passwordError', 'Password must be at least 6 characters');
        hasError = true;
    }

    if (password !== confirmPassword) {
        showError('confirmError', 'Passwords do not match');
        hasError = true;
    }

    if (hasError) return;

    try {
        const response = await apiCall('/users/register', 'POST', {
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password
        });

        if (response && response.token) {
            setToken(response.token);
            setToken(response.token);
            setUserEmail(response.email);
            localStorage.setItem('userId', response.userId);
            localStorage.setItem('userRole', response.role);
            document.getElementById('registerForm').style.display = 'none';
            document.getElementById('successMessage').style.display = 'block';
        } else {
            showError('errorMessage', response?.message || 'Registration failed');
        }
    } catch (error) {
        showError('errorMessage', 'An error occurred: ' + error.message);
    }
}

// Handle user login
async function handleLogin(event) {
    event.preventDefault();

    // Clear previous errors
    document.querySelectorAll('.error-message').forEach(el => el.textContent = '');
    document.getElementById('errorMessage').style.display = 'none';

    // Get form values
    const email = document.getElementById('email').value.trim();
    const password = document.getElementById('password').value;

    // Validate inputs
    let hasError = false;

    if (!email) {
        showError('emailError', 'Email is required');
        hasError = true;
    } else if (!isValidEmail(email)) {
        showError('emailError', 'Invalid email format');
        hasError = true;
    }

    if (!password) {
        showError('passwordError', 'Password is required');
        hasError = true;
    }

    if (hasError) return;

    try {
        const response = await apiCall('/users/login', 'POST', {
            email: email,
            password: password
        });

        if (response && response.token) {
            setToken(response.token);
            setUserEmail(response.email);
            localStorage.setItem('userId', response.userId);
            localStorage.setItem('userRole', response.role);
            // alert('Login successful!'); // Removed for smoother UX
            window.location.href = '../rooms-page';
        } else {
            showError('errorMessage', response?.message || 'Invalid email or password');
        }
    } catch (error) {
        showError('errorMessage', 'Login failed: ' + error.message);
    }
}
