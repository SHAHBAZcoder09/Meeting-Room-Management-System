# How to Verify Frontend-Backend Connection

Since the frontend now makes real API calls, you can verify the connection using the browser's developer tools.

## 1. Network Tab Verification
1.  Open the application in Chrome: `http://localhost:8080`.
2.  Right-click anywhere and select **Inspect** -> **Network**.
3.  **Login Verification**:
    *   Attempt to login.
    *   Look for a request named `login` (red if failed, green/200 if success).
    *   Click on it. In the **Headers** tab, you should see `Request URL: http://localhost:8080/api/users/login`.
    *   In the **Payload** tab, you should see the email and password sent.
4.  **Dashboard Verification**:
    *   After login, if successful, you will land on Dashboard.
    *   Look for a request named `rooms`.
    *   If it returns `200 OK`, the connection is successful (even if the list is empty).

## 2. Console Logs
1.  Open **Inspect** -> **Console**.
2.  On successful login, you should see: `Login successful: { ... }`.
3.  On failure, you will see `Login failed:` or `Login error:`.

## 3. Database Check
Since we removed the mock data, the database is initially empty.
*   **The Login will fail** until you create a user in the database or use the registration endpoint (if available).
*   **To test immediately**: You might want to re-enable the `DataInitializer` temporarily or run a SQL INSERT command if you have access to a database console.
