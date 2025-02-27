<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.OrderDetail" %>
<%@ page import="service.impl.OrderDetail.OrderDetailService" %>
<%@ page import="repository.connection.DBRepository" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
  OrderDetailService orderDetailService = new OrderDetailService(DBRepository.getConnection());
  List<OrderDetail> orderDetails = orderDetailService.getAll();
  request.setAttribute("orderDetails", orderDetails);
%>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Quản Lý Chi Tiết Đơn Hàng</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <style>
    body { font-family: Arial, sans-serif; background-color: #f8f9fa; }
    .container { margin-top: 30px; }
    .table th, .table td { text-align: center; vertical-align: middle; }
    .status-processing { color: #ffc107; font-weight: bold; }
    .status-delivered { color: #28a745; font-weight: bold; }
    .status-cancelled { color: #dc3545; font-weight: bold; }
    .search-box {
      display: flex;
      align-items: center;
      border: 2px solid #ffa500;
      border-radius: 5px;
      overflow: hidden;
      width: 100%;
    }
    .search-box input {
      border: none;
      flex-grow: 1;
      padding: 8px;
      outline: none;
    }
    .search-box button {
      background-color: #ffa500;
      border: none;
      padding: 8px 12px;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .search-box button i {
      color: white;
    }
  </style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<div class="container">
  <h2 class="text-center text-primary">Quản Lý Chi Tiết Đơn Hàng</h2>
  <div class="card shadow p-4">
    <div class="row mb-3">
      <div class="col-md-6">
        <!-- Ô tìm kiếm -->
        <div class="search-bar">
          <input type="text" class="search-input" placeholder="Tìm kiếm theo tên khách hàng...">
          <button class="search-btn">
            <i class="fas fa-search"></i>
          </button>
        </div>

        <!-- Nhúng Font Awesome để có icon -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- CSS ngay bên dưới -->
        <style>
          /* Ô tìm kiếm */
          .search-bar {
            display: flex;
            align-items: center;
            border-radius: 5px;
            overflow: hidden;
            background-color: #FFA500;
            max-width: 500px;
            margin: auto;
            padding: 5px;
          }

          .search-input {
            flex: 1;
            padding: 10px 15px;
            border: none;
            outline: none;
            font-size: 14px;
            background-color: #fff;
            border-top-left-radius: 5px;
            border-bottom-left-radius: 5px;
          }

          .search-btn {
            background-color: #FFA500;
            border: none;
            padding: 10px 15px;
            color: white;
            cursor: pointer;
            border-top-right-radius: 5px;
            border-bottom-right-radius: 5px;
            transition: background 0.3s ease;
          }

          .search-btn:hover {
            background-color: #ff8c00;
          }

          .search-btn i {
            font-size: 18px;
          }
        </style>

      </div>
      <div class="col-md-3">
        <select id="statusFilter" class="form-select">
          <option value="">-- Lọc theo trạng thái --</option>
          <option value="Đang xử lý">Đang xử lý</option>
          <option value="Đã giao">Đã giao</option>
          <option value="Đã hủy">Đã hủy</option>
        </select>
      </div>
    </div>

    <table class="table table-striped table-bordered">
      <thead class="table-dark">
      <tr>
        <th>ID</th>
        <th>Order ID</th>
        <th>Book ID</th>
        <th>Số lượng</th>
        <th>Khách Hàng</th>
        <th>Số Điện Thoại</th>
        <th>Địa Chỉ</th>
        <th>Ghi chú</th>
        <th>Phương Thức Thanh Toán</th>
        <th>Trạng Thái</th>
        <th>Hành Động</th>
      </tr>
      </thead>
      <tbody id="orderTable">
      <c:forEach var="orderDetail" items="${orderDetails}">
        <tr>
          <td>${orderDetail.id}</td>
          <td>${orderDetail.orderId}</td>
          <td>${orderDetail.bookId}</td>
          <td>${orderDetail.quantity}</td>
          <td>${orderDetail.fullName}</td>
          <td>${orderDetail.phoneNumber}</td>
          <td>
              ${orderDetail.street}, ${orderDetail.ward}, ${orderDetail.district}, ${orderDetail.provinceCity}
          </td>
          <td>${orderDetail.noteOrder}</td>
          <td>${orderDetail.paymentMethod}</td>
          <td>
            <span class="${orderDetail.status eq 'Đang xử lý' ? 'status-processing'
                          : (orderDetail.status eq 'Đã giao' ? 'status-delivered'
                          : 'status-cancelled')}">
                ${orderDetail.status}
            </span>
          </td>
          <td>
            <button class="btn btn-warning btn-sm editBtn"
                    data-id="${orderDetail.id}"
                    data-name="${orderDetail.fullName}"
                    data-phone="${orderDetail.phoneNumber}"
                    data-address="${orderDetail.street}, ${orderDetail.ward}, ${orderDetail.district}, ${orderDetail.provinceCity}"
                    data-status="${orderDetail.status}">
              Sửa
            </button>

            <a href="ordersList?action=delete&id=${orderDetail.id}" class="btn btn-danger btn-sm"
               onclick="return confirm('Bạn có chắc chắn muốn xóa chi tiết đơn hàng này?')">
              Xóa
            </a>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const searchInput = document.getElementById("searchInput");
    const statusFilter = document.getElementById("statusFilter");
    const rows = document.querySelectorAll("#orderTable tr");

    function filterTable() {
      let searchValue = searchInput.value.toLowerCase();
      let selectedStatus = statusFilter.value.toLowerCase();

      rows.forEach(row => {
        let customerName = row.cells[4].textContent.toLowerCase();
        let statusText = row.cells[9].textContent.toLowerCase();

        let matchesSearch = customerName.includes(searchValue);
        let matchesStatus = selectedStatus === "" || statusText.includes(selectedStatus);

        row.style.display = matchesSearch && matchesStatus ? "" : "none";
      });
    }

    searchInput.addEventListener("keyup", filterTable);
    statusFilter.addEventListener("change", filterTable);
  });
</script>

</body>
</html>
