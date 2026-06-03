// Load cart from localStorage
function getCart() {
    return JSON.parse(localStorage.getItem('auramart_cart')) || [];
}

// Save cart to localStorage
function saveCart(cart) {
    localStorage.setItem('auramart_cart', JSON.stringify(cart));
    updateCartCount();
}

// Add item to cart
function addToCart(id, name, price, image) {
    let cart = getCart();
    const existing = cart.find(item => item.id === id);

    if (existing) {
        existing.quantity += 1;
    } else {
        cart.push({ id, name, price, image, quantity: 1 });
    }

    saveCart(cart);
    showCartNotification(name);
}

// Update cart count in navbar
function updateCartCount() {
    const cart  = getCart();
    const total = cart.reduce((sum, item) => sum + item.quantity, 0);
    const badge = document.getElementById('cart-count');
    if (badge) badge.textContent = total;
}

// Remove item from cart
function removeFromCart(id) {
    let cart = getCart().filter(item => item.id !== id);
    saveCart(cart);
    renderCart();
}

// Update item quantity
function updateQuantity(id, change) {
    let cart = getCart();
    const item = cart.find(item => item.id === id);

    if (item) {
        item.quantity += change;
        if (item.quantity <= 0) {
            cart = cart.filter(i => i.id !== id);
        }
    }

    saveCart(cart);
    renderCart();
}

// Show notification when item added
function showCartNotification(name) {
    const note = document.createElement('div');
    note.className = 'cart-notification';
    note.textContent = `✅ "${name}" added to cart!`;
    document.body.appendChild(note);

    setTimeout(() => note.remove(), 3000);
}

// Render cart page
function renderCart() {
    const cart      = getCart();
    const container = document.getElementById('cart-items');
    const summary   = document.getElementById('cart-summary');

    if (!container) return;

    if (cart.length === 0) {
        container.innerHTML = `
            <div class="empty-cart">
                <h2>🛒 Your cart is empty</h2>
                <p>Looks like you haven't added anything yet.</p>
                <a href="index.php" class="hero-btn">Start Shopping</a>
            </div>`;
        if (summary) summary.innerHTML = '';
        return;
    }

    let html  = '';
    let total = 0;

    cart.forEach(item => {
        const subtotal = item.price * item.quantity;
        total += subtotal;

        html += `
        <div class="cart-item">
            <img src="images/${item.image || ''}" 
                 onerror="this.src='images/no-image.png'" 
                 alt="${item.name}">
            <div class="cart-item-info">
                <h3>${item.name}</h3>
                <p>KES ${parseFloat(item.price).toLocaleString()}</p>
            </div>
            <div class="cart-item-controls">
                <button onclick="updateQuantity(${item.id}, -1)">−</button>
                <span>${item.quantity}</span>
                <button onclick="updateQuantity(${item.id}, 1)">+</button>
            </div>
            <div class="cart-item-subtotal">
                KES ${subtotal.toLocaleString()}
            </div>
            <button class="remove-btn" onclick="removeFromCart(${item.id})">🗑️</button>
        </div>`;
    });

    container.innerHTML = html;

    if (summary) {
        summary.innerHTML = `
        <div class="summary-card">
            <h3>Order Summary</h3>
            <div class="summary-row">
                <span>Items (${cart.reduce((s, i) => s + i.quantity, 0)})</span>
                <span>KES ${total.toLocaleString()}</span>
            </div>
            <div class="summary-row">
                <span>Shipping</span>
                <span>FREE</span>
            </div>
            <hr>
            <div class="summary-row total">
                <span>Total</span>
                <span>KES ${total.toLocaleString()}</span>
            </div>
            <a href="checkout.php">
                <button class="checkout-btn">Proceed to Checkout</button>
            </a>
            <a href="index.php" class="continue-link">← Continue Shopping</a>
        </div>`;
    }
}

// Initialize cart count on page load
document.addEventListener('DOMContentLoaded', updateCartCount);