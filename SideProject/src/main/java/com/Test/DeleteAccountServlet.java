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

@WebServlet("/deleteAccount")
public class DeleteAccountServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 세션 가져오기
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("loginpage.html");
            return;
        }

        // 세션에서 사용자 정보 가져오기
        Object userObj = session.getAttribute("user");
        if (userObj == null || !(userObj instanceof User)) {
            response.sendRedirect("loginpage.html");
            return;
        }

        User user = (User) userObj;

        try (Connection connection = DBConnection.getConnection()) {
            // 데이터베이스에서 사용자 삭제
            String query = "DELETE FROM Users WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, user.getId());
            statement.executeUpdate();

            // 세션 무효화
            session.invalidate();

            // 탈퇴 성공 메시지 페이지로 리디렉션
            response.sendRedirect("deleteSuccess.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("회원 탈퇴에 실패했습니다.");
        }
    }
}
