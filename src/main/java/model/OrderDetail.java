package model;

public class OrderDetail {
    private int id;
    private int orderId;
    private int bookId;
    private int quantity;
    private String fullName;
    private String phoneNumber;
    private String provinceCity;
    private String district;
    private String ward;
    private String street;
    private String noteOrder;
    private String paymentMethod;
    private String status; // Thêm trạng thái

    // Constructor đầy đủ
    public OrderDetail(int id, int orderId, int bookId, int quantity,
                       String fullName, String phoneNumber, String provinceCity,
                       String district, String ward, String street,
                       String noteOrder, String paymentMethod, String status) {
        this.id = id;
        this.orderId = orderId;
        this.bookId = bookId;
        this.quantity = quantity;
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.provinceCity = provinceCity;
        this.district = district;
        this.ward = ward;
        this.street = street;
        this.noteOrder = noteOrder;
        this.paymentMethod = paymentMethod;
        this.status = status;
    }

    public String getAddress() {
        return street + ", " + ward + ", " + district + ", " + provinceCity;
    }


    // Getters và Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getProvinceCity() {
        return provinceCity;
    }

    public void setProvinceCity(String provinceCity) {
        this.provinceCity = provinceCity;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getWard() {
        return ward;
    }

    public void setWard(String ward) {
        this.ward = ward;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getNoteOrder() {
        return noteOrder;
    }

    public void setNoteOrder(String noteOrder) {
        this.noteOrder = noteOrder;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}