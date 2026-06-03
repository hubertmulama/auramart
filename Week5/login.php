<?php
session_start();
include 'includes/db.php';

if(isset($_POST['login'])){
    $email    = mysqli_real_escape_string($conn, $_POST['email']);
    $password = $_POST['password'];

    $query  = "SELECT * FROM users WHERE email='$email'";
    $result = mysqli_query($conn, $query);

    if(mysqli_num_rows($result) == 1){
        $user = mysqli_fetch_assoc($result);

        if(password_verify($password, $user['password'])){
            // Store user info in session
            $_SESSION['user_id']   = $user['id'];
            $_SESSION['user_name'] = $user['fullname'];
            $_SESSION['user_role'] = $user['role'];

            // Redirect based on role
            if($user['role'] == 'admin'){
                header("Location: admin/index.php");
            } else {
                header("Location: dashboard.php");
            }
            exit();
        } else {
            $error = "Incorrect password. Please try again.";
        }
    } else {
        $error = "No account found with that email.";
    }
}
?>

<?php include 'includes/db.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AuraMart - Login</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="auth-body">

<div class="auth-container">
    <h2>Welcome Back</h2>
    <p>Login to your AuraMart account</p>

    <?php if(isset($error)) echo "<p class='error'>$error</p>"; ?>

    <form method="POST" onsubmit="return validateLogin()">
        <input type="email" name="email" id="email" placeholder="Email Address" required>
        <input type="password" name="password" id="password" placeholder="Password" required>
        <button type="submit" name="login">Login</button>
    </form>

    <p>Don't have an account? <a href="register.php">Register here</a></p>
</div>

<script src="js/main.js"></script>
</body>
</html>