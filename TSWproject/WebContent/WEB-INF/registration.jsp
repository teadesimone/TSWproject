<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<%
String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="./styles/formStyle.css">
  <title>Registration page</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <style>
    *{
      height: 100%;
      margin: auto;
      width: 100%;
    }

    .container{
      display: grid;
      grid-template-columns: 25% 50% 25%;
      width: 100%;
    }

    .card{
      grid-column:  2/3;
      display: grid;
      grid-template-columns: 1fr;
      grid-template-rows: 10% 70% 20%;
      height:98%;
      width:96%;
      display: inline-flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      gap: 35px;
    }
    .title{
      grid-column: 1/3;
      grid-row: 1;
      width:100%;
      height:100%;
      margin-top: 8%;
      bottom: 30px;
      text-align:center;
    }


    .footerContainer{
      grid-column: 1/3;
      grid-row: 3;
      transform: translateY(-100%);
    }

    .submitContainer{
      text-align:center;
    }

    .submit{
      height: 70%;
      width: 25%;
      padding:0.5%;
      margin:auto;
    }

    .link{
      width:100%;
      height:100%;
      margin:auto;
      text-align:center;
    }

    .inputBox{
      width: 55%;
      display: inline-flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
    }

    .error{
      transform: translateY(-100%);
    }

    @media only screen and (max-width: 900px){ /* media query per tablet e schermi laptop medi */
      .container{
        grid-template-columns: 1fr 5fr 1fr;
      }
      .card{
        width:100%;
      }
    }

    @media only screen and (max-width: 480px){ /* media query per smartphone */
      .container{
        grid-template-columns: 1fr;
      }
      .card{
        grid-column:1;
        grid-template-columns: 1fr;
        grid-template-rows: 1fr 3fr 1fr;
        width:100%;
      }
      .footerContainer{
        grid-column: 1;
        grid-row: 3;
      }

      .title{
        grid-column:1;
        grid-row: 1;
      }

    }

    /*
    .container{
      display: grid;
      grid-template-columns: 25% 50% 25%;
      width: 100%;
    }

    .card{
      grid-column:  2/3;
      display: grid;
      grid-template-columns: 1fr 1fr;
      grid-template-rows: 10% 80% 10%;
      height:100%;
      width:100%;
    }

    .container1{
      grid-column: 1;
      grid-row:2;
      height:100%;
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      gap: 0.5px;
    }

    .container2{
      grid-column: 2;
      grid-row: 2;
      height:100%;
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      gap: 5px;
    }

    .container2 inputBox{
      margin-top: 5%;
    }

    .container1 inputBox{
      margin-top: 19%;
    }

    .title{
      grid-column: 1/3;
      grid-row: 1;
      width:100%;
      height:100%;
      margin-top: 8%;
      bottom: 80px;
      text-align:center;
    }

    .link{
      grid-column: 1/3;
      grid-row: 2;
      width:100%;
      height:100%;
      margin-bottom:0;
      margin-top: 20px;
      text-align:center;
    }

    .inputBox{
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
    }

    .submitContainer{
      grid-column: 1/3;
      grid-row:3;
      margin-left:40%;
      height: 70%;
      width: 30%;
    }
    .submit{
      text-align:center;
    }


    @media screen and(max-width: 900px)and(min-width: 768px){
      .container{
        grid-template-columns: 1fr 1fr 1fr;
      }
    }

    @media screen and (max-width: 480px){
      .container{
        grid-template-columns: 1fr;
      }
      .card{
        grid-column:1;
        grid-template-columns: 1fr;
        grid-template-rows: 1fr 3fr 3fr 1fr 1fr;
        width:100%;
      }

      .container1{
        grid-column:1;
        grid-row: 2;
      }

      .container2{
        grid-column:1;
        grid-row: 3;
      }

      .title{
        grid-column:1;
        grid-row: 1;
      }

      .link{
        grid-column:1;
        grid-row: 5;
      }

      .submitContainer{
        grid-column:1;
        grid-row: 4;
      }
    }*/

    /*
    .title{
      bottom: 0px;
    }

    .container{
      grid-template-columns: 25% 25% 25% 25%;
    }

    .card{
      grid-column: 2/4;
    }

    .logic-container1{
      grid-column: 2/ span 3;
    }

    .logic-container2{
      grid-column: 3 / span 4;
    }

    .link{
      grid-column: 2/4;
      margin: auto;
    }*/

    /*.card{
      width: 50%;
    }

    .logic-container{
      float: left;
      width: 50%;
    }

    .link{
      top: 150%;
      left: 37%;
      margin:auto;
    }*/

  </style>
