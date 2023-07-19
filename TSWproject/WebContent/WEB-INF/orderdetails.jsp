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
	<link rel="stylesheet" type="text/css" href="./styles/tableStyle.css">
	<meta content="width=device-width, initial-scale=1" name="viewport" />
	
	<title>Order Details</title>
	
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
				cursor: pointer;
				border-radius: 20px;
				font-size:8px;
                width: 80px;
                height: 20px;
			}

			input[type="submit"]:hover {
				background-color: #84A8A1;
				color: #fff;
				border: none;
				padding: 5%;
				margin-top: 2px;
				cursor: pointer;
				font-size:5px;
			}

			#goBack {
			    margin-top: 5px;
			    cursor: pointer;
			    border-radius: 20px;
			    text-decoration: none;
			    font-size:8px;
                width: 20px;
                height: 10px;
			}
			
		}

	</style>
	
</head>

<body>
	<%@include file="header.jsp" %>
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
		<a href="clientorders" id="goBack"><i class="fa fa-angle-double-left" aria-hidden="true"></i>Go back</a></p>

		<%@include file="footer.jsp" %>
	</body>
	</html>