<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<%

ClientBean clientbean = (ClientBean) request.getSession().getAttribute("utente");

%>

<!DOCTYPE html>
<html lang="en">
<head>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <meta name="viewport" content="width=device-width, initial-scale=1">
<style>
 
  header .grid-container{
    display: grid;
    grid-template-columns: 10% 10% 70% 10%;
    grid-template-rows: auto ;
    gap: 10px;
    background: rgba(250,250,250);
  
  }
  header .grid-container > div {

    text-align: center;
    font-family: "Times New Roman", serif, sans-serif; 
    font-size:20px;
  }
  
  .logo{
    
    width: auto;
    height: auto;
    align-content: center;
    
  }
  
  .logo img{
    
    
    width: 100%;
    height: auto;
    
  }
  
  .menu {
    
    justify-content: center;
    align-content: center;
    padding-top: 25%;
    
  }
  
  .main-header{
    
  font-size: 30px;
    justify-content: center;
    align-content: center;
    align-text: center;
    padding-top:3%;
  
  }
  
  .main-header a:link,.main-header a:visited {

    background-color: white;
    color: black;
    border: 2px solid #4C8577;
    padding: 1%;
    border-radius: 20px;
    margin:1%;

    text-align: center;
    text-decoration: none;
    display: inline-block;
  }
  
  .main-header a:hover,.main-header a:active {
    background-color: #4C8577;
    color: white;
    padding: 1%;
    margin:1%;
    border-radius: 20px;
    display: inline-block;
  }
  
  .sidenav-btn {
    width: auto;
    height:auto;
    padding: 5px 10px;
    margin: 0 5px;
    border: 2px solid #4C8577;
    border-radius: 10px;
    background-color: #fff;
    cursor: pointer;
    text-align: center;
    font-size: 25px;
    letter-spacing: 1px;
    font-family: "Times New Roman", serif, sans-serif;
  }
  
  .sidenav-btn:hover {
    color: white;
    background-color: #4C8577;
  }
  
  .carrello{
    font-size: 30px;
    justify-content: center;
    align-content: center;
    align-text: center;
    margin-right:30%;
    padding:25%;
    color: #4C8577;
  
  }
  
  

.sidenav {
  height: 100%;
  width: 0;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: #4C8577;
  overflow-x: hidden;
  transition: 0.5s;
  padding-top: 60px;
}

.sidenav a {
  padding: 8px 8px 8px 32px;
  text-decoration: none;
  font-size: 25px;
  color: #000000;
  display: block;
  transition: 0.3s;
}

.sidenav a:hover {
  color: #E5FFDE;
}

.sidenav-btn {
  font-size: 15px;
}

.sidenav .closebtn {
  position: absolute;
  top: 0;
  right: 25px;
  font-size: 30px;
  margin-left: 50px;
}



/*qui inizia css header bozza*/



header {
  overflow: hidden;
  background-color: #f1f1f1;
  width: 100%;
  z-index: 999;
}




.fa.fa-shopping-cart {
  font-size: 40px;
  color: #4C8577;
  
}
/*
.header a:hover {
  background-color: #ddd;
  color: black;
}

.header a.active {
  background-color: dodgerblue;
  color: white;
}
*/

@media screen and (max-width: 880px){
  
  .carrello{
    font-size: 20px;
    

  }

}

@media screen and (max-width: 780px) {
  
  .main-header {
     display: none;
  
  }
  
  header .grid-container{
    display: grid;
    grid-template-columns: 40% 20% 40%;
    grid-template-rows: auto ;
    gap: 10px;
    background: rgba(250,250,250);

  }
  
  .carrello{
    font-size: 20px;
    justify-content: center;
    align-content: center;
    align-text: center;
    padding:30%;
    padding-bottom: 10%

    color: #4C8577;

  }
  
  .logo{

    width: auto;
    height: auto;
    align-content: center;
    padding-top:10%;

  }
  
 
}

