<?php
session_start();
include("PharmacyDatabase.php");

if(isset($_POST['submit'])) {
    $username = $_POST['userName'];
    $password = $_POST['password'];
    $contactInfo = $_POST['contactInfo'];
    $userType = $_POST['userType'];

    

    $db = new PharmacyDatabase();
    $connection = $db->getConnection();

    $sql = "SELECT * FROM users WHERE username = '$username' AND password = '$password' AND contactInfo = '$contactInfo' AND userType = '$userType'";
    $result = $connection->query($sql);
      
    if($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $_SESSION['user_id'] = $row['userId'];
        $_SESSION['user_type'] = $row['userType'];
        

        
        if($row['userType'] == 'pharmacist') {
            header('Location: home.php');
        } else {
            header('Location: viewPrescriptions.php');
        }
        exit();
    } else {
        
        echo "<script>alert('Invalid username or password');</script>";
        echo "<script>window.location.href='index.php';</script>";
    }
}
?>