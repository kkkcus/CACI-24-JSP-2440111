<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, com.Test.User" %>
<%@ page import="com.Test.DBConnection" %>

<%
    // 로그인한 사용자 확인
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("loginpage.html");
        return;
    }

    // 게시글 ID 가져오기
    int postId = Integer.parseInt(request.getParameter("id"));
    String postTitle = "";
    String postContent = "";

    try (Connection connection = DBConnection.getConnection()) {
        // 게시글 데이터 가져오기
        String query = "SELECT * FROM Posts WHERE id = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setInt(1, postId);
        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {
            postTitle = resultSet.getString("title"); // 제목
            postContent = resultSet.getString("content"); // 내용
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 수정</title>
    <link rel="stylesheet" href="css/writePost1.css">
</head>
<body>
    <div class="post-form-container">
        <h1>게시글 수정</h1>
        <form action="editPost" method="post">
            <input type="hidden" name="id" value="<%= postId %>">
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" value="<%= postTitle %>" required>
            </div>
            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="content" name="content" required><%= postContent %></textarea>
            </div>
            <div class="form-buttons">
                <button type="submit" class="submit-btn">수정</button>
                <a href="viewPost.jsp?id=<%= postId %>" class="cancel-btn">취소</a>
            </div>
        </form>
    </div>
</body>
</html>
