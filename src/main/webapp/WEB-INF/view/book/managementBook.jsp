<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>

<head>
    <title>Danh sách sản phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<style>
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
</style>
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
            <button type="submit" class="search-btn" style="height: 41px">
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
                        <i class="bi bi-list"></i>
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


<div class="container mt-4">
    <h2 class="text-center mb-4">Danh sách sản phẩm</h2>

    <table class="table table-bordered table-hover align-middle text-center">
        <thead class="table-primary">
        <tr>
            <th style="width: 5%;">STT</th>
            <th style="width: 10%;">Hình ảnh</th>
            <th style="width: 20%;">Tên sách</th>
            <th style="width: 15%;">Tác giả</th>
            <th style="width: 10%;">Giá (VNĐ)</th>
            <th style="width: 10%;">Số lượng</th>
            <th style="width: 20%;">Mô tả</th>
            <th style="width: 10%;">Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="book" items="${books}" >
            <tr>
                <td>${book.id}</td>
                <td>
                    <img src="${book.imageURL}" alt="${book.title}" class="img-thumbnail" style="width: 50px; height: 50px;">
                </td>
                <td>${book.title}</td>
                <td>${book.author}</td>
                <td><fmt:formatNumber value="${book.price}" type="number" pattern="#,##0.000" /> VNĐ</td>
                <td>${book.stockQuantity}</td>
                <td class="text-truncate" style="max-width: 200px;">${book.bookDescription}</td>
                <td>
                    <div class="d-flex justify-content-center gap-2">
                        <a href="managementBook?action=editForm&id=${book.id}" class="btn btn-warning btn-sm">Sửa</a>
                        <a href="deleteBook?id=${book.id}" class="btn btn-danger btn-sm"
                           onclick="return confirm('Bạn có chắc chắn muốn xóa sách này không?');">Xóa</a>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleDropdown() {
        var menu = document.querySelector(".dropdown-menu");
        menu.classList.toggle("show");
    }
</script>
</body>
</html>
