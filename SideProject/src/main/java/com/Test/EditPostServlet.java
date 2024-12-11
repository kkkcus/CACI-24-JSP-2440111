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
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/editPost")
public class EditPostServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("loginpage.html");
            return;
        }

        int postId = Integer.parseInt(request.getParameter("id"));
        String newTitle = request.getParameter("title");
        String newContent = request.getParameter("content");

        try (Connection connection = DBConnection.getConnection()) {
            // 작성자 확인 쿼리
            String authorQuery = "SELECT author FROM Posts WHERE id = ?";
            PreparedStatement authorStatement = connection.prepareStatement(authorQuery);
            authorStatement.setInt(1, postId);
            ResultSet resultSet = authorStatement.executeQuery();

            if (resultSet.next()) {
                String postAuthor = resultSet.getString("author");
                if (!user.getName().equals(postAuthor)) {
                    response.getWriter().write("권한이 없습니다.");
                    return;
                }
            } else {
                response.getWriter().write("존재하지 않는 게시글입니다.");
                return;
            }

            // 수정 처리
            String updateQuery = "UPDATE Posts SET title = ?, content = ? WHERE id = ?";
            PreparedStatement updateStatement = connection.prepareStatement(updateQuery);
            updateStatement.setString(1, newTitle);
            updateStatement.setString(2, newContent);
            updateStatement.setInt(3, postId);
            updateStatement.executeUpdate();

            response.sendRedirect("viewPost.jsp?id=" + postId);
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("수정 중 오류가 발생했습니다.");
        }
    }
}
