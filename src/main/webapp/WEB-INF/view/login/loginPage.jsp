<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
  String errorMessage = (String) request.getAttribute("errorMessage");
  String successMessage = (String) session.getAttribute("successMessage");

  if (successMessage != null) {
    session.removeAttribute("successMessage"); // Xóa thông báo sau khi hiển thị
  }
%>

<!DOCTYPE html>

<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Đăng Nhập & Đăng Ký</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
  <style>
    body {
      background-color: #f8f9fa;
    }
    .login-container {
      display: flex;
      width: 900px;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      margin-top: 80px;
    }
    .login-box, .register-box {
      width: 50%;
      padding: 40px;
    }
    .login-box {
      background-color: #fff;
    }
    .register-box {
      background-color: #f28c13;
      color: white;
    }
    .form-control {
      border-radius: 5px;
    }
    .btn-submit {
      width: 100%;
      padding: 10px;
      border-radius: 5px;
      font-weight: bold;
      border: none;
      transition: 0.3s;
    }
    .btn-login {
      background-color: #f28c13;
      color: white;
    }
    .btn-login:hover {
      background-color: #d6760d;
    }
    .btn-register {
      background-color: white;
      color: #f28c13;
    }
    .btn-register:hover {
      background-color: #f5f5f5;
    }
    .password-toggle {
      cursor: pointer;
    }
  </style>
</head>
<body>
<%
  String error = (String) request.getAttribute("error");
  String success = request.getParameter("success");
%>

<div class="container mt-3">
  <% if (successMessage != null) { %>
  <div class="alert alert-success" role="alert"><%= successMessage %></div>
  <% } %>

  <% if (errorMessage != null) { %>
  <div class="alert alert-danger" role="alert"><%= errorMessage %></div>
  <% } %>
</div>


<div class="d-flex justify-content-center mt-5">
  <div class="login-container">
    <div class="login-box">
      <h2 class="text-center">Đăng nhập</h2>
      <form action="login" method="post">
        <div class="input-group mb-3">
          <span class="input-group-text"><i class="bi bi-envelope"></i></span>
          <input type="text" class="form-control" name="username" placeholder="Email *" required>
        </div>
        <div class="input-group mb-3">
          <span class="input-group-text"><i class="bi bi-lock"></i></span>
          <input type="password" class="form-control" name="password" placeholder="Mật khẩu *" required>
        </div>
        <button type="submit" class="btn btn-primary mt-3">Đăng nhập</button>
      </form>

    </div>
    <div class="register-box">
      <h2 class="text-center">Đăng ký thành viên</h2>
      <form action="register" method="post">
        <div class="input-group mb-3">
          <span class="input-group-text"><i class="bi bi-person"></i></span>
          <input type="text" class="form-control" name="username" placeholder="Họ tên *" required>
        </div>
        <div class="input-group mb-3">
          <span class="input-group-text"><i class="bi bi-envelope"></i></span>
          <input type="email" class="form-control" name="email" placeholder="Email *" required>
        </div>
        <div class="input-group mb-3">
          <span class="input-group-text"><i class="bi bi-lock"></i></span>
          <input type="password" class="form-control" name="password" id="register-password" placeholder="Mật khẩu *" required>
          <span class="input-group-text password-toggle" onclick="togglePassword('register-password')"><i class="bi bi-eye"></i></span>
        </div>
        <div class="input-group mb-3">
          <span class="input-group-text"><i class="bi bi-lock"></i></span>
          <input type="password" class="form-control" name="confirm_password" id="confirm-password" placeholder="Nhập lại mật khẩu *" required>
          <span class="input-group-text password-toggle" onclick="togglePassword('confirm-password')"><i class="bi bi-eye"></i></span>
        </div>
        <button type="submit" class="btn btn-submit btn-register mt-3">Đăng Ký</button>
      </form>
    </div>
  </div>
</div>
<script>
  function togglePassword(id) {
    let passwordField = document.getElementById(id);
    let icon = document.querySelector(`[onclick="togglePassword('${id}')"] i`);
    passwordField.type = passwordField.type === "password" ? "text" : "password";
    icon.classList.toggle("bi-eye-slash");
  }
</script>
</body>
</html>
