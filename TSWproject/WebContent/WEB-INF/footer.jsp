<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">

<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>Footer</title>
    <style>
    
     
    footer{
        font-size: 30px;
    
    }
    
    .container{
        display: flex;
        flex-direction: row;
        height: auto;
        justify-content: center;
        border-top-style: double;
        border-color: #84A8A1;
    }
    
    .contattaci{
        height: 90%;
        width: 90%;
        text-align: center;
        padding:2%;
    }
    
    .informazioni{
        height: 90%;
        width: 90%;
        text-align: center;
        padding:2%;
    }
    
    .social{
        height: 90%;
        width: 90%;
        text-align: center;
        padding:2%;
    }
    
    .contattaci h1, .informazioni h1, .social h1{

        display: flex;
        justify-content: center;
        color: #4C8577;
        padding: 1%;
        border-top-style: double;
        border-bottom-style: double;
        border-color: #84A8A1;
        font-family: "Times New Roman", serif, sans-serif;
        font-size: 95%;
    }
    .contattaci p, .informazioni p, .social p{

        display: flex;
        justify-content: center;
        color: #18020C;
        padding: 1%;
        font-size: 70%;
       
        font-family: "Times New Roman", serif, sans-serif; 
    }
    .informazioni a{

        display: flex;
        justify-content: center;
        color: #18020C;
        padding: 1%;
        border-color: #84A8A1;
        font-family: "Times New Roman", serif, sans-serif;
        font-size: 95%;
    }
    
    .icon-instagram:hover {
        color: #F166D9;
    }
    .icon-facebook:hover {
        color: #3b5998;
    }
    .icon-linkedin:hover {
        color: #0077B5;
    }
    .fa.fa-instagram{
        font-size: 80%;
    
    }
    .fa.fa-facebook{
        font-size: 80%;

    }
    .fa.fa-linkedin{
        font-size: 80%;

    }
    
    @media screen and (max-width: 800px){
        
        footer{
            font-size: 20px;

        }
    
    }
    
    @media screen and (max-width: 480px){

        footer{
            font-size: 10px;

        }

    }



    </style>

</head>

<body>
<footer>

    <div class="container">

        <div class="contattaci">
            <h1>Contact us!</h1>
            <p> +39 1234567890 </p>
            <p>JadeTear@gmail.com</p>
        </div >


        <div class="social">
            <h1>Follow us!</h1>
            <p class="icon-instagram"><i class="fa fa-instagram" aria-hidden="true"></i>&nbsp  Jade_Tear_Jewels</p>
            <p class="icon-facebook"><i class="fa fa-facebook" aria-hidden="true"></i> &nbsp Jade_Tear_Jewels</p>
            <p class="icon-linkedin"><i class="fa fa-linkedin" aria-hidden="true"></i> &nbsp Jade_Tear_Jewels</p>


        </div>

        <div class="informazioni">
            <h1>Info</h1>
            <p> <a href = "aboutus.jsp"> About us </a></p>
            <p> <a href = "customerservice.jsp">  FAQ and costumer service</a></p>
        </div>     
</div>

</footer>
</body>

</html>
