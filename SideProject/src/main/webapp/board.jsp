<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*, com.Test.User, com.Test.DBConnection" %>
<%
    // HttpSession 중복 정의 방지
    User user = null;
    if (session == null) {
        session = request.getSession(false);
    }
    if (session != null) {
        user = (User) session.getAttribute("user");
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Community</title>
    <link rel="stylesheet" href="css/board.css?v=2">
</head>
<body>
    <div class="board-container">
        <h1>Community</h1>
        <div class="action-buttons">
            <a href="main.jsp" class="back-btn">메인으로 돌아가기</a>
            <% if (user != null) { %>
                <a href="writePost.jsp" class="write-btn">게시글 작성</a>
            <% } %>
        </div>

        <table class="board-table">
            <thead>
                <tr>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성 시간</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try (Connection connection = DBConnection.getConnection()) {
                        String query = "SELECT * FROM Posts ORDER BY created_at DESC";
                        PreparedStatement statement = connection.prepareStatement(query);
                        ResultSet resultSet = statement.executeQuery();
                        while (resultSet.next()) {
                %>
                            <tr>
                                <td><a href="viewPost.jsp?id=<%= resultSet.getInt("id") %>"><%= resultSet.getString("title") %></a></td>
                                <td><%= resultSet.getString("author") %></td>
                                <td><%= resultSet.getTimestamp("created_at") %></td>
                            </tr>
                <%
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
