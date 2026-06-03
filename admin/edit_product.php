<?php
session_start();
include '../includes/db.php';

if(!isset($_SESSION['user_id']) || $_SESSION['user_role'] != 'admin'){
    header("Location: ../login.php");
    exit();
}

$id      = intval($_GET['id']);
$product = mysqli_fetch_assoc(mysqli_query($conn, "SELECT * FROM products WHERE id=$id"));

if(isset($_POST['update_product'])){
    $name        = mysqli_real_escape_string($conn, $_POST['name']);
    $description = mysqli_real_escape_string($conn, $_POST['description']);
    $price       = floatval($_POST['price']);
    $stock       = intval($_POST['stock']);
    $category    = mysqli_real_escape_string($conn, $_POST['category']);
    $image       = $product['image'];

    if($_FILES['image']['name'] != ''){
        $target = '../images/' . basename($_FILES['image']['name']);
        move_uploaded_file($_FILES['image']['tmp_name'], $target);
        $image = $_FILES['image']['name'];
    }

    mysqli_query($conn, "UPDATE products SET 
                         name='$name', description='$description', 
                         price='$price', stock='$stock', 
                         category='$category', image='$image' 
                         WHERE id=$id");
    header("Location: products.php");
    exit();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>AuraMart - Edit Product</title>
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
            <a href="products.php" class="active">📦 Products</a>
            <a href="orders.php">🛒 Orders</a>
            <a href="users.php">👥 Users</a>
            <a href="../logout.php">🚪 Logout</a>
        </nav>
    </div>

    <div class="main-content">
        <h1>✏️ Edit Product</h1>
        <p>Update the product details below.</p>

        <div class="form-card">
            <form method="POST" enctype="multipart/form-data">
                <div class="form-grid">
                    <input type="text" name="name" value="<?php echo $product['name']; ?>" required>
                    <input type="number" name="price" value="<?php echo $product['price']; ?>" step="0.01" required>
                    <input type="number" name="stock" value="<?php echo $product['stock']; ?>" required>
                    <input type="text" name="category" value="<?php echo $product['category']; ?>">
                    <input type="file" name="image" accept="image/*">
                </div>
                <textarea name="description" rows="3"><?php echo $product['description']; ?></textarea>
                <button type="submit" name="update_product">Update Product</button>
                <a href="products.php" style="margin-left:10px; color:#6c3fc5;">Cancel</a>
            </form>
        </div>
    </div>
</div>

</body>
</html>