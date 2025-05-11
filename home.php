<?php
session_start(); 

if (!isset($_SESSION['user_type'])) {
    header('Location: index.php');
    exit();
}
?>
<html>
<head><title>Pharmacy Portal</title></head>
<link rel="stylesheet" href="css/style.css">

<body>
    <h1>Pharmacy Portal</h1>
    <p>Welcome, <?php echo htmlspecialchars($_SESSION['user_type']); ?>!</p>
    
    <nav>
        <?php if($_SESSION['user_type'] == 'pharmacist'): ?>
            <a href="addPrescription.php">Add Prescription</a> |
             <a href="viewInventory.php">View Inventory</a> |
        <?php endif; ?>
        <a href="viewPrescriptions.php">View Prescriptions</a> |
    </nav>
    <br><br>
    <a href="logout.php">Logout</a>

</body>
</html>