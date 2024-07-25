package com.projectA.repository.vo;

public class UserVo {

    // User-related fields
    private long userNo;
    private String name;
    private String password;
    private String branchId; // This will be used for both user and order context
    private String authCode;
    private String tokenizedPassword; // New field to store tokenized password

    // Order-related fields
    private long orderId;
    private String orderDate;
    private int checked; // Changed to String to match SQL query result
    private String bookName;
    private int quantity;

    // Default constructor
    public UserVo() {
    }

    // Constructor for User-related information
    public UserVo(long userNo, String name, String password, String branchId, String authCode) {
        this.userNo = userNo;
        this.name = name;
        this.password = password;
        this.branchId = branchId;
        this.authCode = authCode;
    }

    // Constructor for User-related information (without password)
    public UserVo(long userNo, String name, String branchId, String authCode) {
        this.userNo = userNo;
        this.name = name;
        this.branchId = branchId;
        this.authCode = authCode;
    }

    // Constructor for Order-related information
	/*
	 * public UserVo(long orderId, String branchId, Date orderDate, String bookName,
	 * int quantity, String checked) { this.orderId = orderId; this.branchId =
	 * branchId; this.orderDate = orderDate; this.bookName = bookName; this.quantity
	 * = quantity; this.checked = checked; }
	 */

    // Constructor for Order-related information (minimal)
    public UserVo(long orderId, String orderDate, int checked) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.checked = checked;
    }

    // Getters and Setters for User-related fields
    public long getNo() {
        return userNo;
    }

    public void setNo(long no) {
        this.userNo = userNo;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getBranchId() {
        return branchId;
    }

    public void setBranchId(String branchId) {
        this.branchId = branchId;
    }

    public String getAuthCode() {
        return authCode;
    }

    public void setAuthCode(String authCode) {
        this.authCode = authCode;
    }

    public String getTokenizedPassword() {
        return tokenizedPassword;
    }

    public void setTokenizedPassword(String tokenizedPassword) {
        this.tokenizedPassword = tokenizedPassword;
    }

    // Getters and Setters for Order-related fields
    public long getOrderId() {
        return orderId;
    }

    public void setOrderId(long orderId) {
        this.orderId = orderId;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public int getChecked() {
        return checked;
    }

    public void setChecked(int checked) {
        this.checked = checked;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "UserVo [userNo=" + userNo + ", name=" + name + ", password=" + password + ", branchId=" + branchId
                + ", authCode=" + authCode + ", tokenizedPassword=" + tokenizedPassword + ", orderId=" + orderId
                + ", orderDate=" + orderDate + ", checked=" + checked + ", bookName=" + bookName + ", quantity="
                + quantity + "]";
    }
}
