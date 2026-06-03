<?php
session_start();
include 'includes/db.php';

$order_id = intval($_GET['id']);
$order    = mysqli_fetch_assoc(mysqli_query($conn, "SELECT * FROM orders WHERE id=$order_id"));
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AuraMart - Order Placed!</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/shop.css">
    <link rel="stylesheet" href="css/checkout.css">
</head>
<body>

<nav class="navbar">
    <div class="nav-brand">🛍️ AuraMart</div>
    <div class="nav-links">
        <a href="index.php">Home</a>
        <a href="cart.php">🛒 Cart <span class="cart-count" id="cart-count">0</span></a>
    </div>
</nav>

<div class="success-wrapper">
    <div class="success-card">
        <div class="success-icon">✅</div>
        <h1>Order Placed Successfully!</h1>
        <p>Thank you, <strong><?php echo $order['fullname']; ?></strong>!</p>
        <p>Your order <strong>#<?php echo str_pad($order_id, 5, '0', STR_PAD_LEFT); ?></strong> 
           has been received.</p>

        <div class="order-details">
            <div class="detail-row">
                <span>Payment Method</span>
                <span><?php echo $order['payment_method']; ?></span>
            </div>
            <div class="detail-row">
                <span>Delivery Address</span>
                <span><?php echo $order['address']; ?></span>
            </div>
            <div class="detail-row total">
                <span>Total Paid</span>
                <span>KES <?php echo number_format($order['total'], 2); ?></span>
            </div>
        </div>

        <a href="index.php"><button>Continue Shopping</button></a>
    </div>
</div>

<footer class="footer">
    <p>&copy; <?php echo date('Y'); ?> AuraMart. All rights reserved.</p>
</footer>

<script src="js/cart.js"></script>
</body>
</html>