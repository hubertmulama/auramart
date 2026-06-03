<?php
session_start();
include '../includes/db.php';

if(!isset($_SESSION['user_id']) || $_SESSION['user_role'] != 'admin'){
    header("Location: ../login.php");
    exit();
}

// Delete product
if(isset($_GET['delete'])){
    $id = intval($_GET['delete']);
    mysqli_query($conn, "DELETE FROM products WHERE id=$id");
    header("Location: products.php");
    exit();
}

// Add product
if(isset($_POST['add_product'])){
    $name        = mysqli_real_escape_string($conn, $_POST['name']);
    $description = mysqli_real_escape_string($conn, $_POST['description']);
    $price       = floatval($_POST['price']);
    $stock       = intval($_POST['stock']);
    $category    = mysqli_real_escape_string($conn, $_POST['category']);

    // Handle image upload
    $image = '';
    if($_FILES['image']['name'] != ''){
        $target = '../images/' . basename($_FILES['image']['name']);
        move_uploaded_file($_FILES['image']['tmp_name'], $target);
        $image = $_FILES['image']['name'];
    }

    mysqli_query($conn, "INSERT INTO products (name, description, price, stock, category, image) 
                         VALUES ('$name', '$description', '$price', '$stock', '$category', '$image')");
    header("Location: products.php");
    exit();
}

// Fetch all products
$products = mysqli_query($conn, "SELECT * FROM products ORDER BY created_at DESC");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AuraMart - Products</title>
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
            <a href="products.php" class="active">📦 Products</a>
            <a href="orders.php">🛒 Orders</a>
            <a href="users.php">👥 Users</a>
            <a href="../logout.php">🚪 Logout</a>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <h1>📦 Products Management</h1>
        <p>Add, edit, or remove products from AuraMart.</p>

        <!-- Add Product Form -->
        <div class="form-card">
            <h3>Add New Product</h3>
            <form method="POST" enctype="multipart/form-data">
                <div class="form-grid">
                    <input type="text" name="name" placeholder="Product Name" required>
                    <input type="number" name="price" placeholder="Price (KES)" step="0.01" required>
                    <input type="number" name="stock" placeholder="Stock Quantity" required>
                    <input type="text" name="category" placeholder="Category (e.g. Electronics)">
                    <input type="file" name="image" accept="image/*">
                </div>
                <textarea name="description" placeholder="Product Description" rows="3"></textarea>
                <button type="submit" name="add_product">Add Product</button>
            </form>
        </div>

        <!-- Products Table -->
        <div class="table-card">
            <h3>All Products</h3>
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <?php if(mysqli_num_rows($products) > 0): ?>
                    <?php while($row = mysqli_fetch_assoc($products)): ?>
                    <tr>
                        <td><?php echo $row['id']; ?></td>
                        <td>
                            <?php if($row['image']): ?>
                                <img src="../images/<?php echo $row['image']; ?>" width="50" height="50" style="object-fit:cover; border-radius:5px;">
                            <?php else: ?>
                                N/A
                            <?php endif; ?>
                        </td>
                        <td><?php echo $row['name']; ?></td>
                        <td><?php echo $row['category']; ?></td>
                        <td>KES <?php echo number_format($row['price'], 2); ?></td>
                        <td><?php echo $row['stock']; ?></td>
                        <td>
                            <a href="edit_product.php?id=<?php echo $row['id']; ?>" class="btn-edit">Edit</a>
                            <a href="products.php?delete=<?php echo $row['id']; ?>" 
                               class="btn-delete" 
                               onclick="return confirm('Delete this product?')">Delete</a>
                        </td>
                    </tr>
                    <?php endwhile; ?>
                <?php else: ?>
                    <tr><td colspan="7" style="text-align:center;">No products added yet.</td></tr>
                <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>