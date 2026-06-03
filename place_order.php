<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

session_start();
include 'includes/db.php';

header('Content-Type: application/json');

$data = json_decode(file_get_contents('php://input'), true);

if(!$data){
    echo json_encode(['success' => false, 'error' => 'No data received']);
    exit();
}

$user_id  = isset($_SESSION['user_id']) ? intval($_SESSION['user_id']) : null;
$fullname = mysqli_real_escape_string($conn, $data['fullname']);
$email    = mysqli_real_escape_string($conn, $data['email']);
$phone    = mysqli_real_escape_string($conn, $data['phone']);
$address  = mysqli_real_escape_string($conn, $data['address']);
$payment  = mysqli_real_escape_string($conn, $data['payment']);
$total    = floatval($data['total']);
$cart     = $data['cart'];

$user_id_value = ($user_id === null) ? 'NULL' : "'$user_id'";

$query = "INSERT INTO orders (user_id, fullname, email, phone, address, total, payment_method) 
          VALUES ($user_id_value, '$fullname', '$email', '$phone', '$address', '$total', '$payment')";

if(mysqli_query($conn, $query)){
    $order_id = mysqli_insert_id($conn);

    foreach($cart as $item){
        $product_id   = intval($item['id']);
        $product_name = mysqli_real_escape_string($conn, $item['name']);
        $price        = floatval($item['price']);
        $quantity     = intval($item['quantity']);

        $item_query = "INSERT INTO order_items 
                       (order_id, product_id, product_name, price, quantity) 
                       VALUES ('$order_id', '$product_id', '$product_name', '$price', '$quantity')";

        if(!mysqli_query($conn, $item_query)){
            echo json_encode([
                'success' => false, 
                'error'   => 'Order item insert failed: ' . mysqli_error($conn)
            ]);
            exit();
        }

        mysqli_query($conn, "UPDATE products SET stock = stock - $quantity WHERE id = $product_id");
    }

    echo json_encode(['success' => true, 'order_id' => $order_id]);

} else {
    echo json_encode([
        'success' => false, 
        'error'   => 'Order insert failed: ' . mysqli_error($conn)
    ]);
}
?>