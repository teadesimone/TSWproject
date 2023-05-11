<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration page</title>
</head>
<body>
	<h1>Register</h1>
    
    <form action="registration" method="post">
        
        <br>
        <label for="email">Insert email:</label><br>
        <input name="email" type="email" maxlenght="30" required placeholder="myemail@domain.com">
        <br>
        
        <br>
        <label for="password">Insert password:</label><br>
        <input name="password" type="password" maxlenght="20" required placeholder="password123">
        <br>
        
        <br>
        <label for="username">Username:</label><br>
        <input name="username" type="text" maxlenght="20" required placeholder="Ciro05">
        <br>
        
        <br>
        <label for="nome">Name:</label><br>
        <input name="nome" type="text" maxlenght="30" required placeholder="Ciro">
        <br>
        
        <br>
        <label for="cognome">Surname:</label><br>
        <input name="cognome" type="text" maxlenght="30" required placeholder="Esposito">
        <br>
        
        <br>
        <label for="cf">CF:</label><br>
        <input name="cf" type="text" maxlenght="16" required placeholder="ABCDEF01G23H456I">
        <br>
        
        <br>
        <label for="indirizzo">Street:</label><br>
        <input name="indirizzo" type="text" maxlenght="50" required placeholder="via Roma 69">
        <br>
        
        <br>
        <label for="citta">City:</label><br>
        <input name="citta" type="text" maxlenght="40" required placeholder="Ottaviano">
        <br>
        
        <br>
        <label for="provincia">Province:</label><br>
        <input name="provincia" type="text" maxlenght="40" required placeholder="Napoli">
        <br>
        
        <br>
        <label for="cap">CAP:</label><br>
        <input name="cap" type="text" maxlenght="5" required placeholder="00000">
        <br>
        
        <br>
        <label for="telefono">Cellphone number:</label><br>
        <input name="telefono" type="text" maxlenght="12" required placeholder="000000000000">
        <br>
        
        <br>
        <input type="submit" value="Submit">
        <br>
    </form>
    
</body>
</html>