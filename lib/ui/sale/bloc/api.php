<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
require_once 'server.php';
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $postData = file_get_contents('php://input');
    // Process the POST data
     $postData;
$data = json_decode($postData, true);
if (isset($data['method'])) {
    switch ($data['method']) {
        case 'masterData':
            handleMasterData($conn,$data);
            break;
        case 'addCustomer':
            handleAddCustomer($conn, $data);
            break;
        case 'login':
            handleLogin($conn, $data);
            break;
        case 'registration':
            handleRegistration($conn,$data);
            break;
        case 'getProducts':
            handleGetProducts($conn,$data);
            break;
        case 'requestStock':
            handleRequestStock($conn,$data);
            break;
        case 'myPendingStockRequests':
            handleMyPendingStockRequests($conn, $data);
            break;
        case 'acceptStock':
            handleAcceptStock($conn,$data);
            break;
        case 'depositCollection':
            handleDepositCollection($conn,$data);
            break;
        case 'myDepositionRequest':
            handleMyDepositionRequest($conn, $data);
            
            break;
        case 'acceptCollection':
            handleAcceptCollection($conn,$data);
            break;
        case 'getUser':
            handleGetUser($conn, $data);
            break;
            case 'getProductsByUser':
                handleGetProductsByUser($conn, $data);
                break;
            
        case 'myBookings':
            handleMyBookings($conn, $data);
            break;

            
        default:
            echo json_encode(["error" => "Method not found"]);
            break;
    }
} else {
    echo json_encode(["error" => "Method not specified"]);
}
}
    function handleMasterData($conn,$data) {
   
    
    // Fetch region data
    $regionSql = "SELECT * FROM regions";
    $regionResult = $conn->query($regionSql);
    $regions = [];

    if ($regionResult->num_rows > 0) {
        while ($row = $regionResult->fetch_assoc()) {
            $regions[] = $row;
        }
    }

    // Fetch user role data
    $roleSql = "SELECT * FROM roles";
    $roleResult = $conn->query($roleSql);
    $roles = [];

    if ($roleResult->num_rows > 0) {
        while ($row = $roleResult->fetch_assoc()) {
            $roles[] = $row;
        }
    }

    echo json_encode([

        "regions" => $regions,
        "roles" => $roles
    ]);
}

    function handleLogin($conn,$data) {
    $usernameOrMobile = $data['username'];
    $password = $data['password'];

    $sql = "SELECT * FROM user_master_view WHERE (username = '$usernameOrMobile' OR mobile = '$usernameOrMobile') AND password = '$password'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        echo json_encode(["message" => "Login successful", "user" => $user]);
    } else {
        echo json_encode(["error" => "Invalid username/mobile or password"]);
    }
    }

    function handleRegistration($conn,$data) {
        $sql = "INSERT INTO user_master (name, username, password, mobile, role_id, region_id, supervisor_id) 
        VALUES ('" . $data['name'] . "', '" . $data['username'] . "', '" . $data['password'] . "', '" . $data['mobile'] . "', " . $data['role_id'] . ", " . $data['region_id'] . ", " . $data['supervisor_id']. ")";

        if ($conn->query($sql) === TRUE) {
            
        echo json_encode(["message" => "New record created successfully", "registration_code" => $conn->insert_id]);
        } else {
            echo json_encode(["error" => "Error: " . $sql . " - " . $conn->error]);
        }
    }

    function handleGetProducts($conn,$data) {
    $productSql = "SELECT * FROM products JOIN user_products ON products.id = user_products.product_id";
    $productResult = $conn->query($productSql);
    $products = [];

    if ($productResult->num_rows > 0) {
        while ($row = $productResult->fetch_assoc()) {
            $products[] = $row;
        }
    }

    echo json_encode([
        "products" => $products
    ]);
    }

    function handleRequestStock($conn,$data) {
        // Implement requestStock logic here
         $sql = "INSERT INTO `stock_request_master` (`id`, `date`, `raised_by`, `pending_with`, `status`) VALUES (NULL, NOW(), '" . $data['userId'] . "', '" . $data['supervisorId'] . "', 'Pending');";
        if ($conn->query($sql) === TRUE) {
            $requestId = $conn->insert_id;
             $list = json_decode($data['products'], true);

            foreach ($list as $product) {
                $productId = $product['id'];
                $quantity = $product['quantity'];
                if($quantity == 0) {
                    continue;
                }
                $detailSql = "INSERT INTO `stock_request_detail` (`stock_request_id`, `product_id`, `quantity`) VALUES ('$requestId', '$productId', '$quantity')";
                if (!$conn->query($detailSql)) {
                    echo json_encode(["error" => "Error: " . $detailSql . " - " . $conn->error]);
                    return;
                }
            }
            echo json_encode(["message" => "Stock request recorded successfully", "request_id" => $conn->insert_id]);
        } else {
            echo json_encode(["error" => "Error: " . $sql . " - " . $conn->error]);
        }
    }

