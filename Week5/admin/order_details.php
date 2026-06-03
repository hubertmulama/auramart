<?php
session_start();
include '../includes/db.php';

if(!isset($_SESSION['user_id']) || $_SESSION['user_role'] != 'admin'){
    header("Location: ../login.php");
    exit();
}

$order_id = intval($_GET['id']);
$order    = mysqli_fetch_assoc(mysqli_query($conn, "SELECT * FROM orders WHERE id=$order_id"));
$items    = mysqli_query($conn, "SELECT * FROM order_items WHERE order_id=$order_id");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AuraMart - Order Details</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/admin.css">
</head>
<body>

<div class="admin-wrapper">

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

    <div class="main-content">
        <h1>📋 Order #<?php echo str_pad($order_id, 5, '0', STR_PAD_LEFT); ?></h1>
        <a href="orders.php" style="color:#6c3fc5;">← Back to Orders</a>

        <!-- Customer Details -->
        <div class="form-card" style="margin-top:20px;">
            <h3>Customer Details</h3>
            <div class="detail-grid">
                <div><strong>Name:</strong> <?php echo $order['fullname']; ?></div>
                <div><strong>Email:</strong> <?php echo $order['email']; ?></div>
                <div><strong>Phone:</strong> <?php echo $order['phone']; ?></div>
                <div><strong>Address:</strong> <?php echo $order['address']; ?></div>
                <div><strong>Payment:</strong> <?php echo $order['payment_method']; ?></div>
                <div><strong>Status:</strong> 
                    <span class="status-badge status-<?php echo $order['status']; ?>">
                        <?php echo ucfirst($order['status']); ?>
                    </span>
                </div>
                <div><strong>Date:</strong> <?php echo date('d M Y, h:i A', strtotime($order['created_at'])); ?></div>
            </div>
        </div>

        <!-- Order Items -->
        <div class="table-card" style="margin-top:20px;">
            <h3>Ordered Items</h3>
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Product</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Subtotal</th>
                    </tr>
                </thead>
                <tbody>
                <?php 
                $grand_total = 0;
                while($item = mysqli_fetch_assoc($items)): 
                    $subtotal = $item['price'] * $item['quantity'];
                    $grand_total += $subtotal;
                ?>
                    <tr>
                        <td><?php echo $item['id']; ?></td>
                        <td><?php echo $item['product_name']; ?></td>
                        <td>KES <?php echo number_format($item['price'], 2); ?></td>
                        <td><?php echo $item['quantity']; ?></td>
                        <td>KES <?php echo number_format($subtotal, 2); ?></td>
                    </tr>
                <?php endwhile; ?>
                    <tr style="font-weight:bold; background:#f9f6ff;">
                        <td colspan="4" style="text-align:right;">Total</td>
                        <td>KES <?php echo number_format($grand_total, 2); ?></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>