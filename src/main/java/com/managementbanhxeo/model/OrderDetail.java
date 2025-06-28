package com.managementbanhxeo.model;

public class OrderDetail {
    private int orderId;
    private int menuId;
    private int quantity;
    private double price;
    private Menu menu;

    public OrderDetail() {}

    public OrderDetail(int orderId, int menuId, int quantity, double price, Menu menu) {
        this.orderId = orderId;
        this.menuId = menuId;
        this.quantity = quantity;
        this.price = price;
        this.menu = menu;
    }

    // Getters and setters
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public int getMenuId() { return menuId; }
    public void setMenuId(int menuId) { this.menuId = menuId; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public Menu getMenu() { return menu; }
    public void setMenu(Menu menu) { this.menu = menu; }
}