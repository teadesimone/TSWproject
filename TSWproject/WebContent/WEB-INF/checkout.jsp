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
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   <link rel="stylesheet" href="styles/formStyle.css" type="text/css">

   <style>
    .grid-container {
     display: grid;
     grid-template-columns: auto ;
     grid-template-rows: auto auto auto;
     gap: 60px;
     background: rgba(250,250,250);
    }

    .grid-container > div {
     font-size: 30px;
    }
   
   
    .container{
     display: grid;
     grid-template-columns: 15% 70% 15%;
     width: 100%;
    }

    .transparentCard{
     grid-column:  2/3;
     display: grid;
     grid-template-columns: 1fr;
     grid-template-rows: 10% 70% 20%;
     height:100%;
     width:100%;
     display: flex;
     justify-content: center;
     align-items: center;
     flex-direction: column;
     gap: 20px;

    }


    .title{

     grid-column: 2;
     grid-row: 1;
     width:100%;
     height:100%;
     margin: auto;
     bottom: 30px;
     text-align:center;
    }

    .submitContainer{
     text-align:center;
     grid-row: 3;
    }

    .submit{
     height: 200%;
     width: 400%;
     padding:10%;
     margin: auto;
    }

    .inputBox{
     width: 55%;
     display: inline-flex;
     justify-content: center;
     align-items: center;
     flex-direction: column;
    }

    .special{
     width: 55%;
     display: flex;
     justify-content: center;
     align-items: center;
     flex-direction: row;
    }

    .inputBox input[type="radio"]{
     border: 0px;
     width: 100%;
     height: 1em;
    }
    
    .inputBox input[type="checkbox"]{
     border: 0px;
     width: 100%;
     height: 2em;
    }


    .error{
     transform: translateY(-100%);
    }

    @media only screen and (max-width: 900px){ 
     .container{
      grid-template-columns: 1fr 5fr 1fr;
     }
     .transparentCard{
      width:100%;
     }
    }

    @media only screen and (max-width: 480px){ 
     .container{
      grid-template-columns: 1fr;
     }

     .transparentCard{
      grid-column:1;
      grid-template-columns: 1fr;
      grid-template-rows: 1fr 3fr 1fr;
      width:100%;
     }

     .title{
      grid-column:1;
      grid-row: 1;
     }

     .submitContainer{
      grid-column: 1;
      grid-row: 3;
     }

    }

   </style>

  </head>
  <body>
   
   <div class="grid-container">
    <div class="header" >
     <%@include file="/WEB-INF/header.jsp" %></div>

   <form action="payment" method="post" onsubmit="event.preventDefault(); validate(this)">  
    <div class="container">
     <div class="transparentCard">
      <span class="title">Checkout</span> 

      <% if (error != null){%>
       <div class="errorNoTranslate"><%=error%></div>
       <%}%>

       <input type="hidden" name="action" value="confirm_buy">

       <div class="inputBox">
        <span class="error" id="errorDestinatario"></span>
        <input id="destinatario" name="destinatario" type="text" maxlenght="30" required autocomplete="off" placeholder="destinatario" >
        <label id="destinatarioLabel" for="destinatario">Insert addressee:</label>
       </div>

       <div class="inputBox">
        <input name="note" type="text" maxlenght="100" autocomplete="off" placeholder="Insert notes...">
        <label for="note">Notes:</label>
       </div>

       <div class="inputBox special">
        <label for="spedizione">Shipping:</label>
        <input type="hidden" name="action" value="spedizione">
        <input type="radio" id ="1"  name="spedizione" value="Standard" required>
        <label for="1">Standard Shipping (7 - 10  Business Days)</label>
        <input type="radio" id="2" name="spedizione" value="Economic"  required>
        <label for="2">Economic Shipping (12 - 15  Business Days) </label>
        <input type="radio" id="3" name="spedizione" value="Express" required>
        <label for="3">Express Shipping (3 - 5  Business Days) ( <b>€5</b> )</label>    
       </div>


       <div class="inputBox special">
        <label for="regalo">Gift:</label><br>
        <input name="regalo" type="checkbox" value="true">
       </div> 

       <div class="inputBox special">
        <input type="hidden" name="action" value="metodo_di_pagamento">
        <input type="radio" id ="1"  name="metodo_di_pagamento" value="carta_di_credito" required onchange="enableCard()">
        <label for="1">Credit card</label>
        <input type="radio" id="2" name="metodo_di_pagamento" value="carta_di_debito"  required onchange="enableCard()">
        <label for="2">Charge card </label>
        <input type="radio" id="3" name="metodo_di_pagamento" value="Paypal" required onchange="enableCard()">
        <label for="3">Paypal</label>       
       </div>

       <div class="inputBox special">
        <label for="carta">Insert card:</label>
        <select name="carta" id="carta" disabled >

         <%  for(int i=0; i<payments.size(); i++) { %>
          <option value="<%= payments.get(i).getId()%>"><%="****" + payments.get(i).getNumero_carta().substring(payments.get(i).getNumero_carta().length()-4) %></option>
          <% } %> 

         </select>
        </div>

        <div class="inputBox special">
         <label for="indirizzo">Insert shipping address:</label><br>
         <select name="indirizzo" id="indirizzo" >

          <%  for(int i=0; i<addresses.size(); i++) { %>
           <option value="<%= addresses.get(i).getId()%>"><%=addresses.get(i).getVia() + addresses.get(i).getCitta() %></option>
           <% } %> 

          </select>
         </div>

         <div class="submitContainer">
          <input class="submit" type="submit" value="Pay">
         </div>
        </div>
       </div>
      </form>

      <div class="footer">
       <%@include file="/WEB-INF/footer.jsp" %>
      </div>

     </div>     
      
      <script>
       $(document).ready(function () {

        $("#destinatario").on("input", function() {
         if ($("#destinatario").val().length !== 0)
                $("#destinatarioLabel").addClass("notEmpty");
                else
                $("#destinatarioLabel").removeClass("notEmpty");
        });

       })
      
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