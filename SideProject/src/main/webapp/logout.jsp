<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    session.invalidate(); // 세션 무효화
    response.sendRedirect("main.jsp"); // 로그아웃 후 로그인 페이지로 이동
%>
