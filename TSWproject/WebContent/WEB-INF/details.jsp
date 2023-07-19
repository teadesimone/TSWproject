<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<% JewelBean j = (JewelBean) request.getAttribute("detailed");

String erroresoldout2 = (String)request.getAttribute("erroresoldout2");
%>

<!DOCTYPE html>
<html lang ="en">

<head>
    <title> Product Details </title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


    <style>

        * {
            box-sizing: border-box;
        }

    .grid-container{

      display: grid;
      grid-template-columns: auto ;
      grid-template-rows: auto auto auto auto;
      gap: 30px;
      background: rgba(250,250,250);
    }

    .grid-container > div {

      text-align: center;
      font-family: "Times New Roman", serif, sans-serif; 
      font-size:20px;
    }

    .main-container{

         width: 100%;
        height: 100%;

    }

    .main{
        display: flex;
        flex-wrap: wrap;
        flex-direction: row;
        justify-content: center;
        height: auto;
        padding: 2%;
    }

    .image{

        width: 45%;
        height: auto;
        padding: 1%;
        margin:1%;

    }

    .image img{
        width: 100%;
        height: 100%;
        border: 1px solid #634B66;
        border-radius: 5px;
        transition: transform .5s;
    }

    .image img:hover {
        -ms-transform: scale(1.1); /* IE 9 */
        -webkit-transform: scale(1.1); /* Safari 3-8 */
        transform: scale(1.1); 
    }

    .information{

        width: 45%;
        height: auto;
    padding:2%;
    text-align: center;
    color: #634B66;
    margin:2%;


    }

    .title h1{
        width: 100%;
         border-top-style: double;
         border-bottom-style: double;
         border-color: #634B66;
        padding: 5%;
        color: #634B66;


    }


    .main a:link,.main a:visited {
        background-color: white;
        color: black;
        border: 2px solid #634B66;
        padding: 2%;
        border-radius: 20px;
        margin:1%;

        text-align: center;
        text-decoration: none;
        display: inline-block;
    }

    .main a:hover,.main a:active {
        background-color: #634B66;
        color: white;
        padding: 2%;
        margin:1%;
        border-radius: 20px;
        display: inline-block;
    }

    @media screen and (max-width: 800px){

        .main{

            flex-direction: column;
            justify-content: center;

        }

        .image{

            width: 100%;
        }

        .information{

            width: 100%;

        }

    }





    </style>

</head>

<body>

<div class="grid-container">

<div class="header">
	<%@include file="header.jsp" %></div>

    <div class="title">
    <h1><%=j.getNome() %></h1>
    </div>

    <div class="main-container">

        <div class="main">

            <div class="image">

                <a target='_blank' href="<%= "images//" + j.getImmagine() %>">
                 <img src= "<%= "images//" + j.getImmagine() %>" alt="<%=j.getNome() %>">
             </a>

            </div>


              <div class="information">



                <h3>Description</h3>
                <p><%=j.getDescrizione() %></p>


                <h3>Material</h3>
                <p><%=j.getMateriale() %></p>

                <h3>Gemstone</h3>
                <p><%=j.getPietra() %></p>

                <h3>Price</h3>
                <p><%=j.getPrezzo() %>€</p>




                <% if (erroresoldout2 != null){%>
                            <div style="color:red;"><%=erroresoldout2%></div>
                    <%}%>
                <br>
                <a href="cart"> Cart </a> 

               <%  if (j.getDisponibilita() > 0){ %>
                <a href="cart?action=add&id=<%=j.getId()%>"> Add to Cart </a> 

               <% } %>
                <a href="catalog"> Go Back </a> 

                </div>

          </div>

    </div>

   <div class="footer">
    <%@include file="footer.jsp" %></div>

    </div>
</body>
</html>
