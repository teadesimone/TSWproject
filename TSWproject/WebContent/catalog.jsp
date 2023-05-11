<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<%
List<JewelBean> products = (ArrayList<JewelBean>) request.getAttribute("products");
if(products == null) {
    response.sendRedirect("./createCatalog");
    return;
} %>

<!DOCTYPE html>
<html>

<head>
    <title> JadeTear Catalog </title>
</head>

<body>
	<%@include file="/WEB-INF/header.jsp" %>
    <h2>Our Catalog</h2>
    <table border = "1">
        <tr>
            <th>Name</th>
            <th>Image</th>
            <th>Description</th>
            <th>Price</th>
            <th>Detailed Description</th>
            <th>Add to Cart</th>
        </tr>
        <% for(JewelBean j: products){ %>
            <tr>
                <td><%=j.getNome() %></td>
                <td><img src= "<%= "images//" + j.getImmagine() %>" alt="<%=j.getNome() %>" width="90"  height="90"></td>
                <td><%=j.getDescrizione() %></td>
                <td><%=j.getPrezzo() %></td>
                <td><a href="details?id=<%=j.getId()%>"> Show Details</a><br></td>
                <td><a href="cart?action=add&id=<%=j.getId()%>"> Add to Cart</a><br></td>
            </tr>
            <% } %>
    </table>
    <a href="cart"> Cart </a>
    <%@include file="/WEB-INF/footer.jsp" %>
</body>

</html>
