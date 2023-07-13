<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<%
       String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Registration page</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
    <h1>Register</h1>
    
    <form action="registration" method="post" onsubmit="event.preventDefault(); validate(this)">
        <% if (error != null){%>
        <div><%=error%></div>
        <%}%>
        
        <br>
        <label for="email">Insert email:</label><br>
        <input id="email" name="email" type="email" maxlenght="30" required placeholder="myemail@domain.com" onblur="checkEmailAjax()">
        <span id="errorEmail"></span>
        <span id="errorCheckEmail"></span>
        <br>
        
        <br>
        <label for="password">Insert password:</label><br>
        <input name="password" type="password" maxlenght="20" required placeholder="password123">
        <span id="errorPsw"></span>
        <br>
        
        <br>
        <label for="username">Username:</label><br>
        <input id ="username" name="username" type="text" maxlenght="20" required placeholder="Ciro05" onblur="checkUsernameAjax()">
        <span id="errorUsername"></span>
        <span id="errorCheckUsername"></span>
        <br>
        
        <br>
        <label for="nome">Name:</label><br>
        <input name="nome" type="text" maxlenght="30" required placeholder="Ciro">
        <span id="errorNome"></span>
        <br>
        
        <br>
        <label for="cognome">Surname:</label><br>
        <input name="cognome" type="text" maxlenght="30" required placeholder="Esposito">
        <span id="errorCognome"></span>
        <br>
        
        <br>
        <label for="cf">CF:</label><br>
        <input name="cf" type="text" maxlenght="16" required placeholder="ABCDEF01G23H456I">
        <span id="errorCf"></span>
        <br>
        
        <br>
        <label for="indirizzo">Street:</label><br>
        <input name="indirizzo" type="text" maxlenght="50" required placeholder="via Roma 69">
        <span id="errorIndirizzo"></span>
        <br>
        
        <br>
        <label for="citta">City:</label><br>
        <input name="citta" type="text" maxlenght="40" required placeholder="Ottaviano">
        <span id="errorCitta"></span>
        <br>
        
        <br>
        <label for="provincia">Province:</label><br>
        <input name="provincia" type="text" maxlenght="40" required placeholder="Napoli">
        <span id="errorProvincia"></span>
        <br>
        
        <br>
        <label for="cap">CAP:</label><br>
        <input name="cap" type="text" maxlenght="5" required placeholder="00000">
        <span id="errorCap"></span>
        <br>
        
        <br>
        <label for="telefono">Cellphone number:</label><br>
        <input name="telefono" type="text" maxlenght="12" required placeholder="000000000000">
        <span id="errorTelefono"></span>
        <br>
        
        <br>
        <input type="submit" value="Submit"> 
        <br>
    </form>

    <script>
    function validate(obj) {	
           let valid = true;	
		
           let email = document.getElementsByName("email")[0];    
           let errorEmail = document.getElementById('errorEmail');
	    if(!checkEmail(email)) {
		    valid = false;
                  errorCheckEmail.textContent = "";
		    errorEmail.textContent = "Error: invalid email address"; 
	    } else {
            errorCheckEmail.textContent = "";
            errorEmail.textContent = ""; 
        }

        let psw = document.getElementsByName("password")[0];    
        let errorPsw = document.getElementById('errorPsw');
	    if(!checkPsw(psw)) {
		    valid = false;
		    errorPsw.textContent = "Error: password must be at least 6 characters long and must contain at least one number and one letter"; 
	    } else {
            errorPsw.textContent = ""; 
        }

        let username = document.getElementsByName("username")[0];
        let errorUsername = document.getElementById('errorUsername');
	    if(!checkUsername(username)) {
		    valid = false;
                  errorCheckUsername.textContent = "";
		    errorUsername.textContent = "Error: username must be between 6 and 20 characters long and can only contain letters, numbers, underscores, and hyphens"; 
	    } else {
	    errorCheckUsername.textContent = "";
	    errorUsername.textContent = ""; 
        }

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

function checkUsernameAjax() {
       
       var username = $("#username").val();

       $.ajax({
              url: "registration?action=check",
              type: "GET",
              data : { username : username },
              success: function(resp) {
                     if(resp == true){ //se ha trovato una corrispondenza
                            $("#errorCheckUsername").empty();
                            $("#errorCheckUsername").append("Error: username already taken");
                     }
                     else if (resp == false) {
                            $("#errorCheckUsername").empty();
                     }
              },
              error: function() {
                     $("#errorCheckUsername").empty();
                     $("#errorCheckUsername").append("Error: an error occurred while checking your username");
              }
       });
}

function checkEmailAjax() {

       var email = $("#email").val();

       $.ajax({
              url: "registration?action=checkemail",
              type: "GET",
              data : { email : email },
              success: function(resp) {
                     if(resp == true){ //se ha trovato una corrispondenza
                            $("#errorCheckEmail").empty();
                            $("#errorCheckEmail").append("Error: email already taken");
                     }
                     else if (resp == false) {
                            $("#errorCheckEmail").empty();
                     }
              },
              error: function() {
                     $("#errorCheckEmail").empty();
                     $("#errorCheckEmail").append("Error: an error occurred while checking your email");
              }
       });
}

    </script>
    
     <h3>You already have a profile? Sign in <a href= "login.jsp"> here</a></h3>
     
     <h3>Return to <a href="home.jsp"> home </a></h3>
    
</body>
</html>