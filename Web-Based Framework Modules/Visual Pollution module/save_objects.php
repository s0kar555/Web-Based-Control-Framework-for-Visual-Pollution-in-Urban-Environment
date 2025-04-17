<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

$servername = "localhost";
$username = "root";
$password = ""; // Your database password
$dbname = "object_database"; // Your database name

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$data = json_decode(file_get_contents('php://input'), true);

// Generate a unique ID for this batch of records
$unique_id = uniqid();

foreach ($data as $item) {
    $quantity = $item['quantity'];
    $objectName = $item['objectName'];
    $size = $item['size'];
    $weight = $item['weight'];
    $negativeAction = $item['negativeAction'];

    // Fetch category and status from objects table
    $sql_fetch = "SELECT category, status FROM objects WHERE objectName = '$objectName'";
    $result = $conn->query($sql_fetch);
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $category = $row['category'];
        $status = $row['status'];
    } else {
        $category = 'unknown';
        $status = 'unknown';
    }

    $sql = "INSERT INTO new_objects (unique_id, quantity, category, status, objectName, size, weight, negativeAction) 
            VALUES ('$unique_id', '$quantity', '$category', '$status', '$objectName', '$size', '$weight', '$negativeAction')";

    if ($conn->query($sql) !== TRUE) {
        echo "Error: " . $sql . "<br>" . $conn->error;
        exit;
    }
}

$conn->close();
echo "New objects inserted successfully with ID: $unique_id";
?>
