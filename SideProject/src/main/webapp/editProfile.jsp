<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.Test.User" %>
<%
    User user = (session != null) ? (User) session.getAttribute("user") : null;

    if (user == null) {
        response.sendRedirect("loginpage.html");
        return;
    }

    String username = user.getName();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>정보 수정</title>
    <link rel="stylesheet" href="css/editProfile.css">
</head>
<body>
    <div class="container">
        <h1>정보 수정</h1>
        <form action="updateProfile" method="post">
            <label for="username">이름</label>
            <input type="text" id="username" name="username" placeholder="새 이름 입력">

            <label for="email">이메일</label>
            <input type="email" id="email" name="email" placeholder="새 이메일 입력">

            <label for="password">비밀번호</label>
            <input type="password" id="password" name="password" placeholder="새 비밀번호 입력">

            <button type="submit">수정 완료</button>
        </form>

        <!-- 탈퇴 버튼 추가 -->
        <form action="deleteAccount" method="post">
            <button type="submit" class="delete-btn">회원 탈퇴</button>
        </form>
    </div>
</body>
</html>
