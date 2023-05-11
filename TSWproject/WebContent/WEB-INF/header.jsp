<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>

</head>
<body>
<header>

<h1>JadeTear</h1>

<% if (session.getAttribute("utente") == null) { %>

<a href="login.jsp"> Login </a>
<a href="registration.jsp"> Register </a>

<% } else { %>

<p> Hello ${utente.username}! </p>

<% } %>



</header>
</body>
</html>
