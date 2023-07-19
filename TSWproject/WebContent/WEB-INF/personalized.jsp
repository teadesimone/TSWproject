<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<% ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
if(client == null){
 response.sendRedirect("login");	
 return;
}
String error = (String) request.getAttribute("error");

%>

<!DOCTYPE html>
<html lang="en">

<head>
 <meta content="width=device-width, initial-scale=1" name="viewport" />
 <title> Personalized </title>
 <link rel="stylesheet" href="styles/formStyle.css" type="text/css">

 <style>
  .grid-container {
   display: grid;
   grid-template-columns: auto ;
   grid-template-rows: auto auto auto;
   gap: 60px;
   background: rgba(250,250,250);
  }

  .grid-container > div {
   font-size: 30px;
  }
  
 .container{
   grid-row: 2;
   display: grid;
   grid-template-columns: 15% 70% 15%;
   width: 100%;
  }

  .transparentCard{
   grid-column:  2/3;
   display: grid;
   grid-template-columns: 1fr;
   grid-template-rows: 10% 70% 20%;
   height:100%;
   width:100%;
   display: flex;
   justify-content: center;
   align-items: center;
   flex-direction: column;
   gap: 30px;

  }


  .title{

   grid-column: 2;
   grid-row: 1;
   width:100%;
   height:100%;
   margin-top: 27px;
   text-align:center;
  }

  .submitContainer{
   display: flex;
   flex-direction: row;
   text-align:center;
  }

  .submit{
   height: 200%;
   width: 100%;
   padding:10%;
   margin: 5%;
  }

  .inputBox{
   width: 55%;
   display: inline-flex;
   justify-content: center;
   align-items: center;
   flex-direction: column;
  }

  .special{
   width: 55%;
   display: flex;
   justify-content: center;
   align-items: center;
   flex-direction: row;
  }

  .inputBox input[type="radio"]{
   border: 0px;
   width: 100%;
   height: 1em;
  }


  .error{
   transform: translateY(-100%);
  }

  @media only screen and (max-width: 900px){ 
   .container{
    grid-template-columns: 1fr 5fr 1fr;
   }
   .transparentCard{
    width:100%;
   }
  }

  @media only screen and (max-width: 480px){ 
   .container{
    grid-template-columns: 1fr;
   }

   .transparentCard{
    grid-column:1;
    grid-template-columns: 1fr;
    grid-template-rows: 1fr 3fr 1fr;
    width:100%;
   }

   .title{
    grid-column:1;
    grid-row: 1;
   }

   .submitContainer{
    grid-column: 1;
    grid-row: 3;
   }

  }
 </style>

</head>

<body>

 <div class="grid-container">
  <div class="header" >
   <%@include file="/WEB-INF/header.jsp" %></div>
 
 <form action="personalized?action=insert" method="post" onsubmit="event.preventDefault(); validate(this)">
  <div class="container">
   <div class="transparentCard">
    <span class="title"> Customize your jewel  </span>
    <% if (error != null){%>
     <div class="errorNoTranslate"><%=error%></div>
     <%}%>

     <div class="inputBox special">
      <label for="category">Category:</label>

      <select name="category">
       <option value="Necklace"> Necklace </option>
       <option value="Earrings"> Earrings </option>
       <option value="Ring"> Ring </option>
       <option value="Bracelet"> Bracelet </option>

      </select>
     </div>

     <div class="inputBox special">
      <label for="gemstone">Gemstone:</label>
      <select name="gemstone">
       <option value="Jade"> Jade </option>
       <option value="Amethyst">Amethyst </option>
       <option value="Quarz"> Quarz </option>
       <option value="Rose Quarz"> Rose Quarz </option>
       <option value="Citrine"> Citrine </option>
       <option value="Aquamarine"> Aquamarine </option>
      </select>
     </div>

     <div class="inputBox special"> 
      <label for="material">Material:</label>
      <select name="material">
       <option value="Gold"> Gold </option>
       <option value="Silver"> Silver </option>
       <option value="Rose Gold"> Rose Gold </option>

      </select>
     </div>

     <div class="inputBox">
      <span class="error" id="errorDescrizione"></span>
      <label id="descriptionLabel" for="description">Describe how you want your jewel:</label>
      <textarea name="description" maxlength="100" rows="3" required placeholder="enter description (max 100 characters)"></textarea>
     </div>

     <div class="submitContainer">
      <input class="submit" type="submit" value="Send">
      <input class="submit" type="reset" value="Reset">
     </div>
    </div>
   </div>
  </form>
  <div class="footer">
   <%@include file="/WEB-INF/footer.jsp" %>
  </div>
  
 </div>
  <script>
   function validate(obj) {	
    let valid = true;	

    let descrizione = document.getElementsByName("description")[0];    
    let errorDescrizione = document.getElementById('errorDescrizione');
    if(!checkDescrizione(descrizione)) {
     valid = false;
     errorDescrizione.textContent = "Error: description must be 100 characters at most"; 
    } else {
     errorDescrizione.textContent = ""; 
    }
    if(valid) obj.submit();
   }

   function checkDescrizione(inputtxt) {
    let descrizione = /^[a-zA-Z\s]{1,100}$/;
    if(inputtxt.value.match(descrizione)) 
    return true

    return false;	
   }

  </script>

 </body>

 </html>
 