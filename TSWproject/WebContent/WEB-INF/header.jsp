<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lan="en">
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
    	nav ul{
    		list-style-type: none;
    	}
    	nav ul li{
    		display: inline;
    		padding: 5px;
    	}
    </style>
</head>
<body>
<header>

	<h1>JadeTear</h1>

	<% if (session.getAttribute("utente") != null) { %>
		<p> Hello ${utente.username}! </p>
	<% } %>
	
	<nav>
		<ul>
			<li><a href="home.jsp">  Home  </a></li>
			<li><a href="catalog.jsp">  Catalog  </a></li>
			<li><a href="menu.jsp">  Menu  </a></li>
			<li><a href="cart">  Cart  </a></li>
			<li><a href="personalized.jsp">  Customize your jewel  </a></li>
		</ul>
	</nav>
	
</header>
</body>
</html>
