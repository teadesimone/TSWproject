<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, java.sql.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<%
	OrderBean order = (OrderBean) request.getAttribute("detailedOrder");
	OrderDAO model = new OrderDAO();
	JewelDAO jewelModel = new JewelDAO();
	
%>

<!-- STAMPA: nome, immagine, personalizzato, quantità, prezzo -->

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta content="width=device-width, initial-scale=1" name="viewport" />
		<!-- <link rel="stylesheet" href="styles/orderdetails.css"> -->
		<title>Order Details <%=order.getId()%></title>
	</head>

	<body>
		<%@include file="/WEB-INF/header.jsp" %>
		<h1>
			Order date: <%=order.getData() %>
		</h1>


		<div>

			<div>
				<p>
					Total Price € <%=order.getPrezzo_totale()%>
				</p>

			</div>

			<div >
				<!-- QUA STA LA ROBA DELLA DATA DI CONSEGNA -->

				<div >
						<table>
							<tr>
								<th>Name</th>
								<th>Image</th>
								<th>Customized</th>
								<th>Quantity</th>
								<th>Price</th>
							</tr>
						<%
							
							for ( OrderProductBean prodotto : order.getProducts() ){
								 JewelBean jewel = jewelModel.doRetrieveByKey(prodotto.getId_prodotto());
								 	
								%>
							<tr>
								<td><%=jewel.getNome() %></td>
								<td><img src="<%= "images//" + jewel.getImmagine() %>" alt="<%=jewel.getNome()%>"  width="70"  height="70"></td>
								<td><%=jewel.getPersonalizzato() %></td>
								<td><%=prodotto.getQuantita() %></td>
								<td><%=prodotto.getPrezzo() %></td>
							
							</tr>
							
							<%	} %>
						</table>
						
						<form action="orderdetails?action=viewInvoice" method="post">
							<input type="hidden" name="idOrder" value="<%= order.getId() %>" >
							<input type="submit" value="View Invoice">
						</form>
						
				</div>
			</div>
			
		</div>
		
		<br>
		 <a href="clientorders"> Go back </a>
		
		<%@include file="/WEB-INF/footer.jsp" %>
	</body>
</html>