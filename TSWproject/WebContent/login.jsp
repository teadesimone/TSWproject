<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login page</title>
</head>
<body>
	<h1>Login</h1>
    
    <form action="login" method="post">
        <br>
        <label for="email">Insert email:</label><br>
        <input name="email" type="email" maxlenght="30" required placeholder="myemail@domain.com">
        <br>
        
        <br>
        <label for="password">Insert password:</label><br>
        <input name="password" type="password" maxlenght="20" required placeholder="password123">
        <br>
       
        <br>
        <input type="submit" value="Submit">
        <br>
    </form>
</body>
</html>