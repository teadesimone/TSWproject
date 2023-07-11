<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

    
<!DOCTYPE html>
<html lang="en">
<head>
<title>Login page</title>
</head>
<body>
	<h1>Login</h1>
    
    <form action="login" method="post" onsubmit="event.preventDefault(); validate(this)">
        <br>
        <label for="email">Insert email:</label><br>
        <input name="email" type="email" maxlenght="30" required placeholder="myemail@domain.com">
        <span id="errorEmail"></span>
        <br>
        
        <br>
        <label for="password">Insert password:</label><br>
        <input name="password" type="password" maxlenght="20" required placeholder="password123">
        <br>
       
        <br>
        <input type="submit" value="Submit">
        <br>
    </form>
    
    <h3>You didn't register yet? Sign up <a href= "registration.jsp"> here</a></h3>
    
    <h3>Return to <a href="home.jsp"> home </a></h3>
    
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
    
          if(valid) obj.submit();
      }    
          
          function checkEmail(inputtxt) {
              let email = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
              if(inputtxt.value.match(email)) 
		    return true;

              return false;	
          }
    </script>
    
</body>
</html>