<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<% Cart cart = (Cart) request.getSession().getAttribute("cart");
if (cart == null) {
    cart = new Cart();
    request.getSession().setAttribute("cart", cart);
} %>

<!DOCTYPE html>
<html>

<head>
    <title> Cart </title>
</head>

<body>
    <h1> Cart Details </h1>
    <table border = "1">
        <tr>
            <th>Name</th>
            <th>Price per unit</th>
            <th>Amount</th>
            <th> Operations </th>
        </tr>

        <% ArrayList<CartProduct> cartProd = cart.getProducts();
            for (CartProduct j : cartProd) { %>

            <form method = "get" action ="cart">
                <tr>
                    <td> <%=j.getProduct().getNome()%> </td>
                    <td> <%=j.getProduct().getPrezzo()%> <input type="hidden" name="id" value = "<%= j.getProduct().getId() %>"> </td>
                    <td> <input type="number" name="quantity" value= "<%= j.getQuantity() %>"> </td>
                    <td> <input type="submit" name="action" value="Modify Amount"> <br> <input type="submit" name="action" value="Delete from Cart"> <br> </td>
                </tr>
                
                <!-- <input type ="submit" name="action" value= "procedi all'ordine"> -->
            </form>

            <% } %>
    </table>
    <!-- FORM CON ACTION BUY-->
    <form action="cart" method="post">
        <input type="hidden" name="action" value="buy">
        <input type ="submit" value="procedi all'ordine">
    </form>

    <a href="createCatalog"> Go back </a>

</body>
</html>
