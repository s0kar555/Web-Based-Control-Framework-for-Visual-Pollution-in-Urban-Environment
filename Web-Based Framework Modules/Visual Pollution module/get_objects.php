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

$sql = "SELECT category, objectName, size, weight, negativeAction FROM objects";
$result = $conn->query($sql);

$objects = [];
if ($result) {
    while ($row = $result->fetch_assoc()) {
        $objects[] = [
            'category' => $row['category'],
            'name' => $row['objectName'],
            'size' => $row['size'],
            'weight' => $row['weight'],
            'negativeActions' => $row['negativeAction']
        ];
    }
}

$conn->close();
echo json_encode($objects);
?>
