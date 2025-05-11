<?php
include("PharmacyDatabase.php");
?>

<!DOCTYPE html>
<html>
    <head>
        <title>Pharmacy Portal</title>
        <link rel="stylesheet" href="css/style.css">
        </head>
    <body>
<div id="form">
    <h2> Pharmacy Login </h2>
    <form name="form" action="login.php" method="post">
             <label> Username</b></label>
            <input type="text" id="Enter Username" name="userName" >

            <label  for="contactInfo"><b>contactInfo</b></label>
            <input type="text" id="Enter email" name="contactInfo" >
       
            <label  for="usertype"><b>userType</b></label>
            <input type="text" id="Enter userType" name="userType" required>

            <label  for="password"><b>password</b></label>
            <input type="password" id="Enter password" name="password" required>
      
             </label> <button type="submit " name="submit">Login</button></label><br><br>
             <a href="register.php">Register</a>
        </form>
</div >
</html>

