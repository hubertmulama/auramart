<?php
session_start();
include '../includes/db.php';

if(!isset($_SESSION['user_id']) || $_SESSION['user_role'] != 'admin'){
    header("Location: ../login.php");
    exit();
}

// Update order status
if(isset($_POST['update_status'])){
    $order_id = intval($_POST['order_id']);
    $status   = mysqli_real_escape_string($conn, $_POST['status']);
    mysqli_query($conn, "UPDATE orders SET status='$status' WHERE id=$order_id");
    header("Location: orders.php");
    exit();
}

// Fetch all orders
$orders = mysqli_query($conn, "SELECT * FROM orders ORDER BY created_at DESC");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AuraMart - Orders</title>
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
            <a href="index.php">🏠 Dashboard</a>
            <a href="products.php">📦 Products</a>
            <a href="orders.php" class="active">🛒 Orders</a>
            <a href="users.php">👥 Users</a>
            <a href="../logout.php">🚪 Logout</a>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <h1>🛒 Orders Management</h1>
        <p>View and manage all customer orders.</p>

        <div class="table-card">
            <h3>All Orders</h3>
            <table>
                <thead>
                    <tr>
                        <th>Order #</th>
                        <th>Customer</th>
                        <th>Phone</th>
                        <th>Address</th>
                        <th>Total</th>
                        <th>Payment</th>
                        <th>Status</th>
                        <th>Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <?php if(mysqli_num_rows($orders) > 0): ?>
                    <?php while($order = mysqli_fetch_assoc($orders)): ?>
                    <tr>
                        <td>#<?php echo str_pad($order['id'], 5, '0', STR_PAD_LEFT); ?></td>
                        <td>
                            <?php echo $order['fullname']; ?><br>
                            <small><?php echo $order['email']; ?></small>
                        </td>
                        <td><?php echo $order['phone']; ?></td>
                        <td><?php echo $order['address']; ?></td>
                        <td>KES <?php echo number_format($order['total'], 2); ?></td>
                        <td><?php echo $order['payment_method']; ?></td>
                        <td>
                            <span class="status-badge status-<?php echo $order['status']; ?>">
                                <?php echo ucfirst($order['status']); ?>
                            </span>
                        </td>
                        <td><?php echo date('d M Y', strtotime($order['created_at'])); ?></td>
                        <td>
                            <form method="POST" style="display:flex; gap:5px;">
                                <input type="hidden" name="order_id" value="<?php echo $order['id']; ?>">
                                <select name="status">
                                    <option value="pending"    <?php echo $order['status']=='pending'    ? 'selected':''; ?>>Pending</option>
                                    <option value="processing" <?php echo $order['status']=='processing' ? 'selected':''; ?>>Processing</option>
                                    <option value="shipped"    <?php echo $order['status']=='shipped'    ? 'selected':''; ?>>Shipped</option>
                                    <option value="delivered"  <?php echo $order['status']=='delivered'  ? 'selected':''; ?>>Delivered</option>
                                    <option value="cancelled"  <?php echo $order['status']=='cancelled'  ? 'selected':''; ?>>Cancelled</option>
                                </select>
                                <button type="submit" name="update_status" class="btn-edit">Update</button>
                            </form>
                            <a href="order_details.php?id=<?php echo $order['id']; ?>" 
                               class="btn-view" style="margin-top:5px; display:inline-block;">
                               View Items
                            </a>
                        </td>
                    </tr>
                    <?php endwhile; ?>
                <?php else: ?>
                    <tr><td colspan="9" style="text-align:center;">No orders yet.</td></tr>
                <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>