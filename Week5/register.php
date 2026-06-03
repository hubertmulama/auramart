<?php 
include 'includes/db.php';

if(isset($_POST['register'])){
    $fullname = mysqli_real_escape_string($conn, $_POST['fullname']);
    $email    = mysqli_real_escape_string($conn, $_POST['email']);
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT);

    // Check if email already exists
    $check = mysqli_query($conn, "SELECT * FROM users WHERE email='$email'");

    if(mysqli_num_rows($check) > 0){
        $error = "Email already registered. Please login.";
    } else {
        $query = "INSERT INTO users (fullname, email, password, role) 
                  VALUES ('$fullname', '$email', '$password', 'customer')";
        
        if(mysqli_query($conn, $query)){
            $success = "Account created successfully! <a href='login.php'>Login here</a>";
        } else {
            $error = "Something went wrong. Please try again.";
        }
    }
}
?>

<?php include 'includes/db.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AuraMart - Register</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="auth-body">

<div class="auth-container">
    <h2>Create an Account</h2>
    <p>Join AuraMart today</p>

    <?php if(isset($error)) echo "<p class='error'>$error</p>"; ?>
    <?php if(isset($success)) echo "<p class='success'>$success</p>"; ?>

    <form method="POST" onsubmit="return validateRegister()">
        <input type="text" name="fullname" id="fullname" placeholder="Full Name" required>
        <input type="email" name="email" id="email" placeholder="Email Address" required>
        <input type="password" name="password" id="password" placeholder="Password" required>
        <input type="password" name="confirm_password" id="confirm_password" placeholder="Confirm Password" required>
        <button type="submit" name="register">Register</button>
    </form>

    <p>Already have an account? <a href="login.php">Login here</a></p>
</div>

<script src="js/main.js"></script>
</body>
</html>