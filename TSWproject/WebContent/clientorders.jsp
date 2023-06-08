<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<%
	ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
	if(client == null){
		response.sendRedirect("login.jsp");	
		return;
	}
	OrderDAO model = new OrderDAO();
	
	ArrayList<OrderBean> orders = (ArrayList<OrderBean>) request.getAttribute("ordini");
	
%>    
 
<!DOCTYPE html>
<html>

	<head>
	<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">   -->
	<meta charset="UTF-8">
	<meta content="width=device-width, initial-scale=1" name="viewport" />
	<title>I miei Ordini</title>
	
	</head>

	<body>
	  <%@ include file="/WEB-INF/header.jsp" %>
	
	<%	if(!client.getEmail().equals("JadeTear@gmail.com"))  { %>
	<!-- ------------------------------------------------------ -->
		<h1>Gli ordini di: ${client.getUsername()}</h1>
		<table>
			<tr>
				<th>Data Ordine</th>
				<th>Importo Totale</th>
				<th>Dettaglio</th>
				
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
		 <form action="clientorders" method="get">
                <input type="hidden" name="action" value="nofilter">
               	<h1> Ordini di JadeTear</h1>
		</form>
		
		 <form action="clientorders" method="post">
		 	

				<label for= "cliente"> Insert Client </label>
				<input name="cliente" type = "text"  placeholder = "user" >
				<label for= "Order By Client"> Order By Client </label>
				<input name="Order By Client" type="checkbox"  value="true">
				<br>
	
               
               	<label for= "data_da"> Insert first date </label>
				<input name = "data_da" type = "text" placeholder = "yyyy/mm/dd" >
				<label for= "data_a"> Insert second date  </label>
				<input name = "data_a" type = "text" placeholder = "yyyy/mm/dd" >
				<label for= "Order By Date"> Order By Date </label>
				<input name="Order By Date" type="checkbox"  value="true"> 
				<br>
				<input type="submit" value="Order">
				
		</form>
				
		<table>
		
			<tr>
				<th>Data Ordine</th>
				<th>Importo Totale</th>
				<th>Dettaglio</th>

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
		
		<% } %>
		
		
	</body>
</html>