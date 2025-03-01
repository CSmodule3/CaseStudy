<%@ page import="model.User, java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  List<User> users = (List<User>) request.getAttribute("users");
  String searchQuery = (String) request.getAttribute("searchQuery");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Danh sách người dùng</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">

<h2 class="text-center">Danh sách Người Dùng</h2>

<!-- Form tìm kiếm -->
<!-- Form tìm kiếm với class để áp dụng CSS -->
<form class="search-bar" action="users" method="get">
  <input class="search-input" type="text" name="search" placeholder="Nhập tên người dùng..."
         value="<%= searchQuery != null ? searchQuery : "" %>">
  <button class="search-btn" type="submit">
    <i class="fas fa-search"></i> <!-- Icon tìm kiếm -->
  </button>
</form>

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
  }

  .search-btn i {
    font-size: 18px;
  }
</style>


<table class="table table-bordered">
  <thead class="table-dark">
  <tr>
    <th>ID</th>
    <th>Username</th>
    <th>Email</th>
    <th>Role ID</th>
    <th>Trạng thái</th> <!-- Thêm cột trạng thái -->
    <th>Hành động</th>
  </tr>
  </thead>
  <tbody>
  <% for (User u : users) { %>
  <tr>
    <td><%= u.getId() %></td>
    <td><%= u.getUsername() %></td>
    <td><%= u.getEmail() %></td>
    <td><%= u.getRoleId() %></td>
    <td>
      <% if (u.getStatus() == 1) { %>
      <span class="badge bg-success">Hoạt động</span>
      <% } else { %>
      <span class="badge bg-danger">Bị ẩn</span>
      <% } %>
    </td>
    <td>
      <button class="btn btn-warning btn-sm" onclick="openEditModal(<%= u.getId() %>, '<%= u.getUsername() %>', '<%= u.getEmail() %>', <%= u.getRoleId() %>)">
        Sửa
      </button>
      <form action="users" method="post" class="d-inline">
        <input type="hidden" name="id" value="<%= u.getId() %>">
        <input type="hidden" name="action" value="delete">
        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn ẩn người dùng này?')">Ẩn</button>
      </form>
    </td>
  </tr>
  <% } %>
  </tbody>

</table>

<!-- Modal chỉnh sửa -->
<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="editModalLabel">Chỉnh sửa Người Dùng</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="editForm" action="users" method="post">
          <input type="hidden" name="id" id="editUserId">
          <input type="hidden" name="action" value="edit">

          <div class="mb-3">
            <label class="form-label">Username</label>
            <input type="text" class="form-control" name="username" id="editUsername" required>
          </div>
          <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" class="form-control" name="email" id="editEmail" required>
          </div>
          <div class="mb-3">
            <label class="form-label">Role ID</label>
            <input type="number" class="form-control" name="role_id" id="editRoleId" required>
          </div>
          <button type="submit" class="btn btn-success">Lưu thay đổi</button>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- Script Bootstrap & Modal -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function openEditModal(id, username, email, roleId) {
    document.getElementById("editUserId").value = id;
    document.getElementById("editUsername").value = username;
    document.getElementById("editEmail").value = email;
    document.getElementById("editRoleId").value = roleId;

    var editModal = new bootstrap.Modal(document.getElementById("editModal"));
    editModal.show();
  }
</script>

</body>
</html>
