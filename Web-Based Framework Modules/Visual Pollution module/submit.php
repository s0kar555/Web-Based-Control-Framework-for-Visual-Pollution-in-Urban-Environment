<?php
$servername = "localhost";
$username = "root";
$password = ""; // Your database password
$dbname = "object_database"; // Your database name

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$category = $_POST['category'];
$status = $_POST['status'];
$objectName = $_POST['objectName'];
$negativeAction = $_POST['negativeAction'];
$size = $_POST['size'];

if ($status == 'negative') {
    $weight = 5;
} elseif ($category == 'building') {
    $weight = 3.75;
} elseif ($category == 'other' && $status == 'Neutral') {
    $weight = 2.5;
} elseif ($category == 'street') {
    $weight = 1.25;
}

$sql = "INSERT INTO objects (category, status, objectName, negativeAction, size, weight) 
        VALUES ('$category', '$status', '$objectName', '$negativeAction', '$size', '$weight')";

if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
