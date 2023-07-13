<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<% ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
	if(client == null){
		response.sendRedirect("login.jsp");	
		return;
	}
 String error = (String) request.getAttribute("error");

%>

<html lang="en">

<head>
        <title> Personalized </title>
</head>

<body>
        <%@include file="/WEB-INF/header.jsp" %>
        <h1> Customize your jewel  </h1>

        
        <form action="personalized?action=insert" method="post" onsubmit="event.preventDefault(); validate(this)">
              <% if (error != null){%>
               <div><%=error%></div>
              <%}%>  
                <br>
                <label for="category">Category:</label><br>
      
                  <select name="category">
               	 	 <option value="Necklace"> Necklace </option>
               		 <option value="Earring"> Earrings </option>
               		 <option value="Ring"> Ring </option>
               		 <option value="Bracelet"> Bracelet </option>
              	
           		  </select>  

                <br>

                <br>
                <label for="gemstone">Gemstone:</label><br>
                <select name="gemstone">
               	 	<option value="Jade"> Jade </option>
               		 <option value="Amethyst">Amethyst </option>
               		 <option value="Ruby"> Ruby </option>
                  <option value="Rose Quarz"> Rose Quarz </option>
                  <option value="Emerald"> Emerald </option>
                  <option value="Aquamarine"> Aquamarine </option>
              	
           		  </select>  
                <br>
                    
                <br>
                <label for="material">Material:</label><br>
                <select name="material">
               	 	 <option value="Gold"> Gold </option>
               		 <option value="Silver"> Silver </option>
               		 <option value="Rose Gold"> Rose Gold </option>
              	
           		  </select>  
                <br>

               <br>
                <label for="description">Describe how you want your jewel:</label><br>
                <textarea name="description" maxlength="100" rows="3" required placeholder="enter description (max 100 characters)"></textarea>
                <span id="errorDescrizione"></span>
                <br>

                <br>
                <input type="submit" value="Send Request">
                <input type="reset" value="Reset"> <br>
                
                 
        </form>
<script>
    function validate(obj) {	
     let valid = true;	

     let descrizione = document.getElementsByName("descrizione")[0];    
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
      let descrizione = /^[a-zA-Z0-9]{1,100}$/;
      if(inputtxt.value.match(descrizione)) 
		        return true

      return false;	
     }
    
</script>

</body>

</html>
