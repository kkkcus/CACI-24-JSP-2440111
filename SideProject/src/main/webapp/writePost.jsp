<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.Test.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("loginpage.html");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 작성</title>
    <link rel="stylesheet" href="css/writePost.css">
</head>
<body>
    <div class="write-post-container">
        <h1>게시글 작성</h1>
        <form action="createPost" method="post">
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" placeholder="제목을 입력하세요" required>
            </div>
            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="content" name="content" placeholder="내용을 입력하세요" rows="10" required></textarea>
            </div>
            <div class="form-actions">
                <button type="submit" class="submit-btn">작성</button>
                <button type="button" class="cancel-btn" onclick="location.href='board.jsp';">취소</button>
            </div>
        </form>
    </div>
</body>
</html>
