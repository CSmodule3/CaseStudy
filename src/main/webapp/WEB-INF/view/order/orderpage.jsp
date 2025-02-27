<%--
  Created by IntelliJ IDEA.
  User: DacHaiPham
  Date: 2/13/2025
  Time: 7:26 PM
  To change this template use File | Settings | File Templates.
--%>
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
            <form>
                <div class="mb-3">
                    <label class="form-label">Họ tên *</label>
                    <input type="text" class="form-control" required>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Email *</label>
                        <input type="email" class="form-control" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Số điện thoại *</label>
                        <input type="text" class="form-control" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Tỉnh/Thành phố *</label>
                        <select id="city" class="form-select" onchange="updateDistricts()">
                            <option selected>-- Chọn thành phố --</option>
                            <option value="hanoi">Hà Nội</option>
                            <option value="hcm">TP. Hồ Chí Minh</option>
                            <option value="danang">Đà Nẵng</option>
                            <option value="hue">Huế</option>
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

        <!-- Giỏ hàng -->
        <div class="col-md-4">
            <h4>Giỏ hàng</h4>
            <div class="card p-3">
                <div class="d-flex">
                    <img src="https://via.placeholder.com/50" class="me-3" alt="Sản phẩm">
                    <div>
                        <p class="mb-1" >Tên sách</p>
                        <strong>0đ</strong>
                    </div>
                </div>
                <p><strong>Tổng giá:</strong> 0đ</p>
                <p><strong>Trọng lượng:</strong></p>
                <p><strong>Vận chuyển:</strong> 0đ</p>
                <h5 class="text-danger">0đ</h5>
            </div>
        </div>

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

        <!-- Nút điều hướng -->
        <div class="mt-4 d-flex justify-content-center gap-4">
            <button type="button" class="btn btn-secondary">Quay lại</button>
            <button type="submit" class="btn btn-danger">Thanh toán</button>
        </div>
    </div>
</div>

<footer class="bg-light text-center py-3 mt-4">
    <p class="mb-0">© 2024 Cửa hàng của bạn. All Rights Reserved.</p>
</footer>

<!-- JavaScript -->
<script>
    const districts = {
        hanoi: ["Ba Đình", "Hoàn Kiếm", "Hai Bà Trưng", "Cầu Giấy"],
        hcm: ["Quận 1", "Quận 3", "Quận 5", "Bình Thạnh"],
        danang: ["Hải Châu", "Thanh Khê", "Ngũ Hành Sơn", "Cẩm Lệ", "Sơn Trà"],
        hue: ["Phú Vang", "Hương Trà", "Hương Thủy", "Phong Điền"]
    };

    const wards = {
        "Ba Đình": ["Điện Biên", "Kim Mã", "Ngọc Hà", "Trúc Bạch"],
        "Hoàn Kiếm": ["Hàng Bài", "Hàng Gai", "Hàng Trống", "Phan Chu Trinh"],
        "Quận 1": ["Bến Nghé", "Bến Thành", "Cầu Kho", "Cô Giang"],
        "Quận 3": ["Phường 1", "Phường 2", "Phường 3", "Phường 4"],
        "Hải Châu": ["Bình Hiên", "Bình Thuận", "Hải Châu 1", "Hải Châu 2"],
        "Thanh Khê": ["Hòa Khê", "Tam Thuận", "Tân Chính", "Vĩnh Trung"],
        "Phú Vang": ["Phú Đa", "Phú Hồ", "Phú Xuân", "Vinh Hà"]
    };

    function updateDistricts() {
        const city = document.getElementById("city").value;
        const districtSelect = document.getElementById("district");
        districtSelect.innerHTML = "<option selected>-- Chọn quận huyện --</option>";

        if (districts[city]) {
            districts[city].forEach(district => {
                let option = new Option(district, district);
                districtSelect.add(option);
            });
        }

        // Reset phường/xã
        updateWards();
    }

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
</script>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
