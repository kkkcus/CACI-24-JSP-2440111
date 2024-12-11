<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>로그인</title>
</head>
<body>
<% 
    String loginError = (String) request.getAttribute("loginError");
    if (loginError != null) { 
%>
    <p style="color:red;"><%= loginError %></p>
<% 
    } 
%>
<form action="login" method="post">
    <input type="email" name="email" placeholder="이메일" required>
    <input type="password" name="password" placeholder="비밀번호" required>
    <button type="submit">로그인</button>
</form>
</body>
</html>
