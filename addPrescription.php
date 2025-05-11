<?php
require_once 'PharmacyDatabase.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $db = new PharmacyDatabase();
    $result = $db->addPrescription($_POST['patient_username'], $_POST['medication_id'], $_POST['dosage_instructions'], $_POST['quantity']);

    echo "Prescription added successfully!" ;
}
?>

<html>
<head><title>Add Prescription</title></head>
<body>
    <h1>Add Prescription</h1>
        <link rel="stylesheet" href="css/style.css">

    <form method="POST">
        Patient Username: <input type="text" name="patient_username" /><br>
        Medication ID: <input type="number" name="medication_id" /><br>
        Dosage Instructions: <textarea name="dosage_instructions"></textarea><br>
        Quantity: <input type="number" name="quantity" /><br>
        <button type="submit">Save</button>
    </form>
    <p><a href="home.php">Back to Home</a></p>
</body>
</html>
