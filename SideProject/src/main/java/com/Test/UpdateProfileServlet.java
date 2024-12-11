package com.Test;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("loginpage.html");
            return;
        }

        User user = (User) session.getAttribute("user");

        // 기존 값 가져오기
        String currentName = user.getName();
        String currentEmail = user.getEmail();
        String currentPassword = user.getPassword();

        // 폼 데이터 가져오기
        String newName = request.getParameter("username");
        String newEmail = request.getParameter("email");
        String newPassword = request.getParameter("password");

        // 사용자가 입력하지 않은 필드는 기존 값 유지
        if (newName == null || newName.trim().isEmpty()) {
            newName = currentName;
        }
        if (newEmail == null || newEmail.trim().isEmpty()) {
            newEmail = currentEmail;
        }
        if (newPassword == null || newPassword.trim().isEmpty()) {
            newPassword = currentPassword;
        }

        try (Connection connection = DBConnection.getConnection()) {
            String query = "UPDATE Users SET username = ?, email = ?, password = ? WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, newName);
            statement.setString(2, newEmail);
            statement.setString(3, newPassword);
            statement.setInt(4, user.getId());
            statement.executeUpdate();

            // 세션 정보 업데이트
            user.setName(newName);
            user.setEmail(newEmail);
            user.setPassword(newPassword);
            session.setAttribute("user", user);

            response.sendRedirect("main.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("정보 수정에 실패했습니다.");
        }
    }
}
