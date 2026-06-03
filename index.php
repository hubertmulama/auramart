<?php
session_start();
include 'includes/db.php';

// Fetch all products
$products = mysqli_query($conn, "SELECT * FROM products ORDER BY created_at DESC");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AuraMart - Shop</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/shop.css">
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

<!-- Hero Section -->
<div class="hero">
    <h1>Welcome to AuraMart</h1>
    <p>Discover amazing products at unbeatable prices</p>
    <a href="#products" class="hero-btn">Shop Now</a>
</div>

<!-- Search & Filter -->
<div class="search-bar" id="products">
    <input type="text" id="searchInput" placeholder="Search products..." onkeyup="searchProducts()">
    <select id="categoryFilter" onchange="filterCategory()">
        <option value="">All Categories</option>
        <?php
        $categories = mysqli_query($conn, "SELECT DISTINCT category FROM products WHERE category != ''");
        while($cat = mysqli_fetch_assoc($categories)){
            echo "<option value='{$cat['category']}'>{$cat['category']}</option>";
        }
        ?>
    </select>
</div>

<!-- Products Grid -->
<div class="products-grid" id="productsGrid">
    <?php if(mysqli_num_rows($products) > 0): ?>
        <?php while($product = mysqli_fetch_assoc($products)): ?>
        <div class="product-card" data-category="<?php echo $product['category']; ?>">
            <?php if($product['image']): ?>
                <img src="images/<?php echo $product['image']; ?>" alt="<?php echo $product['name']; ?>">
            <?php else: ?>
                <div class="no-image">No Image</div>
            <?php endif; ?>
            <div class="product-info">
                <span class="product-category"><?php echo $product['category']; ?></span>
                <h3><?php echo $product['name']; ?></h3>
                <p><?php echo substr($product['description'], 0, 80); ?>...</p>
                <div class="product-footer">
                    <span class="price">KES <?php echo number_format($product['price'], 2); ?></span>
                    <button class="add-to-cart" onclick="addToCart(
                        <?php echo $product['id']; ?>,
                        '<?php echo addslashes($product['name']); ?>',
                        <?php echo $product['price']; ?>,
                        '<?php echo $product['image']; ?>'
                    )">Add to Cart</button>
                </div>
            </div>
        </div>
        <?php endwhile; ?>
    <?php else: ?>
        <p class="no-products">No products available yet. Check back soon!</p>
    <?php endif; ?>
</div>

<!-- Footer -->
<footer class="footer">
    <p>&copy; <?php echo date('Y'); ?> AuraMart. All rights reserved.</p>
</footer>

<script src="js/main.js"></script>
<script src="js/cart.js"></script>
</body>
</html>