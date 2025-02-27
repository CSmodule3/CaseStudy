<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Danh Sách Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

    <style>
        .sidebar {
            background-color: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease-in-out;
        }
        .sidebar:hover {
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        .sidebar h4 {
            font-weight: bold;
            margin-bottom: 15px;
        }
        .sidebar ul li {
            padding: 5px 0;
        }
        .sidebar ul li a {
            color: #333;
            text-decoration: none;
            transition: color 0.3s;
        }
        .sidebar ul li a:hover {
            color: #ff9800;
        }
        .product-card {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: center;
            border: 1px solid #ddd;
            border-radius: 12px;
            padding: 15px;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            background-color: white;
            height: 100%; /* Chiều cao đồng đều */
        }

        /* Ảnh sản phẩm cùng kích thước */
        .product-card img {
            width: 100%;
            height: 200px; /* Đảm bảo chiều cao cố định */
            object-fit: contain; /* Giữ nguyên tỉ lệ ảnh */
            display: block;
            margin: auto;
        }

        /* Đảm bảo tiêu đề có chiều cao giống nhau */
        .product-card h5 {
            min-height: 50px; /* Đặt chiều cao tối thiểu để tránh lệch */
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        /* Căn chỉnh phần giá */
        .price {
            color: red;
            font-size: 20px;
            font-weight: bold;
            margin: 10px 0;
        }


        .buy-button {
            background-color: #ff9800;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            width: 100%;
            margin-top: auto; /* Đẩy xuống dưới cùng */
        }

        .buy-button:hover {
            background-color: #e68900;
        }


        .container {
            max-width: 1200px;
            margin: auto;
        }

        .banner-large {
            width: 100%;
            height: auto;
            max-height: 320px;
            object-fit: cover;
            border-radius: 10px;
        }

        .banner-small {
            width: 100%;
            height: auto;
            max-height: 155px;
            object-fit: cover;
            border-radius: 10px;
        }

        .custom-header {
            background-color: white;
            padding: 10px 0;
            border-bottom: 2px ;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }


        .container {
            max-width: 1200px;
            margin: auto;
        }


        .header-logo {
            height: 60px;
        }

        /* Ô tìm kiếm */
        .search-bar {
            display: flex;
            align-items: center;
            border: 2px solid #FFA500;
            border-radius: 5px;
            overflow: hidden;
            background-color: #fff;
            max-width: 500px;
            margin: auto;
        }

        .search-input {
            flex: 1;
            padding: 10px 15px;
            border: none;
            outline: none;
            font-size: 14px;
        }

        .search-btn {
            background-color: #FFA500;
            border: none;
            padding: 10px 15px;
            color: white;
            cursor: pointer;
        }

        .search-btn i {
            font-size: 18px;
        }


        .header-account {
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
            color: #FFA500;
            transition: color 0.3s;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .header-account i {
            font-size: 24px;
            margin-bottom: 5px;
        }

        .header-account:hover {
            color: #FF8C00;
        }
        .payment {
            display: flex;
            flex-direction: column;
            align-items: center;
            color: orange;
            text-decoration: none;
            font-weight: bold;
            font-size: 14px;
        }
        .payment i {
            font-size: 24px; /* Kích thước biểu tượng */
            margin-bottom: 5px; /* Khoảng cách giữa icon và chữ */
        }

        .payment:hover {
            color: darkorange; /* Màu cam đậm khi hover */
        }
        .custom-header {
            background-color: white;
            padding: 10px 0;
            border-bottom: 2px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .container1 {
            max-width: 1200px;
            margin: auto;
            display: flex; /* Dùng Flexbox */
            align-items: center; /* Căn giữa theo chiều dọc */
            justify-content: space-between; /* Dàn đều các phần tử */
            padding: 0 20px;
        }

        .header-logo {
            height: 60px;
        }

        /* Ô tìm kiếm */
        .search-bar {
            display: flex;
            align-items: center;
            border: 2px solid #FFA500;
            border-radius: 5px;
            overflow: hidden;
            background-color: #fff;
            max-width: 500px;
            flex-grow: 1; /* Cho phép mở rộng */
            margin: 0 20px; /* Tạo khoảng cách giữa logo và các nút bên phải */
        }

        .search-input {
            flex: 1;
            padding: 10px 15px;
            border: none;
            outline: none;
            font-size: 14px;
        }

        .search-btn {
            background-color: #FFA500;
            border: none;
            padding: 10px 15px;
            color: white;
            cursor: pointer;
        }

        .search-btn i {
            font-size: 18px;
        }

        /* Các nút bên phải */
        .header-right {
            display: flex;
            align-items: center;
            gap: 30px; /* Khoảng cách giữa các nút */
        }

        .header-account,
        .payment,
        .manage {
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
            color: #FFA500;
            transition: color 0.3s;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .header-account i,
        .payment i,
        .manage i {
            font-size: 24px;
            margin-bottom: 5px;
        }

        .header-account:hover,
        .payment:hover,
        .manage:hover {
            color: #FF8C00;
        }
        /* Định dạng dropdown */
        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-menu {
            display: none;
            position: absolute;
            background-color: #fff;
            min-width: 180px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 5px;
            padding: 10px 0;
        }

        .dropdown-menu a {
            display: block;
            padding: 10px 15px;
            text-decoration: none;
            color: #333;
        }

        .dropdown-menu a:hover {
            background-color: #f1f1f1;
        }

        /* Khi mở dropdown */
        .show {
            display: block;
        }
        /* Hộp chat */
        .chat-popup {
            display: none;
            position: fixed;
            bottom: 80px;
            right: 20px;
            width: 320px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
            border: 1px solid #ddd;
        }

        /* Nội dung chat */
        .chat-body {
            padding: 10px;
            height: 250px;
            overflow-y: auto;
            border-bottom: 1px solid #ddd;
        }

        /* Tin nhắn */
        .messages {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }



        /* Footer chat */
        .chat-footer {
            display: flex;
            padding: 5px;
        }

        .chat-footer input {
            flex: 1;
            padding: 8px;
            border: none;
            outline: none;
        }

        .chat-footer button {
            background: #007bff;
            color: white;
            border: none;
            padding: 8px;
            cursor: pointer;
        }
        /* Nút mở chat */
        .chat-icon {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #007bff;
            color: white;
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            font-size: 24px;
            cursor: pointer;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
            transition: transform 0.2s;
        }

        .chat-icon:hover {
            transform: scale(1.1);
        }

        /* Hộp chat */
        .chat-popup {
            display: none;
            position: fixed;
            bottom: 80px;
            right: 20px;
            width: 320px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
            border: 1px solid #ddd;
        }

        /* Header chat */
        .chat-header {
            background: #007bff;
            color: white;
            padding: 10px;
            border-radius: 10px 10px 0 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .chat-header .close-btn {
            background: none;
            border: none;
            color: white;
            font-size: 18px;
            cursor: pointer;
        }

        /* Nội dung chat */
        .chat-body {
            padding: 10px;
            height: 200px;
            overflow-y: auto;
        }

        /* Footer chat */
        .chat-footer {
            display: flex;
            border-top: 1px solid #ddd;
            padding: 5px;
        }

        .chat-footer input {
            flex: 1;
            padding: 8px;
            border: none;
            outline: none;
        }

        .chat-footer button {
            background: #007bff;
            color: white;
            border: none;
            padding: 8px;
            cursor: pointer;
        }
        /* Nút Facebook */
        .icon-circle {
            position: fixed;
            bottom: 80px; /* Điều chỉnh vị trí */
            right: 20px; /* Điều chỉnh vị trí */
            background-color: #1877F2; /* Màu xanh Facebook */
            color: white;
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            font-size: 24px;
            cursor: pointer;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
            transition: transform 0.2s, background-color 0.3s;
            text-decoration: none;
        }

        .icon-circle i {
            color: white;
        }

        .icon-circle:hover {
            transform: scale(1.1);
            background-color: #166FE5; /* Màu hover đậm hơn */
        }
    </style>
</head>
<body style="background-color: #f8f9fa;">
<header class="custom-header">
    <div class="container1">
        <!-- Logo -->
        <div>
            <a href="/book">
                <img src="https://beedesign.com.vn/wp-content/uploads/2020/08/logo-nha-sach-Viet.jpg" alt="Logo" class="header-logo">
            </a>
        </div>

        <!-- Ô tìm kiếm -->
        <form action="/book" method="GET" class="search-bar">
            <input type="hidden" name="type" value="title">
            <input type="text" class="search-input" name="query" placeholder="Tìm kiếm sách theo tên...">
            <button type="submit" class="search-btn">
                <i class="bi bi-search"></i>
            </button>
        </form>

        <!-- Các nút bên phải -->
        <div class="header-right">
            <c:if test="${empty sessionScope.user}">
                <a href="/login" class="header-account">
                    <i class="bi bi-person-fill"></i>
                    <span>Tài khoản</span>
                </a>
            </c:if>

            <c:if test="${not empty sessionScope.user}">
                <a href="/logout" class="header-account">
                    <i class="bi bi-box-arrow-right"></i>
                    <span>Đăng xuất</span>
                </a>
            </c:if>

            <c:if test="${sessionScope.roleId == 1}">
                <div class="dropdown">
                    <a href="#" class="manage" onclick="toggleDropdown()">
                        <i class="bi bi-person-lines-fill"></i>
                        <span>Quản lý</span>
                    </a>
                    <div class="dropdown-menu">
                        <a href="/users">Quản lý người dùng</a>
                        <a href="/managementBook">Quản lý sách</a>
                        <a href="/orderDetails">Quản lý đơn hàng</a>
                    </div>
                </div>
            </c:if>


            <a href="/orderpage" class="payment">
                <i class="bi bi-cart-fill"></i>
                <span>Thanh toán</span>
            </a>
        </div>
    </div>
</header>
<div>
    <div class="container" style="margin-top: 15px">
        <div class="row">
            <div class="col-md-8">
                <div id="mainBannerCarousel" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="https://cdn0.fahasa.com/media/magentothem/banner7/valentine_t2_840x320.jpg" class="d-block w-100 banner-large" alt="Banner 1">
                        </div>
                        <div class="carousel-item">
                            <img src="https://cdn0.fahasa.com/media/magentothem/banner7/trangct2_152_840x320.jpg" class="d-block w-100 banner-large" alt="Banner 2">
                        </div>
                        <div class="carousel-item">
                            <img src="https://cdn0.fahasa.com/media/magentothem/banner7/DinhTi_0225_840x320.jpg" class="d-block w-100 banner-large" alt="Banner 3">
                        </div>
                        <div class="carousel-item">
                            <img src="https://cdn0.fahasa.com/media/magentothem/banner7/thanhtoankhongtienmat_t2_840x320.jpg" class="d-block w-100 banner-large" alt="Banner 3">
                        </div>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#mainBannerCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#mainBannerCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
            </div>

            <!-- Banner nhỏ bên phải -->
            <div class="col-md-4">
                <div class="row">
                    <div class="col-12 mb-2">
                        <img src="https://cdn0.fahasa.com/media/wysiwyg/Thang-02-2025/UuDai_T2_392x156_1.jpg" class="w-100 banner-small" alt="Banner Right 1">
                    </div>
                    <div class="col-12">
                        <img src="https://cdn0.fahasa.com/media/wysiwyg/Thang-02-2025/Fahasa_Onine_392x156.jpg" class="w-100 banner-small" alt="Banner Right 2">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container mt-4">
    <div class="row">
        <div class="col-lg-3">
            <div class="sidebar">
                <h4>Tác giả</h4>
                <ul class="list-unstyled">
                    <li><a href="/book?type=author&query=Nam Cao">Nam Cao</a></li>
                    <li><a href="/book?type=author&query=Vũ Trọng Phụng">Vũ Trọng Phụng</a></li>
                    <li><a href="/book?type=author&query=Nguyễn Nhật Ánh">Nguyễn Nhật Ánh</a></li>
                    <li><a href="/book?type=foreign_author">Tác giả nước ngoài</a></li>
                </ul>

                <h4>GIÁ</h4>
                <ul class="list-unstyled">
                    <li><input type="radio" name="price"> 0đ -50,000đ</li>
                    <li><input type="radio" name="price"> 50,000đ - 100,000đ</li>
                    <li><input type="radio" name="price"> 100,000đ - 150,000đ</li>
                    <li><input type="radio" name="price"> 150,000đ - 300,000đ</li>
                </ul>
            </div>
        </div>

        <!-- Product List -->
        <!-- Product List -->
        <div class="col-lg-9">
            <div class="row">
                <c:forEach var="book" items="${books}">
                    <div class="col-lg-4 col-md-6 mb-4 d-flex">
                        <div class="product-card w-100">
                            <c:choose>
                                <c:when test="${not empty book.imageURL}">
                                    <img src="${book.imageURL}" alt="Ảnh sản phẩm">
                                </c:when>
                                <c:otherwise>
                                    <img src="default-image.jpg" alt="Không có ảnh">
                                </c:otherwise>
                            </c:choose>
                            <h5>${book.title}</h5>
                            <p class="price">
                                <fmt:formatNumber value="${book.price}" type="number" pattern="#,##0.000" />VND
                            </p>

                            <!-- Form to pass product details using JavaBean -->
                            <form action="order" method="get">
                                <input type="hidden" name="bookId" value="${book.id}">
                                <input type="hidden" name="imageURL" value="${book.imageURL}" />
                                <input type="hidden" name="title" value="${book.title}" />
                                <input type="hidden" name="price" value="${book.price}" />
                                <button class="buy-button" type="submit">Mua ngay</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <a  href="https://www.facebook.com/v.tafii" class="icon-circle">
            <i class="bi bi-facebook"></i>
        </a>
        <!-- Nút mở chat -->
        <div id="chat-button" class="chat-icon">
            <i class="bi bi-chat-fill"></i>
        </div>

        <!-- Hộp chat -->
        <div id="chatbox" class="chat-popup">
            <div class="chat-header">
                <span>Chatbot Hỗ Trợ Mua Hàng</span>
                <button id="close-chat" class="close-btn">&times;</button>
            </div>
            <div class="chat-body">
                <div class="messages" id="response"></div>
            </div>
            <div class="chat-footer">
                <input type="text" id="userInput" placeholder="Nhập tin nhắn...">
                <button id="send-chat">Gửi</button>
            </div>
        </div>
    </div>
    </div>
<script>
    function toggleDropdown() {
        var menu = document.querySelector(".dropdown-menu");
        menu.classList.toggle("show");
    }


    document.getElementById("chat-button").addEventListener("click", function () {
        document.getElementById("chatbox").style.display = "block";
    });

    document.getElementById("close-chat").addEventListener("click", function () {
        document.getElementById("chatbox").style.display = "none";
    });

    document.getElementById("send-chat").addEventListener("click", function () {
        let input = document.getElementById("chat-input");
        if (input.value.trim() !== "") {
            let messages = document.querySelector(".messages");
            let newMessage = document.createElement("div");
            newMessage.textContent = input.value;
            messages.appendChild(newMessage);
            input.value = "";
        }
    });
        document.getElementById("chat-button").addEventListener("click", function () {
        document.getElementById("chatbox").style.display = "block";
    });

        document.getElementById("close-chat").addEventListener("click", function () {
        document.getElementById("chatbox").style.display = "none";
    });

        document.getElementById("send-chat").addEventListener("click", sendMessage);

        async function sendMessage() {
        const inputField = document.getElementById('userInput');
        const input = inputField.value.trim();
        const responseDiv = document.getElementById('response');

        if (!input) {
        return;
    }

        // Hiển thị tin nhắn người dùng
        const userMessage = document.createElement('div');
        userMessage.classList.add('user-message');
        userMessage.textContent = input;
        responseDiv.appendChild(userMessage);

        // Xóa nội dung ô nhập sau khi gửi
        inputField.value = '';

        // Hiển thị trạng thái "Đang trả lời..."
        const loadingMessage = document.createElement('div');
        loadingMessage.classList.add('bot-message');
        loadingMessage.textContent = "Đang trả lời...";
        responseDiv.appendChild(loadingMessage);

        try {
        const response = await fetch("https://openrouter.ai/api/v1/chat/completions", {
        method: "POST",
        headers: {
        "Authorization": "Bearer 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",
        "HTTP-Referer": "http://localhost:8080/",
        "X-Title": "HelloServlet",
        "Content-Type": "application/json"
    },
        body: JSON.stringify({
        "model": "deepseek/deepseek-r1-distill-llama-70b:free",
        "messages": [{"role": "user", "content": input}],
    })
    });

        const data = await response.json();
        console.log("API Response:", data); // Debug response

        // Xóa tin nhắn "Đang trả lời..."
        responseDiv.removeChild(loadingMessage);

        // Thêm tin nhắn phản hồi từ chatbot
        const botMessage = document.createElement('div');
        botMessage.classList.add('bot-message');
        botMessage.textContent = data.choices?.[0]?.message?.content || 'Không có phản hồi.';
        responseDiv.appendChild(botMessage);

    } catch (error) {
        console.error("Fetch error:", error);
        responseDiv.removeChild(loadingMessage);
        const errorMessage = document.createElement('div');
        errorMessage.classList.add('bot-message');
        errorMessage.textContent = 'Lỗi: ' + error.message;
        responseDiv.appendChild(errorMessage);
    }

        // Cuộn xuống tin nhắn mới nhất
        responseDiv.scrollTop = responseDiv.scrollHeight;
    }
</script>

</div>
</body>
</html>
