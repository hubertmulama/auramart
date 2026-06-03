<?php
session_start();
include 'includes/db.php';

if(!isset($_SESSION['user_id'])){
    header("Location: login.php");
    exit();
}

$user_id = $_SESSION['user_id'];

// Fetch user details
$user = mysqli_fetch_assoc(mysqli_query($conn, "SELECT * FROM users WHERE id=$user_id"));

// Fetch customer orders
$orders = mysqli_query($conn, "SELECT * FROM orders WHERE user_id=$user_id ORDER BY created_at DESC");

// Order stats
$total_orders    = mysqli_fetch_assoc(mysqli_query($conn, "SELECT COUNT(*) as total FROM orders WHERE user_id=$user_id"))['total'];
$total_spent     = mysqli_fetch_assoc(mysqli_query($conn, "SELECT SUM(total) as spent FROM orders WHERE user_id=$user_id AND status != 'cancelled'"))['spent'];
$total_spent     = $total_spent ? $total_spent : 0;
$pending_orders  = mysqli_fetch_assoc(mysqli_query($conn, "SELECT COUNT(*) as total FROM orders WHERE user_id=$user_id AND status='pending'"))['total'];
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AuraMart - My Account</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/shop.css">
    <link rel="stylesheet" href="css/dashboard.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
    <div class="nav-brand">🛍️ AuraMart</div>
    <div class="nav-links">
        <a href="index.php">Home</a>
        <a href="cart.php">🛒 Cart <span class="cart-count" id="cart-count">0</span></a>
        <a href="dashboard.php">My Account</a>
        <a href="logout.php">Logout</a>
    </div>
</nav>

<!-- Dashboard Wrapper -->
<div class="dashboard-wrapper">

    <!-- Profile Card -->
    <div class="profile-card">
        <div class="profile-avatar">
            <?php echo strtoupper(substr($user['fullname'], 0, 1)); ?>
        </div>
        <div class="profile-info">
            <h2><?php echo $user['fullname']; ?></h2>
            <p><?php echo $user['email']; ?></p>
            <span class="role-badge role-<?php echo $user['role']; ?>">
                <?php echo ucfirst($user['role']); ?>
            </span>
        </div>
        <a href="logout.php" class="logout-btn">🚪 Logout</a>
    </div>

    <!-- Stats Cards -->
    <div class="dash-stats">
        <div class="dash-stat-card">
            <h3>Total Orders</h3>
            <p class="stat-number"><?php echo $total_orders; ?></p>
        </div>
        <div class="dash-stat-card">
            <h3>Pending Orders</h3>
            <p class="stat-number"><?php echo $pending_orders; ?></p>
        </div>
        <div class="dash-stat-card">
            <h3>Total Spent</h3>
            <p class="stat-number">KES <?php echo number_format($total_spent, 2); ?></p>
        </div>
    </div>

    <!-- Order History -->
    <div class="order-history">
        <h2>📦 My Orders</h2>

        <?php if(mysqli_num_rows($orders) > 0): ?>
            <?php while($order = mysqli_fetch_assoc($orders)): ?>
            <div class="order-card">
                <div class="order-card-header">
                    <div>
                        <h3>Order #<?php echo str_pad($order['id'], 5, '0', STR_PAD_LEFT); ?></h3>
                        <small><?php echo date('d M Y, h:i A', strtotime($order['created_at'])); ?></small>
                    </div>
                    <span class="status-badge status-<?php echo $order['status']; ?>">
                        <?php echo ucfirst($order['status']); ?>
                    </span>
                </div>
                <div class="order-card-body">
                    <div class="order-meta">
                        <span>📍 <?php echo $order['address']; ?></span>
                        <span>💳 <?php echo $order['payment_method']; ?></span>
                        <span>💰 KES <?php echo number_format($order['total'], 2); ?></span>
                    </div>

                    <!-- Order Items -->
                    <?php
                    $items = mysqli_query($conn, "SELECT * FROM order_items WHERE order_id={$order['id']}");
                    ?>
                    <div class="order-items-list">
                        <?php while($item = mysqli_fetch_assoc($items)): ?>
                        <div class="order-item-row">
                            <span><?php echo $item['product_name']; ?></span>
                            <span>x<?php echo $item['quantity']; ?></span>
                            <span>KES <?php echo number_format($item['price'] * $item['quantity'], 2); ?></span>
                        </div>
                        <?php endwhile; ?>
                    </div>
                </div>
            </div>
            <?php endwhile; ?>
        <?php else: ?>
            <div class="no-orders">
                <p>🛒 You haven't placed any orders yet.</p>
                <a href="index.php" class="hero-btn">Start Shopping</a>
            </div>
        <?php endif; ?>
    </div>

</div>

<!-- Footer -->
<footer class="footer">
    <p>&copy; <?php echo date('Y'); ?> AuraMart. All rights reserved.</p>
</footer>

<script src="js/cart.js"></script>
</body>
</html>