<?php
session_start();
include '../db_connection.php'; // Include your DB connection

// Check if the form is submitted
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Prepare a query to find the admin by username
    $stmt = $conn->prepare("SELECT * FROM admins WHERE username = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();
    $admin = $result->fetch_assoc();

    // Check if the username exists and verify the password
    if (password_verify($password, $admin['password'])) {
        // Successful login, set session variables
        $_SESSION['admin_id'] = $admin['id'];
        $_SESSION['username'] = $admin['username'];
        $_SESSION['role'] = $admin['role'];
    
        // Redirect to the admin dashboard (check the URL)
        header('Location: admin.php');
        exit();
    }
    
    else {
        // Invalid credentials
        $error_message = "Invalid username or password.";
    }
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-50 font-sans">

    <div class="min-h-screen flex flex-col justify-center items-center bg-gradient-to-r from-green-400 to-blue-500">
        <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md">
            <h2 class="text-2xl font-bold text-green-600 text-center mb-6">Admin Login</h2>

            <?php
            if (isset($error_message)) {
                echo "<div class='bg-red-100 text-red-700 p-2 mb-4 rounded'>" . $error_message . "</div>";
            }
            ?>

            <form method="POST" action="admin_login.php" class="space-y-4">
                <div>
                    <label for="username" class="block text-sm font-medium text-gray-700">Username:</label>
                    <input type="text" id="username" name="username" required class="w-full px-4 py-2 border border-gray-300 rounded-lg">
                </div>

                <div>
                    <label for="password" class="block text-sm font-medium text-gray-700">Password:</label>
                    <input type="password" id="password" name="password" required class="w-full px-4 py-2 border border-gray-300 rounded-lg">
                </div>

                <button type="submit" class="w-full py-3 bg-green-500 text-white rounded-lg hover:bg-green-600">Login</button>
            </form>

            <div class="mt-6 text-center">
                <p class="text-sm text-gray-600">Don't have an admin account? <a href="register_admin.php" class="text-blue-500">Register here</a></p>
            </div>
        </div>
    </div>

</body>

</html>
