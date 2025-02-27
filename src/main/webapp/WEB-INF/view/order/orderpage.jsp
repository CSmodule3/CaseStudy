<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="model.Book" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: DacHaiPham
  Date: 2/13/2025
  Time: 7:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%
    Book book = new Book();
    book.setImageURL(request.getParameter("imageURL"));
    book.setTitle(request.getParameter("title"));

    String priceParam = request.getParameter("price");
    double price = 0.0;

    if (priceParam != null && !priceParam.trim().isEmpty()) {
        try {
            price = Double.parseDouble(priceParam);
            book.setPrice(price);
        } catch (NumberFormatException e) {
            // Không đặt giá trị nếu lỗi
        }
    }
%>


<!DOCTYPE html>
<html lang="vi">
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

    <style>

        /*body {*/
        /*    padding-top: 70px; !* Tạo khoảng trống để tránh navbar che mất nội dung *!*/
        /*}*/

        /* Màu chủ đạo */
        .navbar, footer {
            background-color: #ff7f00 !important; /* Màu cam */
        }

        .navbar .nav-link {
            color: white !important;
        }

        .navbar .nav-link:hover {
            color: #ffd700 !important; /* Màu vàng nhạt */
        }

        .btn-danger {
            background-color: #ff7f00 !important; /* Màu cam */
            border-color: #ff7f00 !important;
        }

        .btn-danger:hover {
            background-color: #e67300 !important; /* Màu cam đậm */
            border-color: #e67300 !important;
        }

        .card {
            border-color: #ff7f00 !important;
        }

        h4, h5 {
            color: #ff7f00 !important;
        }

        .custom-header {
            background-color: white;
            padding: 10px 0;
            border-bottom: 2px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
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
        /* Điều chỉnh chiều rộng ảnh */
        .card img {
            max-width: 100px; /* Giới hạn chiều rộng ảnh */
            height: auto;
            margin-right: 15px;
            border-radius: 5px;
        }

        /* Bố cục giỏ hàng */
        .card {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px;
            border: 2px solid #ff7f00;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .card-body {
            flex-grow: 1;
            padding-left: 10px;
        }

        .card-body h5 {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .card-body p {
            font-size: 14px;
            margin-bottom: 5px;
        }

        .card-footer {
            display: flex;
            justify-content: flex-end;
            font-size: 14px;
            font-weight: bold;
            color: #ff7f00;
        }

        .card-footer .total-price {
            font-size: 16px;
        }

    </style>

</head>
<body>

<!-- Thanh Navbar -->
<header class="custom-header">
    <div class="container">
        <div class="row align-items-center justify-content-between ">
            <div class="col-auto">
                <a href="/book">
                    <img src="https://beedesign.com.vn/wp-content/uploads/2020/08/logo-nha-sach-Viet.jpg" alt="Logo" class="header-logo">
                </a>
            </div>

            <div class="col-md-6">
                <div class="search-bar">
                    <input type="text" class="search-input" placeholder="Tìm kiếm sản phẩm...">
                    <button class="search-btn">
                        <i class="bi bi-search"></i>
                    </button>
                </div>
            </div>

            <div class="col-auto">
                <a href="/login" class="header-account">
                    <i class="bi bi-person-fill"></i>
                    <span style="margin-top: -10px">Tài khoản</span>
                </a>
            </div>

            <div class="col-auto">
                <a href="/orderpage" class="payment">
                    <i class="bi bi-cart-fill"></i>
                    <span style="margin-top: -10px">Thanh toán</span>
                </a>
            </div>
        </div>
    </div>
</header>

    <!-- Nội dung chính -->
<div class="container mt-4">
    <div class="row">
        <!-- Địa chỉ giao hàng -->
        <div class="col-md-8">
            <h4>Địa chỉ giao hàng</h4>
            <form id="checkoutForm">
                <div class="mb-3">
                    <label class="form-label">Họ tên *</label>
                    <input type="text" class="form-control" required>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Email *</label>
                        <input type="email" class="form-control" id="email" required onblur="validateEmail()">
                        <div class="text-danger" id="emailError"></div>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Số điện thoại *</label>
                        <input type="text" class="form-control" id="phone" required oninput="validatePhone()">
                        <div class="text-danger" id="phoneError"></div>
                    </div>

                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Tỉnh/Thành phố *</label>
                        <select id="city" class="form-select" onchange="updateDistricts()">
                            <option selected>-- Chọn thành phố --</option>
                        </select>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Quận/Huyện *</label>
                        <select id="district" class="form-select" onchange="updateWards()">
                            <option selected>-- Chọn quận huyện --</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Phường/Xã/Thị trấn *</label>
                        <select id="ward" class="form-select">
                            <option selected>-- Chọn phường/xã/thị trấn --</option>
                        </select>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Số nhà, Tên đường</label>
                        <input type="text" class="form-control">
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">Ghi chú</label>
                    <textarea class="form-control" rows="3"></textarea>
                </div>
            </form>
        </div>

        <%
            if (book == null || book.getTitle() == null || book.getImageURL() == null || book.getPrice() == 0.0) {
        %>
        <div class="col-md-4">
            <h4>Giỏ hàng</h4>
            <div class="card p-3 text-center">
                <p>Giỏ hàng của bạn đang trống</p>
            </div>
        </div>
        <%
        } else {
        %>
        <!-- Giỏ hàng -->
        <div class="col-md-4">
            <h4>Giỏ hàng</h4>
            <div class="card p-3">
                <div class="d-flex">
                    <img src="<%= book.getImageURL() %>" alt="Sản phẩm">
                    <div class="card-body">
                        <h5><%= book.getTitle() %></h5>
                        <p><strong>Trọng lượng:</strong> 300g</p>
                        <p><strong>Vận chuyển:</strong> 30,000 VNĐ/p</p>
                    </div>
                </div>
                <div class="card-footer">
                    <p class="total-price">
                        Tổng giá: <fmt:formatNumber value="${book.price}" type="number" pattern="#,##0.000" /> VND
                    </p>
                </div>
            </div>
        </div>
        <%
            }
        %>

        <!-- Phương thức thanh toán -->
        <div class="mt-4">
            <h4>Vận chuyển</h4>
            <hr>
            <h5>Hình thức thanh toán</h5>
            <form>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="paymentMethod" id="cod" checked>
                    <label class="form-check-label" for="cod">
                        Thanh toán khi nhận hàng
                    </label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="paymentMethod" id="bankTransfer">
                    <label class="form-check-label" for="bankTransfer">
                        Chuyển khoản qua ATM/Internet Banking
                    </label>
                </div>
            </form>
        </div>
    </div>

        <!-- Nút điều hướng -->
        <div class="mt-4 d-flex justify-content-center gap-4">
            <button type="button" class="btn btn-secondary">Quay lại</button>
            <button type="submit" class="btn btn-danger" onclick="handlePayment()">Thanh toán</button>
        </div>
    </div>
</div>

<footer class="bg-light text-center py-3 mt-4">
    <p class="mb-0">© 2024 Cửa hàng của bạn. All Rights Reserved.</p>
</footer>

<script>
    // Danh sách tỉnh/thành phố
    const cities = {
        "Hà Nội": ["Ba Đình", "Hoàn Kiếm", "Hai Bà Trưng", "Đống Đa"],
        "TP. Hồ Chí Minh": ["Quận 1", "Quận 3", "Quận 5", "Quận 7"],
        "Đà Nẵng": ["Hải Châu", "Thanh Khê", "Sơn Trà", "Ngũ Hành Sơn"]
    };

    // Danh sách quận/huyện và phường/xã
    const wards = {
        "Ba Đình": ["Phường Phúc Xá", "Phường Trúc Bạch", "Phường Liễu Giai"],
        "Hoàn Kiếm": ["Phường Hàng Bạc", "Phường Hàng Đào", "Phường Tràng Tiền"],
        "Quận 1": ["Phường Bến Nghé", "Phường Bến Thành", "Phường Nguyễn Thái Bình"],
        "Hải Châu": ["Phường Hải Châu 1", "Phường Hải Châu 2", "Phường Thanh Bình"]
    };

    // Hàm cập nhật danh sách tỉnh/thành phố
    function updateCities() {
        const citySelect = document.getElementById("city");
        for (const city in cities) {
            let option = new Option(city, city);
            citySelect.add(option);
        }
    }

    // Hàm cập nhật danh sách quận/huyện khi chọn tỉnh/thành phố
    function updateDistricts() {
        const city = document.getElementById("city").value;
        const districtSelect = document.getElementById("district");
        districtSelect.innerHTML = "<option selected>-- Chọn quận/huyện --</option>";

        if (cities[city]) {
            cities[city].forEach(district => {
                let option = new Option(district, district);
                districtSelect.add(option);
            });
        }

        // Reset danh sách phường/xã
        updateWards();
    }

    // Hàm cập nhật danh sách phường/xã khi chọn quận/huyện
    function updateWards() {
        const district = document.getElementById("district").value;
        const wardSelect = document.getElementById("ward");
        wardSelect.innerHTML = "<option selected>-- Chọn phường/xã/thị trấn --</option>";

        if (wards[district]) {
            wards[district].forEach(ward => {
                let option = new Option(ward, ward);
                wardSelect.add(option);
            });
        }
    }

    // Gọi hàm cập nhật danh sách tỉnh/thành phố khi tải trang
    updateCities();

    function handlePayment() {
        // Lấy phương thức thanh toán được chọn
        let paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').id;

        if (paymentMethod === "cod") {
            // Thanh toán khi nhận hàng -> Hiển thị xác nhận
            alert("Đơn hàng của bạn đã được đặt thành công! Vui lòng nhận hàng và thanh toán khi giao hàng.");
        } else if (paymentMethod === "bankTransfer") {
            alert("Đơn hàng của bạn đã được đặt thành công! Vui lòng chờ ngày nhận hàng.");
        }

        // Đặt lại toàn bộ giá trị của form
        document.getElementById("checkoutForm").reset();
    }


    function validateEmail() {
        let emailInput = document.getElementById("email");
        let emailError = document.getElementById("emailError");
        let emailValue = emailInput.value.trim();

        if (!emailValue.endsWith("@gmail.com")) {
            emailError.textContent = "Vui lòng nhập email có đuôi @gmail.com";
            emailInput.classList.add("is-invalid");
        } else {
            emailError.textContent = "";
            emailInput.classList.remove("is-invalid");
        }
    }

    function validatePhone() {
        let phoneInput = document.getElementById("phone");
        let phoneError = document.getElementById("phoneError");
        let phoneValue = phoneInput.value.trim();

        // Kiểm tra nếu không phải số hoặc rỗng
        if (!/^\d*$/.test(phoneValue)) {
            phoneError.textContent = "Vui lòng chỉ nhập số, đủ 10 số.";
            phoneInput.classList.add("is-invalid");
        } else {
            phoneError.textContent = "";
            phoneInput.classList.remove("is-invalid");
        }
    }




</script>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
