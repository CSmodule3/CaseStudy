<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.CartItem" %>
<%@ page session="true" %>

<%
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    if (cart == null) {
        cart = new java.util.ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Giỏ hàng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<!-- Header -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">
        <a class="navbar-brand" href="#">Pibook Clone</a>
        <button class="btn btn-primary">Giỏ hàng (<%= cart.size() %>)</button>
    </div>
</nav>

<!-- Giỏ hàng -->
<div class="container mt-4">
    <h2>Giỏ hàng của bạn</h2>

    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Ảnh</th>
            <th>Tên sản phẩm</th>
            <th>Giá</th>
            <th>Số lượng</th>
            <th>Thành tiền</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <%
            double total = 0;
            for (CartItem item : cart) {
                double subtotal = item.getPrice() * item.getQuantity();
                total += subtotal;
        %>
        <tr>
            <td><img src="<%= item.getImage() %>" alt="Ảnh sản phẩm" width="50"></td>
            <td><%= item.getName() %></td>
            <td><%= String.format("%,.0f", item.getPrice()) %> đ</td>
            <td>
                <form action="cart" method="post">
                    <input type="hidden" name="id" value="<%= item.getId() %>">
                    <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1" class="form-control">
                    <button type="submit" class="btn btn-sm btn-primary">Cập nhật</button>
                </form>
            </td>
            <td><%= String.format("%,.0f", subtotal) %> đ</td>
            <td>
                <a href="cart?action=remove&id=<%= item.getId() %>" class="btn btn-danger btn-sm">Xóa</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <h4>Tổng cộng: <%= String.format("%,.0f", total) %> đ</h4>

    <a href="cart.jsp" class="btn btn-secondary">Mua tiếp</a>
    <a href="orderpage.jsp" class="btn btn-success">Thanh toán</a>
</div>

</body>
</html>
