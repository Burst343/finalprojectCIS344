<?php
session_start();
require_once 'PharmacyDatabase.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $db = new PharmacyDatabase();
    
    if ($db->addUser(
        $_POST['username'],
        $_POST['contactInfo'],
        $_POST['userType'],
        $_POST['password']
    )) {
        header("Location: index.php");
        exit();
    }
}
?>

<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h1>Register</h1>
    <form method="POST">
        Username: <input type="text" name="username" required><br>
        Password: <input type="password" name="password" required><br>
        Email: <input type="text" name="contactInfo" required><br>
        User Type: 
        <select name="userType" required>
            <option value="patient">Patient</option>
            <option value="pharmacist">Pharmacist</option>
        </select><br>
        <button type="submit">Register</button>
    </form>
    <p>Already have an account? <a href="index.php">Login</a></p>