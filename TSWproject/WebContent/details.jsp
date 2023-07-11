<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<% JewelBean j = (JewelBean) request.getAttribute("detailed");%>

<!DOCTYPE html>
<html lang ="en">

<head>
    <title> Product Details </title>
</head>

<body>
	<%@include file="/WEB-INF/header.jsp" %>
    <h1><%=j.getNome() %></h1>

    <h3>Image</h3>
    <p><img src= "<%= "images//" + j.getImmagine() %>" alt="<%=j.getNome() %>" width="90"  height="90"></p>

    <h3>Description</h3>
    <p><%=j.getDescrizione() %></p>

    <h4>Category</h4>
    <p><%=j.getCategoria() %></p>

    <h4>Material</h4>
    <p><%=j.getMateriale() %></p>

    <h4>Gemstone</h4>
    <p><%=j.getPietra() %></p>

    <h3>Price</h3>
    <p><%=j.getPrezzo() %></p>


    <br>
    <br>
    <a href="cart"> Cart </a> <br>
    <a href="cart?action=add&id=<%=j.getId()%>"> Add to Cart </a> <br>
    <a href="createCatalog"> Go Back </a> <br>

    <%@include file="/WEB-INF/footer.jsp" %>
</body>
</html>
