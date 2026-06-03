function validateRegister() {
    const fullname = document.getElementById('fullname').value.trim();
    const email = document.getElementById('email').value.trim();
    const password = document.getElementById('password').value;
    const confirm = document.getElementById('confirm_password').value;

    if (fullname === '') {
        alert('Please enter your full name.');
        return false;
    }

    if (email === '') {
        alert('Please enter your email address.');
        return false;
    }

    if (password.length < 6) {
        alert('Password must be at least 6 characters.');
        return false;
    }

    if (password !== confirm) {
        alert('Passwords do not match.');
        return false;
    }

    return true;
}

function validateLogin() {
    const email = document.getElementById('email').value.trim();
    const password = document.getElementById('password').value;

    if (email === '') {
        alert('Please enter your email address.');
        return false;
    }

    if (password === '') {
        alert('Please enter your password.');
        return false;
    }

    return true;
}

// Search products
function searchProducts() {
    const input = document.getElementById('searchInput').value.toLowerCase();
    const cards = document.querySelectorAll('.product-card');

    cards.forEach(card => {
        const name = card.querySelector('h3').textContent.toLowerCase();
        card.style.display = name.includes(input) ? 'block' : 'none';
    });
}

// Filter by category
function filterCategory() {
    const selected = document.getElementById('categoryFilter').value.toLowerCase();
    const cards    = document.querySelectorAll('.product-card');

    cards.forEach(card => {
        const category = card.getAttribute('data-category').toLowerCase();
        card.style.display = (selected === '' || category === selected) ? 'block' : 'none';
    });
}