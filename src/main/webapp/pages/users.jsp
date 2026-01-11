<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Users - User Management System</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>

    <body>
        <!-- Navigation Bar -->
        <nav class="navbar">
            <div class="container">
                <div class="navbar-brand">
                    <h1>User Management System</h1>
                </div>
                <ul class="nav-links">
                    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/login">Login</a></li>
                    <li><a href="${pageContext.request.contextPath}/users-list" class="active">Users</a></li>
                    <li><a href="javascript:logout()" id="logoutBtn">Logout</a></li>
                </ul>
            </div>
        </nav>

        <!-- Users Section -->
        <section class="users-section">
            <div class="container">
                <div class="users-header">
                    <h2>User Management</h2>
                    <button class="btn btn-primary" onclick="openAddUserModal()">Add New User</button>
                </div>

                <div class="search-bar">
                    <input type="text" id="searchInput" placeholder="Search users..." onkeyup="filterUsers()">
                </div>

                <!-- Users Table -->
                <div class="table-container">
                    <table class="users-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th>Created</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="usersTableBody">
                            <tr>
                                <td colspan="8" class="text-center">Loading users...</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

        <!-- Add/Edit User Modal -->
        <div id="userModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 id="modalTitle">Add New User</h2>
                    <span class="close" onclick="closeUserModal()">&times;</span>
                </div>
                <div class="modal-body">
                    <form id="userForm">
                        <input type="hidden" id="userId" name="userId">

                        <div class="form-group">
                            <label for="modalFirstName">First Name</label>
                            <input type="text" id="modalFirstName" name="firstName" required>
                        </div>

                        <div class="form-group">
                            <label for="modalLastName">Last Name</label>
                            <input type="text" id="modalLastName" name="lastName" required>
                        </div>

                        <div class="form-group">
                            <label for="modalEmail">Email</label>
                            <input type="email" id="modalEmail" name="email" required>
                        </div>

                        <div class="form-group">
                            <label for="modalPassword">Password</label>
                            <input type="password" id="modalPassword" name="password"
                                placeholder="Leave blank to keep current">
                        </div>

                        <div class="form-group">
                            <label for="modalRole">Role</label>
                            <select id="modalRole" name="role">
                                <option value="USER">User</option>
                                <option value="ADMIN">Admin</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="modalActive">
                                <input type="checkbox" id="modalActive" name="active" checked>
                                Active
                            </label>
                        </div>

                        <div class="modal-buttons">
                            <button type="button" class="btn btn-secondary" onclick="closeUserModal()">Cancel</button>
                            <button type="submit" class="btn btn-primary">Save User</button>
                        </div>
                    </form>
                    <div id="formError" class="alert alert-danger" style="display:none;"></div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="footer">
            <div class="container">
                <p>&copy; 2026 User Management System. All rights reserved.</p>
            </div>
        </footer>

        <script src="${pageContext.request.contextPath}/js/main.js"></script>
        <script src="${pageContext.request.contextPath}/js/users.js"></script>
    </body>

    </html>