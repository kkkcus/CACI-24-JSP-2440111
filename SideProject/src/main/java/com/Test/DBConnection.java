package com.Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/UserManagement?useUnicode=true&characterEncoding=utf-8"; // 데이터베이스 URL
    private static final String USER = "appuser"; // MySQL 사용자 이름
    private static final String PASSWORD = "mypassword123"; // MySQL 비밀번호

    public static Connection getConnection() throws SQLException {
        try {
            // JDBC 드라이버 로드
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("Database connection failed!");
        }
    }
    
    public static void main(String[] args) {
        try (Connection connection = DBConnection.getConnection()) {
            System.out.println("Database connected successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
