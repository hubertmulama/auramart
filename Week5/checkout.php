<?php
session_start();
include 'includes/db.php';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AuraMart - Checkout</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/shop.css">
    <link rel="stylesheet" href="css/checkout.css">
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

<!-- Checkout Content -->
<div class="checkout-wrapper">
    <h1>🧾 Checkout</h1>

    <div class="checkout-layout">

        <!-- Delivery Details Form -->
        <div class="checkout-form">
            <h3>Delivery Details</h3>
            <form id="checkoutForm">
                <input type="text" id="fullname" placeholder="Full Name" required
                       value="<?php echo isset($_SESSION['user_name']) ? $_SESSION['user_name'] : ''; ?>">
                <input type="email" id="email" placeholder="Email Address" required>
                <input type="tel" id="phone" placeholder="Phone Number (e.g. 0712345678)" required>
                <textarea id="address" placeholder="Delivery Address" rows="3" required></textarea>

                <h3>Payment Method</h3>
                <div class="payment-options">
                    <label class="payment-option">
                        <input type="radio" name="payment" value="Cash on Delivery" checked>
                        <span>💵 Cash on Delivery</span>
                    </label>
                    <label class="payment-option">
                        <input type="radio" name="payment" value="M-Pesa">
                        <span>📱 M-Pesa</span>
                    </label>
                    <label class="payment-option">
                        <input type="radio" name="payment" value="Bank Transfer">
                        <span>🏦 Bank Transfer</span>
                    </label>
                </div>

                <button type="button" onclick="placeOrder()">Place Order</button>
            </form>
        </div>

        <!-- Order Summary -->
        <div class="checkout-summary">
            <h3>Order Summary</h3>
            <div id="checkout-items"></div>
            <hr>
            <div class="summary-row">
                <span>Subtotal</span>
                <span id="checkout-subtotal">KES 0</span>
            </div>
            <div class="summary-row">
                <span>Shipping</span>
                <span>FREE</span>
            </div>
            <hr>
            <div class="summary-row total">
                <span>Total</span>
                <span id="checkout-total">KES 0</span>
            </div>
        </div>

    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <p>&copy; <?php echo date('Y'); ?> AuraMart. All rights reserved.</p>
</footer>

<script src="js/cart.js"></script>
<script src="js/checkout.js"></script>
</body>
</html>