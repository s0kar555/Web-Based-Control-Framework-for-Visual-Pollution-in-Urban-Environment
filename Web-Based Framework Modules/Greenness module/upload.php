<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['image'])) {
    $targetDir = "uploads/";
    if (!is_dir($targetDir)) {
        mkdir($targetDir, 0777, true); // Ensure the upload directory exists
    }

    $imageFileType = strtolower(pathinfo($_FILES["image"]["name"], PATHINFO_EXTENSION));
    $targetFile = $targetDir . uniqid() . '.' . $imageFileType;
    $maskFile = $targetDir . uniqid() . '_mask.png';

    if (move_uploaded_file($_FILES["image"]["tmp_name"], $targetFile)) {
        // Call the Python script to create the mask
        $output = [];
        $return_var = 0;

        // Use the full path to the Python executable
        $pythonPath = '"C:\\Users\\Saad Ali\\AppData\\Local\\Programs\\Python\\Python312\\python.exe"'; // Replace this with the actual path on your system
        $command = "$pythonPath " . escapeshellarg("green_coverage.py") . " " . escapeshellarg($targetFile) . " " . escapeshellarg($maskFile);

        // Log the command for debugging
        file_put_contents('debug.log', "Command: $command\n", FILE_APPEND);

        // Execute the command
        exec($command, $output, $return_var);

        // Log the output and return code
        file_put_contents('debug.log', "Output: " . implode("\n", $output) . "\nReturn code: $return_var\n", FILE_APPEND);

        if ($return_var === 0) {
            // Read the green percentage from the JSON file
            $jsonFile = str_replace('.png', '_percentage.json', $maskFile);
            $greenData = json_decode(file_get_contents($jsonFile), true);
            $greenPercentage = $greenData['green_percentage'];

            echo json_encode([
                "success" => true,
                "upload_path" => $targetFile,
                "mask_path" => $maskFile,
                "green_percentage" => $greenPercentage,
                "log" => $output
            ]);
        } else {
            echo json_encode([
                "success" => false,
                "message" => "Error processing image. Check debug.log for more details."
            ]);
        }
    } else {
        echo json_encode([
            "success" => false,
            "message" => "Failed to upload image."
        ]);
    }
} else {
    echo json_encode([
        "success" => false,
        "message" => "No image uploaded."
    ]);
}
?>
