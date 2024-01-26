<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

$hostname = "localhost";
$database = "cgpa";
$username = "root";
$password = " "; // Set your actual database password

$db = new PDO("mysql:host=$hostname;dbname=$database", $username, $password);
// Initial response code
// Response code will be changed if the request goes into any of the processes
http_response_code(404);
$response = new stdClass();

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    try {
        // Check login credentials
        $jsonbody = json_decode(file_get_contents('php://input'));

        // Use prepared statements to prevent SQL injection
        $stmt = $db->prepare("SELECT * FROM user WHERE email = :email");
        $stmt->execute(array(':email' => $jsonbody->email));
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user && password_verify($jsonbody->password, $user['password'])) {
            // User authenticated successfully
            http_response_code(200);
            $response['message'] = "Login successful";
        } else {
            // Invalid credentials
            http_response_code(401);
            $response['error'] = "Invalid email or password";
        }
    } catch (Exception $ee) {
        http_response_code(500);
        $response['error'] = "Error occurred" . $ee->getMessage();
    }
}


echo json_encode($response);
exit();
?>
