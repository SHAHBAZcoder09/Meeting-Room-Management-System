// Protect the users page
protectPage();

// Load users on page load
window.addEventListener('load', function() {
    loadUsers();
});

// Load all users
async function loadUsers() {
    try {
        const response = await apiCall('/users', 'GET');
        
        if (Array.isArray(response)) {
            displayUsers(response);
        } else {
            displayUsers([]);
        }
    } catch (error) {
        document.getElementById('usersTableBody').innerHTML = 
            '<tr><td colspan="8" class="text-center alert-danger">Error loading users</td></tr>';
    }
}

// Display users in table
function displayUsers(users) {
    const tbody = document.getElementById('usersTableBody');
    
    if (users.length === 0) {
        tbody.innerHTML = '<tr><td colspan="8" class="text-center">No users found</td></tr>';
        return;
    }

    tbody.innerHTML = users.map(user => `
        <tr>
            <td>${user.id}</td>
            <td>${user.firstName}</td>
            <td>${user.lastName}</td>
            <td>${user.email}</td>
            <td>${user.role}</td>
            <td><span class="status-${user.active ? 'active' : 'inactive'}">
                ${user.active ? 'Active' : 'Inactive'}
            </span></td>
            <td>${formatDate(user.createdAt)}</td>
            <td>
                <button class="btn btn-sm" onclick="editUser(${user.id})" style="margin-right: 0.5rem;">Edit</button>
                <button class="btn btn-danger btn-sm" onclick="deleteUser(${user.id})">Delete</button>
            </td>
        </tr>
    `).join('');
}

// Filter users by search
function filterUsers() {
    const searchInput = document.getElementById('searchInput').value.toLowerCase();
    const rows = document.querySelectorAll('.users-table tbody tr');
    
    rows.forEach(row => {
        const text = row.textContent.toLowerCase();
        row.style.display = text.includes(searchInput) ? '' : 'none';
    });
}

// Open add user modal
function openAddUserModal() {
    document.getElementById('userId').value = '';
    document.getElementById('modalTitle').textContent = 'Add New User';
    document.getElementById('userForm').reset();
    document.getElementById('formError').style.display = 'none';
    document.getElementById('userModal').classList.add('show');
}

// Close user modal
function closeUserModal() {
    document.getElementById('userModal').classList.remove('show');
}

// Edit user
async function editUser(userId) {
    try {
        const response = await apiCall(`/users/${userId}`, 'GET');
        
        if (response) {
            document.getElementById('userId').value = response.id;
            document.getElementById('modalFirstName').value = response.firstName;
            document.getElementById('modalLastName').value = response.lastName;
            document.getElementById('modalEmail').value = response.email;
            document.getElementById('modalRole').value = response.role;
            document.getElementById('modalActive').checked = response.active;
            document.getElementById('modalPassword').value = '';
            document.getElementById('modalTitle').textContent = 'Edit User';
            document.getElementById('formError').style.display = 'none';
            document.getElementById('userModal').classList.add('show');
        }
    } catch (error) {
        alert('Error loading user: ' + error.message);
    }
}

// Save user (add or update)
document.getElementById('userForm').addEventListener('submit', async function(event) {
    event.preventDefault();

    const userId = document.getElementById('userId').value;
    const firstName = document.getElementById('modalFirstName').value.trim();
    const lastName = document.getElementById('modalLastName').value.trim();
    const email = document.getElementById('modalEmail').value.trim();
    const password = document.getElementById('modalPassword').value;
    const role = document.getElementById('modalRole').value;
    const active = document.getElementById('modalActive').checked;

    // Validate
    if (!firstName || !lastName || !email) {
        showError('formError', 'First name, last name, and email are required');
        return;
    }

    if (!isValidEmail(email)) {
        showError('formError', 'Invalid email format');
        return;
    }

    try {
        const userData = {
            firstName: firstName,
            lastName: lastName,
            email: email,
            role: role,
            active: active
        };

        if (password) {
            if (!isValidPassword(password)) {
                showError('formError', 'Password must be at least 6 characters');
                return;
            }
            userData.password = password;
        }

        let response;
        if (userId) {
            // Update user
            response = await apiCall(`/users/${userId}`, 'PUT', userData);
        } else {
            // Add new user (requires password)
            if (!password) {
                showError('formError', 'Password is required for new users');
                return;
            }
            response = await apiCall('/users', 'POST', userData);
        }

        if (response) {
            closeUserModal();
            loadUsers();
            alert(userId ? 'User updated successfully' : 'User created successfully');
        }
    } catch (error) {
        showError('formError', 'Error saving user: ' + error.message);
    }
});

// Delete user
async function deleteUser(userId) {
    if (!confirm('Are you sure you want to delete this user?')) {
        return;
    }

    try {
        await apiCall(`/users/${userId}`, 'DELETE');
        loadUsers();
        alert('User deleted successfully');
    } catch (error) {
        alert('Error deleting user: ' + error.message);
    }
}

// Close modal when clicking outside
window.addEventListener('click', function(event) {
    const modal = document.getElementById('userModal');
    if (event.target === modal) {
        closeUserModal();
    }
});
