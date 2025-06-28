package com.managementbanhxeo.model;

import java.util.Date;
import java.util.List;

public class Order {
    private int orderId;
    private int userId;
    private double totalAmount;
    private String status;
    private Date orderDate;
    private String username;
    private List<OrderDetail> orderDetails;
    private String note; // Thêm thuộc tính note

    public Order() {}

    public Order(int orderId, int userId, double totalAmount, String status, Date orderDate, String username, List<OrderDetail> orderDetails, String note) {
        this.orderId = orderId;
        this.userId = userId;
        this.totalAmount = totalAmount;
        this.status = status;
        this.orderDate = orderDate;
        this.username = username;
        this.orderDetails = orderDetails;
        this.note = note; // Gán giá trị note
    }

    // Getters and setters
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public List<OrderDetail> getOrderDetails() { return orderDetails; }
    public void setOrderDetails(List<OrderDetail> orderDetails) { this.orderDetails = orderDetails; }
    public String getNote() { return note; } // Thêm getter
    public void setNote(String note) { this.note = note; } // Thêm setter
}