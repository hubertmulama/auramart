// Render order summary on checkout page
function renderCheckoutSummary() {
    const cart      = getCart();
    const container = document.getElementById('checkout-items');

    if (!container) return;

    if (cart.length === 0) {
        window.location.href = 'cart.php';
        return;
    }

    let html  = '';
    let total = 0;

    cart.forEach(item => {
        const subtotal = item.price * item.quantity;
        total += subtotal;

        html += `
        <div class="checkout-item">
            <img src="images/${item.image || ''}" 
                 onerror="this.src=''" 
                 alt="${item.name}">
            <div class="checkout-item-info">
                <p>${item.name}</p>
                <small>x${item.quantity}</small>
            </div>
            <span>KES ${subtotal.toLocaleString()}</span>
        </div>`;
    });

    container.innerHTML = html;
    document.getElementById('checkout-subtotal').textContent = 'KES ' + total.toLocaleString();
    document.getElementById('checkout-total').textContent    = 'KES ' + total.toLocaleString();
}

// Place order
function placeOrder() {
    const fullname = document.getElementById('fullname').value.trim();
    const email    = document.getElementById('email').value.trim();
    const phone    = document.getElementById('phone').value.trim();
    const address  = document.getElementById('address').value.trim();
    const payment  = document.querySelector('input[name="payment"]:checked').value;
    const cart     = getCart();

    // Validation
    if (!fullname || !email || !phone || !address) {
        alert('Please fill in all delivery details.');
        return;
    }

    if (cart.length === 0) {
        alert('Your cart is empty.');
        return;
    }

    const total = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);

    // Send order to PHP
    fetch('place_order.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ fullname, email, phone, address, payment, cart, total })
    })
    .then(res => res.json())
    .then(data => {
        if (data.success) {
            localStorage.removeItem('auramart_cart');
            window.location.href = 'order_success.php?id=' + data.order_id;
        } else {
            alert('Something went wrong. Please try again.');
        }
    })
    .catch(() => {
        alert('Connection error. Please try again.');
    });
}

document.addEventListener('DOMContentLoaded', renderCheckoutSummary);