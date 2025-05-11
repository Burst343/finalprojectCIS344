<?php
class PharmacyDatabase {
    private $host = "localhost";
    private $port = "3306";
    private $database = "pharmacy_portal_db";
    private $user = "root";
    private $password = "";
    private $connection;

    public function __construct() {
        $this->connect();
    }

    private function connect() {
        $this->connection = new mysqli($this->host, $this->user, $this->password, $this->database, $this->port);
        if ($this->connection->connect_error) {
            die("Connection failed: " . $this->connection->connect_error);
        }
        echo "";
    }

    public function addPrescription($patientUserName, $medicationId, $dosageInstructions, $quantity)  {
        $stmt = $this->connection->prepare(
            "SELECT userId FROM Users WHERE userName = ? AND userType = 'patient'"
        );
        $stmt->bind_param("s", $patientUserName);
        $stmt->execute();
        $stmt->bind_result($patientId);
        $stmt->fetch();
        $stmt->close();
        
        if ($patientId){
            $stmt = $this->connection->prepare(
                "INSERT INTO prescriptions (userId, medicationId, dosageInstructions, quantity) VALUES (?, ?, ?, ?)"
            );
            $stmt->bind_param("iisi", $patientId, $medicationId, $dosageInstructions, $quantity);
            $stmt->execute();
            $stmt->close();
            echo "";
        }else{
            echo "failed to add prescription";
        }
    }

    public function getAllPrescriptions() {
        $result = $this->connection->query("SELECT * FROM  prescriptions join medications on prescriptions.medicationId= medications.medicationId");
        return $result->fetch_all(MYSQLI_ASSOC);
    }
    
    public function MedicationInventory() {
     
    $result = $this->connection->query(
        "SELECT * FROM MedicationInventoryView"
    );
    return $result->fetch_all(MYSQLI_ASSOC);
}

   public function addUser($userName, $contactInfo, $userType, $password) {
    $stmt = $this->connection->prepare(
        "INSERT INTO users (userName, contactInfo, userType, password) VALUES (?, ?, ?, ?)"
    );
    $stmt->bind_param("ssss", $userName, $contactInfo, $userType, $password);
    return $stmt->execute();
}
    
public function getConnection() {
    return $this->connection;
}
}
?>