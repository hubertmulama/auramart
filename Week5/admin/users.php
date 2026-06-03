<?php
session_start();
include '../includes/db.php';

if(!isset($_SESSION['user_id']) || $_SESSION['user_role'] != 'admin'){
    header("Location: ../login.php");
    exit();
}

// Delete user
if(isset($_GET['delete'])){
    $id = intval($_GET['delete']);
    // Prevent admin from deleting themselves
    if($id != $_SESSION['user_id']){
        mysqli_query($conn, "DELETE FROM users WHERE id=$id");
    }
    header("Location: users.php");
    exit();
}

// Update user role
if(isset($_POST['update_role'])){
    $id   = intval($_POST['user_id']);
    $role = mysqli_real_escape_string($conn, $_POST['role']);
    mysqli_query($conn, "UPDATE users SET role='$role' WHERE id=$id");
    header("Location: users.php");
    exit();
}

// Fetch all users
$users = mysqli_query($conn, "SELECT * FROM users ORDER BY created_at DESC");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AuraMart - Users</title>
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
            <a href="orders.php">🛒 Orders</a>
            <a href="users.php" class="active">👥 Users</a>
            <a href="../logout.php">🚪 Logout</a>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <h1>👥 Users Management</h1>
        <p>View and manage all registered users.</p>

        <div class="table-card">
            <h3>All Users</h3>
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Joined</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <?php if(mysqli_num_rows($users) > 0): ?>
                    <?php while($user = mysqli_fetch_assoc($users)): ?>
                    <tr>
                        <td><?php echo $user['id']; ?></td>
                        <td><?php echo $user['fullname']; ?></td>
                        <td><?php echo $user['email']; ?></td>
                        <td>
                            <span class="role-badge role-<?php echo $user['role']; ?>">
                                <?php echo ucfirst($user['role']); ?>
                            </span>
                        </td>
                        <td><?php echo date('d M Y', strtotime($user['created_at'])); ?></td>
                        <td>
                            <!-- Update Role -->
                            <form method="POST" style="display:flex; gap:5px; margin-bottom:5px;">
                                <input type="hidden" name="user_id" value="<?php echo $user['id']; ?>">
                                <select name="role">
                                    <option value="customer" <?php echo $user['role']=='customer' ? 'selected':''; ?>>Customer</option>
                                    <option value="admin"    <?php echo $user['role']=='admin'    ? 'selected':''; ?>>Admin</option>
                                </select>
                                <button type="submit" name="update_role" class="btn-edit">Update</button>
                            </form>
                            <!-- Delete -->
                            <?php if($user['id'] != $_SESSION['user_id']): ?>
                                <a href="users.php?delete=<?php echo $user['id']; ?>"
                                   class="btn-delete"
                                   onclick="return confirm('Delete this user?')">Delete</a>
                            <?php else: ?>
                                <span style="font-size:12px; color:#999;">Current User</span>
                            <?php endif; ?>
                        </td>
                    </tr>
                    <?php endwhile; ?>
                <?php else: ?>
                    <tr><td colspan="6" style="text-align:center;">No users found.</td></tr>
                <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>