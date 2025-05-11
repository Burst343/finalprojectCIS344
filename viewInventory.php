<?php
session_start();
require_once 'PharmacyDatabase.php';

// Check if pharmacist is logged in
if ($_SESSION['user_type'] !== 'pharmacist') {
    header('Location: index.php');
    exit();
}

$db = new PharmacyDatabase();
$inventory = $db->MedicationInventory(); // Using your existing function
?>

<html>
<head>
    <title>Medication Inventory</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h1>Medication Inventory</h1>
    
    <table border="1">
        <tr>
            <th>Name</th>
            <th>Dosage</th>
            <th>Manufacturer</th>
            <th>In Stock</th>
        </tr>
        <?php foreach ($inventory as $item): ?>
        <tr>
            <td><?= htmlspecialchars($item['medicationName']) ?></td>
            <td><?= htmlspecialchars($item['dosage']) ?></td>
            <td><?= htmlspecialchars($item['manufacturer']) ?></td>
            <td><?= htmlspecialchars($item['currentInventory']) ?></td>
        </tr>
        <?php endforeach; ?>
    </table>
    
    <a href="home.php">Back to Home</a>
</body>
</html>