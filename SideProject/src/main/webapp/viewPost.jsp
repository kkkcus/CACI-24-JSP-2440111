<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, com.Test.User" %>
<%@ page import="com.Test.DBConnection" %>

<%
    // 이미 session 내장 객체가 JSP 파일에서 제공됩니다.
    User user = (User) session.getAttribute("user");
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");

    // 게시글 정보 초기화
    int postId = Integer.parseInt(request.getParameter("id"));
    String postTitle = "";
    String postAuthor = "";
    String postContent = "";
    Timestamp postCreatedAt = null;

    try (Connection connection = DBConnection.getConnection()) {
        // 게시글 데이터 가져오기
        String query = "SELECT * FROM Posts WHERE id = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setInt(1, postId);
        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {
            postTitle = resultSet.getString("title");
            postAuthor = resultSet.getString("author");
            postContent = resultSet.getString("content");
            postCreatedAt = resultSet.getTimestamp("created_at");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title><%= postTitle %></title>
    <link rel="stylesheet" href="css/viewPost1.css">
</head>
<body>
    <div class="post-container">
        <div class="post-header">
            <h1 class="post-title"><%= postTitle %></h1>
            <div class="post-meta">
                <span>작성자: <%= postAuthor %></span>
                <span style="float: right;">작성 시간: <%= postCreatedAt %></span>
            </div>
        </div>
        <div class="post-content">
            <p><%= postContent %></p>
        </div>
        <div class="post-actions">
            <% 
                // 관리자거나 본인인 경우에만 삭제 버튼 표시
                if ((user != null && user.getName().equals(postAuthor)) || (isAdmin != null && isAdmin)) { 
            %>
                <form action="deletePost" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= postId %>">
                    <button type="submit" class="delete-btn">삭제</button>
                </form>
            <% } %>
        </div>
        <div>
            <a href="board.jsp" class="back-btn">목록으로 돌아가기</a>
        </div>
    </div>
</body>
</html>