</head>
<body>
  <form action="registration" method="post" onsubmit="event.preventDefault(); validate(this)">
    <div class="container">
      <div class="card">
        <span class="title">Register</span>

        <% if (error != null){%>
          <div class="errorNoTranslate"><%=error%></div>
          <%}%>

          <div class="inputBox">
            <span class="error" id="errorEmail"></span>
            <span class="error" id="errorCheckEmail"></span>
            <input id="email" name="email" type="email" maxlenght="30" required autocomplete="off" placeholder="myemail@domain.com" onblur="checkEmailAjax()">
            <label id="emailLabel" for="email">Insert email:</label>
          </div>

          <div class="inputBox">
            <span class="error" id="errorPsw"></span>
            <input id="password" name="password" type="password" maxlenght="20"  autocomplete="off" required placeholder="password123">
            <label id="passwordLabel" for="password">Insert password:</label>
          </div>

          <div class="inputBox">
            <span class="error" id="errorUsername"></span>
            <span class="error" id="errorCheckUsername"></span>
            <input id ="username" name="username" type="text" maxlenght="20" required autocomplete="off" placeholder="Ciro05" onblur="checkUsernameAjax()">
            <label id="usernameLabel" for="username">Username:</label>
          </div>

          <div class="inputBox">
            <span class="error" id="errorNome"></span>
            <input id="nome" name="nome" type="text" maxlenght="30" required autocomplete="off" placeholder="Ciro">
            <label id="nomeLabel" for="nome">Name:</label>
          </div>

          <div class="inputBox">
            <span class="error" id="errorCognome"></span>
            <input id="cognome" name="cognome" type="text" maxlenght="30" required autocomplete="off" placeholder="Esposito">
            <label id="cognomeLabel" for="cognome">Surname:</label>
          </div>

          <div class="inputBox">
            <span class="error" id="errorCf"></span>
            <input id="cf" name="cf" type="text" maxlenght="16" required autocomplete="off" placeholder="ABCDEF01G23H456I">
            <label id="cfLabel" for="cf">CF:</label>
          </div>

          <div class="inputBox">
            <span class="error" id="errorIndirizzo"></span>
            <input id="indirizzo" name="indirizzo" type="text" maxlenght="50" autocomplete="off" required placeholder="via Roma 69">
            <label id="indirizzoLabel" for="indirizzo">Street:</label>
          </div>

          <div class="inputBox">
            <span class="error" id="errorCitta"></span>
            <input id="citta" name="citta" type="text" maxlenght="40" required autocomplete="off" placeholder="Ottaviano">
            <label id="cittaLabel" for="citta">City:</label>
          </div>

          <div class="inputBox">
            <span class="error" id="errorProvincia"></span>
            <input id="provincia" name="provincia" type="text" maxlenght="40" autocomplete="off" required placeholder="Napoli">
            <label id="provinciaLabel" for="provincia">Province:</label>
          </div>

          <div class="inputBox">
            <span class="error" id="errorCap"></span>
            <input id="cap" name="cap" type="text" maxlenght="5" required autocomplete="off" placeholder="00000">
            <label id="capLabel" for="cap">CAP:</label>
          </div>

          <div class="inputBox">
            <span class="error" id="errorTelefono"></span>
            <input id="telefono" name="telefono" type="text" maxlenght="12" required autocomplete="off" placeholder="000000000000">
            <label id="telefonoLabel" for=telefono">Cellphone number:</label>
          </div>
          <div class="footerContainer">
            <div class="submitContainer">
              <input type="hidden" name="action" value="register">
              <input class="submit" type="submit" value="Submit"> 
            </div>

            <div class="link">
              <span>You already have a profile? Sign in <a href= "login"> here</a></span>
              <span>Return to <a href="home"> home </a></span>
            </div>
          </div>
        </div>
      </div>
    </form>
    <script>
      $(document).ready(function () {

        $("#email").on("input", function() {
          if ($("#email").val().length !== 0)
          $("#emailLabel").addClass("notEmpty");
          else
          $("#emailLabel").removeClass("notEmpty");
        });

        $("#password").on("input", function() {
          if ($("#password").val().length !== 0)
          $("#passwordLabel").addClass("notEmpty");
          else
          $("#passwordLabel").removeClass("notEmpty");
        });

        $("#cap").on("input", function() {
          if ($("#cap").val().length !== 0)
          $("#capLabel").addClass("notEmpty");
          else
          $("#capLabel").removeClass("notEmpty");
        });

        $("#username").on("input", function() {
          if ($("#username").val().length !== 0)
          $("#usernameLabel").addClass("notEmpty");
          else
          $("#usernameLabel").removeClass("notEmpty");
        });

        $("#nome").on("input", function() {
          if ($("#nome").val().length !== 0)
          $("#nomeLabel").addClass("notEmpty");
          else
          $("#nomeLabel").removeClass("notEmpty");
        });

        $("#cognome").on("input", function() {
          if ($("#cognome").val().length !== 0)
          $("#cognomeLabel").addClass("notEmpty");
          else
          $("#cognomeLabel").removeClass("notEmpty");
        });

        $("#cf").on("input", function() {
          if ($("#cf").val().length !== 0)
          $("#cfLabel").addClass("notEmpty");
          else
          $("#cfLabel").removeClass("notEmpty");
        });

        $("#indirizzo").on("input", function() {
          if ($("#indirizzo").val().length !== 0)
          $("#indirizzoLabel").addClass("notEmpty");
          else
          $("#indirizzoLabel").removeClass("notEmpty");
        });

        $("#citta").on("input", function() {
          if ($("#citta").val().length !== 0)
          $("#cittaLabel").addClass("notEmpty");
          else
          $("#cittaLabel").removeClass("notEmpty");
        });

        $("#provincia").on("input", function() {
          if ($("#provincia").val().length !== 0)
          $("#provinciaLabel").addClass("notEmpty");
          else
          $("#provinciaLabel").removeClass("notEmpty");
        });

        $("#telefono").on("input", function() {
          if ($("#telefono").val().length !== 0)
          $("#telefonoLabel").addClass("notEmpty");
          else
          $("#telefonoLabel").removeClass("notEmpty");
        });

      })  
    
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
        let telefono = /^\d{12}$/;
        if(inputtxt.value.match(telefono)) 
        return true;

        return false;
      }
      
      //FUNZIONE AJAX CHE CONTROLLA SE LO USERNAME E' GIA' NEL DATABASE
      //Funzionamento: chiamata a funzione "check" della registration
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

  </body>
  </html>