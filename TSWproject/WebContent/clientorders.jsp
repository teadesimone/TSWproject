<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<%
	ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
	if(client == null){
		response.sendRedirect("login.jsp");	
		return;
	}
	
	ArrayList<OrderBean> orders = (ArrayList<OrderBean>) request.getAttribute("ordini");
	if(orders == null){
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/clientorders");
        dispatcher.forward(request, response);
	}
%>    

<!DOCTYPE html>
<html lang="en">

	<head>
	<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">   -->
	<meta charset="UTF-8">
	<meta content="width=device-width, initial-scale=1" name="viewport" />
	<title>Orders</title>
	
	</head>

	<body>
	  <%@ include file="/WEB-INF/header.jsp" %>
	
	<%	if(!client.getEmail().equals("JadeTear@gmail.com"))  { %>
	<!-- ------------------------------------------------------ -->
		<h1> ${utente.username}'s orders</h1>
		<table>
			<tr>
				<th>  Order Date  </th>
				<th>  Total Price  </th>
				<th>  Details  </th>
				
			</tr>

			<%

			for(OrderBean order: orders){
			%>
			<tr>
				<td><%=order.getData() %></td>
				<td><%=order.getPrezzo_totale() %></td>
				<td><a href="orderdetails?ordine=<%=order.getId()%>">Dettaglio</a></td>
			</tr>
			<%
			}	
			%>
		</table>
		
		<% }else{ %>
		
	<!--	---------------------------------------------------------------- -->
		 <form action="admin" method="get">
                <input type="hidden" name="action" value="ordersNoFilter">
				<h1> JadeTear orders </h1>
		</form>
		
		 <form action="admin?action=orders" method="post">

				<label for= "cliente"> Insert Client </label>
				<input name="cliente" type = "text"  placeholder = "user" >
				<label for= "Order By Client"> Order By Client </label>
				<input name="Order By Client" type="checkbox"  value="true">
				<br>
	
               
               	<label for= "data_da"> Insert first date </label>
				<input name = "data_da" type = "date" placeholder = "yyyy/mm/dd" >
				<label for= "data_a"> Insert second date  </label>
				<input name = "data_a" type = "date" placeholder = "yyyy/mm/dd" >
				<label for= "Order By Date"> Order By Date </label>
				<input name="Order By Date" type="checkbox"  value="true"> 
				<br>
				<input type="submit" value="Order">
				
		</form>
				
		<table>
		
			<tr>
				<th> Order Date </th>
				<th> Total Price </th>
				<th> Client </th>
				<th> Details </th>
	

			</tr>
	

			<%

			for(OrderBean order: orders){
			%>
			<tr>
				<td><%=order.getData() %></td>
				<td><%=order.getPrezzo_totale() %></td>
				<td><%=order.getClient().getUsername() %></td>
				<td><a href="orderdetails?ordine=<%=order.getId()%>">Details</a></td>
			</tr>
			<%
			}	
			%>
		</table>
		
		<% } %>
		
		
		<br>
		<a href="createCatalog"> Go back </a>
		
		<%@include file="/WEB-INF/footer.jsp" %>
		
	</body>
</html>