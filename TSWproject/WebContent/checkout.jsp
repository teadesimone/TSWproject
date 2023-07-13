<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, it.unisa.model.*"%>
    
    <%ArrayList<AddressBean> addresses = (ArrayList<AddressBean>) request.getAttribute("addresses");
      ArrayList<PaymentMethodBean> payments = (ArrayList<PaymentMethodBean>) request.getAttribute("payments");
      
      String error = (String) request.getAttribute("error");
    %>


<!DOCTYPE html>
<html lang="en">
	<head>
		<meta content="width=device-width, initial-scale=1" name="viewport" />
		<meta charset="UTF-8">
		<title>Checkout</title>
		<!-- <link rel="stylesheet" href="styles/formStyle.css" type="text/css"> -->
	</head>
	<body>
 <%@include file="/WEB-INF/header.jsp" %>
	<h1>Checkout</h1>

    
    <form action="payment" method="post" onsubmit="event.preventDefault(); validate(this)">
    
      <% if (error != null){%>
                <div><%=error%></div>
        <%}%>
        
		<input type="hidden" name="action" value="confirm_buy">
        
        <br>
        <label for="destinatario">Insert addressee:</label><br>
        <input name="destinatario" type="text" maxlenght="30" required placeholder="destinatario" >
        <span id="errorDestinatario"></span>
        <br>
        
        <br>
        <label for="note">Notes:</label><br>
        <input name="note" type="text" maxlenght="100" placeholder="bla">
        <br>
        
        <br>
        <label for="spedizione">Shipping:</label><br>
       <div>
                <input type="hidden" name="action" value="spedizione">
                 <input type="radio" id ="1"  name="spedizione" value="Standard" required>
                  <label for="1">Standard Shipping (7 - 10  Business Days)</label><br>
                  <input type="radio" id="2" name="spedizione" value="Economic"  required>
                  <label for="2">Economic Shipping (12 - 15  Business Days) </label><br>
                  <input type="radio" id="3" name="spedizione" value="Express" required>
                  <label for="3">Express Shipping (3 - 5  Business Days) ( <b>€5</b> )</label><br>
                    
        </div>
        <br>
        
        <br>
         <label for="regalo">Gift:</label><br>
 		<input name="regalo" type="checkbox" value="true">
        <br>
        
          <br>
          
          <div>
                <input type="hidden" name="action" value="metodo_di_pagamento">
                <input type="radio" id ="1"  name="metodo_di_pagamento" value="carta_di_credito" required onchange="enableCard()">
                  <label for="1">Credit card</label><br>
                  <input type="radio" id="2" name="metodo_di_pagamento" value="carta_di_debito"  required onchange="enableCard()">
                  <label for="2">Charge card </label><br>
                  <input type="radio" id="3" name="metodo_di_pagamento" value="Paypal" required onchange="enableCard()">
                  <label for="3">Paypal</label><br>
                    
        </div>
        
            <label for="carta">Insert card:</label><br>
            <select name="carta" id="carta" disabled required>


         <%  for(int i=0; i<payments.size(); i++) { %>
	  
		  <option value="<%= payments.get(i).getId()%>"><%="****" + payments.get(i).getNumero_carta().substring(payments.get(i).getNumero_carta().length()-4) %></option>
		  
        <% } %> 
           
           </select>
        
        <br>
        
        <label for="indirizzo">Insert shipping address:</label><br>
         <select name="indirizzo" id="indirizzo" required>


         <%  for(int i=0; i<addresses.size(); i++) { %>
	  
		  <option value="<%= addresses.get(i).getId()%>"><%=addresses.get(i).getVia() + addresses.get(i).getCitta() %></option>
		  
	     <% } %> 
           
           </select>
        <br>
        <input type="submit" value="Pay">
        <br>
    </form>
    <%@include file="/WEB-INF/footer.jsp" %>
    
      <script>
    function validate(obj) {	
     let valid = true;	

     let addressee = document.getElementsByName("destinatario")[0];
     let errorDestinatario = document.getElementById('errorDestinatario');
     if(!checkLettere(addressee)) {
      valid = false;
      errorDestinatario.textContent = "Error: addressee must contain only alphabetic characters"; 
     } else {
      errorDestinatario.textContent = ""; 
     }
     
     if(valid) obj.submit();
    }
      
      
          function checkLettere(inputtxt) {
           let addressee = /^[A-Za-z ]+$/;
           if(inputtxt.value.match(addressee)) 
		           return true

           return false;	
          }
          
          function enableCard() {
           var radio1 = document.getElementById('1'); 
           var radio2 = document.getElementById('2'); 
           var radio3 = document.getElementById('3'); 
           var carta = document.getElementById('carta'); 

           if (radio1.value !== '' || radio2.value !== '' || radio3.value !== '' ) {  
            carta.disabled = false;  
           }
          } 
      
      </script>
</body>
</html>