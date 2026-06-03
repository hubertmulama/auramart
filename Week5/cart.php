<?php
session_start();
include 'includes/db.php';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AuraMart - Cart</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/shop.css">
    <link rel="stylesheet" href="css/cart.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
    <div class="nav-brand">🛍️ AuraMart</div>
    <div class="nav-links">
        <a href="index.php">Home</a>
        <a href="cart.php">🛒 Cart <span class="cart-count" id="cart-count">0</span></a>
        <?php if(isset($_SESSION['user_id'])): ?>
            <a href="dashboard.php">My Account</a>
            <a href="logout.php">Logout</a>
        <?php else: ?>
            <a href="login.php">Login</a>
            <a href="register.php">Register</a>
        <?php endif; ?>
    </div>
</nav>

<!-- Cart Content -->
<div class="cart-wrapper">
    <h1>🛒 Your Cart</h1>

    <div class="cart-layout">
        <div id="cart-items"></div>
        <div id="cart-summary"></div>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <p>&copy; <?php echo date('Y'); ?> AuraMart. All rights reserved.</p>
</footer>

<script src="js/cart.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', renderCart);
</script>
</body>
</html>