::-webkit-scrollbar {
  width: 20px;
}

::-webkit-scrollbar-track {
  box-shadow: inset 0 0 5px #AEA4B4; 
  border-radius: 10px;
}

::-webkit-scrollbar-thumb {
  background: #AEA4B4; 
  border-radius: 10px;
}

::-webkit-scrollbar-thumb:hover {
  background: #968c9c; 
}

</style>
</head>
<body>
  <header>
    <div class="grid-container"> 
  
      <div class= "menu">
        
        <button class="sidenav-btn" onclick="openNav()">&#9776;</button>
        
    <div id="mySidenav" class="sidenav">
      <button class="closebtn" onclick="closeNav()">&times;</button>
      
    
      
      <a href="home">  Home <i class="fa fa-home" aria-hidden="true"></i> </a>
      <a href="catalog">  Catalog <i class="fa fa-diamond" aria-hidden="true"></i> </a>
      
      <% if (clientbean == null) { %>

        <a href="login">Login <i class="fa fa-sign-in" aria-hidden="true"></i></a><br>
        <a href="registration">Register <i class="fa fa-user-plus" aria-hidden="true"></i></a><br>
        <a href="personalized">  Customize your jewel <i class="fa fa-pencil" aria-hidden="true"></i> </a><br>

        <% } else if (clientbean != null && (clientbean.getEmail().equals("JadeTear@gmail.com"))) { %>

          <a href="admin?action=ordersNoFilter">Orders <i class="fa fa-shopping-bag" aria-hidden="true"></i></a><br>
          <a href="admin?action=clientsNoFilter">Clients <i class="fa fa-users" aria-hidden="true"></i></a><br>
          <a href="admin">Admin Profile <i class="fa fa-user" aria-hidden="true"></i></a><br>
          <a href="login?action=logout">Logout <i class="fa fa-sign-out" aria-hidden="true"></i></a><br>

          <% } else {%>
            

            <a href="clientorders">My Orders <i class="fa fa-shopping-bag" aria-hidden="true"></i></a><br>
            <a href="userdetails">My Profile <i class="fa fa-user" aria-hidden="true"></i></a><br>
            <a href="login?action=logout">Logout <i class="fa fa-sign-out" aria-hidden="true"></i></a><br>
            <a href="personalized">  Customize your jewel <i class="fa fa-pencil" aria-hidden="true"></i> </a><br>

            <% } %>
          </div>
          
        </div>
        
        <div class="logo">
          
          <img src="images//logo.png" class="logo"></a>
        
        </div>

          <div id="main" class="main-header">

          
            <% if (clientbean == null) { %>
           
                 
                 <a href="home">  Home  </a>
                 <a href="catalog">  Catalog  </a>
                 <a href="personalized">  Customize your jewel  </a>
                

              <% } %>
          
          
            <% if (clientbean != null) { %>
           
                  
                  <a href="home">  Home  </a>
                  <a href="catalog">  Catalog  </a>
                  <a href="personalized">  Customize your jewel  </a>
               
              
              <% } %>
              
              <% if (clientbean != null && clientbean.getEmail().equals("JadeTear@gmail.com")) { %>
              
                    
                    <a href="home">  Home  </a>
                    <a href="catalog">  Catalog  </a>
                
          
                <% } %>

            </div>
            
            <div class="carrello">
              
              <% if (clientbean==null || !clientbean.getEmail().equals("JadeTear@gmail.com")) { %>
                
              <a href="cart"><i class="fa fa-shopping-cart" aria-hidden="true"></i></a>
               
              <% } %>
              
            </div>
            
          </div>
          </header>
          <script>
            function openNav() {
              document.getElementById("mySidenav").style.width = "250px";

            }

            function closeNav() {
              document.getElementById("mySidenav").style.width = "0";
              document.getElementById("main").style.marginLeft= "0";
            }
          </script>

        </body>
        </html> 
        