<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>
    
<%ArrayList<AddressBean> addresses = (ArrayList<AddressBean>) request.getAttribute("addresses");
  ArrayList<PaymentMethodBean> payments = (ArrayList<PaymentMethodBean>) request.getAttribute("payments");
  ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
  if(client == null){
		response.sendRedirect("login.jsp");	
		return;
	}
  
  ArrayList<ClientBean> clients = (ArrayList<ClientBean>) request.getAttribute("clienti");
  
  String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang= "en">
<head>
        <title>User page</title>
</head>
<body>
        <%@include file="/WEB-INF/header.jsp" %>
<!-- -------------------- ADMIN --------------------- -->

    <%
        if(client.getEmail().equalsIgnoreCase("JadeTear@gmail.com")) {   %>

        
          <form action="admin" method="get">
        <input type="hidden" name="action" value="clientsNoFilter">
	<h1> JadeTear clients </h1>
    </form>

    <form action="admin?action=ByClient" method="post">

        <label for= "cliente"> Insert Client Username </label>
	<input name="cliente" type = "text"  placeholder = "user" >
	<input type="submit" value="Order"> <br>
    <a href="admin?action=clientsNoFilter" > <h4> Reset </h4></a>
	<br>

    </form>

    <table>

        <tr>
	       <th> Name </th>
	       <th> Surname </th>
           <th> Username </th>
	       <th> Cellphone Number</th>
           <th> Email </th>
           
        </tr>


	<% for(ClientBean cliente: clients){ %>

		<tr>
			<td><%=cliente.getNome() %></td>
			<td><%=cliente.getCognome() %></td>
			<td><%=cliente.getUsername() %></td>
            <td><%=cliente.getTelefono() %></td>
            <td><%=cliente.getEmail() %></td>
		<td></td>
	</tr>
	<% } %>
    </table>

    
        
<!-- -------------------- UTENTE -------------------- -->

<%    }else{  %>
  
	<h1>User Profile</h1>

    <form action="userdetails?action=modify" method="post" onsubmit="event.preventDefault(); validate(this)">
        
        <% if (error != null){%>
        <div><%=error%></div>
        <%}%>

        <h3>Modify your account</h3>    
    
        <br>
        <label for="email">Email:</label><br>
        <input name="email" type="email" maxlength="30" required value="<%=client.getEmail() %>">
        <span id="errorEmail"></span>
        <br>

        <br>
        <label for="nome">Name:</label><br>
        <input name="nome" type="text" maxlength="30" required value="<%=client.getNome() %>">
        <span id="errorNome"></span>
        <br>

        <br>
        <label for="cognome">Surname:</label><br>
        <input name="cognome" type="text" maxlength="30" required value="<%=client.getCognome() %>">
        <span id="errorCognome"></span>
        <br>

        <br>
        <label for="cf">CF:</label><br>
        <input name="cf" type="text" maxlength="16" required value="<%=client.getCf() %>">
        <span id="errorCf"></span>
        <br>

        <br>
        <label for="indirizzo">Street:</label><br>
        <input name="indirizzo" type="text" maxlength="50" required value="<%=client.getVia() %>">
        <span id="errorIndirizzo"></span>
        <br>

        <br>
        <label for="citta">City:</label><br>
        <input name="citta" type="text" maxlength="40" required value="<%=client.getCitta() %>">
        <span id="errorCitta"></span>
        <br>

        <br>
        <label for="provincia">Province:</label><br>
        <input name="provincia" type="text" maxlength="40" required value="<%=client.getProvincia() %>">
        <span id="errorProvincia"></span>
        <br>

        <br>
        <label for="cap">CAP:</label><br>
        <input name="cap" type="text" maxlength="5" required value="<%=client.getCap() %>">
        <span id="errorCap"></span>
        <br>

        <br>
        <label for="telefono">Cellphone number:</label><br>
        <input name="telefono" type="text" maxlength="12" required value="<%=client.getTelefono() %>">
        <span id="errorTelefono"></span>
        <br>

        <br>
        <input type="submit" value="Submit">
        <br>
    </form> <br>
    
    <!--
    <form>
        QUI SERVE UN FORM SISTEMATO PER MODIFICARE LA PASSWORD
    </form>
    -->
   
   
   	<h3>Delete your cards</h3><br>
   
    <% if (payments != null){ %>
  
            
         <%  for(int i=0; i<payments.size(); i++) { %>
             
             <form action="userdetails?action=deletePaymentCard" method="post">
                        
             <label for="payment" ><%="****" + payments.get(i).getNumero_carta().substring(payments.get(i).getNumero_carta().length()-4) %></label>
				<input type="hidden" name="id_carta" value = "<%= payments.get(i).getId()%>">
                <input type= "submit" value="Delete this card" id = "payment"><br>
                
            </form>

        <% } %> 

     <br>
      
    <% } %>
    
    <form action="userdetails?action=addPaymentCard" method="post" onsubmit="event.preventDefault(); validate_payment(this)">
    
        <h3>Add here your cards</h3> 
        
        <!-- aggiungi carta alla sessione -->
        
        <br>
            <label for="numero_carta">Card number:</label><br>
            <input name="numero_carta" type="text" maxlength="50" required placeholder="enter name">
            <span id="errorNumero_carta"></span>
        <br>
        
        <br>
            <label for="cvv">Cvv:</label><br>
            <input name="cvv" type="text" maxlength="50" required placeholder="123">
            <span id="errorCvv"></span>
        <br>
        
        <br>
            <label for="data_scadenza">Expiration Date:</label><br>
            <input name="data_scadenza" type="date" maxlength="50" required placeholder="dd/mm/yyyy">
            <span id="errorData_scadenza"></span>
        <br>
        
        <br>
            <label for="circuito">Card Network:</label><br>
            <select name="circuito" id="circuito">
                <option value="PayPal"> Paypal </option>
                <option value="Mastercard">MasterCard </option>
                <option value="VISA">VISA </option>
                <option value="PostePay">Postepay </option>
                <option value="American Express">American Express </option>
                <option value="Bancomat">Bancomat </option>
            </select>
        <br>
        
        <input type="submit" value="Add">
        
    </form><br>
    
    	<h3>Delete your addresses</h3><br>
    
    <% if (addresses != null){ %>
    
   
         <%  for(int i=0; i<addresses.size(); i++) { %>
                        
                <form action="userdetails?action=deleteAddress" method="post">
                   
                 
                <label for="address"><%=addresses.get(i).getVia() + " " + addresses.get(i).getCitta() %></label>
				<input type="hidden" name="id_indirizzo" value = "<%= addresses.get(i).getId()%>">
                <input type= "submit" value="Delete this address"  id ="address"><br>
                
                </form>

        <% } %> 

    <br>
    
    <% } %>
    
    <form action="userdetails?action=addAddress" method="post" onsubmit="event.preventDefault(); validate_address(this)">

        <h3>Add here your addresses</h3>   
        
        
        <br>
            <label for="via_indirizzo">Street:</label><br>
            <input name="via_indirizzo" type="text" maxlength="50" required placeholder="Enter Street">
            <span id="errorVia_indirizzo"></span>
        <br>

        <br>
            <label for="citta_indirizzo">City:</label><br>
            <input name="citta_indirizzo" type="text" maxlength="50" required placeholder="London">
            <span id="errorCitta_indirizzo"></span>
        <br>

        <br>
            <label for="CAP_indirizzo">CAP:</label><br>
            <input name="CAP_indirizzo" type="text" maxlength="50" required placeholder="00000">
            <span id="errorCAP_indirizzo"></span>
        <br>
        
        <input type=submit value="Add">
        
        
    </form>
    
    
<% } %>
  
    
  
    
      <script>
    function validate(obj) {	
        let valid = true;	

        let email = document.getElementsByName("email")[0];    
        let errorEmail = document.getElementById('errorEmail');
        if(!checkEmail(email)) {
            valid = false;
            errorEmail.textContent = "Error: invalid email address"; 
        } else {
            errorEmail.textContent = ""; 
        }

       //aggiungi form password

       let name = document.getElementsByName("nome")[0];
       let errorNome = document.getElementById('errorNome');
        if(!checkLettere(name)) {
            valid = false;
            errorNome.textContent = "Error: name must contain only alphabetic characters"; 
        } else {
            errorNome.textContent = ""; 
        }

        let surname = document.getElementsByName("cognome")[0];
        let errorCognome = document.getElementById('errorCognome');
        if(!checkLettere(surname)) {
            valid = false;
            errorCognome.textContent = "Error: surname must contain only alphabetic characters"; 
        } else {
            errorCognome.textContent = ""; 
        }

        let cf = document.getElementsByName("cf")[0];
        let errorCf = document.getElementById('errorCf');
        if(!checkCf(cf)) {
            valid = false;
            errorCf.textContent = "Error: invalid CF format"; 
        } else {
            errorCf.textContent = ""; 
        }

        let indirizzo = document.getElementsByName("indirizzo")[0];
        let errorIndirizzo = document.getElementById('errorIndirizzo');
        if(!checkIndirizzo(indirizzo)) {
            valid = false;
            errorIndirizzo.textContent = "Error: invalid street format"; 
        } else {
            errorIndirizzo.textContent = ""; 
        }

        let citta = document.getElementsByName("citta")[0];
        let errorCitta = document.getElementById('errorCitta');
        if(!checkLettere(citta)) {
            valid = false;
            errorCitta.textContent = "Error: city must contain only alphabetic characters"; 
        } else {
            errorCitta.textContent = ""; 
        }

        let provincia = document.getElementsByName("provincia")[0];
        let errorProvincia = document.getElementById('errorProvincia');
        if(!checkLettere(provincia)) {
            valid = false;
            errorProvincia.textContent = "Error: province must contain only alphabetic characters"; 
        } else {
            errorProvincia.textContent = ""; 
        }

        let cap = document.getElementsByName("cap")[0];
        let errorCap = document.getElementById('errorCap');
        if(!checkCap(cap)) {
            valid = false;
            errorCap.textContent = "Error: CAP must contain 5 numbers"; 
        } else {
            errorCap.textContent = ""; 
        }

        let telefono = document.getElementsByName("telefono")[0];    
        let errorTelefono = document.getElementById('errorTelefono');
        if(!checkTelefono(telefono)) {
            valid = false;
            errorTelefono.textContent = "Error: invalid cellphone number format"; 
        } else {
            errorTelefono.textContent = ""; 
        }
        
        if(valid) obj.submit();
    }
      
    function validate_payment(obj){
        
        let valid = true;
        
        let numero_carta = document.getElementsByName("numero_carta")[0];    
        let errorNumero_carta = document.getElementById('errorNumero_carta');
        if(!checkNumero_carta(numero_carta)) {
            valid = false;
            errorNumero_carta.textContent = "Error: card number must be between 13 and 19 digits"; 
        } else {
            errorNumero_carta.textContent = ""; 
        }
        
        let cvv = document.getElementsByName("cvv")[0];
        let errorCvv = document.getElementById('errorCvv');
        if(!checkCvv(cvv)) {
            valid = false;
            errorCvv.textContent = "Error: Cvv must contain only three numbers"; 
        } else {
            errorCvv.textContent = ""; 
        }
        
        let data_scadenza = document.getElementsByName("data_scadenza")[0];
        let errorData_scadenza = document.getElementById('errorData_scadenza');
        if(!checkData(data_scadenza)) {
            valid = false;
            errorData_scadenza.textContent = "Error: date formant must be dd/MM/yyyy"; 
        } else {
            errorData_scadenza.textContent = ""; 
        }
        
        if(valid) obj.submit();
    }
      
        function validate_address(obj){

            let valid = true;
            let indirizzo = document.getElementsByName("via_indirizzo")[0];
            let errorVia_indirizzo = document.getElementById('errorVia_indirizzo');
        if(!checkIndirizzo(indirizzo)) {
            valid = false;
            errorVia_indirizzo.textContent = "Error: invalid street format"; 
        } else {
            errorVia_indirizzo.textContent = ""; 
        }

        let citta = document.getElementsByName("citta_indirizzo")[0];
        let errorCitta_indirizzo = document.getElementById('errorCitta_indirizzo');
        if(!checkLettere(citta)) {
            valid = false;
            errorCitta_indirizzo.textContent = "Error: city must contain only alphabetic characters"; 
        } else {
            errorCitta_indirizzo.textContent = ""; 
        }
        let cap = document.getElementsByName("CAP_indirizzo")[0];
        let errorCAP_indirizzo = document.getElementById('errorCAP_indirizzo');
            if(!checkCap(cap)) {
                valid = false;
                errorCAP_indirizzo.textContent = "Error: CAP must contain 5 numbers"; 
            } else {
                errorCAP_indirizzo.textContent = ""; 
            }
            
            if(valid) obj.submit();

        }  

    function checkEmail(inputtxt) {
        let email = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        if(inputtxt.value.match(email)) 
		    return true;

        return false;	
    }

    function checkPsw(inputtxt) {
        //almeno una lettera, almeno una cifra, da 6 a 20 caratteri
        let psw = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,20}$/;
        if(inputtxt.value.match(psw)) 
		    return true;

        return false;	
    }

    function checkUsername(inputtxt) {
        let username = /^[a-zA-Z0-9_-]{6,20}$/;
        if(inputtxt.value.match(username)) 
		    return true;

        return false;	
    }

    function checkLettere(inputtxt) {
        let name = /^[A-Za-z ]+$/;
        if(inputtxt.value.match(name)) 
		    return true

        return false;	
    }

    function checkCf(inputtxt) {
        let cf = /^[A-Z]{6}[0-9]{2}[A-Z][0-9]{2}[A-Z][0-9]{3}[A-Z]$/;
        if(inputtxt.value.match(cf)) 
		    return true

        return false;	
    }

    function checkIndirizzo(inputtxt) {
        let indirizzo = /^([A-Za-z]+\s)+\d+$/;
        if(inputtxt.value.match(indirizzo)) 
		    return true

        return false;	
    }

    function checkCap(inputtxt) {
        let cap = /^\d{5}$/;
        if(inputtxt.value.match(cap)) 
		    return true

        return false;	
    }

    function checkTelefono(inputtxt) {
        let telefono = /^\d{10}$/;
        if(inputtxt.value.match(telefono)) 
		return true;

        return false;
    }
      
    function checkNumero_carta(inputtxt) {
        let numero_carta = /^\d{13,19}$/;
        if(inputtxt.value.match(numero_carta)) 
		    return true;

        return false;	
    }
      
     function checkCvv(inputtxt) {
         let cvv = /^\d{3}$/;
         if(inputtxt.value.match(cvv)) 
		    return true;

         return false;	
     }
      
     function checkData(inputtxt) {
         let date = /^\d{4}\-\d{2}\-\d{2}$/;
         if(inputtxt.value.match(date)) 
		    return true;

         return false;	
     }

    </script> 
    
      <%@include file="/WEB-INF/footer.jsp" %>

</body>
</html>