//supervsor
    function handleMyPendingStockRequests($conn, $data) {
        $userId = $data['user_id'];
        $sql = "SELECT * FROM stock_request_master WHERE pending_with = '$userId' AND status = 'Pending'";
        $result = $conn->query($sql);

        $requests = [];

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $requests[] = $row;
            }
        }

        echo json_encode([
            "requests" => $requests
        ]);
    }

    function handleAcceptStock($conn,$data) {
        // Implement acceptStock logic here
        echo "acceptStock method called";
    }

    function handleDepositCollection($conn,$data) {
        $amount = $data['amount'];
        $depositorId = $data['userId'];

        $sql = "INSERT INTO `collection_deposit_master` (`id`, `date`, `raised_by`, `pending_with`, `amount`, `status`) VALUES (NULL, NOW(), '" . $depositorId . "', '" . $data['supervisorId'] . "', '" . $amount . "', 'Pending');";

        if ($conn->query($sql) === TRUE) {

            $conn->query("UPDATE user_master SET commission = commission + 700, collection = collection - " . $data['amount'] . " WHERE user_id = '" . $data['userId'] . "';");
           
            echo json_encode(["message" => "Deposit collection recorded successfully", "deposit_id" => $conn->insert_id]);
        } else {
            echo json_encode(["error" => "Error: " . $sql . " - " . $conn->error]);
        }
    }

    function handleAddCustomer($conn, $data) {
        $sql = "INSERT INTO `customers` (`customer_id`, `name`, `mobile`, `email`, `address`, `pincode`) VALUES (NULL, '" . $data['customerName'] . "', '" . $data['mobileNumber'] . "', '" . $data['email'] . "', '" . $data['address'] . "', '" . $data['pincode'] . "');";
        
        if ($conn->query($sql) === TRUE) {
             $conn->query("INSERT INTO `sales_master` (`sales_id`, `customer_id`, `user_id`, `sales_date`, `total_amount`) VALUES (NULL, LAST_INSERT_ID(), '".$data["userId"]."', NOW(), '2999');");
        $customerId = 
        $productId = $data['pId'];
        $productType = $data['type'];

        if ($productType == 'freshsold') {

            // echo "freshsold";
            $conn->query("UPDATE user_products SET quantity = quantity - 1 WHERE product_id IN(" . $productId . ",8);");
            $conn->query("UPDATE user_master SET commission = commission + 700, collection = collection + " . $data['amount'] . " WHERE user_id = '" . $data['userId'] . "';");
            $conn->query("UPDATE user_master SET commission = commission + 700, collection = collection + " . $data['amount'] . " WHERE user_id = '" . $data['userId'] . "';");
           
        } else if($productType == 'booking') {

            // echo "booking";
            $conn->query("UPDATE user_products SET quantity = quantity - 1 WHERE product_id = 8 ;");
            $conn->query("UPDATE user_master SET commission = commission + 300, collection = collection + " . $data['amount'] . " WHERE user_id = '" . $data['userId'] . "';");

        } else {

            // echo "bookingsold";
            $conn->query("UPDATE user_products SET quantity = quantity - 1 WHERE product_id = " . $productId . ";");
            $conn->query("UPDATE user_master SET commission = commission + 400, collection = collection + " . $data['amount'] . " WHERE user_id = '" . $data['userId'] . "';");
            
        }

            echo json_encode(["message" => "Customer added successfully", "customer_id" => $conn->insert_id]);
        } else {
            echo json_encode(["error" => "Error: " . $sql . " - " . $conn->error]);
        }
    }

    function handleGetUser($conn, $data) {
        $userId = $data['user_id'];
        $sql = "SELECT * FROM user_master_view WHERE user_id = '$userId'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $user = $result->fetch_assoc();
            echo json_encode(["user" => $user]);
        } else {
            echo json_encode(["error" => "User not found"]);
        }
    }

    function handleMyBookings($conn, $data) {
        $userId = $data['user_id'];
        $sql = "SELECT * FROM customers WHERE user_id = '$userId'";
        $result = $conn->query($sql);

        $bookings = [];

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $bookings[] = $row;
        }
        echo json_encode([
            "bookings" => $bookings
        ]);
    
        } else {
            echo json_encode(["error" => "User not found"]);
        }
    }

    function handleMyDepositionRequest($conn, $data) {
        $userId = $data['userId'];
        $sql = "SELECT u.name as pending_with, c.amount, c.date, c.status FROM `collection_deposit_master` c, user_master u WHERE raised_by='$userId' AND c.pending_with = u.user_id;";
        $result = $conn->query($sql);

        $requests = [];

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $requests[] = $row;
            }
        }
        $result1 = $conn->query("select * from user_master where user_id = '$userId'");
        echo json_encode([
            "requests" => $requests,
            "user" => $result1->fetch_assoc()
        ]);
    }
    function handleAcceptCollection($conn, $data) {
        // Implement acceptCollection logic here
        echo "acceptCollection method called";
    }

    function handleGetProductsByUser($conn, $data) {
        $userId = $data['user_id'];
        $sql = "SELECT u.product_id,u.user_id, u.quantity, p.Price, p.name, p.commission, p.SKU, p.cat_id FROM `user_products` u, `products` p where u.user_id = '$userId' AND u.product_id=p.id;";
        $result = $conn->query($sql);

        $products = [];

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $products[] = $row;
            }
        }

        echo json_encode([
            "products" => $products
        ]);
    }

?>