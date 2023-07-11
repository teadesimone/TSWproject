<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <title>Menu</title>
</head>
<body>


<h1>JadeTear</h1>

<% if (session.getAttribute("utente") == null) { %>

<a href="login.jsp"><h3> Login</h3> </a>
<a href="registration.jsp"> <h3>Register</h3> </a>


<% } else if (session.getAttribute("utente") != null && ((ClientBean) session.getAttribute("utente")).getEmail().equals("JadeTear@gmail.com")) { %>

    <a href="admin?action=ordersNoFilter"> <h3>Orders</h3> </a> <br>
    <a href="admin?action=clientsNoFilter"> <h3>Clients</h3> </a> <br>
    <a href="admin.jsp"> <h3>Admin Profile</h3> </a> <br>
    <a href="login?action=logout"> <h3>Logout</h3> </a> <br>

<% } else {%>

    <a href="clientorders"> <h3>My Orders</h3> </a> <br>
    <a href="userdetails"> <h3>My Profile</h3> </a> <br>
    <a href="login?action=logout"> <h3>Logout</h3></a> <br>

<% } %>


</body>
</html>