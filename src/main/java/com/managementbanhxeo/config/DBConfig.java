package com.managementbanhxeo.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConfig {
    private static final String URL = "jdbc:mysql://localhost:3306/management_banhxeo";
    private static final String USER = "root";
    private static final String PASSWORD = "01218923570Aa";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Kết nối CSDL thành công!");
        } catch (ClassNotFoundException e) {
            System.out.println("Lỗi: Driver không tìm thấy - " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Lỗi: Kết nối CSDL thất bại - " + e.getMessage());
        }
        return conn;
    }
}