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

@WebServlet("/deletePost")
public class DeletePostServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        Boolean isAdmin = (session != null) ? (Boolean) session.getAttribute("isAdmin") : false;

        if (user == null) {
            response.sendRedirect("loginpage.html");
            return;
        }

        int postId = Integer.parseInt(request.getParameter("id"));

        try (Connection connection = DBConnection.getConnection()) {
            // 게시글 작성자 확인
            String authorQuery = "SELECT author FROM Posts WHERE id = ?";
            PreparedStatement authorStatement = connection.prepareStatement(authorQuery);
            authorStatement.setInt(1, postId);
            ResultSet resultSet = authorStatement.executeQuery();

            if (resultSet.next()) {
                String postAuthor = resultSet.getString("author");

                // 관리자거나 작성자인 경우에만 삭제 가능
                if (isAdmin || user.getName().equals(postAuthor)) {
                    String deleteQuery = "DELETE FROM Posts WHERE id = ?";
                    PreparedStatement deleteStatement = connection.prepareStatement(deleteQuery);
                    deleteStatement.setInt(1, postId);
                    deleteStatement.executeUpdate();

                    response.sendRedirect("board.jsp");
                } else {
                    response.getWriter().write("권한이 없습니다.");
                }
            } else {
                response.getWriter().write("존재하지 않는 게시물입니다.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("게시물 삭제에 실패했습니다.");
        }
    }
}
