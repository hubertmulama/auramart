<?php
$conn = mysqli_connect("localhost", "root", "", "auramart");

if(!$conn){
    die("Connection Failed: " . mysqli_connect_error());
} 
?>