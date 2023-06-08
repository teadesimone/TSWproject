<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, java.sql.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<%
	OrderBean order = (OrderBean) request.getAttribute("detailedOrder");
	OrderDAO model = new OrderDAO();
	JewelDAO jewelModel = new JewelDAO();
	
%>

<!-- STAMPA: nome, immagine, personalizzato, quantità, prezzo -->

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta content="width=device-width, initial-scale=1" name="viewport" />
		<!-- <link rel="stylesheet" href="styles/orderdetails.css"> -->
		<title>Dettaglio Ordine <%=order.getId()%></title>
	</head>

	<body>
		<%@include file="/WEB-INF/header.jsp" %>
		<h1>
			Ordine effettuato il: <%=order.getData() %>
		</h1>


		<div>

			<div>
				<p>
					Totale € <%=order.getPrezzo_totale()%>
				</p>


			<!-- <p class="fattura-prodotto">
					<a href="#">Scarica Fattura</a>
				</p>  -->
			</div>

			<div >
				<!-- QUA STA LA ROBA DELLA DATA DI CONSEGNA -->

				<div >
						<table>
							<tr>
								<th>Nome</th>
								<th>Immagine</th>
								<th>Personalizzato</th>
								<th>Quantità</th>
								<th>Prezzo</th>
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
				</div>
			</div>
			
		</div>

	</body>
</html>