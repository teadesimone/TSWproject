<%@ page language="java" contentType="text/html; charset=UTF-8"
import = "java.util.*, it.unisa.model.*" pageEncoding="UTF-8"%>

<% JewelBean j = (JewelBean) request.getAttribute("jewel"); %> 


<!DOCTYPE html>
<html> 

<head>
        <title> Admin Page </title>
</head> 

<body> 
        <h1> Admin Page </h1>

        <h2>Add a jewel</h2>
        <form action="admin" method="post">
                <input type="hidden" name="action" value="insert">

                <br>
                <label for="name">Name:</label><br>
                <input name="name" type="text" maxlength="50" required placeholder="enter name">
                <br>

                <br>
                <label for="category">Category:</label><br>
                <input name="category" type="text" maxlength="20" required placeholder="(Ring, Necklace,...)">
                <br>

                <br>
                <label for="gemstone">Gemstone:</label><br>
                <input name="gemstone" type="text" maxlength="20" required
                placeholder="enter gemstone">
                <br>

                <br>
                <label for="image">Image:</label><br>
               
                <input name="image" type="text" maxlength="100" required
                placeholder="enter an url (?)">
                <br>

                <br>
                <label for="availability">Availability:</label><br>
                <input name="availability" type="number" min="0" required>
                <br>

                <br>
                <label for="IVA">IVA:</label><br>
                <input name="IVA" type="number" min="1" value="22" required>
                <br>

                <br>
                <label for="price">Price:</label><br>
                <input name="price" type="number" min="1" required>
                <br>

                <br>
                <label for="description">Description:</label><br>
                <textarea name="description" maxlength="100" rows="3" required placeholder="enter description"></textarea>
                <br>

                <br>
                <label for="material">Material:</label><br>
                <input name="material" type="text" maxlength="20" required>
                <br>

                <br>
                <label for="discount">Discount:</label><br>
                <input name="discount" type="number" min="0" value="0">
                <br>

                <br>
                <label for="personalized">Personalized:</label><br>
                <input name="personalized" type="checkbox" value="true">
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
                <input name="categoryM" type="text" maxlength="20" required value="<%=j.getCategoria() %>">
                <br>

                <br>
                <label for="gemstone">Gemstone:</label><br>
                <input name="gemstoneM" type="text" maxlength="20" required value="<%=j.getPietra() %>">
                <br>

                <br>
                <label for="image">Image:</label><br>
               
                <input name="imageM" type="text" maxlength="100" required value="<%=j.getImmagine() %>">
                <br>

                <br>
                <label for="availability">Availability:</label><br>
                <input name="availabilityM" type="number" min="0" required value="<%=j.getDisponibilita() %>">
                <br>

                <br>
                <label for="IVA">IVA:</label><br>
                <input name="IVAM" type="number" min="1" required value="<%=j.getIVA() %>">
                <br>

                <br>
                <label for="price">Price:</label><br>
                <input name="priceM" type="number" min="1" required value="<%=j.getPrezzo() %>">
                <br>

                <br>
                <label for="description">Description:</label><br>
                <textarea name="descriptionM" maxlength="100" rows="3" required><%=j.getDescrizione() %></textarea>
                <br>

                <br>
                <label for="material">Material:</label><br>
                <input name="materialM" type="text" maxlength="20" required value="<%=j.getMateriale() %>">
                <br>

                <br>
                <label for="discount">Discount:</label><br>
                <input name="discountM" type="number" min="0" value="<%=j.getSconto() %>">
                <br>

                <% if (!j.getPersonalizzato()) { %>
                        <br>
                        <label for="personalized">Personalized:</label><br>
                        <input name="personalizedM" type="checkbox" value="<%=j.getPersonalizzato() %>">
                        <br>
                        <% } else { %>
                                <br>
                                <label for="personalized">Personalized:</label><br>
                                <input name="personalizedM" type="checkbox" value="<%=j.getPersonalizzato() %>" checked>
                                <br>
                                <% } %>

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

</body>
</html>
