<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Error</title>
    <link rel="stylesheet" type="text/css" href="./styles/errorStyle.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    
    <style>
        p{
            margin-top: 30px;
        }
    
    </style>
    
</head>
<body>
    <h3>Ops... Something went wrong!</h3>
    
        <img src="images//error.png" class="errorImg"alt="Error" >

    <p> Are you sure you're registered?
        If not, try to <a href="registration">register <i class="fa fa-user-plus" aria-hidden="true"></i></a> 
    </p>

    <p> If you're already registered or you put the wrong login credentials...
        Retry <a href="login">login <i class="fa fa-sign-in" aria-hidden="true"></i></a> 
    </p>

</body>
</html>