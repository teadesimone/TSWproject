<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lan="en">
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<header>

<h1>JadeTear</h1>

<% if (session.getAttribute("utente") != null) { %>


<p> Hello ${utente.username}! </p>

<% } %>

<a href="home.jsp">  Home  </a> &nbsp
<a href="catalog.jsp">  Catalog  </a> &nbsp
<a href="menu.jsp">  Menu  </a> &nbsp
<a href="cart">  Cart  </a> &nbsp
<a href="personalized.jsp">  Customize your jewel  </a> &nbsp &nbsp &nbsp 


</header>


    

</body>
</html>
