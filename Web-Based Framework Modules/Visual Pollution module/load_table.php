<?php
$servername = "localhost";
$username = "root";
$password = ""; // Your database password
$dbname = "object_database"; // Your database name

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT * FROM objects";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "<table border='1'>
            <tr>
                <th>ID</th>
                <th>Category</th>
                <th>Status</th>
                <th>Object Name</th>
                <th>Negative Action</th>
                <th>Size</th>
                <th>Weight</th>
            </tr>";
    while($row = $result->fetch_assoc()) {
        // Determine the background color based on the category
        $bgColor = "";
        if ($row["category"] == "Buildings") {
            $bgColor = "#FFDEBD";
        } elseif ($row["category"] == "Street") {
            $bgColor = "#DAE9F8";
        } elseif ($row["category"] == "Other (facilities)") {
            $bgColor = "#DAF2D0";
        }

        echo "<tr style='background-color: $bgColor;'>
                <td>".$row["id"]."</td>
                <td>".$row["category"]."</td>
                <td>".$row["status"]."</td>
                <td>".$row["objectName"]."</td>
                <td>".$row["negativeAction"]."</td>
                <td>".$row["size"]."</td>
                <td>".$row["weight"]."</td>
              </tr>";
    }
    echo "</table>";
} else {
    echo "0 results";
}


$conn->close();
?>
