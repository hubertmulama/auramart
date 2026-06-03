<?php
session_start();
include '../includes/db.php';

if(!isset($_SESSION['user_id']) || $_SESSION['user_role'] != 'admin'){
    header("Location: ../login.php");
    exit();
}

// Fetch live stats
$total_products = mysqli_fetch_assoc(mysqli_query($conn, "SELECT COUNT(*) as total FROM products"))['total'];
$total_orders   = mysqli_fetch_assoc(mysqli_query($conn, "SELECT COUNT(*) as total FROM orders"))['total'];
$total_users    = mysqli_fetch_assoc(mysqli_query($conn, "SELECT COUNT(*) as total FROM users"))['total'];
$total_revenue  = mysqli_fetch_assoc(mysqli_query($conn, "SELECT SUM(total) as revenue FROM orders WHERE status != 'cancelled'"))['revenue'];
$total_revenue  = $total_revenue ? $total_revenue : 0;

// Recent orders
$recent_orders = mysqli_query($conn, "SELECT * FROM orders ORDER BY created_at DESC LIMIT 5");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AuraMart - Admin Panel</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/admin.css">
</head>
<body>

<div class="admin-wrapper">

    <!-- Sidebar -->
    <div class="sidebar">
        <h2>AuraMart</h2>
        <p>Admin Panel</p>
        <nav>
            <a href="index.php" class="active">🏠 Dashboard</a>
            <a href="products.php">📦 Products</a>
            <a href="orders.php">🛒 Orders</a>
            <a href="users.php">👥 Users</a>
            <a href="../logout.php">🚪 Logout</a>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <h1>Welcome, <?php echo $_SESSION['user_name']; ?> 👋</h1>
        <p>Here's what's happening on AuraMart today.</p>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <h3>Total Products</h3>
                <p class="stat-number"><?php echo $total_products; ?></p>
            </div>
            <div class="stat-card">
                <h3>Total Orders</h3>
                <p class="stat-number"><?php echo $total_orders; ?></p>
            </div>
            <div class="stat-card">
                <h3>Total Users</h3>
                <p class="stat-number"><?php echo $total_users; ?></p>
            </div>
            <div class="stat-card">
                <h3>Revenue</h3>
                <p class="stat-number">KES <?php echo number_format($total_revenue, 2); ?></p>
            </div>
        </div>

        <!-- Recent Orders -->
        <div class="table-card" style="margin-top:30px;">
            <h3>Recent Orders</h3>
            <table>
                <thead>
                    <tr>
                        <th>Order #</th>
                        <th>Customer</th>
                        <th>Total</th>
                        <th>Payment</th>
                        <th>Status</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                <?php if(mysqli_num_rows($recent_orders) > 0): ?>
                    <?php while($order = mysqli_fetch_assoc($recent_orders)): ?>
                    <tr>
                        <td>#<?php echo str_pad($order['id'], 5, '0', STR_PAD_LEFT); ?></td>
                        <td><?php echo $order['fullname']; ?></td>
                        <td>KES <?php echo number_format($order['total'], 2); ?></td>
                        <td><?php echo $order['payment_method']; ?></td>
                        <td>
                            <span class="status-badge status-<?php echo $order['status']; ?>">
                                <?php echo ucfirst($order['status']); ?>
                            </span>
                        </td>
                        <td><?php echo date('d M Y', strtotime($order['created_at'])); ?></td>
                    </tr>
                    <?php endwhile; ?>
                <?php else: ?>
                    <tr><td colspan="6" style="text-align:center;">No orders yet.</td></tr>
                <?php endif; ?>
                </tbody>
            </table>
        </div>

    </div>
</div>

</body>
</html>