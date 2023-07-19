<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<%
	ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
	if(client == null){
		response.sendRedirect("login");	
		return;
	}

	ArrayList<OrderBean> orders = (ArrayList<OrderBean>) request.getAttribute("ordini");
		if(orders == null){
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/clientorders");
			dispatcher.forward(request, response);
		}

		String dateError = (String)request.getAttribute("dateError");
		String clientError = (String)request.getAttribute("clientError");
		%>    

		<!DOCTYPE html>
		<html lang="en">

		<head>
			<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">   -->

			<link rel="stylesheet" type="text/css" href="./styles/tableStyle.css">
			<meta charset="UTF-8">
			<meta content="width=device-width, initial-scale=1" name="viewport" />
			<title>Orders</title>
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
			<%@ include file="header.jsp" %>

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

							<td><button onclick="redirectToServlet()" id="clientbutton" value = "<%=order.getId()%>">Details <i class="fa fa-eye" aria-hidden="true"></i></button></td>
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

						<% if (clientError != null){%>
							<span><%=clientError%></span>
							<%}%>


							<label for= "data_da"> Insert first date </label>
							<input name = "data_da" type = "date" placeholder = "yyyy/mm/dd" >
							<label for= "data_a"> Insert second date  </label>
							<input name = "data_a" type = "date" placeholder = "yyyy/mm/dd" >
							<label for= "Order By Date"> Order By Date </label>
							<input name="Order By Date" type="checkbox"  value="true"> 
							<br>

							<% if (dateError != null){%>
								<span><%=dateError%></span>
								<%}%>

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

										<td><button onclick="redirectToServlet2()" id="adminbutton" value = "<%=order.getId()%>">Details <i class="fa fa-eye" aria-hidden="true"></i></button></td>
									</tr>
									<%
								}	
								%>
							</table>

							<% } %>


							<br>


							<%@include file="footer.jsp" %>

							<script>

								function redirectToServlet() {

									var id = $("#clientbutton").val();


									window.location.href = "orderdetails?ordine="+id;
								}

								function redirectToServlet2() {

									var id = $("#adminbutton").val();

									window.location.href = "orderdetails?ordine="+id;
								}

							</script>

						</body>
						</html>