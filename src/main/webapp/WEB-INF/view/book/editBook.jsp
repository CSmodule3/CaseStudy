<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
  <title>Chỉnh sửa sách</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
  <h2 class="text-center mb-4">Chỉnh sửa sách</h2>

  <form action="/managementBook" method="post" class="row g-3">
    <input type="hidden" name="action" value="edit">
    <input type="hidden" name="id" value="${book.id}">

    <div class="col-md-6">
      <label class="form-label">Tên sách</label>
      <input type="text" class="form-control" name="title" value="${book.title}" required>
    </div>

    <div class="col-md-6">
      <label class="form-label">Tác giả</label>
      <input type="text" class="form-control" name="author" value="${book.author}" required>
    </div>

    <div class="col-md-6">
      <label class="form-label">Giá (VNĐ)</label>
      <input type="number" step="0.01" class="form-control" name="price" value="${book.price}" required>
    </div>

    <div class="col-md-6">
      <label class="form-label">Số lượng</label>
      <input type="number" class="form-control" name="stock_quantity" value="${book.stockQuantity}" required>
    </div>

    <div class="col-md-6">
      <label class="form-label">Hình ảnh (URL)</label>
      <input type="text" class="form-control" name="ImageURL" value="${book.imageURL}">
    </div>

    <div class="col-md-12">
      <label class="form-label">Mô tả sách</label>
      <textarea class="form-control" name="book_description" rows="3">${book.bookDescription}</textarea>
    </div>

    <div class="col-md-6 text-center">
      <img src="${book.imageURL}" alt="Book Image" class="img-thumbnail" style="width: 150px; height: 200px;">
    </div>

    <div class="col-12 text-center">
      <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
      <a href="/managementBook" class="btn btn-secondary">Hủy</a>
    </div>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
