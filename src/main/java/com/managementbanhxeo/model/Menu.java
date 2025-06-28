package com.managementbanhxeo.model;

public class Menu {
    private int menuId;
    private String name;
    private double price;
    private String imageUrl;
    private int likes;
    private int quantity;
    private String category;

    public Menu() {}

    public Menu(String name, double price, String imageUrl, int likes, String category) {
        this.name = name;
        this.price = price;
        this.imageUrl = imageUrl;
        this.likes = likes;
        this.quantity = 0; // Mặc định quantity là 0
        this.category = category;
    }

    public Menu(int menuId, String name, double price, String imageUrl, int likes, String category) {
        this.menuId = menuId;
        this.name = name;
        this.price = price;
        this.imageUrl = imageUrl;
        this.likes = likes;
        this.quantity = 0; // Mặc định quantity là 0
        this.category = category;
    }

    // Getters and setters
    public int getMenuId() { return menuId; }
    public void setMenuId(int menuId) { this.menuId = menuId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public int getLikes() { return likes; }
    public void setLikes(int likes) { this.likes = likes; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
}