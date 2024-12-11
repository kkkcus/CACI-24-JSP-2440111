<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.Test.User" %>
<%
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE-edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Name one genius that ain't crazy</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
    <link rel="stylesheet" href="css/style.css">
    <script defer src="js/ie.js"></script>
</head>
<body>
<header>
    <div class="inner">
        <h1><a href="#">KANYE WEST</a></h1>
        
        <ul id="gnb">
            <li><a href="#">RECAP</a></li>
            <li><a href="#">GALLERY</a></li>
            <li><a href="#">YOUTUBE</a></li>
            <li><a href="board.jsp">COMMUNITY</a></li>
            <li><a href="#">LOCATION</a></li>
        </ul>
        
        <ul class="util">
            <li><a href="member1.html">CONTACT</a></li>
            <li><a href="#">HELP</a></li>
            <% if (user != null) { %>
                <li><a href="#">Welcome, <%= user.getName() %></a></li>
                <li><a href="logout.jsp">LOGOUT</a></li>
                <li><a href="editProfile.jsp">EDIT PROFILE</a></li>
            <% } else { %>
                <li><a href="loginpage.html">LOGIN</a></li>
                <li><a href="register.jsp">JOIN</a></li>
            <% } %>
        </ul>
    </div>
</header>
<figure>
    <video src="img/visual.mp4" autoplay muted loop></video>
    <div class="inner">
        <h1>Name one genius that ain't crazy</h1>
        <p>The best producer in the history of hip-hop and music.<br>
           You can't be a genius without being crazy.</p>
        <a href="#">VIEW DETAIL</a>
    </div>
</figure>
</body>
</html>
