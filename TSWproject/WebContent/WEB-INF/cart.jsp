<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<% Cart cart = (Cart) request.getSession().getAttribute("cart");
if (cart == null) {
    cart = new Cart();
    request.getSession().setAttribute("cart", cart);
   
}

 String erroredisponibilita = (String)request.getAttribute("erroredisponibilita");
 String erroresoldout = (String)request.getAttribute("erroresoldout");
%>

<!DOCTYPE html>
<html lang="en">

<head>
	<link rel="stylesheet" type="text/css" href="./styles/tableStyle.css">
    <title> Cart </title>
    <style>

        @media screen and (max-width: 700px){

            img{

                width:70px;
                height:70px;

            }

            table, th, td{
                border: none;
                font-size: 8px;
                padding:1%;

            }


            table th:first-child{
                border-radius:10px 0 0 10px;
            }

            table th:last-child{
                border-radius:0 10px 10px 0;
            }

            input[type="submit"] {
                background-color: #18020C;
                color: #fff;
                border: none;
                padding: 2%;
                margin-top: 2px;
                cursor: pointer;
                border-radius: 20px;
                font-size:5px;
            }

            input[type="submit"]:hover {
                background-color: #84A8A1;
                color: #fff;
                border: none;
                padding: 2%;
                margin-top: 2px;
                cursor: pointer;
                font-size:5px;
            }

            input[type="number"] {

                width: 15px;
            }
        }

    </style>
</head>

<body>
    <%@include file="header.jsp" %>
    <h1> Cart Details </h1>

     <% if (erroredisponibilita != null){%>
                <div><%=erroredisponibilita%></div>
        <%}%>

         <% if (erroresoldout != null){%>
                <div><%=erroresoldout%></div>
        <%}%>
    <table border = "1">
        <tr>
            <th> Image </th>
            <th> Name </th>
            <th> Price per unit </th>
            <th> Amount </th>
            <th> Operations </th>
        </tr>

        <% ArrayList<CartProduct> cartProd = cart.getProducts();
            for (CartProduct j : cartProd) { %>

            <form method = "post" action ="cart">
                <tr>
                    <td> <img src="<%= "images//" + j.getProduct().getImmagine() %>" alt="<%=j.getProduct().getNome()%>"  width="100"  height="100"> </td>
                    <td> <%=j.getProduct().getNome()%> </td>
                    <td> <%=j.getProduct().getPrezzo()%> <input type="hidden" name="id" value = "<%= j.getProduct().getId() %>"> </td>
                    <td> <input type="number" name="quantity" value= "<%= j.getQuantity() %>"> </td>
                    <td> <input type="submit" name="action" value="Modify Amount"> <br> <input type="submit" name="action" value="Delete from Cart"> <br> </td>
                </tr>

            </form>

            <% } %>
    </table>
    <!-- FORM CON ACTION BUY-->
    <form action="cart" method="post">
        <input type="hidden" name="action" value="buy">
        <input type ="submit" value="Proceed to checkout">
    </form>


    <%@include file="footer.jsp" %>
</body>
</html>
