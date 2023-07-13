<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<%
JewelBean j = (JewelBean) request.getAttribute("jewel");
ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
if(!client.getEmail().equalsIgnoreCase("JadeTear@gmail.com") || client==null){
    response.sendRedirect("Error403.jsp");	
    return;
}
String error = (String) request.getAttribute("error");

%>


<!DOCTYPE html>
<html lang="en">

<head>
        <title> Admin Page </title>
</head>

<body>
        <%@include file="/WEB-INF/header.jsp" %>
        <h1> Admin Page </h1>

        <h2>Add a jewel</h2>
        <% if (error != null){%>
                <div><%=error%></div>
        <%}%>
        <form action="admin" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="insert">

                <br>
                <label for="name">Name:</label><br>
                <input name="name" type="text" maxlength="50" required placeholder="enter name">
                <br>

                <br>
                <label for="category">Category:</label><br>
                <select name="category">
                    <option value="Necklace"> Necklace </option>
                    <option value="Earrings"> Earrings </option>
                    <option value="Ring"> Ring </option>
                    <option value="Bracelet"> Bracelet </option>

                </select> <br> 

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
                <label for="image">Image:</label><br>
                <input name="image" type="file" required>
                <br>

                <br>
                <label for="availability">Availability:</label><br>
                <input name="availability" type="number" min="0" required>
                <br>

                <br>
                <label for="IVA">IVA:</label><br>
                <input name="IVA" type="number" min="1" max="22" value="22" required>
                <br>

                <br>
                <label for="price">Price:</label><br>
                <input name="price" type="number" min="1" max='5000' required>
                <br>

                <br>
                <label for="description">Description:</label><br>
                <textarea name="description" maxlength="100" rows="3" required placeholder="enter description"></textarea>
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
                <label for="discount">Discount:</label><br>
                <input name="discount" type="number" min="0" max="99" value="0">
                <br>
                
                <br>
                <input type="submit" value="Add">
                <input type="reset" value="Reset">
        </form>
        

        <h2>Update with new info</h2>
        <form action="admin" method="post">
                <input type="hidden" name="action" value="load">
                <fieldset>
                        <legend> Write down the jewel's ID you want to modify</legend>
                        <label for="id">Id:</label><br>
                        <input name="id" type="number" required>
                        <input type="submit" value="Load">
                </fieldset>
        </form>

        <%if(j != null){%>
        	<form action="admin" method="post">
        		<input type="hidden" name="action" value="modify">
        		<input type="hidden" name="idM" value=<%=j.getId() %>>

                <br>
                <label for="name">Name:</label><br>
                <input name="nameM" type="text" maxlength="50" required value="<%=j.getNome() %>">
                <br>

                <br>
                <label for="category">Category:</label><br>
                <select name="categoryM">
                    <option value="Necklace"> Necklace </option>
                    <option value="Earrings"> Earrings </option>
                    <option value="Ring"> Ring </option>
                    <option value="Bracelet"> Bracelet </option>
                </select>
                <br>

                <br>
                <label for="gemstone">Gemstone:</label><br>
                  <select name="gemstoneM">
               	 	 <option value="Jade"> Jade </option>
               		 <option value="Amethyst">Amethyst </option>
               		 <option value="Ruby"> Ruby </option>
                     <option value="Rose Quarz"> Rose Quarz </option>       
                     <option value="Emerald"> Emerald </option>
                     <option value="Aquamarine"> Aquamarine </option>

           		  </select>  
                <br>

                <br>
                <label for="image">Image:</label>
                <input name="imageM" type="text" maxlength="100" required value="<%=j.getImmagine() %>">
                <br>

                <br>
                <label for="availability">Availability:</label><br>
                <input name="availabilityM" type="number" min="0" required value="<%=j.getDisponibilita() %>">
                <br>

                <br>
                <label for="IVA">IVA:</label><br>
                <input name="IVAM" type="number" min="1" max='22' required value="<%=j.getIVA() %>">
                <br>

                <br>
                <label for="price">Price:</label><br>
                <input name="priceM" type="number" min="1" max='5000' required value="<%=j.getPrezzo() %>">
                <br>

                <br>
                <label for="description">Description:</label><br>
                <textarea name="descriptionM" maxlength="100" rows="3" required><%=j.getDescrizione() %></textarea>
                <br>

                <br>
                <label for="materialM">Material:</label><br> <select name="category">
               	  <select name="materialM">
               	 	 <option value="Gold"> Gold </option>
               		 <option value="Silver"> Silver </option>
               		 <option value="Rose Gold"> Rose Gold </option>

           		  </select>  
                <br>

                <br>
                <label for="discount">Discount:</label><br>
                <input name="discountM" type="number" min="0" max="99" value="<%=j.getSconto() %>">
                <br>

                <input type="submit" value="Modify">
           </form>

        <%}%>

        <h2>Delete a jewel</h2>
        <form action="admin" method="post">
                <input type="hidden" name="action" value="delete">
                <fieldset>
                        <legend> Write down the jewel's ID you want to delete</legend>
                        <label for="id">Id:</label><br>
                        <input name="id" type="number" required>
                        <input type="submit" value="Delete">
                </fieldset>
        </form>
        <%@include file="/WEB-INF/footer.jsp" %>
</body>
</html>
